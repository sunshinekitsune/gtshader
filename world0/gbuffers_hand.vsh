#version 330 core

layout(location = 0) in vec3 vaPosition;
layout(location = 1) in vec2 vaUV0;
layout(location = 2) in vec2 vaUV2;
layout(location = 3) in vec4 vaColor;

uniform mat4 gbufferModelView;
uniform mat4 gbufferProjection;

out vec2 texCoord;
out vec2 lmCoord;
out vec4 color;

void main() {
    gl_Position = gbufferProjection * gbufferModelView * vec4(vaPosition, 1.0);
    texCoord = vaUV0;
    lmCoord = vaUV2 * (1.0 / 256.0) + (1.0 / 32.0);
    color = vaColor;
}