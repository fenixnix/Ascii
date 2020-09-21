shader_type canvas_item;
const float PI = 3.14159265358979323846;
//precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
uniform float pattern = 3.0;

mat2 rotate2d(float angle){
	return mat2(
		vec2(
			cos(angle),
			-sin(angle)
		),
		vec2(
			sin(angle),
			cos(angle)
		)
	);
}

float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(l,l)*4.0);
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}

void fragment(){
    vec2 st = UV;
    vec3 color = vec3(0.0);
	st *= rotate2d(sin(u_time));
	st += u_resolution;
	st = tile(st,pattern);
    st = fract(st);
	//st.y = mod(st.x,1.2);
    color = vec3(st,0.0);
    COLOR = vec4(color,1.0);
}