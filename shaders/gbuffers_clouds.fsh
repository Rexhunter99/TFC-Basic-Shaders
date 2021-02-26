#version 120


varying vec2 v_TexCoord;
varying vec4 v_Color;

uniform sampler2D texture;

#include "lib/fog.fsh"


void main()
{
	gl_FragData[0] = texture2D(texture, v_TexCoord.xy) * v_Color;

	// Apply fog to the fragment, but we're never in water
	gl_FragData[0].rgb = FogFragment(gl_FragData[0].rgb, 0);

}
