shader_type canvas_item;

render_mode blend_add;

uniform int NUM_PARTICLES = 75;
uniform int NUM_FIREWORKS = 5;

vec3 pow3(vec3 v, float p)
{
    return pow(abs(v), vec3(p));
}

vec2 hash( vec2 x )  // replace this by something better
{
    const vec2 k = vec2( 0.3183099, 0.3678794 );
    x = x*k + k.yx;
    return -1.0 + 2.0*fract( 16.0 * k*fract( x.x*x.y*(x.x+x.y)) );
}

vec2 noise(vec2 tc)
{
	return hash(tc*5.);
}

vec3 fireworks(vec2 p, float iTime)
{
    vec3 color = vec3(0., 0., 0.);
    
    for(int fw = 0; fw < NUM_FIREWORKS; fw++)
    {
        vec2 pos = noise(vec2(0.82, 0.11)*float(fw))*1.5;
    	float time = mod(iTime*3., 6.*(1.+noise(vec2(0.123, 0.987)*float(fw)).x));
        for(int i = 0; i < NUM_PARTICLES; i++)
    	{
        	vec2 dir = noise(vec2(0.512, 0.133)*float(i));
            dir.y -=time * 0.1;
            float term = 1./length(p-pos-dir*time)/50.;
            color += pow3(vec3(
                term * noise(vec2(0.123, 0.133)*float(i)).y,
                0.8 * term * noise(vec2(0.533, 0.133)*float(i)).x,
                0.5 * term * noise(vec2(0.512, 0.133)*float(i)).x),
                          1.25);
        }
    }
    return color;
}

void fragment()
{
	vec2 p = (UV-.5)*5.;
    vec3 color = fireworks(p,TIME);
    COLOR = vec4(color*color*color, 1.);
}