#version 120

varying vec2 v_TexCoord;
varying vec4 v_Color;

void main()
{
	gl_Position = ftransform();
	gl_FogFragCoord = gl_Position.z;//length(ftransform().xyz);
	
	v_TexCoord = (gl_MultiTexCoord0).xy;
	v_Color = gl_Color;
}
