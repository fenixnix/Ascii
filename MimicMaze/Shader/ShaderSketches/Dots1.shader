shader_type canvas_item;

uniform vec2 resolution = vec2(1024.);

float swirl(vec2 coord, float time)
{
    float l = length(coord) / resolution.x;
    float phi = atan(coord.y, coord.x + 1e-6);
    return sin(l * 10. + phi - time * 4.) * 0.5 + 0.5;
}

float halftone(vec2 coord, float time)
{
    coord -= resolution * 0.5;
    float size = resolution.x / (60. + sin(time * 0.5) * 50.);
    vec2 uv = coord / size; 
    vec2 ip = floor(uv); // column, row
    vec2 odd = vec2(0.5 * mod(ip.y, 2), 0); // odd line offset
    vec2 cp = floor(uv - odd) + odd; // dot center
    float d = length(uv - cp - 0.5) * size; // distance
    float r = swirl(cp * size, time) * (size - 2.) * 0.5; // dot radius
    return clamp(d - r, 0, 1);
}

void fragment()
{
	float time = TIME;
	COLOR = vec4(vec3(1, 1, 0) * halftone(FRAGCOORD.xy,time), 1);
}
