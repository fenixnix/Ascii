shader_type canvas_item;

uniform vec2 mouse;
uniform float zoom:hint_range(0.01,100) = 3.;
uniform float speed:hint_range(0.01,100) = .1;
uniform float num_layers:hint_range(0.01,100) = 10.;
uniform float star_color = 6.28;

const float PI = 3.1415;

mat2 Rot(float a){
	float s = sin(a),c = cos(a);
	return mat2(
		vec2(c,-s),
		vec2(s,c)
	);
}

float Rays(vec2 uv){
	float ret = 1.-abs(uv.x*uv.y*3000.);
	return max(0.,ret);
}

float Star(vec2 uv,float flare){
	vec2 clr = vec2(0);
	float d = length(uv);
	float m = .02/d ;
	
	float rays = Rays(uv);
	m += rays*flare;
	
	uv *= Rot(PI/4.);
	rays = Rays(uv);
	m += rays*.3*flare;
	m *= smoothstep(.8,.5,d);
	return m;
}

float Hash21(vec2 p){
	p = fract(p*vec2(123.34,456.21));
	p += dot(p,p+45.32);
	return fract(p.x*p.y);
}

vec3 StarLayer(vec2 uv,float t){
	vec2 gv = fract(uv) -.5;
	vec2 id = floor(uv);
	vec3 clr = vec3(0);
	for(int y = -1;y<=1;y++){
		for(int x = -1;x<=1;x++){
			vec2 offs = vec2(float(x),float(y));
			float n = Hash21(id+offs);
			float size = fract(n*345.32);
			float star = Star(gv - offs - vec2(n,fract(n*34.))+.5,smoothstep(.8,.9,size));
			vec3 color = sin(vec3(.2,.3,.9)*fract(n*2345.56)*star_color)*.5+.5;
			color * color*vec3(1,0.5,1.+size);
			star *= sin(t*3.+n*6.2831)*.5+.5;
			clr += star*size*color;
		}
	}
	return clr;
}

void fragment(){
	float t = TIME*speed;
	vec2 uv = UV - .5;
	vec2 M = mouse;
	//uv += M;
	uv *= Rot(t);
	uv *= zoom;
	vec3 clr = vec3(0);
	
	for(float i = 0.;i<1.;i+=1./num_layers){
		float depth = fract(i+t);
		float scale = mix(20.,.5,depth);
		float fade = depth*smoothstep(1.,.9,depth);
		clr += StarLayer(uv*scale + i*236.78+M,t)*fade;
	}
	
	COLOR = vec4(clr,1.);
}