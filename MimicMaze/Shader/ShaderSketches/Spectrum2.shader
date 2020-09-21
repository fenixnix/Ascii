shader_type canvas_item;

uniform vec2 resolution = vec2(1024.);
uniform vec3 spectrum;
uniform sampler2D prevFrame;

void fragment()
{
    vec2 p = FRAGCOORD.xy;
    vec3 c;
    if (p.x < 1.)
    {
        // spectrum history
        c = texture(prevFrame, vec2(p.x, p.y - 1.) / resolution).rgb;
        c = mix(spectrum * vec3(1., 16., 256.) * 2., c, min(1, p.y));
    }
    else
    {
        // color bars
        vec2 ref = vec2(0, p.x * 0.1 / resolution.y);
        c = texture(prevFrame, ref).rgb;
        c = c - abs(p.y / resolution.y - 0.5);
    }
    COLOR = vec4(c, 1.);
}
