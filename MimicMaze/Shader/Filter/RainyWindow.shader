shader_type canvas_item;

uniform float scale = 3.;
uniform float time_offset = 0;
uniform float distortion = .1;
uniform float lod = 1.5;
uniform vec2 aspect = vec2(4,1);


float N21(vec2 p){
	p = fract(p*vec2(123.39,345.45));
	p += dot(p,p+34.345);
	return fract(p.x+p.y);
}

float drawGrid(vec2 p){
	if(p.x>.48||p.y>.49){
		return 1.;
	}
	return 0.;
}

float drawTrail(vec2 p, vec2 offset,float t){
	vec2 dropPos = (p-offset)/aspect;
	vec2 trailPos = (p-vec2(offset.x,t*.25))/aspect;
	trailPos.y = (fract(trailPos.y*8.)-.5)/8.;
	float trail = smoothstep(.03,.01,length(trailPos));
	float fogTrail = smoothstep(-.05,.05,dropPos.y);
	fogTrail *= smoothstep(.5,offset.y,p.y);
	trail *= fogTrail;
	fogTrail *= smoothstep(.05,.04,abs(dropPos.x));
	float rainDrop = 0.;
	rainDrop += trail;
	rainDrop += fogTrail*.5;
	return rainDrop;
}

float drawDrop(vec2 p, vec2 offset){
	vec2 dropPos = (p-offset)/aspect;
	float drop = smoothstep(.05,0.03,length(dropPos));
	return drop;
}

float drawRainDrop(vec2 p,vec2 offset,float t){
	return drawDrop(p,offset) + drawTrail(p,offset,t);
}

vec2 RainLayer(vec2 screen_uv, vec2 uv, float t){
	uv.y += t*.25;
	vec2 gv = fract(uv)-.5;
	vec2 id = floor(uv);
	
	float n = N21(id);
	t+=n*6.2831;
	
	float w = screen_uv.y*10.;
	float x = (n-.5)*.8;
	x += (.4-abs(x))*sin(3.*w)*sin(w)*sin(w)*sin(w)*sin(w)*sin(w)*sin(w)*.45;
	float y = -sin(t+sin(t+sin(t)*.5))*.45;
	y -= (gv.x-x)*(gv.x-x);
	vec2 offset = vec2(x,y);
	
	float raindrop = drawRainDrop(gv,offset,t);

	vec2 offs = vec2(raindrop); 
	return offs;
}

void fragment(){ 
	float t = TIME;
	vec3 clr = vec3(0.);
	vec2 uv = (UV)*scale*aspect;
	
	vec2 offs = vec2(0);
	offs += RainLayer(SCREEN_UV,uv,t);
	offs += RainLayer(SCREEN_UV,uv*1.35+5.54,t);
	offs += RainLayer(SCREEN_UV,uv*2.5 - 8.54,t);
	//clr += vec3(1.,0,0)*drawGrid(gv);
	//clr.rg = id*0.1;
	//clr += N21(id);
	
	clr = textureLod(SCREEN_TEXTURE,SCREEN_UV+offs*distortion,lod*(1.-length(offs))).rgb;
	COLOR = vec4(clr,1.);
}