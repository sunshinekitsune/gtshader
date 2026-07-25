#version 330 compatibility

uniform sampler2D colortex0;

in vec2 texCoord;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 fragColor;

void main() {
	fragColor = texture(colortex0, texCoord);
}
