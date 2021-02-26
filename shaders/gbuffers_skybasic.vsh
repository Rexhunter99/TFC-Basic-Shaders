#version 120

varying vec4 v_Color;

void main()
{
	gl_Position = ftransform();
	gl_FogFragCoord = gl_Position.z;

	v_Color = gl_Color;
}
