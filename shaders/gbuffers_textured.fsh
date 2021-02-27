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

    vec4 texColor = texture2D(texture, v_TexCoord.st);

    // HACK: CustomHoe fix
    if (texColor.rgb == vec3(0.0) && texColor.a > 0.005)
    {
        // To work around the hoe not working in shaders, we check if the texel is black, if it is
        // then set it to white
        texColor.rgb = vec3(1.0);
    }

    // Mix texture RGB, vertex RBB and lightmap RGB together for the fragment RGB
    gl_FragData[0].rgb = texColor.rgb * v_Color.rgb * texture2D(lightmap, v_LightCoord).rgb;

    // Mix the texture alpha and vertex alpha together
    gl_FragData[0].a = texColor.a * v_Color.a;

	// Apply fog to the fragment
	gl_FragData[0].rgb = FogFragment(gl_FragData[0].rgb, isEyeInWater);
}