shader_type canvas_item;

uniform vec2 resolution = vec2(1024.);

float uvrand(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment()
{
    vec2 offs = vec2(resolution.x - resolution.y, 0) / 2.;
    vec2 p = (FRAGCOORD.xy - offs) / resolution.y;

    vec2 ro = vec2(0.5, 0.5); // rect origin
    vec2 rw = vec2(0.5, 0.5); // rect extent (half width)
    float t = floor(TIME);

    for (float i = 0.; i < 6.; i+=1.)
    {
        if (uvrand(ro + t) < 0.05 * i) break;
        rw *= 0.5;
        ro += rw * (step(ro, p) * 2. - 1.);
    }
    float rnd = uvrand(ro);
    vec2 sl = rnd < 0.5 ? vec2(1,0) : vec2(0,1); // sliding param
    sl *= 2. * rw * (1. - smoothstep(0, 0.5, fract(TIME)));
    vec2 cp = (abs(rw - p + ro) - sl) * resolution.y - 3.; // rect fill
    float c = clamp(min(cp.x, cp.y), 0, 1.);
    c *= rnd * (1. - abs(floor(p.x))); // outside
    COLOR = vec4(c, 0, 0, 1.);
}
