shader_type canvas_item;

uniform float resolution = 1024.;

float circles(vec2 coord, float _time)
{
    float reso = 5.0;
    float width = resolution / reso;

    vec2 center = floor(coord / width + 0.5) * width;
    float dist = distance(coord, center);

    float time = _time * 0.9;
    float phase = dot(center, vec2(1.647346, 7.323874));
    float radius = width * (0.3 + sin(time + phase) * 0.16);

    return dist - radius;
}

float line(vec2 coord, float seed, float _time)
{
    vec2 dir = vec2(-1.0, 1.0);
    float bound = dot(vec2(resolution), abs(dir));

    float speed = fract(seed * 4785.9433) * 0.3 + 0.3;
    float time = fract(_time * speed);

    float phase = _time * (fract(seed * 438.454) * 3.3 + 3.3);
    float width = bound * 0.02 * (sin(phase) + 1.0);

    float dist = dot(coord, dir) + (time - 0.5) * bound;
    return abs(dist) - width;
}

void fragment()
{
    vec2 p = FRAGCOORD.xy;
    
    float c = 1e+6;
    for (int i = 0; i < 4; i++)
        c = min(c, line(p, 94.3 * float(i),TIME));

    c = max(c, circles(p,TIME));
    c = clamp(1.0 - abs(1.0 - c), 0.0, 1.0);
    
    COLOR = vec4(vec3(c, c, c), 1);
}