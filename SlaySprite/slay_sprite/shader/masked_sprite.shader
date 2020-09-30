shader_type canvas_item;

uniform sampler2D mask;

void fragment(){
	vec4 clr = texture(TEXTURE,UV);
	vec4 msk = texture(mask,UV);
	COLOR = clr*msk.a;
}