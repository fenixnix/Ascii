shader_type canvas_item;

const float pi = 3.1415926;

uniform float resolution = 1024.;

float rand(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment()
{
    float scale = resolution/5.;
    vec2 p = FRAGCOORD.xy / scale;
    float t = TIME * 0.6 + rand(floor(p)) * 200.;
    
    float s2 = 1.6 + 0.6 * sin(t);
    p = (fract(p) - 0.5) * s2; // repeat and scale
    scale /= s2;

    float d1 = 1e6; // distance field (petal)
    float d2 = 0.;   // distance field (cut)

    for (int i = 0; i < 5; i++)
    {
        float phi = pi * (2.0 * float(i) / 5. + 0.1) + t;

        vec2 v1 = vec2(cos(phi), sin(phi)); // outward vector
        vec2 v2 = vec2(-v1.y, v1.x);        // vertical vector
        vec2 v3 = vec2(cos(phi - 1.), sin(phi - 1.)); // cut line 1
        vec2 v4 = vec2(cos(phi + 1.), sin(phi + 1.)); // cut line 2

        d1 = min(d1, max(distance(p, v1 * 0.27 - v2 * 0.15),
                         distance(p, v1 * 0.27 + v2 * 0.15)));

        d2 = max(d2, min(dot(v3, p) - dot(v3, v1 * 0.4),
                         dot(v4, p) - dot(v4, v1 * 0.4)));
    }

    vec2 c12 = vec2(1) - vec2(d1 - 0.29, d2) * scale;
    vec3 c = max(vec3(1, 0.7, 0.7) + p.y, 0) * min(c12.x, c12.y);

    COLOR = vec4(c, 1);
}