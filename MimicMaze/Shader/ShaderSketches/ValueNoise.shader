shader_type canvas_item;

uniform vec2 resolution = vec2(1024.);


float rand(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise(vec2 p)
{
    vec2 ip = floor(p);
    float r00 = rand(ip);
    float r01 = rand(ip + vec2(0, 1));
    float r10 = rand(ip + vec2(1, 0));
    float r11 = rand(ip + vec2(1, 1));
    vec2 fp = smoothstep(0, 1, p - ip);
    return mix(mix(r00, r01, fp.y), mix(r10, r11, fp.y), fp.x);
}

void fragment()
{
    vec2 p = FRAGCOORD.xy * 20. / resolution.y;
    COLOR = vec4(noise(p));
}
