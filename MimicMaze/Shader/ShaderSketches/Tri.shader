shader_type canvas_item;

const float PI = 3.141592;

uniform vec2 resolution = vec2(1024.);



void fragment()
{
    vec2 coord = FRAGCOORD.xy - resolution * 0.5;

    float phi = atan(coord.y, coord.x + 1e-6);
    float seg = fract(phi / (2. * PI) + 0.5 - 0.5 / 6.) * 3.;

    float theta = (floor(seg) * 2. / 3. + 0.5) * PI;
    vec2 dir = vec2(-cos(theta), -sin(theta));

    float y = dot(dir, coord);
    float w = resolution.x * 0.08;

    float phase = TIME * 1.1;
    float pr = y / w - TIME * 1.4;
    float id = floor(pr) - floor(phase);

    float th1 = fract( id      / 2.) * 2.;
    float th2 = fract((id + 1.) / 2.) * 2.;
    float thp = min(1, fract(phase) + fract(seg) * 0.2);
    float th = mix(th1, th2, smoothstep(0.8, 1.0, thp));

    float d = fract(pr);
    float c = clamp((abs(0.5 - d) - (1. - th) / 2.) * w / 2., 0, 1.);

    COLOR = vec4(c, c, c, 1.);
}
