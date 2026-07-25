#version 330 compatibility

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform vec4 entityColor;

in vec2 texCoord;
in vec2 lmCoord;
in vec4 glColor;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 fragColor;

void main() {
	vec4 albedo = texture(gtexture, texCoord) * glColor;
	if (albedo.a < 0.1) {
		discard;
	}

	vec4 light = texture(lightmap, lmCoord);
	vec3 litColor = albedo.rgb * light.rgb;

	litColor = mix(litColor, entityColor.rgb, entityColor.a);

	fragColor = vec4(litColor, albedo.a);
}