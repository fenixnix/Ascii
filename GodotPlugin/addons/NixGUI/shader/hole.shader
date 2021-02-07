shader_type canvas_item;
render_mode blend_add;

uniform float S = 0.2;
uniform float C = 8.0;
uniform float T = 40.0;
uniform vec2 Resolution = vec2(1,1);

void fragment()
{
	vec2 R = Resolution.xy;
	vec2 U = (UV + UV - R)/R.y;

    // Convert to polar coordinates.
    float a = atan(U.y, U.x),
        r = length(U),
        l = max(0., 1. - r * (1. + S*(1.+sin(a*C+r*T-TIME*5.0))));
   
	//COLOR = vec4(l,l,l,1);
    COLOR = vec4(l*l, 3.*l,l,l);
}