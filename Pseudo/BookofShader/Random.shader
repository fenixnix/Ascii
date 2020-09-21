shader_type canvas_item;
const float PI = 3.14159265358979323846;

uniform float x_offset = 1.0;
uniform float scale = 1.0;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

void fragment(){
    vec2 st = UV;
    vec3 color = vec3(0.0);
	st.x += x_offset;
	st *= scale;
 	vec2 ipos = floor(st);  // get the integer coords
    vec2 fpos = fract(st);  // get the fractional coords

    // Assign a random value based on the integer coord
    color = vec3(random( ipos ));
    COLOR =  vec4(color,1.0);
}