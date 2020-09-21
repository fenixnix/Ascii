shader_type canvas_item;

uniform vec2 resolution = vec2(1024.);

vec2 rotate(vec2 p, float theta)
{
    vec2 sncs = vec2(sin(theta), cos(theta));
    return vec2(p.x * sncs.y - p.y * sncs.x, dot(p, sncs));
}

float swirl(vec2 coord, float t)
{
    float l = length(coord) / resolution.x;
    float phi = atan(coord.y, coord.x + 1e-6);
    return sin(l * 10. + phi - t * 4.) * 0.5 + 0.5;
}

float halftone(vec2 coord, float angle, float t, float amp, float time)
{
    coord -= resolution * 0.5;
    float size = resolution.x / (60. + sin(time * 0.5) * 50.);
    vec2 uv = rotate(coord / size, angle / 180. * 3.14); 
    vec2 ip = floor(uv); // column, row
    vec2 odd = vec2(0.5 * mod(ip.y, 2), 0); // odd line offset
    vec2 cp = floor(uv - odd) + odd; // dot center
    float d = length(uv - cp - 0.5) * size; // distance
    float r = swirl(cp * size, t) * size * 0.5 * amp; // dot radius
    return 1. - clamp(d  - r, 0, 1.);
}

void fragment()
{
	float time = TIME;
    vec3 c1 = 1. - vec3(1., 0, 0) * halftone(FRAGCOORD.xy,   0, time * 1.00, 0.7, time);
    vec3 c2 = 1. - vec3(0, 1., 0) * halftone(FRAGCOORD.xy,  30, time * 1.33, 0.7, time);
    vec3 c3 = 1. - vec3(0, 0, 1.) * halftone(FRAGCOORD.xy, -30, time * 1.66, 0.7, time);
    vec3 c4 = 1. - vec3(1., 1., 1.) * halftone(FRAGCOORD.xy,  60, time * 2.13, 0.4, time);
    COLOR = vec4(c1 * c2 * c3 * c4,1.);
}
