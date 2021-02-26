#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;
varying float v_LightGradient;

uniform vec3 moonPosition;
uniform vec3 sunPosition;
uniform vec3 upPosition;

void main()
{
    gl_Position = ftransform();
    vec3 v_Normal = normalize(gl_NormalMatrix * gl_Normal);
    v_Color = gl_Color;
    v_TexCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    v_LightCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    gl_FogFragCoord = length(gl_Position.xyz);

    // Hacky fix because shadowLightPosition wasn't working for me
    float NtoS = dot(v_Normal, normalize(sunPosition));
    float NtoM = dot(v_Normal, normalize(moonPosition));
    float NtoSM = (NtoS * dot(normalize(sunPosition), normalize(upPosition))) + (NtoM * dot(normalize(moonPosition), normalize(upPosition)));
    v_LightGradient = clamp(NtoSM, 0.0, 1.0);
}