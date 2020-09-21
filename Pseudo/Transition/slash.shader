shader_type canvas_item;

uniform float progress:hint_range(-5.,5.) = 0.5;
uniform float range:hint_range(.1,5.) = 1.;
uniform vec2 offset;

float dome(vec2 _pos,float _radius){
	vec2 l = (_pos-vec2(0.5))/_radius;
	return min(1.,length(l));
}

void fragment(){
	vec4 color = texture(TEXTURE,UV);
	vec2 pos = UV+vec2(1.,-1.)*progress;
	float alpha = 1.-dome(pos,range);
	COLOR = vec4(vec3(color.r),smoothstep(0,1.,alpha)*color.a);
	//COLOR = vec4(alpha);
}