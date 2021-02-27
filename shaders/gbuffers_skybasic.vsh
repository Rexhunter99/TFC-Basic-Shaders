#version 120

varying vec4 v_Color;

void main()
{
	gl_Position = ftransform();
	gl_FogFragCoord = length(gl_Position.xyz);

	v_Color = gl_Color;
}
