#version 330 core

in vec2 texCoord;
in vec2 lmCoord;
in vec4 color;

out vec4 fragColor;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

void main() {
    vec4 albedo = texture(gtexture, texCoord) * color;
    if (albedo.a < 0.1) discard;
    
    vec4 lm = texture(lightmap, lmCoord);
    
    fragColor = vec4(albedo.rgb * lm.rgb, albedo.a);
}