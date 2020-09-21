shader_type canvas_item;

const float PI = 3.14159265358979323846;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

mat2 rotate2d(float angle){
	float s = sin(angle);
	float c = cos(angle);
	return mat2(
		vec2(c,-s),
		vec2(s,c)
	);
}

void fragment(){
	
}