shader_type canvas_item;

uniform vec2 center;
uniform float resolution = 1024.;
const float pi = 3.1415926;

float uvrand(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

float arc(vec2 coord, float _time)
{
    float t = floor(_time * 1.1) * 7.3962;

    vec2 sc = (coord.xy - vec2(resolution) / 2.) / resolution;
    float phi = atan(sc.y, sc.x + 1e-6);
    vec2 pc = vec2(fract(phi / (pi * 2.) + _time * 0.07), length(sc));

    vec2 org = vec2(0.5, 0.5);
    vec2 wid = vec2(0.5, 0.5);

    for (float i = 0.; i < 7.; i+=1.)
    {
        //if (uvrand(org + t) < 0.04 * i) break;
        if (uvrand(org) < 0.04 * i) break;
        wid *= 0.5;
        org += wid * (step(org, pc) * 2. - 1.);
    }

    return uvrand(org);
}

void fragment()
{
    vec4 delta = vec4(-1, -1, 1, 1) * .5;
	vec2 pos = FRAGCOORD.xy + center;
	
    // neightbor four samples
    float c1 = arc(pos + delta.xy,TIME);
    float c2 = arc(pos + delta.zy,TIME);
    float c3 = arc(pos + delta.xw,TIME);
    float c4 = arc(pos + delta.zw,TIME);

    // roberts cross operator
    float gx = c1 - c4;
    float gy = c2 - c3;
	float g = sqrt(gx * gx + gy * gy);

    COLOR = vec4(g * 4.);
}
