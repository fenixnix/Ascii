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

float tri(vec2 uv,float time)
{
    float sp = 1.2 + 3.3 * rand(floor(uv2tri(uv)));
    return max(0, sin(sp * time));
}

void fragment()
{
    vec2 uv = (FRAGCOORD.xy - resolution.xy / 2.) / resolution.y;

    float t1 = TIME / 2.;
    float t2 = t1 + 0.5;

    float c1 = tri(uv * (2. + 4. * fract(t1)) + floor(t1),TIME);
    float c2 = tri(uv * (2. + 4. * fract(t2)) + floor(t2),TIME);

    COLOR = vec4(mix(c1, c2, abs(1. - 2. * fract(t1))));
}
