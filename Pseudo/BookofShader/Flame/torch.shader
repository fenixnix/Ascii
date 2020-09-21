shader_type spatial;

uniform sampler2D iChannel1;
uniform vec2 center_offset;

mat2 rotate2d(float angle){
	float s = sin(angle);
	float c = cos(angle);
	return mat2(
		vec2(c,-s),
		vec2(s,c)
	);
}

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

float fbm(vec2 uv)
{
    float n = (texture(iChannel1, uv).r - 0.5) * 0.5;
    n += (texture(iChannel1, uv * 2.0).r - 0.5) * 0.5 * 0.5;
    n += (texture(iChannel1, uv * 3.0).r - 0.5) * 0.5 * 0.5 * 0.5;
	return n + 0.5;
}

// -----------------------------------------------
void fragment()
{
	float iTime = TIME;
    vec2 uv = vec2(UV.x,1.-UV.y) + center_offset;
    vec2 _uv = uv;
    uv -= vec2(0.5);
    //uv.y /= iResolution.x / iResolution.y;
    vec2 centerUV = uv;
    
    // height variation from fbm
    float variationH = fbm(vec2(iTime * .3)) * 1.1;
    
	// flame "speed"
	vec2 offset = vec2(0.0, -iTime * 0.15);

    // flame turbulence
	float f = fbm(uv * 0.1 + offset); // rotation from fbm
	float l = max(0.1, length(uv)); // rotation amount normalized over distance
	uv += rotate2d( ((f - 0.5) / l) * smoothstep(-0.2, .4, _uv.y) * 0.45) * uv;    

    // flame thickness
    float flame = 1.3 - abs(uv.x) * 5.0;

    // bottom of flame 
    float blueflame = pow(flame * .9, 15.0);
    blueflame *= smoothstep(.2, -1.0, _uv.y);
    blueflame /= abs(uv.x * 2.0);
    blueflame = clamp(blueflame, 0.0, 1.0);

    // flame
    flame *= smoothstep(1., variationH * 0.5, _uv.y);
	flame = clamp(flame, 0.0, 1.0);
    flame = pow(flame, 3.);
    flame /= smoothstep(1.1, -0.1, _uv.y);    

    // colors
    vec4 col = mix(vec4(1.0, 1., 0.0, 0.0), vec4(1.0, 1.0, .6, 0.0), flame);
    col = mix(vec4(1.0, .0, 0.0, 0.0), col, smoothstep(0.0, 1.6, flame));
    vec4 fragColor = col;

    // clear bg outside of the flame
    fragColor *= flame;
    fragColor.a = flame;

	// bg halo
    float haloSize = 0.5;
    float centerL = 1.0 - (length(centerUV + vec2(0.0, 0.1)) / haloSize);
    vec4 halo = vec4(.8, .3, .3, 0.0) * 1.0 * fbm(vec2(iTime * 0.035)) * centerL + 0.02;
    vec4 finalCol = mix(halo, fragColor, fragColor.a);
    fragColor = finalCol;

    // just a hint of noise
    fragColor *= mix(random(uv) + random(uv * .45), 1.0, 0.9);
    fragColor = clamp(fragColor, 0.0, 1.0);

	ALBEDO = fragColor.rgb;
	ALPHA = fragColor.a;
}
