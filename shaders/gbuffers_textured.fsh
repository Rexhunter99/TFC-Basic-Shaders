#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform int isEyeInWater;

#include "lib/fog.fsh"


void main()
{
	// TODO: Submit a patch for TFC+ to fix the hoe tile-entity
	// Disabled due to TFC+ hoe tile entity being wound the wrong way
    // Discard any fragments that belong to non front-facing primitives, this prevents the ugly
    // Z-Fighting/Flickering you can see on grass, ground litter and so on in many other shaders.
    //if (!gl_FrontFacing) discard;

    vec4 texColor = texture2D(texture, v_TexCoord.st) * v_Color;
	texColor.rgb = v_Color.rgb * texColor.rgb;
	//texColor.a = (texColor.a > 0.05) ? 1.0 : 0.0;

    gl_FragData[0] = texColor * texture2D(lightmap, v_LightCoord);

	// Apply fog to the fragment
	gl_FragData[0].rgb = FogFragment(gl_FragData[0].rgb, isEyeInWater);
}