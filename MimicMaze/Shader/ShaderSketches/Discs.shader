shader_type canvas_item;


uniform vec2 resolution = vec2(1024.);

const float rep = 10.;

void fragment()
{
    float scale = 8. / resolution.y;
    vec2 p0 = FRAGCOORD.xy * scale;

    vec2 p1 = floor(p0);
    vec2 p2 = (fract(p0 * vec2(2, 1.2)) - vec2(0, 0.5)) / vec2(2, 1.2);

    float c1 = length(p2);
    float c2 = length(vec2(0.5, 0) - p2);

    float c3 = abs(0.5 - fract(c1 * rep + 0.25));
    float c4 = abs(0.5 - fract(c2 * rep + 0.25));

    c4 *= 1. - clamp((c2 - 0.4) * 10., 0, 1.);
    float c = mix(c3, c4, clamp((c1 - 0.4) * 10., 0, 1.));

    c = (0.35 - c) / (scale * rep);

    COLOR = vec4(c);
}
