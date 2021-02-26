#version 120

varying vec2 v_Texcoord;
varying vec4 v_Color;
uniform sampler2D texture;


void main()
{
	gl_FragData[0] = texture2D(texture, v_Texcoord.xy) * v_Color;
}
