// srtuss, 2017

#define pi 3.1415926535897932384626433832795

float light(vec3 p)
{
    float s, w, v;
    s = 3.5;
    w = abs(fract(p.y * s) - .5) / s;
    
    v = min(v, length(vec2(length(p) - .8, w)) - .02);
    
    return length(vec2(abs(length(p) - .8), w));//v;
}

vec2 rotate(vec2 v, float a)
{
    float co = cos(a), si = sin(a);
    return v * mat2(co, si, -si, co);
}

float scene(vec3 p)
{
    // chamber:
    float v = length(p) - 1.;
    
    //return v;
    
    float s = 6.;
    float w = abs(fract(p.y * s) - .5) / s;
    
    float a = atan(p.z, p.x);
    
    v = min(v, length(vec2(v, w)) - .01 - (sin(a * 10.) + 1.) * 0.01);
    
    //v = length(p) - 1.;
    
    s = 3. / pi;
    w = abs(fract(a * s) - .5) / s;
    float l = length(p.xz);
    
    v = max(v, ((w - .3) * l));
    
    v = max(v, -length(p) + .6);
    
    v = min(v + .05, max(v, -(length(p) - .9)));
    
    v = min(v + .04, max(v, -(length(p.xz) - .5)));
    
    //v = min(v, length(p.xz) - .2);
    
    
    s = 2.;
    w = abs(fract(p.y * s) - .5) / s;
    
    v = min(v, length(vec2(length(p) - .8, w)) - .02);
    
    v = min(v, max(v - .02, light(p) - .02));
    
    
    
    // walkway
    v = min(v, max(p.y + .2, abs(l - 3.) - 1.));
    
    s = 30.;
    vec2 uv = p.xz * s;
    float rf = min(
        abs(fract(dot(uv, normalize(vec2(.5, 1.)))) - .5),
    	abs(fract(dot(uv, normalize(vec2(-.5, 1.)))) - .5));
    rf = (rf - .08) / s;
    
    v = max(v, -max(abs(l - 3.) - .9, (-p.y - .22)));
    //v = min(v, max(abs(l - 3.) - .9, max(rf, p.y + 0.21)));
    
    
    // support
    s = 2. / pi;
    float r = abs(fract(a * s) - .5) / s;
    float sh = abs(dot(vec2(l, p.y + .2), normalize(vec2(1., 1.9))));
    w = max(r * l - 0.1, sh - .1);
    w = max(w, -(l - .7));
    
    w = max(w, -sh + .01);
    //w = max(w, -max(sh - .101, (r - .06) * l));
    w = max(w, -((r - .06) * l));
    
    v = min(v, min(w, max(v - .04, w - .1)));
    v = min(v, max(length(vec2(sh, r)) - 0.05, -l + .7));
    
    
    // rings/wires
    s = 3. / pi;
    r = abs(fract(a * s) - .5) / s;
    w = length(vec2(length(vec2(p.y, length(p.xz) - 3.)) -1., r * l)) - .04;
    v = min(v, w);//*/
    
    float open = smoothstep(1., 1.2, iTime) * .05 +
        smoothstep(1.2, 1.4, iTime) * -.01 +
        smoothstep(2., 6., iTime) * 1. + sin((iTime - 5.) * 3.) * .05 * smoothstep(5., 8., iTime) * smoothstep(10., 8., iTime);
    
    
    float vv = v;
    vec3 pp = p;
    for(int i = 0; i < 6; ++i)
    {
        p = pp;
        
        p.xz = rotate(p.xz, float(i) * 2. * pi / 6.);
        
        vec2 ro = vec2(-0.3, .5);
        p.xy = rotate(p.xy + ro, open * -1.5) - ro;
        l = length(p.xz);
        v = length(p) - 1.;

        s = 6.;
        w = abs(fract(p.y * s) - .5) / s;

        a = atan(p.z, p.x);

        v = min(v, length(vec2(v, w)) - .01 - (sin(a * 10.) + 1.) * 0.01);

        //v = length(p) - 1.;

        s = 3. / pi;
        a = clamp(a, -.5, .5);
        w = abs(fract(a * s) - .5) / s;

        v = max(v, -((w - .3) * l));

        v = max(v, -length(p) + .6);

        v = min(v + .05, max(v, -(length(p) - .9)));

        v = min(v + .04, max(v, -(length(p.xz) - .5)));
        
        vv = min(vv, v);
    }
    return vv;
}

float field(vec3 p)
{
    float v = length(p) - 1.;
    
    float s = 6.;
    float w = abs(fract(p.y * s) - .5) / s;
    
    float a = atan(p.z, p.x);
    
    v = min(v, length(vec2(v, w)) - .01 - (sin(a * 10.) + 1.) * 0.01);
    
    //v = length(p) - 1.;
    
    s = 3. / pi;
    w = abs(fract(a * s) - .5) / s;
    float l = length(p.xz);
    
    v = max(v, ((w - .3) * l));
    
    v = max(v, -length(p) + .6);
    
    v = min(v + .05, max(v, -(length(p) - .9)));
    
    v = min(v + .04, max(v, -(length(p.xz) - .5)));
    
   	//v = min(v, length(p.xz) - .2);
    
    
	//v = min(v, l - 0.4);
    
    return v - min(1., iTime / 6.) * .03;
}

vec3 field_normal(vec3 p)
{
    vec2 h = vec2(0.005, 0.0);
    return normalize(vec3(
        field(p + h.xyy) - field(p - h.xyy),
        field(p + h.yxy) - field(p - h.yxy),
        field(p + h.yyx) - field(p - h.yyx)
    ));
}

