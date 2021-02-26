#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;

varying float v_LightGradient;

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec4 entityColor;
uniform int isEyeInWater;
uniform int fogMode;

// Define some OpenGL constants for fog
const int GL_LINEAR = 9729;
const int GL_EXP = 2048;
const int GL_EXP2 = 2049;


void main()
{
    // Discard any fragments that belong to non front-facing primitives, this prevents the ugly
    // Z-Fighting/Flickering you can see on grass, ground litter and so on in many other shaders.
    if (!gl_FrontFacing) discard;

    vec4 blockLight = texture2D(lightmap, v_LightCoord.st);// Cache it to optimise the lookup
    vec4 texColor = texture2D(texture, v_TexCoord.st);

    gl_FragData[0] = texColor * blockLight * v_Color;
    gl_FragData[0].rgb *= 0.5 + ((v_LightGradient * v_LightCoord.t) / 2.0);

    // Additive entity color is a bit more vibrant and less prone to being hidden by other factors.
    gl_FragData[0].rgb += entityColor.rgb * entityColor.a;

    // Explicitly check if the eye is underwater or the fog is Exponential
    if (fogMode == GL_EXP || isEyeInWater == 1)
    {
        gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, 1.0 - clamp(exp(-gl_Fog.density * gl_FogFragCoord), 0.0, 1.0));
    }
    // Otherwise check if it's linear fog
    else if (fogMode == GL_LINEAR)
    {
        gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
    }
    // Debug: If EXP2 fog is used set the entire fragment to fullbright blue!
    else if (fogMode == GL_EXP2)
    {
        gl_FragData[0].rgb = vec3(0.0, 0.0, 1.0);
    }
}