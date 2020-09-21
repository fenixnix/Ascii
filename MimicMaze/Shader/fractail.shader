shader_type canvas_item;

uniform vec2 center;
uniform float pixel_grid = 64;
uniform float val = .1;

void vertex(){
	vec2 pos = VERTEX;
	vec2 dif = pos - center*256.;
	pos += dif*length(dif)*.01*val;
	VERTEX = pos;
	//POINT_SIZE = .3;
}

void fragment(){
	vec2 uv = UV;
	float pixel = sin(TIME)*pixel_grid;
	vec4 tx = texture(TEXTURE,floor(uv*pixel)/pixel);
	//tx = texture(TEXTURE,uv);
	uv = sin(uv*64.*3.14);
	float m = step(val,uv.x)*step(val,uv.y);

	tx *= m;
	COLOR = tx;
}