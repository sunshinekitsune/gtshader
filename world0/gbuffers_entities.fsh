#version 330 core

in vec2 texCoord;
in vec2 lmCoord;
in vec4 color;
in vec3 vViewPos;

out vec4 fragColor;

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform vec4 entityColor;

#include "/lib/fog.glsl"

void main() {
    vec4 albedo = texture(gtexture, texCoord) * color;
    if (albedo.a < 0.1) discard;
    
    albedo.rgb = mix(albedo.rgb, entityColor.rgb, entityColor.a);
    
    vec4 lm = texture(lightmap, lmCoord);
    vec3 litColor = albedo.rgb * lm.rgb;
    
    litColor = applyBedrockFog(litColor, vViewPos);
    
    fragColor = vec4(litColor, albedo.a);
}