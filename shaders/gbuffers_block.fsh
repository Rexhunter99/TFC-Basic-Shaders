#version 120

varying vec4 v_Color;
varying vec2 v_LightCoord;
varying vec2 v_TexCoord;

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform int isEyeInWater;

#include "lib/fog.fsh"


void main()
{
	vec4 fragColor = vec4(v_Color.rgb, (v_Color.a > 0.1) ? 1.0 : 0.0);

	fragColor *= texture2D(lightmap, v_LightCoord);

	gl_FragData[0] = fragColor * texture2D(texture, v_TexCoord);

	// Apply fog to the fragment
	gl_FragData[0].rgb = FogFragment(gl_FragData[0].rgb, isEyeInWater);
}