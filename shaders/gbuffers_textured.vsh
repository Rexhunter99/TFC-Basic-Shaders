#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;


void main()
{
	v_Color = gl_Color;
	v_TexCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	v_LightCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;

	gl_Position = ftransform();
	gl_FogFragCoord = length(gl_Position.xyz);
}