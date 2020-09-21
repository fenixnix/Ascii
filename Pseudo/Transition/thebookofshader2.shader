shader_type canvas_item;

vec4 red(float time){
	return vec4(vec3(abs(cos(time)),abs(sin(time)),0),1.0);
}

float plot(vec2 st, float pct){
	return smoothstep(pct-0.02,pct,st.y) -
		smoothstep(pct,pct+0.02,st.y);
}

void fragment(){
	vec3 color = vec3(0);
	vec2 bl = smoothstep(vec2(0.2),vec2(0.4),UV);
	float pct = bl.x*bl.y;
	vec2 tr = smoothstep(vec2(0.2),vec2(0.4),1.0-UV);
	pct *= tr.x*tr.y;
	color = vec3(pct);
	COLOR = vec4(color,1);
}

