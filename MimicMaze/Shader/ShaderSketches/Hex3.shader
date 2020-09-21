shader_type canvas_item;

uniform vec2 resolution = vec2(1024.);

void fragment()
{
    const float pi = 3.1415926535;
    vec2 p = FRAGCOORD.xy - resolution / 2.;
    float phi = atan(p.y, p.x + 1e-5);

    float fin = mod(floor(phi * 3. / pi + 0.5), 6.);
    float phi_fin = fin * pi / 3.;

    vec2 dir = vec2(cos(phi_fin), sin(phi_fin));
    float l = dot(dir, p) - TIME * resolution.y / 8.;
    float seg = floor(l * 70. / resolution.y);

    float th = sin(TIME) * 0.4 + 0.5;
    float t = sin(seg * 92.198763) * TIME;
    COLOR = vec4(step(th, fract(phi / pi / 2. + t)));
}
