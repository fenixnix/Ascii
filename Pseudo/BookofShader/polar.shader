shader_type canvas_item;
	
const float PI = 3.141592653;

vec2 polar(vec2 p){
	float r = length(p);
	float i = acos(p.x)/PI;
	return vec2(r,i);
}

void fragment(){
	vec2 uv = UV-.5;
	vec2 uv2 = polar(uv);
	
	float mask = smoothstep(.5,0.,uv2.x);
	
	//vec3 clr = texture(SCREEN_TEXTURE,uv2).rgb;
	//vec3 clr = uv2.xyx*mask;
	vec3 clr = vec3(mask);
	
	COLOR = vec4(vec3(clr),1.);
}