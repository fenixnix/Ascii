shader_type canvas_item;

float luminance(vec3 c)
{
	return dot(c, vec3(.2126, .7152, .0722));
}

vec4 filterf(sampler2D tx,in vec2 fragCoord, vec2 pixel_size)
{
	vec4 hc =
		texture(tx,vec2(-1.,-1.)*pixel_size+fragCoord) *  1. + texture(tx,vec2(0,-1)*pixel_size + fragCoord) *  2.
		+texture(tx,vec2(1,-1)*pixel_size+fragCoord) *  1. + texture(tx,vec2(-1, 1)*pixel_size+fragCoord) * -1.
		+texture(tx,vec2(0, 1)*pixel_size+fragCoord) * -2. + texture(tx,vec2( 1, 1)*pixel_size+fragCoord) * -1.;
	vec4 vc = 
		texture(tx,vec2(-1.,-1.)*pixel_size+fragCoord) *  1. + texture(tx,vec2(-1,0)*pixel_size + fragCoord) *  2.
		+texture(tx,vec2(-1,1)*pixel_size+fragCoord) *  1. + texture(tx,vec2(1,-1)*pixel_size+fragCoord) * -1.
		+texture(tx,vec2(1, 0)*pixel_size+fragCoord) * -2. + texture(tx,vec2(1, 1)*pixel_size+fragCoord) * -1.;

	return texture(tx,fragCoord) * pow(luminance(vc.rgb*vc.rgb + hc.rgb*hc.rgb), .6);
}

void fragment()
{
    COLOR = filterf(SCREEN_TEXTURE,SCREEN_UV,SCREEN_PIXEL_SIZE);
}