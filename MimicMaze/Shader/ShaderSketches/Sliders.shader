shader_type canvas_item;

uniform vec2 resolution = vec2(1024.);
uniform vec3 spectrum;

float rand(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment()
{
    float t = TIME * 1.2;

    float rep = 2. + pow(rand(vec2(floor(t))), 2.) * 100.;
    vec2 p0 = FRAGCOORD.xy / vec2(20., resolution.y / rep);
    vec2 p1 = floor(p0);
    vec2 p2 = fract(p0);

    float r = rand(p1 + floor(t) * 0.11356);
    float x = 1. - p2.y;
    float sp = mix(spectrum.x * 2., spectrum.y * 4.,step(0.5,r));
    float th = fract(t - min(1., sp * (1. + r * 2.)));
    float c = step(smoothstep(0, 1., th), x);
    COLOR = vec4(c);
}
