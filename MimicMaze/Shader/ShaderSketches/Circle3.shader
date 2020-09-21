shader_type canvas_item;

uniform float resolution = 1024.;

float circle(vec2 coord, vec2 seed, float time)
{
    float reso = 16.0;
    float cw = resolution / reso;

    vec2 p = mod(coord, cw);
    float d = distance(p, vec2(cw / 2.0));

    float rnd = dot(floor(coord / cw), seed);
    float t = time * 2.0 + fract(sin(rnd)) * 6.2;

    float l = cw * (sin(t) * 0.25 + 0.25);
    return clamp(l - d, 0.0, 1.0);
}

float circle3(vec2 coord, float spd, float time)
{
    float reso = 12.0;
    float cw = resolution / reso;

    vec2 p = mod(coord, cw);
    float d = distance(p, vec2(cw / 2.0));

    float rnd = dot(floor(coord / cw), vec2(1323.443, 1412.312));
    float t = time * 2.0 + fract(sin(rnd)) * 6.2;

    float l = cw * (sin(t * spd) * 0.25 + 0.25);
    return clamp(l - d, 0.0, 1.0);
}

void fragment()
{
    vec2 p = FRAGCOORD.xy;
    vec2 dp = vec2(7.9438, 0.3335) * TIME;
//    float c1 = circle3(p - dp, vec2(323.443, 412.312),TIME);
//    float c2 = circle3(p + dp, vec2(878.465, 499.173),TIME);
    float c1 = circle3(p - dp, 1.0,TIME);
    float c2 = circle3(p + dp, 1.4,TIME);
    float c = max(0.0, c1 - c2);
    COLOR = vec4(vec3(c), 1);
}