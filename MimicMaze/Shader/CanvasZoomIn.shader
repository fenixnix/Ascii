shader_type canvas_item;

uniform float val = .5;

void vertex(){
	vec2 size = 1./TEXTURE_PIXEL_SIZE;
	vec2 center = size/2.;
	vec2 pos = VERTEX - center;
	VERTEX = pos*val + center;
}

void fragment(){
	vec4 clr = texture(TEXTURE,UV);
	clr.a *= val;
	COLOR = clr;
}