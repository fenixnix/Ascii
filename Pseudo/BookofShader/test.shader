//http://www.iquilezles.org/www/index.htm
//http://aprt.us/

shader_type canvas_item;

const float PI = 3.141592653;

uniform vec4 color:hint_color = vec4(1.);
uniform vec4 color2:hint_color = vec4(0.);
uniform float rate:hint_range(0,1.) = 1.;
uniform vec2 offset = vec2(0);
uniform vec2 size = vec2(1);
uniform float r1 = .3;
uniform float r2 = .1;

uniform sampler2D perlin_fbm;

//
float random(vec2 p){
	return fract(sin(dot(p,vec2(12.9898,78.233)))*43758.5453123);
}

vec2 hash( vec2 p ) // replace this by something better
{
	p = vec2( dot(p,vec2(127.1,311.7)), dot(p,vec2(269.5,183.3)) );
	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

//float noise(vec2 p){
//	vec2 i = floor(p);
//    vec2 f = fract(p);
//	//vec2 f = vec2(0);
//
//    // Four corners in 2D of a tile
//    float a = random(i + vec2(0,0));
//    float b = random(i + vec2(1.0, 0.0));
//    float c = random(i + vec2(0.0, 1.0));
//    float d = random(i + vec2(1.0, 1.0));
//
//    vec2 u = f * f * (3.0 - 2.0 * f);
//
//    return mix(a, b, u.x) +
//            (c - a)* u.y * (1.0 - u.x) +
//            (d - b) * u.x * u.y;
//}

//float noise(vec2 p )
//{
//    vec2 i = floor( p );
//    vec2 f = fract( p );
//
//	vec2 u = f*f*(3.0-2.0*f);
//
//    return mix( mix( random( i + vec2(0.0,0.0) ), 
//                     random( i + vec2(1.0,0.0) ), u.x),
//                mix( random( i + vec2(0.0,1.0) ), 
//                     random( i + vec2(1.0,1.0) ), u.x), u.y);
//}

float noise(vec2 p)
{
    const float K1 = 0.366025404; // (sqrt(3)-1)/2;
    const float K2 = 0.211324865; // (3-sqrt(3))/6;

	vec2  i = floor( p + (p.x+p.y)*K1 );
    vec2  a = p - i + (i.x+i.y)*K2;
    float m = step(a.y,a.x); 
    vec2  o = vec2(m,1.0-m);
    vec2  b = a - o + K2;
	vec2  c = a - 1.0 + 2.0*K2;
    vec3  h = max( 0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
	vec3  n = h*h*h*h*vec3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));
    return dot( n, vec3(70.0) );
}

const int OCTAVES = 6;
float fbm(vec2 p){
	 // Initial values
	float value = 0.0;
	float amplitude = .5;
	float frequency = 0.;
	//
	// Loop of octaves
	for (int i = 0; i < OCTAVES; i++) {
	    value += amplitude * noise(p);
	    p *= 2.;
	    amplitude *= .5;
	}
	return value;
}

vec2 polar(vec2 p){
	float r = length(p);
	float i = acos(p.x)/PI;
	return vec2(r,i);
}
//
float circle(vec2 uv, vec2 center, float _r1,float _r2){
	return smoothstep(_r1,_r1-_r2,length(uv-center));
}

float diamond(vec2 uv, vec2 center, float _r1,float _r2){
	vec2 dif = uv-center;
	return smoothstep(_r1,_r2,abs(dif.y)+abs(dif.x));
}

float square(vec2 uv,vec2 center){
	vec2 dif = uv-center;
	float val = smoothstep(.3,.1,abs(uv.x));
	val = min(val,smoothstep(.3,.1,abs(uv.y)));
	return val;
}

float square2(vec2 uv,vec2 center, float _v1, float _v2){
	vec2 dif = uv-center;
	float val = smoothstep(_v1,_v2,abs(uv.x));
	val *= smoothstep(_v1,_v2,abs(uv.y));
	return val;
}

float nova(vec2 uv, vec2 center, float _v1, float _v2){
	return smoothstep(_v1,_v2,abs(uv.x*uv.y));
}

float gradient(vec2 uv, vec2 center, float _v1, float _v2){
	return smoothstep(_v1,_v2,abs(uv.y));
}

//float fbm(vec2 p, float _t){
//	float amp = 1.;
//	float freq = 1.;
//	float y = sin(p.x*freq);
//	float t = 0.01*(-_t*130.);
//	y += sin(p.x+freq*2.1+t)*4.5;
//	y += sin(p.x+freq*1.72+t*1.121)*4.;
//	y += sin(p.x+freq*2.221+t*.437)*5.;
//	y += sin(p.x+freq*2.1+t*4.269)*2.5;
//	y *= amp*.06;
//	return y;
//}

//domain warping
//Image for f(p) = fbm( p + fbm( p + fbm( p ) ) )
float domainWarping(vec2 p){
	return fbm(fbm(fbm(p)+p)+p);
}

float domainWarpingPattern3(vec2 p){
	vec2 q = vec2( fbm( p + vec2(0.0,0.0) ),
	                fbm( p + vec2(5.2,1.3) ) );
	
	vec2 r = vec2( fbm( p + 4.0*q + vec2(1.7,9.2) ),
	                fbm( p + 4.0*q + vec2(8.3,2.8) ) );
	
	return fbm( p + 4.0*r );
}

void fragment(){
	vec2 uv = UV + offset;
	//uv = polar(uv);
	vec3 clr = vec3(0);
	
	vec2 gv = fract(uv*size)-.5;
	
	float mask = 0.;
	//mask += texture(perlin_fbm,UV + vec2(0,.25)*TIME).r;
	//mask += nova(uv,vec2(0),r1,r2);
	//mask += square2(uv,vec2(0),r1,r2)*.8;
	//mask += fbm(UV+vec2(0,.25)*TIME)*.2;
	//mask = circle(uv,vec2(0),r1,r2);
	mask += diamond(gv,vec2(0),r1,r2);
	//mask += gradient(uv,vec2(0));
	//mask = square2(uv,vec2(0))*gradient(uv,vec2(0));
	//mask *= gradient(uv,vec2(0),.7,.1);
	//mask = domainWarpingPattern3(UV + vec2(0,.25)*TIME);
	mask *= 1.-step(rate,UV.x);
	//clr = texture(SCREEN_TEXTURE,SCREEN_UV+vec2(mask*.01)).rgb;
	clr = vec3(mask)*mix(color2.rgb,color.rgb,rate);
	//clr = vec3(domainWarpingPattern3(UV + vec2(0,.25)*TIME));
	//clr = vec3(domainWarpingPattern3(UV));
	COLOR = vec4(clr,step(.3,mask));
	//COLOR = vec4(domainWarpingPattern3(fract(uv+sin(TIME)*vec2(0.25,0.25))));
}