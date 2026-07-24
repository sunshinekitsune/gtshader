#ifndef FOG_GLSL
#define FOG_GLSL

uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float far;

// Computes seamless atmosphere color matching current biome
vec3 getSkyColor(vec3 worldDir, vec3 fallbackColor) {
    float dist = length(worldDir);
    float nWorldY = dist > 0.0001 ? worldDir.y / dist : 0.0;

    // Prefer skyColor for modded biomes like Thaumcraft Tainted Land (purple)
    vec3 baseSky = dot(skyColor, skyColor) > 0.0001 ? skyColor : fallbackColor;

    // Smooth elevation factor above 3D world horizon
    float horizonFactor = clamp(nWorldY * 3.0, 0.0, 1.0);
    horizonFactor = smoothstep(0.0, 1.0, horizonFactor);

    // Blend fogColor at horizon up to baseSky at zenith
    return mix(fogColor, baseSky, horizonFactor);
}

// Applies direction-matched 1% near distance fog
vec3 applyBedrockFog(vec3 litColor, vec3 viewPos, vec3 worldDir) {
    float dist = length(viewPos);
    if (dist < 0.0001) return litColor;

    // Safety fallback: prevents division by zero if far == 0.0
    float safeFar = far > 1.0 ? far : 128.0;

    // Fast 1% -> 100% fog factor using single-cycle MAD math
    float fogFactor = clamp((dist / safeFar - 0.01) * 1.010101, 0.0, 1.0);
    fogFactor *= fogFactor; // Quadratic curve (x^2)

    // Detect biome sky color (e.g., Thaumcraft purple)
    vec3 baseSky = dot(skyColor, skyColor) > 0.0001 ? skyColor : fogColor;

    // Calculate elevation angle
    float nWorldY = dist > 0.0001 ? worldDir.y / dist : 0.0;
    float horizonFactor = clamp(nWorldY * 3.0, 0.0, 1.0);
    horizonFactor = smoothstep(0.0, 1.0, horizonFactor);

    // Weight target color towards baseSky so distant terrain fades directly
    // into the purple sky background instead of pale grey fogColor!
    vec3 targetSkyColor = mix(fogColor, baseSky, max(horizonFactor, 0.5));

    // Mix terrain into target sky color
    return mix(litColor, targetSkyColor, fogFactor);
}

#endif // FOG_GLSL