shader_type canvas_item;

vec4 red(float time){
	return vec4(vec3(abs(cos(time)),abs(sin(time)),0),1.0);
}

float plot(vec2 st, float pct){
	return smoothstep(pct-0.02,pct,st.y) -
		smoothstep(pct,pct+0.02,st.y);
}

void fragment(){
//	COLOR = red(TIME);
//	COLOR.r = UV.x;
	float x = UV.x;
	float y = smoothstep(0.0,1.0,sin(UV.x+TIME));
	//y = sin(x);
	//y = mod(x,0.5);
	//y = fract(x);
	//y = floor(x);
	y = sign(x);
	
	float pct = plot(UV,1.0-y);
	vec3 color = vec3(y);
	color = (1.0-pct)*color + pct*vec3(0.0,1.0,0.0);
	COLOR = vec4(color,1.0);
	
	//Color
	pct = abs(sin(TIME));
	COLOR = mix(vec4(1.0,0.0,0.0,1.0),vec4(0.0,1.0,0.0,1.0),pct);
}