vec3 normal(vec3 p)
{
    vec2 h = vec2(0.005, 0.0);
    return normalize(vec3(
        scene(p + h.xyy) - scene(p - h.xyy),
        scene(p + h.yxy) - scene(p - h.yxy),
        scene(p + h.yyx) - scene(p - h.yyx)
    ));
}

vec4 tpm(sampler2D tex, vec3 nml, vec3 p)
{
    vec3 mx = max(vec3(0.0), pow((abs(nml.xyz) - 0.2) * 7.0, vec3(3.0)));
	mx /= dot(mx, vec3(1.0));
    
    vec4 col = texture(tex, vec2(p.yz)) * mx.x;
    col += texture(tex, vec2(p.xz)) * mx.y;
    col += texture(tex, vec2(p.xy)) * mx.z;
    return col;
}

float softshadow( in vec3 ro, in vec3 rd, float mint, float maxt, float k )
{
	float res = 1.0;
    float t = mint;
	for(int i = 0; i < 32; ++i)
	{
		float h = scene(ro + rd*t);
		if(h < 0.001)
			return 0.0;
		res = min(res, k * h / t);
		t += h;
	}
	return res;
}

float amb_occ(vec3 p, float h)
{
	float acc = 0.0;
	acc += scene(p + vec3(-h, -h, -h));
	acc += scene(p + vec3(-h, -h, +h));
	acc += scene(p + vec3(-h, +h, -h));
	acc += scene(p + vec3(-h, +h, +h));
	acc += scene(p + vec3(+h, -h, -h));
	acc += scene(p + vec3(+h, -h, +h));
	acc += scene(p + vec3(+h, +h, -h));
	acc += scene(p + vec3(+h ,+h, +h));
	return acc / h;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    uv = uv * 2. - 1.;
    uv.x *= iResolution.x / iResolution.y;
    
    uv += (fract(1253786. * sin(iTime * vec2(11., 22))) - .5) * 0.03 * exp(max(0., iTime - 6.) * -1.);
    
    vec3 rd = normalize(vec3(uv, 1.3));
    vec3 ro = vec3(0., 0.2, -2.);
    
    float tt = -.1;
    rd.yz = rotate(rd.yz, tt);
    ro.yz = rotate(ro.yz, tt);
    
    float pn = iTime * .2;
    rd.xz = rotate(rd.xz, pn);
    ro.xz = rotate(ro.xz, pn);
    
    float rl = -.4;
    rd.yz = rotate(rd.yz, rl);
    ro.yz = rotate(ro.yz, rl);
    
   
    
    
    vec3 col = vec3(0.);
    
    vec3 sun = normalize(vec3(.2, .5, .3));
    vec3 sun2 = normalize(vec3(.4, -.5, .3));
    
    float d = 0.;
    float g = 0.;
    for(int i = 0; i < 90; ++i)
    {
        d += scene(ro + rd * d);
        g += smoothstep(0.3, 0., length(ro + rd * d) - 1.);
    }
    
    if(d < 8.)
    {
        vec3 hit = ro + rd * d;
        vec3 nml = normal(hit);
        //col = vec3(1.) * (nml * .5  + .5) * exp(d * -.2); 

        vec3 li = softshadow(hit, sun, .01, 1., 3.) * vec3(1., .5, 0.4);
        li += softshadow(hit, sun2, .01, 1., 3.) * vec3(.8, 0.9, 1.);
        
        float v = light(hit);
        float x = sin(atan(hit.z, hit.x) + iTime * 40.) * .3 + .7;
        li += (vec3(5.) * exp(v * -30.) + smoothstep(0.01, .0, v - 0.01)) * x;//smoothstep(0.1, .0, v);
        //li += .1;
        
        vec3 ref = reflect(rd, nml);
        //li += pow(texture(iChannel2, ref, 40.).xyz, vec3(2.)) * 0.2;
        
        float e = smoothstep(0., 1., amb_occ(hit, .002) /*+ (texture(iChannel1, hit.xz * 10.).x - .5) * 1.*/) * 0.2;
        
        col = pow(tpm(iChannel1, nml, hit).xyz + e, vec3(2.)) * li;
        
    }
    else
    {
        col = pow(tpm(iChannel0, rd, rd).xyz, vec3(10.));
    }
    
    d = 0.;
    for(int i = 0; i < 20; ++i)
    {
        d += field(ro + rd * d);
    }
    if(d < 5.)
    {
        vec3 hit = ro + rd * d;
        vec3 nml = field_normal(hit);
        
        float field_int = exp(fract(iTime) * -25.) + exp(fract(iTime * 1.3333333333) * -25.) + min(1., (iTime - 2.) / 6.);
        field_int = max(field_int, 0.);
        field_int *= .1;
        
    	col += field_int * (pow(1. - abs(tpm(iChannel0, nml, hit * .25 + iTime * .1).x - .5), 32.)) * (1. - dot(-nml, rd)) * (.5 + sin(iTime * 5.) * .5);
    	
        col += field_int * (pow(1. - abs(tpm(iChannel0, nml, hit * .1 - iTime * .5).x - .5), 32.)) * (1. - dot(-nml, rd)) * exp(fract(iTime * 2.) * -2.);
        
        //col += 0.01;
    }//*/
    
    //col += g * 0.01 * (clamp((iTime - 4.) * .1, 0., 1.));
    
    col = pow(col, vec3(1. / 2.2));
    
    col *= 1.3;
    
	fragColor = vec4(col,1.0);
}