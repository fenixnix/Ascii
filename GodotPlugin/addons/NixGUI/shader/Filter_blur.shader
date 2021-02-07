shader_type canvas_item;

uniform float kernal_size:hint_range(0,32) = 3;

void fragment(){
	vec2 uv = SCREEN_UV;
	vec4 tx = texture(SCREEN_TEXTURE,uv);
//	vec4 sum = vec4(0);
//	int cnt = 0;
//	for(int y = -kernal_size;y<=kernal_size;y+=1){
//		for(int x = -kernal_size;x<=kernal_size;x+=1){
//			sum += texture(SCREEN_TEXTURE,uv+vec2(float(x),float(y))*SCREEN_PIXEL_SIZE);
//			cnt ++;
//		}
//	}
//	sum /= float(cnt);
//	COLOR = vec4(sum.xyz,tx.a);
	COLOR = textureLod(SCREEN_TEXTURE,SCREEN_UV,kernal_size);
}