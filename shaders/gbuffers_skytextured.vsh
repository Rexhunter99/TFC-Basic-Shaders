#version 120

varying vec2 v_Texcoord;
varying vec4 v_Color;


void main()
{
	gl_Position = ftransform();
	
	v_Texcoord = (gl_MultiTexCoord0).xy;
	v_Color = gl_Color;
}
