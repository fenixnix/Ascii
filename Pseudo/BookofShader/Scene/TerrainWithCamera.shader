shader_type canvas_item;

uniform float MAX_DIST = 100.;
uniform float MIN_DIST = 0.01;
uniform float MAX_COUNT = 100.;

float rand(vec2 uv)
{
    return fract(sin(uv.x * 1033.5 + uv.y) * 23930.58);
}
mat2 rotate(float ang){
    float ca = cos(ang);
    float sa = sin(ang);
    return mat2(vec2(ca, sa), vec2(-sa, ca));
}
float noise(vec2 uv){
 	vec2 xy = floor(uv);
    vec2 frac = fract(uv);
    frac = frac * frac * (3. - 2. * frac);
    
    vec2 bl = xy;
    vec2 tl = xy + vec2(0.,1.);
    vec2 br = xy + vec2(1.,0.);
    vec2 tr = xy + vec2(1.,1.);

    float a = rand(tl);
    float b = rand(tr);
    float c = rand(bl);
    float d = rand(br);
    
    float top = mix(a, b, frac.x);
    float bottom = mix(c, d, frac.x);
    
    return mix(bottom, top, frac.y);
}

float fbm(vec2 uv){
 	float res = 0.;
    float amp = .5;
    float freq = .5;
    
    for(int i = 0; i < 8; ++i)
    {
        uv *= rotate(80.);
        res += amp * noise(uv * freq + 3.0);
        amp *= 0.5;
        freq *= 2.0;
    }
    return res;
}


float getDist(vec3 p){   
    float disp = fbm(p.xz*0.08);
    //return disp;
    return (p.y+disp*50.)*.3;
}


vec3 normal(vec3 p){
	vec2 e = vec2(.001, 0.0);
    return normalize(vec3(
    	getDist(p + e.xyy) - getDist(p - e.xyy),
        getDist(p + e.yxy) - getDist(p - e.yxy),
        getDist(p + e.yyx) - getDist(p - e.yyx)
    ));
}


float rayMarch(vec3 ro, vec3 rd){
 	float R0 = 0.;
    for(int i = 0; float(i) < MAX_COUNT; i++){
     	vec3 p = ro + R0 * rd;
        float d = getDist(p);
        R0 += d;
        if(d < MIN_DIST || R0 > MAX_DIST) break;
    }
    return R0;
}

void fragment()
{
	float iTime = TIME;
    //vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    vec2 uv = UV-.5;
	//vec2 mouse = iMouse.xy / iResolution.xy * 100.;
	vec2 mouse = vec2(0.);
	vec3 ro = vec3(0., 2., -30.);
    ro.xz *= rotate(mouse.x);
    float zoom = .5;
    vec3 target = vec3(0.0);
    ro.z += iTime * 5.;
    target.z +=iTime * 5.;
    vec3 ww = normalize(target - ro);
    vec3 uu = normalize(cross(vec3(0., 1., 0.), ww));
    vec3 vv = normalize(cross(ww, uu));
    vec3 rd = normalize(uu * uv.x + vv * uv.y + ww * zoom);
    vec3 col = vec3(0.);
    float d0 = rayMarch(ro, rd);
    col = vec3(d0)/100.;
    COLOR = vec4(1.-col,1.);
}