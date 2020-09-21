shader_type canvas_item;


uniform vec2 resolution = vec2(1024.);


void fragment()
{
    const float pi = 3.1415926535;
    vec2 p = FRAGCOORD.xy - resolution / 2.;
    float phi = atan(p.y, p.x + 1e-6);

    float fin = mod(floor(phi * 3. / pi + 0.5), 6.);
    float phi_fin = fin * pi / 3.;

    vec2 dir = vec2(cos(phi_fin), sin(phi_fin));
    float l = dot(dir, p) - TIME * resolution.y / 5.;

    float ivr = 20.;
    float seg = l / ivr;

    float w = sin(floor(seg) * 0.2 - TIME) * 0.4 + 0.5;
    float c = (w / 2. - abs(fract(seg) - 0.5)) * ivr;

    COLOR = vec4(c, c, c, 1.);
}
