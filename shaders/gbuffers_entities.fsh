#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;

varying float v_LightGradient;

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec4 entityColor;
uniform int isEyeInWater;

#include "lib/fog.fsh"


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

    // Apply fog to the fragment
    gl_FragData[0].rgb = FogFragment(gl_FragData[0].rgb, isEyeInWater);
}