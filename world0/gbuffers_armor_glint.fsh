#version 330 compatibility

uniform sampler2D gtexture;

in vec2 texCoord;
in vec4 glColor;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 fragColor;

void main() {
	fragColor = texture(gtexture, texCoord) * glColor;
}
