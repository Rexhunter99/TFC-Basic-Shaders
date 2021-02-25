#version 120

varying vec4 v_Color;
varying vec2 v_TexCoord;
varying vec2 v_LightCoord;

//uniform mat4 gbufferModelView;
//uniform mat4 gbufferModelViewInverse;

void main()
{
	//vec3 position = mat3(gbufferModelViewInverse) * (gl_ModelViewMatrix * gl_Vertex).xyz + gbufferModelViewInverse[3].xyz;
	//gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(position, 1.0);

	gl_Position = ftransform();
	//v_Normal = normalize(gl_NormalMatrix * gl_Normal);
	v_Color = gl_Color;
	v_TexCoord   = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	v_LightCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
}