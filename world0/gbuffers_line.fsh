#version 330 compatibility

in vec4 glColor;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 fragColor;

void main() {
	fragColor = glColor;
}
