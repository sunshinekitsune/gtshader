#version 330 compatibility

out vec2 texCoord;
out vec2 lmCoord;
out vec4 glColor;

void main() {
	gl_Position = ftransform();
	texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmCoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glColor  = gl_Color;
}
