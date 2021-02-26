#version 120

varying vec4 v_Color;

uniform int isEyeInWater;

#include "lib/fog.fsh"


void main()
{
	gl_FragData[0] = v_Color;

	// Apply fog to the fragment
	gl_FragData[0].rgb = FogFragment(gl_FragData[0].rgb, isEyeInWater);
}
