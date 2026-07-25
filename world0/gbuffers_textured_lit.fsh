#version 330 compatibility

uniform sampler2D gtexture;
uniform sampler2D lightmap;

in vec2 texCoord;
in vec2 lmCoord;
in vec4 glColor;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 fragColor;

void main() {
	vec4 albedo = texture(gtexture, texCoord) * glColor;
	vec4 light = texture(lightmap, lmCoord);
	fragColor = albedo * light;
}
