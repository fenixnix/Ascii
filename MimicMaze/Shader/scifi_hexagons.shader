shader_type canvas_item;

const vec2 iResolution = vec2(1024.);
const vec2 s = vec2(1, 1.7320508); // 1.7320508 = sqrt(3)
const vec3 baseCol = vec3(.05098, .25098, .2784);
const float borderThickness = .02;
const float isolineOffset = .4;
const float isolineOffset2 = .325;
//#define S(r,v) smoothstep(9./iResolution.y,0.,abs(v-(r)))

float S(float r, float v){
	return smoothstep(9./iResolution.y,0.,abs(v-(r)));
}

float calcHexDistance(vec2 p)
{
    p = abs(p);
    return max(dot(p, s * .5), p.x);
}

float random(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec4 calcHexInfo(vec2 uv)
{
    vec4 hexCenter = round(vec4(uv, uv - vec2(.5, 1.)) / s.xyxy);
    vec4 offset = vec4(uv - hexCenter.xy * s, uv - (hexCenter.zw + .5) * s);
    return dot(offset.xy, offset.xy) < dot(offset.zw, offset.zw) ? vec4(offset.xy, hexCenter.xy) : vec4(offset.zw, hexCenter.zw);
}

void fragment()
{
	float iTime = TIME;
	vec2 uv = UV*10.;
    //vec2 uv = 3. * (2. * fragCoord - iResolution.xy) / iResolution.y;
    uv.x += iTime * .25;
    
    vec4 hexInfo = calcHexInfo(uv);
    float totalDist = calcHexDistance(hexInfo.xy) + borderThickness;
    float rand = random(hexInfo.zw);
    
    float angle = atan(hexInfo.y, hexInfo.x) + rand * 5. + iTime;
    vec3 isoline = S(isolineOffset, totalDist) * baseCol * step(3. + rand * .5, mod(angle, 6.28))
        + S(isolineOffset2, totalDist)
                    * baseCol * step(4. + rand * 1.5, mod(angle + rand * 2., 6.28));
    
    float sinOffset = sin(iTime + rand * 8.);
    float aa = 5. / iResolution.y;
    
    vec3 clr = (smoothstep(.51, .51 - aa, totalDist) + pow(1. - max(0., .5 - totalDist), 20.) * 1.5)
        * (baseCol + rand * vec3(0., .1, .09)) + isoline + baseCol * smoothstep(.2 + sinOffset, .2 + sinOffset - aa, totalDist);    
	COLOR = vec4(clr,1.);
}