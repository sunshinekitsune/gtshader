#version 330 core

in vec2 texCoord;
in vec2 lmCoord;
in vec4 color;
in vec3 vViewPos;
in vec3 vWorldDir;

out vec4 fragColor;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

#include "/lib/fog.glsl"

void main() {
    vec4 albedo = texture(gtexture, texCoord) * color;
    if (albedo.a < 0.01) discard;

    vec4 lm = texture(lightmap, lmCoord);
    vec3 litColor = albedo.rgb * lm.rgb;
    
    litColor = applyBedrockFog(litColor, vViewPos, vWorldDir);
    
    fragColor = vec4(litColor, albedo.a);
}