#version 120

varying vec2 v_TexCoord;
varying vec4 v_Color;

uniform float near;
uniform float far;


void main()
{
	gl_Position = ftransform();
	gl_FogFragCoord = near + length(gl_Position.xyz) * (gl_Position.z / far);
	//gl_FogFragCoord = gl_Position.z; // This is what is used in fixed-function

	v_TexCoord = (gl_MultiTexCoord0).xy;
	v_Color = gl_Color;
}
