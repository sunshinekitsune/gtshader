#version 330 core

in vec4 starColor;
in vec3 vViewPos;

out vec4 fragColor;

#include "/lib/fog.glsl"

void main() {
    vec3 viewDir = normalize(vViewPos);
    vec3 worldDir = normalize(mat3(gbufferModelViewInverse) * viewDir);
    vec3 col = getSkyColor(worldDir);

    if (starColor.r == starColor.g && starColor.g == starColor.b && starColor.a > 0.0) {
        col += starColor.rgb * starColor.a;
    }
    
    fragColor = vec4(col, 1.0);
}