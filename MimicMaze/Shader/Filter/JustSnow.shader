shader_type canvas_item;

render_mode blend_add;

// Copyright (c) 2013 Andrew Baldwin (twitter: baldand, www: http://thndl.com)
// License = Attribution-NonCommercial-ShareAlike (http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US)

// "Just snow"
// Simple (but not cheap) snow made from multiple parallax layers with randomly positioned 
// flakes and directions. Also includes a DoF effect. Pan around with mouse.

//#define LIGHT_SNOW // Comment this out for a blizzard
//
//#ifdef LIGHT_SNOW
//	#define LAYERS 50
//	#define DEPTH .5
//	#define WIDTH .3
//	#define SPEED .6
//#else // BLIZZARD
//	#define LAYERS 200
//	#define DEPTH .1
//	#define WIDTH .8
//	#define SPEED 1.5
//#endif

uniform int LAYERS = 50;
uniform float DEPTH = .5;
uniform float WIDTH = .3;
uniform float SPEED = .6;

void fragment()
{
	float iTime = TIME;
	const mat3 p = mat3(
		vec3(13.323122,23.5112,21.71123),
		vec3(21.1212,28.7312,11.9312),
		vec3(21.8112,14.7212,61.3934));
	//vec2 uv = iMouse.xy/iResolution.xy + vec2(1.,iResolution.y/iResolution.x)*fragCoord.xy / iResolution.xy;
	vec2 uv = UV;
	vec3 acc = vec3(0.0);
	float dof = 5.*sin(iTime*.1);
	for (int i=0;i<LAYERS;i++) {
		float fi = float(i);
		vec2 q = uv*(1.+fi*DEPTH);
		q += vec2(q.y*(WIDTH*mod(fi*7.238917,1.)-WIDTH*.5),SPEED*iTime/(1.+fi*DEPTH*.03));
		vec3 n = vec3(floor(q),31.189+fi);
		vec3 m = floor(n)*.00001 + fract(n);
		vec3 mp = (31415.9+m)/fract(p*m);
		vec3 r = fract(mp);
		vec2 s = abs(mod(q,1.)-.5+.9*r.xy-.45);
		s += .01*abs(2.*fract(10.*q.yx)-1.); 
		float d = .6*max(s.x-s.y,s.x+s.y)+max(s.x,s.y)-.01;
		float edge = .005+.05*min(.5*abs(fi-5.-dof),1.);
		acc += vec3(smoothstep(edge,-edge,d)*(r.x/(1.+.02*fi*DEPTH)));
	}
	COLOR = vec4(vec3(acc),1.0);
}