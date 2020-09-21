shader_type canvas_item;


uniform vec2 resolution = vec2(1024.);


float rand(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

vec3 hue2rgb(float h)
{
    h = fract(h) * 6. - 2.;
    return clamp(vec3(abs(h - 1.) - 1., 2. - abs(h), 2. - abs(h - 2.)), 0, 1.);
}

vec2 uv2tri(vec2 uv)
{
    float sx = uv.x - uv.y / 2.; // skewed x
    float sxf = fract(sx);
    float offs = step(fract(1. - uv.y), sxf);
    return vec2(floor(sx) * 2. + sxf + offs, uv.y);
}

float tri(vec2 uv, float time)
{
    vec2 p = floor(uv2tri(uv));
    p = vec2(p.x + p.y, p.y * 2.);
    float d = length(p + 1.);
    float f1 = 1.6 + sin(time * 0.5765) * 0.583;
    float f2 = 1.3 + sin(time * 1.7738) * 0.432;
    return abs(sin(f1 * d) * sin(f2 * d));
}

void fragment()
{
    float t = smoothstep(0.2, 0.8, fract(TIME));

    vec2 uv = FRAGCOORD.xy - resolution.xy / 2.;
    uv *= (2. - t) / resolution.y;

    float c = mix(tri(uv * 4.,TIME), tri(uv * 8.,TIME), t);
    COLOR = vec4(vec3(c), 1.);
}
