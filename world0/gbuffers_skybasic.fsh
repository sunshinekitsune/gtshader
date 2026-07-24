#version 330 core

in vec4 starColor;
in vec3 vViewPos;
in float isStar;

out vec4 fragColor;

uniform mat4 gbufferModelViewInverse;

#include "/lib/fog.glsl"

void main() {
    // Render stars / celestial objects sharply
    if (isStar > 0.5) {
        fragColor = vec4(starColor.rgb, starColor.a);
        return;
    }

    vec3 worldDir = mat3(gbufferModelViewInverse) * vViewPos;
    vec3 col = getSkyColor(worldDir, starColor.rgb);

    fragColor = vec4(col, 1.0);
}