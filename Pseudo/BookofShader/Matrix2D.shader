shader_type canvas_item;
const float PI = 3.14159265358979323846;
//precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;

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

mat2 scale(vec2 _scale){
    return mat2(
		vec2(_scale.x,0.0),
		vec2(0.0,_scale.y)
	);
}

float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float cross_mark(in vec2 _st, float _size){
    return  box(_st, vec2(_size,_size/4.)) +
            box(_st, vec2(_size/4.,_size));
}

float boost_star(in vec2 _st, float _size){
	return box(_st, vec2(_size,_size/4.)) +
		box(_st+vec2(0.1), vec2(_size,_size/4.));
}

void fragment(){
    vec2 st = UV;
    vec3 color = vec3(0.0);
	
    vec2 translate = vec2(cos(u_time),sin(u_time));
    st -= vec2(0.5);
	st *= rotate2d(sin(u_time)*PI);
	st *= scale(vec2(sin(u_time)+1.0));
    st += vec2(0.5);

    // color = vec3(st.x,st.y,0.0);
    color += vec3(cross_mark(st,0.25));
    COLOR = vec4(color,step(0.5,color.r));
}