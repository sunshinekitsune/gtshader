#ifndef FOG_GLSL
#define FOG_GLSL

uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float far;
uniform mat4 gbufferModelViewInverse;

vec3 getSkyColor(vec3 worldDir) {
    if (worldDir.y >= 0.0) {
        float up = clamp(worldDir.y, 0.0, 1.0);
        float elevationFactor = pow(up, 0.55);
        return mix(fogColor, skyColor, elevationFactor);
    } else {
        float down = clamp(-worldDir.y, 0.0, 1.0);
        float elevationFactor = pow(down, 0.75);
        return mix(fogColor, fogColor * 0.75, elevationFactor);
    }
}

vec3 applyBedrockFog(vec3 color, vec3 viewPos) {
    float dist = length(viewPos);
    vec3 viewDir = viewPos / max(dist, 0.0001);
    vec3 worldDir = normalize(mat3(gbufferModelViewInverse) * viewDir);
    vec3 targetSkyColor = getSkyColor(worldDir);
    
    float fogStart = far * 0.01;
    float fogEnd = far;
    float t = clamp((dist - fogStart) / max(fogEnd - fogStart, 0.0001), 0.0, 1.0);

    float fogFactor = t * t;
    return mix(color, targetSkyColor, fogFactor);
}

#endif // FOG_GLSL