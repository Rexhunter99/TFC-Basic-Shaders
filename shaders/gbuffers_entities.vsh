#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;
varying float v_LightGradient;

#include "lib/light.vsh"


void main()
{
    gl_Position = ftransform();
    v_Color = gl_Color;
    v_TexCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    v_LightCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    gl_FogFragCoord = length(gl_Position.xyz);
    vec3 v_Normal = normalize(gl_NormalMatrix * gl_Normal); // It isn't needed in the fragment shader.

    v_LightGradient = LightGradient(v_Normal);
}
