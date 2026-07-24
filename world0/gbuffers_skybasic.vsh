#version 330 core

layout(location = 0) in vec3 vaPosition;
layout(location = 3) in vec4 vaColor;

uniform mat4 gbufferModelView;
uniform mat4 gbufferProjection;

out vec4 starColor;
out vec3 vViewPos;

void main() {
    vViewPos = (gbufferModelView * vec4(vaPosition, 1.0)).xyz;
    starColor = vaColor;
    
    gl_Position = gbufferProjection * vec4(vViewPos, 1.0);
}