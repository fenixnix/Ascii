shader_type canvas_item;

uniform vec2 SUNPOS_N = vec2(.22,.6667);
uniform vec2 SUNPOS_SS = vec2(.5,-.1667);

uniform float NSCALE = .025;
uniform float TSCALE = .2;
uniform float BSAMPS = 128;

uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
// #quickandmessy

// 1D texture lookup noise.
float n1( in float x, in sampler2D t){
    vec2 uv = vec2(fract(x),floor(x)/256.0);
    return texture(t,uv).r;
}

// 4 octave fbm.
float fbm1( in float x, in sampler2D t)
{
    float r =  n1(x    ,t)*.50000;
    	  r += n1(x*2.0,t)*.25000;
    	  r += n1(x*4.0,t)*.12500;
    	  r += n1(x*8.0,t)*.06250;
    	  r += n1(x*8.0,t)*.03125;
    	  return r*1.03225;
    
}

vec3 mountain( in vec2 uv, in float time, in float tscale,
              in float nscale, in float noffset, in float height,
              in float voffset, in sampler2D tex)
{
    time *= tscale;
    uv.x += time;
    uv.x *= nscale;
    
    float n = fbm1(uv.x+noffset,tex)*height + voffset;
    return vec3(step(uv.y,n),n,mod(time,10.0)); // So we don't get pattern stutter.
}

vec4 shadeSky( in vec2 uv )   
{
    // Distance from the center of the sun.
    float ds = length((uv-SUNPOS_N)*vec2(.5,1.));
    
    return mix(vec4(.8,0,.2,1),vec4(.1,0,.4,1),pow(ds,.5));
}

vec4 shadeMountains( in vec2 uv )
{
    // Get the raw mountain texel.
    vec4 m = texture(iChannel0,uv);
    
    float isMtn = step(.001,m.a);
    
    // Get a nice round looking top.
    float top = (uv.y/m.y)*isMtn;
    top = .75*pow(top,44.0); 
    
    // Now we can also add stripes.
    //float pattern = (m.z+uv.x+uv.y*iResolution.y/iResolution.x);
    float pattern = (m.z+uv.x+uv.y);
    pattern = mod(pattern*100.*(1.0-m.a),2.0);
    pattern = floor(pattern);
    
    // Return a vec4 that's a mix between the two stripe colors with
    // a "depth" based alpha, and clamped between 0 and 1.
    return clamp(vec4(mix(vec3(.273438,0,.164063),vec3(.5,0,.117188),pattern)*top,m.a),0.0,1.0);
}

vec4 shadeSun( in vec2 uv )
{
    // Get a texel from the sunshaft buffer.
    vec4 sun = texture(iChannel1,uv);
    
    // This one is simple.
    return sun * vec4(1.4,.75,.9,.8);
}

void fragment()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = UV;
    
    vec4 mountain = texture(iChannel0,uv);
    vec4 fragColor = mountain.rrrr*mountain.a;
    
    // Come up with the sky color.
    vec4 s = shadeSky(uv);
    
    // Get a texel from the mountain scene.
    vec4 m = shadeMountains(uv);
    
    // Get the sample from the sunshafts.
    vec4 sun = shadeSun(uv);
    
    // Add everything together based on alpha.
    fragColor = s;
    fragColor = mix(fragColor,m,m.a);
    fragColor = mix(fragColor,sun,sun.a);
    COLOR = fragColor;
}