shader_type canvas_item;


uniform vec2 resolution = vec2(1024.);


float rand(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

vec2 uv2tri(vec2 uv)
{
    float sx = uv.x - uv.y / 2.; // skewed x
    float sxf = fract(sx);
    float offs = step(fract(1. - uv.y), sxf);
    return vec2(floor(sx) * 2. + sxf + offs, uv.y);
}

void fragment()
{
    vec2 uv = (FRAGCOORD.xy - resolution / 2.) / resolution.y * 8.;
    uv.y += TIME;

    float t = TIME * 0.8;
    float tc = floor(t);
    float tp = smoothstep(0, 0.8, fract(t));

    vec2 r1 = vec2(floor(uv.y), tc);
    vec2 r2 = vec2(floor(uv.y), tc + 1.);
    float offs = mix(rand(r1), rand(r2), tp);

    uv.x += offs * 8.;

    vec2 p = uv2tri(uv);
    float ph = rand(floor(p)) * 6.3 + p.y * 0.2;
    float c = abs(sin(ph + TIME));

    COLOR = vec4(c, c, c, 1.);
}
