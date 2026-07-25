#version 330 compatibility

out vec4 glColor;

void main() {
	gl_Position = ftransform();
	glColor = gl_Color;
}
