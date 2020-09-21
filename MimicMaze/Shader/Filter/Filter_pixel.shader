shader_type canvas_item;

uniform float pixel = 4;

void fragment(){
	ivec2 size = textureSize(SCREEN_TEXTURE,0);
	vec2 pixel_size = vec2(size)/float(pixel);
	
	vec2 uv = floor(SCREEN_UV*pixel_size)/pixel_size;
	
	vec4 clr = texture(SCREEN_TEXTURE,uv);
	
	COLOR = vec4(clr.rgb,1.);
}