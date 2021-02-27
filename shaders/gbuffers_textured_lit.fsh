#version 120

//#define DynamicBlockLighting //Toggle dynamic lighting on blocks

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;
varying float v_LightGradient;

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform int isEyeInWater;

#include "lib/fog.fsh"


void main()
{
    // Discard any fragments that belong to non front-facing primitives, this prevents the ugly
    // Z-Fighting/Flickering you can see on grass, ground litter and so on in many other shaders.
    if (!gl_FrontFacing) discard;

    vec4 blockLight = texture2D(lightmap, v_LightCoord.st);// Cache it to optimise the lookup
    vec4 texColor = texture2D(texture, v_TexCoord.st) * v_Color;

    gl_FragData[0] = texColor * vec4(blockLight.rgb, 1.0);

    #ifdef DynamicBlockLighting
    float light = 0.5 + (v_LightGradient * 0.5);
    gl_FragData[0].rgb *= light;
    #endif

    // Apply fog to the fragment
    gl_FragData[0].rgb = FogFragment(gl_FragData[0].rgb, isEyeInWater);
}