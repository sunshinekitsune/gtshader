#version 330 compatibility

uniform sampler2D gtexture;

in vec2 texCoord;

void main() {
	if (texture(gtexture, texCoord).a < 0.1) {
		discard;
	}
}
