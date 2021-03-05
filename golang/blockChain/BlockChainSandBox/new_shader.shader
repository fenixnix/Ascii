shader_type canvas_item;

void fragment(){
	COLOR = texture(TEXTURE,vec2(UV.x+cos(UV.y+TIME*5.0)/5.0, UV.y));
}