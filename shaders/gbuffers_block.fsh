#version 120

varying vec4 v_Color;
varying vec2 v_LightCoord;
varying vec2 v_TexCoord;

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform int isEyeInWater;
uniform int fogMode;

// Define some OpenGL constants for fog
const int GL_LINEAR = 9729;
const int GL_EXP = 2048;
const int GL_EXP2 = 2049;


void main()
{
	vec4 fragColor = vec4(v_Color.rgb, (v_Color.a > 0.1) ? 1.0 : 0.0);

	fragColor *= texture2D(lightmap, v_LightCoord);

	gl_FragData[0] = fragColor * texture2D(texture, v_TexCoord);

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