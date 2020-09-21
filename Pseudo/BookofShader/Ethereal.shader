shader_type canvas_item;

//#define t (iTime*.03)
uniform sampler2D iChannel0;

float sphere(vec3 p, vec3 rd, float r){
	float b = dot( -p, rd ),
	  inner = b*b - dot(p,p) + r*r;
	return inner < 0. ?  -1. : b - sqrt(inner);
}

vec3 kset(vec3 p, float t) {
	float m=1000., mi=0., l;
	for (float i=0.; i<20.; i++) {
		p = abs(p)/dot(p,p) - 1.;
        l=length(p);
        if (l < m){
			m=l;
		}  
		mi=i;
	}
	return normalize( 3.+texture(iChannel0,vec2(mi*.218954)).xyz )
           * pow( max(0.,1.-m), 2.5+.3*sin(l*25.+t*50.) );
}

void fragment()
{
	float t = TIME*.03;
//    vec2 R = iResolution.xy,  
//        mo = iMouse.z<.1 ? vec2(.1,.2) : iMouse.xy/R-.5;
//    uv = (uv-.5*R)/ R.y;
	vec2 mo = vec2(0);
    vec2 uv = UV-.5;
	
    vec3 ro = -vec3(mo, 2.5-.7*sin(t*3.7535)),
	     rd = normalize(vec3(uv,3.)),
	     v = vec3(0), p;
    float tt,c=cos(t),s=sin(t);
	mat2 rot = mat2(vec2(c,-s),vec2(s,c));
    
	for (float i=20.; i<50.; i++) {
		tt = sphere(ro, rd, i*.03);
		p = ro+rd*tt;
		p.xy *= rot;
		p.xz *= rot;
		v = .9*v + .5*kset(p+p,t)*step(0.,tt);
	}

	vec3 col = v*v *vec3(1.2,1.05,.9);
	COLOR = vec4(col,1.);
}