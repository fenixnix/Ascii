shader_type canvas_item;

// Created by Eric ArnebÃ¤ck - erkaman/2015
// This work is licensed under a 
// Creative Commons Attribution 4.0 International License

uniform int GRASS_BLADES = 50;

float hash( float n ) { return fract(sin(n)*753.5453123); }

float noise( in vec2 x )
{
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
	
    float n = p.x + p.y*157.0;
    return mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                   mix( hash(n+157.0), hash(n+158.0),f.x),f.y);
}

// 2D rotation matrix by approximately 36 degrees.
const mat2 m = mat2(
	vec2(0.8, 0.6),
	vec2(-0.6, 0.8)
);

float fbm(vec2 r) {
    float f;
    // rotate every octave to add more variation. 
    f  = 0.5000*noise( r ); r = r*m*2.01;
    f += 0.2500*noise( r ); r = r*m*2.02;
    f += 0.1250*noise( r ); r = r*m*2.03;
    f += 0.0625*noise( r ); r = r*m*2.01;
    return f;   
}

float rand(float co){
    return fract(sin(dot(vec2(co ,co ) ,vec2(12.9898,78.233))) * 43758.5453);
}

float rand_range(float seed, float low, float high) {
	return low + (high - low) * rand(seed);
}

vec3 rand_color(float seed, vec3 col, vec3 variation) {
    return vec3(
        col.x + rand_range(seed,-variation.x, +variation.x),
        col.y + rand_range(seed,-variation.y, +variation.y),
        col.z + rand_range(seed,-variation.z, +variation.z));
}


vec4 grass(vec2 p, int i, vec2 q, vec2 pos, float curve, float height) {

    pos = q + pos;
    pos.y += 0.5; // coordinate y=0 will represent the bottom. 

    float r = rand_range(float(i+200),0.002,0.005 ); // grass radius 

    
    // the grass gets thinner and thinner, 
    // as it grows to the top of the screen
    r = r * (1.-smoothstep(0.0,height, pos.y)); 




    float s = sign(curve); // curve value sign. 
    //the grass shape is described by a function on the form
    // x = c* y^2, where c is the curve.
    float grass_curve = abs(pos.x - s* pow( curve*( pos.y),2.0));


    // the grass ends at ymax. 
    float ymax = height; 
    
    // sligthly blur the edges of the grass blade to decrease
    // aliasing issues
    float res = 1.0-(1.0 - smoothstep(r, r+0.006,grass_curve  )) *
        (1.0 - smoothstep(ymax-0.1, ymax, pos.y));
   
    
    // grass bottom is dark, but the blade gets gradually brighter as it
    // grows upward.
    vec3 bottom_color = rand_color(float(i),vec3(0.10,0.3,0.1), vec3(0.0,0.20,0.0));
    vec3 top_color =  rand_color(float(i),vec3(0.40,0.6,0.2), vec3(0.0,0.20,0.0));
    vec3 col = mix(bottom_color,top_color,pos.y);
    
   
    // gradually make the grass color lighter as we approach the edges; 
    // makes for a slight 3D effect.
    col = col + vec3(0.0,0.10,0.0)* (1.0-smoothstep(0.0, r,grass_curve));
    

    // add noise in order to add slight visual interest. 
    vec2 a = 104.0*vec2(p.xy);   
    a.x *= 2.9;
    a.y *= 0.2;
    float f = fbm(a);
    col = mix(col - vec3(0.0,0.05,0.0) , col + vec3(0.0,0.1,0.0) ,f);
       
   return vec4(col, 1.0-res);
}


void fragment()
{
	vec2 p = UV;

    vec3 col = vec3(0,0,0); // black background color. 

    vec2 q = p - vec2(0.5,0.5);

    for(int i = 0; i <GRASS_BLADES; i += 1){

        float height = rand_range(float(i+2),0.1,0.9 );

        // grass curve depends on the height. 
        float max_curve = 1.0 - height + 0.40;

        float curve = rand_range(float(i+1),-max_curve,max_curve );
            
        vec2 pos = vec2(rand_range(float(i+3),-0.35,0.35 ),0.0);
       
        vec4 ret = grass(p,i,q,
                         pos,
                         curve, 
                         height);
        
        // blend the grass with the background. 
        col = mix(col, ret.xyz, ret.w);
    }
    
   
	COLOR = vec4(col,smoothstep(.1,1.,col.r+col.g+col.b));
}
