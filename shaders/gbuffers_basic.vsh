#version 120

varying vec3 v_Normal;
varying vec4 v_Color;
varying vec2 v_LightCoord;

void main()
{
	gl_Position = ftransform();

	v_Normal = normalize(gl_NormalMatrix * gl_Normal);
	v_Color = gl_Color;
	v_LightCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
}