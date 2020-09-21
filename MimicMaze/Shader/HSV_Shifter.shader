shader_type canvas_item;

uniform float hue = 0.;
uniform float saturation = 1.;
uniform float value = 1.;

vec3 RGB2HSV(vec3 c)
{
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 HSV2RGB(vec3 c)
{
      vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
      vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
      return c.z * mix(K.xxx, clamp(p - K.xxx,0.,1.), c.y);
}

vec3 ShiftHue(vec3 c){
	vec3 hsv = RGB2HSV(c);
	hsv.r = fract(hsv.r+hue);
	hsv.g *= saturation;
	hsv.b *= value;
	return HSV2RGB(hsv);
}

void fragment(){
	vec4 clr = texture(TEXTURE,UV);
	clr.rgb = ShiftHue(clr.rgb);
	COLOR = clr;
}