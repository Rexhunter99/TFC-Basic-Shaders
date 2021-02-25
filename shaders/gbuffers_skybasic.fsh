#version 120

varying vec4 v_Color;

uniform int isEyeInWater;
uniform int fogMode;

const int GL_LINEAR = 9729;
const int GL_EXP = 2048;
const int GL_EXP2 = 2049;

void main()
{
	gl_FragData[0] = v_Color;
	
	if (fogMode == GL_EXP || isEyeInWater >= 1)
	{
		gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, 1.0 - clamp(exp(-gl_Fog.density * gl_FogFragCoord), 0.0, 1.0));
	}
	else if (fogMode == GL_LINEAR)
	{
		gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
	}
}
