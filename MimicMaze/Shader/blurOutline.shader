shader_type canvas_item;

uniform int kernal_size = 3;

void fragment(){
	vec2 uv = UV;
	vec4 src_color = texture(TEXTURE,UV);
	
	float sum = 0.;
	int cnt = 0;
	for(int y = -kernal_size;y<=kernal_size;y+=1){
		for(int x = -kernal_size;x<=kernal_size;x+=1){
			sum += texture(TEXTURE,uv+vec2(float(x),float(y))*TEXTURE_PIXEL_SIZE).a;
			cnt ++;
		}
	}
	sum /= step(.2,float(cnt));
	
	vec4 color = textureLod(SCREEN_TEXTURE,SCREEN_UV,0);
	if(src_color.a>0.0){
		color = src_color;
	}
	COLOR = color;
	//COLOR = vec4(sum);
}