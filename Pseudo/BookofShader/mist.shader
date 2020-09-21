shader_type canvas_item;

uniform vec4 color:hint_color = vec4(.2,.3,.5,1.);

float random (vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

float noise_perlin (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    // Smooth Interpolation
    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);
    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

vec2 hash( vec2 x )  // replace this by something better
{
    const vec2 k = vec2( 0.3183099, 0.3678794 );
    x = x*k + k.yx;
    return -1.0 + 2.0*fract( 16.0 * k*fract( x.x*x.y*(x.x+x.y)) );
}

float noise_gradient( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );
	vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( dot( hash( i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), 
                     dot( hash( i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( hash( i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), 
                     dot( hash( i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

float noise_gradient_fractal(vec2 uv){
	uv *= 8.0;
    mat2 m = mat2(vec2(1.6,  1.2), vec2(-1.2,  1.6));
	float f  = 0.5000*noise_gradient( uv ); uv = m*uv;
	f += 0.2500*noise_gradient( uv ); uv = m*uv;
	f += 0.1250*noise_gradient( uv ); uv = m*uv;
	f += 0.0625*noise_gradient( uv ); uv = m*uv;
	return f;
}

float hash2(vec2 p)  // replace this by something better
{
    p  = 50.0*fract( p*0.3183099 + vec2(0.71,0.113));
    return -1.0+2.0*fract( p.x*p.y*(p.x+p.y) );
}

float noise_value( in vec2 p )
{
	vec2 i = floor( p );
	vec2 f = fract( p );
	vec2 u = f*f*(3.0-2.0*f);
	return mix( mix( hash2( i + vec2(0.0,0.0) ), 
                     hash2( i + vec2(1.0,0.0) ), u.x),
                mix( hash2( i + vec2(0.0,1.0) ), 
                     hash2( i + vec2(1.0,1.0) ), u.x), u.y);
}

float fbm_noise_value(vec2 st){
	float value = 0.0;
    float amplitude = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < 6; i++) {
        value += amplitude * noise_value(st);
        st *= 2.;
        amplitude *= .5;
    }
    return value;
}

float noise_value_fractal(vec2 uv, vec2 offset){
	uv *= 8.0;
	mat2 m = mat2(vec2(1.6,  1.2),vec2(-1.2,  1.6));
	float f = 0.5000*noise_value( uv+ offset ); uv = m*uv;
	f += 0.2500*noise_value( uv+offset); uv = m*uv;
	f += 0.1250*noise_value( uv+offset ); uv = m*uv;
	f += 0.0625*noise_value( uv+offset ); uv = m*uv;
	return f;
}

void fragment()
{
    vec2 st = UV;
	//float f = noise_perlin(st*32.);
	//float f = noise_gradient(st*32.);
    //float f = noise_value( st*32.);
	//float f = noise_value_fractal(st*.3,vec2(-.1,.02)*TIME*5.);
	float f = fbm_noise_value(st*5.+vec2(-.1,.02)*TIME*5.);
	vec3 col = f* color.rgb;

    COLOR = vec4(col,f*.5);
}