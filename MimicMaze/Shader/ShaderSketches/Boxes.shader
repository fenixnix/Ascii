shader_type canvas_item;

uniform float resulotion = 1024.;

float circle(vec2 coord, vec2 offs, float iGlobalTime)
{
    float reso = 16.0;
    float cw = float(resulotion) / reso;

    vec2 p = mod(coord, cw) - cw * 0.5 + offs * cw;

    vec2 p2 = floor(coord / cw) - offs;
    vec2 gr = vec2(0.193, 0.272);
    float tr = iGlobalTime * 2.0;
    float ts = tr + dot(p2, gr);

    float sn = sin(tr), cs = cos(tr);
    p = mat2(
		vec2(cs, -sn),
		vec2(sn, cs)
		) * p;

    float s = cw * (0.3 + 0.3 * sin(ts));
    float d = max(abs(p.x), abs(p.y));

    return max(0.0, 1.0 - abs(s - d));
}

void fragment()
{
	int width = textureSize(TEXTURE,0).x;
    float c = 0.0;
    for (int i = 0; i < 9; i++)
    {
        float dx = mod(float(i), 3.0) - 1.0;
        float dy = float(i / 3) - 1.0;
        c += circle(FRAGCOORD.xy, vec2(dx, dy),TIME*0.5);
    }
    COLOR = vec4(vec3(min(1.0, c)), 1);
}