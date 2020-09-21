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

vec3 tri(vec2 uv, float time)
{
    vec2 p = floor(uv2tri(uv));
    float h = rand(p + 0.1) * 0.2 + time * 0.2;
    float s = sin((rand(p + 0.2) * 3.3 + 1.2) * time) * 0.5 + 0.5;
    return hue2rgb(h) * s + 0.5;
}

void fragment()
{
    vec2 uv = (FRAGCOORD.xy - resolution.xy / 2.) / resolution.y;

    float t1 = TIME / 2.;
    float t2 = t1 + 0.5;

    vec3 c1 = tri(uv * (8. - 4. * fract(t1)) + floor(t1) * 4.,TIME);
    vec3 c2 = tri(uv * (8. - 4. * fract(t2)) + floor(t2) * 4. + 2.,TIME);

    COLOR = vec4(mix(c1, c2, abs(1. - 2. * fract(t1))), 1.);
}
