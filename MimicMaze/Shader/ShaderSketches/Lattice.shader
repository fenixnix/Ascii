shader_type canvas_item;


uniform vec2 resolution = vec2(1024.);


void fragment()
{
    const float pi = 3.1415926;
    float t = TIME * 0.7;

    float scale = 10. / resolution.y;
    vec2 p = FRAGCOORD.xy * scale + 0.5; // pos normalized /w grid
    p += vec2(2., 0.5) * TIME;

    float rnd = fract(sin(dot(floor(p), vec2(21.98, 19.37))) * 4231.73);
    rnd = floor(rnd * 2.) / 2. + floor(t) / 2.;

    float anim = smoothstep(0, 0.7, fract(t));
    float phi = pi * (rnd + 0.5 * anim + 0.25);
    vec2 dir = vec2(cos(phi), sin(phi));

    vec2 pf = fract(p);
    float d1 = abs(dot(pf - vec2(0.5, 0), dir)); // line 1
    float d2 = abs(dot(pf - vec2(0.5, 1), dir)); // line 2

    COLOR = vec4((0.1 - min(d1, d2)) / scale);
}
