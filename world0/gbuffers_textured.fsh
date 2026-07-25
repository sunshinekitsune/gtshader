#version 330 compatibility

uniform sampler2D gtexture;

in vec2 texCoord;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 fragColor;

void main() {
	vec4 albedo = texture(gtexture, texCoord);

	fragColor = albedo;

	if (fragColor.a < 0.1) {
		discard;
	}
}