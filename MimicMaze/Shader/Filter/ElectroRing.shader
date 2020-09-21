shader_type canvas_item;

const float M_PI = 3.1415926535897932384626433832795;
const float M_TWO_PI = 6.283185307179586;

uniform vec4 iMouse;

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898,12.1414))) * 83758.5453);
}

float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n);
    vec2 f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}

vec3 ramp(float t) {
	return t <= .5 ? vec3( 1. - t * 1.4, .2, 1.05 ) / t : vec3( .3 * (1. - t) * 2., .2, 1.05 ) / t;
}
vec2 polarMap(vec2 uv, float shift, float inner) {

    uv = vec2(0.5) - uv;
    
    
    float px = 1.0 - fract(atan(uv.y, uv.x) / 6.28 + 0.25) + shift;
    float py = (sqrt(uv.x * uv.x + uv.y * uv.y) * (1.0 + inner * 2.0) - inner) * 2.0;
    
    return vec2(px, py);
}
float fire(vec2 n) {
    return noise(n) + noise(n * 2.1) * .6 + noise(n * 5.4) * .42;
}

float shade(vec2 uv, float t) {
    uv.x += uv.y < .5 ? 23.0 + t * .035 : -11.0 + t * .03;    
    uv.y = abs(uv.y - .5);
    uv.x *= 35.0;
    
    float q = fire(uv - t * .013) / 2.0;
    vec2 r = vec2(fire(uv + q / 2.0 + t - uv.x - uv.y), fire(uv + q - t));
    
    return pow((r.y + r.y) * max(.0, uv.y) + .1, 4.0);
}

vec3 color(float grad, vec2 iResolution) {
    
    float m2 = iMouse.z < 0.0001 ? 1.15 : iMouse.y * 3.0 / iResolution.y;
    grad =sqrt( grad);
    vec3 color = vec3(1.0 / (pow(vec3(0.5, 0.0, .1) + 2.61, vec3(2.0))));
    vec3 color2 = color;
    color = ramp(grad);
    color /= (m2 + max(vec3(0), color));
    
    return color;
}

void fragment() {
	float t = TIME;
	vec2 uv = UV+vec2(.45,0);
	vec2 iResolution = 1./SCREEN_PIXEL_SIZE;
	//vec2 iResolution = 1./TEXTURE_PIXEL_SIZE;
    float m1 = iMouse.z < 0.0001 ? 3.6 : iMouse.x * 5.0 / iResolution.x;
    
    //vec2 uv = FRAGCOORD.xy / iResolution.yy;
    float ff = 1.0 - uv.y;
    uv.x -= (iResolution.x / iResolution.y - 1.0) / 2.0;
    vec2 uv2 = uv;
    uv2.y = 1.0 - uv2.y;
	uv = polarMap(uv, 1.3, m1);
	uv2 = polarMap(uv2, 1.9, m1);

    vec3 c1 = color(shade(uv, t),iResolution) * ff;
    vec3 c2 = color(shade(uv2, t),iResolution) * (1.0 - ff);
    
    COLOR = vec4(c1 + c2, c1.g+c2.g);
}