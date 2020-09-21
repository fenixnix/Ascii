shader_type canvas_item;

uniform float thresh:hint_range(0.0,1.0) = 0.5;
uniform sampler2D mask;

void fragment(){
	vec3 color = vec3(texture(mask,UV).r);
	COLOR = vec4(vec3(0),step(color.r,thresh));
}