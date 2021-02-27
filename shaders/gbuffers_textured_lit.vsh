#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;
varying float v_LightGradient;

attribute vec2 mc_Entity;

#include "lib/light.vsh"


void main()
{
    v_Color = gl_Color;
    v_TexCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    v_LightCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    vec3 v_Normal = (gl_NormalMatrix * gl_Normal);

    gl_Position = ftransform();
    gl_FogFragCoord = length(gl_Position.xyz);

    v_LightGradient = LightGradient(v_Normal);

    // GitHub Issue#4
    // HACK: prevents stone stairs, blocks and detailed chisel blocks from being too dark on the sides
    // NOTE: It also makes them fullbright and not use any AO that Notch wrote into his broken OpenGL
    // This is the only solution I could come up with, without completely overhauling TFC+'s rendering code
    // Ideally to fix this, all of the block render code would be rewritten to not bake the AO into the vertex-color
    if (mc_Entity.x == 598.0) {
        v_Color = vec4(1.0);
    }
}