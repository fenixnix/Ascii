shader_type spatial;

uniform vec2 center = vec2(16,16);

uniform float grid_size = .25;
uniform float panel_size = 4.;

uniform vec2 map_size = vec2(32.);

uniform sampler2D map;

uniform sampler2D tile_sea;
uniform sampler2D tile_sand;
uniform sampler2D tile_dirt;

vec3 GetTileIndex(vec2 map_uv){
	return texture(map,map_uv).rgb;
}

void fragment(){
	float gridSizeInUV = grid_size/panel_size;
	vec2 uvUnitSize = map_size*grid_size/panel_size;
	vec2 uv = UV+center*grid_size/panel_size;
	
	vec2 posIndex = floor(uv/uvUnitSize*map_size)/map_size;
	//vec3 tileIndex = fract(posIndex).xyx;
	vec3 tileIndex = GetTileIndex(posIndex);
	//tile around
//	vec3 tileIndexUp = GetTileIndex(posIndex+vec2(0,-1.)*gridSizeInUV);
//	vec3 tileIndexLeft = GetTileIndex(posIndex+vec2(-1,0)*gridSizeInUV);
//	vec3 tileIndexRight = GetTileIndex(posIndex+vec2(1.,0)*gridSizeInUV);
//	vec3 tileIndexDown = GetTileIndex(posIndex+vec2(0,1.)*gridSizeInUV);

	vec3 clr = vec3(1.);
	//Fill Tile
	if(tileIndex.g>.1){
		clr = texture(tile_sea,fract(uv/gridSizeInUV)).rgb;
	}else{
		clr = texture(tile_sand,fract(uv/gridSizeInUV)).rgb;
	}
	
	ALBEDO = clr;
	ALPHA = 1.;
}