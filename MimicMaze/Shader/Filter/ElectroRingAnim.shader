shader_type canvas_item;

render_mode blend_mix;
// Noise animation - Electric
// by nimitz (stormoid.com) (twitter: @stormoid)
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// Contact the author for other licensing options

//The domain is displaced by two fbm calls one for each axis.
//Turbulent fbm (aka ridged) is used for better effect.

const float tau = 6.2831853;

uniform sampler2D iChannel0;

mat2 makem2(in float theta){float c = cos(theta);float s = sin(theta);return mat2(vec2(c,-s),vec2(s,c));}
float noise( in vec2 x ){return texture(iChannel0, x*.01).x;}

float fbm(in vec2 p)
{	
	float z=2.;
	float rz = 0.;
	vec2 bp = p;
	for (float i= 1.;i < 6.;i++)
	{
		rz+= abs((noise(p)-0.5)*2.)/z;
		z = z*2.;
		p = p*2.;
	}
	return rz;
}

float dualfbm(in vec2 p,float time)
{
    //get two rotated fbm calls and displace the domain
	vec2 p2 = p*.7;
	vec2 basis = vec2(fbm(p2-time*1.6),fbm(p2+time*1.7));
	basis = (basis-.5)*.2;
	p += basis;
	
	//coloring
	return fbm(p*makem2(time*0.2));
}

float circ(vec2 p) 
{
	float r = length(p);
	r = log(sqrt(r));
	return abs(mod(r*4.,tau)-3.14)*3.+.2;

}

void fragment()
{
	float iTime = .15*TIME;
	//setup system
	//vec2 p = fragCoord.xy / iResolution.xy-0.5;
	vec2 p = UV-.5;
	//p.x *= iResolution.x/iResolution.y;
	p*=4.;
	
    float rz = dualfbm(p,iTime);
	
	//rings
	p /= exp(mod(iTime*10.,3.14159));
	rz *= pow(abs((0.1-circ(p))),.9);
	
	//final color
	vec3 col = vec3(.2,0.1,0.4)/rz;
	col=pow(abs(col),vec3(.99));
	COLOR = vec4(col,1.);
}