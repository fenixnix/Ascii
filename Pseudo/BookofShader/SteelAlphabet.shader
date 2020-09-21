shader_type canvas_item;
//#ifdef GL_ES
//precision mediump float;
//#endif

const float PI     = 3.14159265358979323846264;
const float TWO_PI = 6.28318530717958647692528;
const float HALF_PI= 1.57079632679489661923132;
const float TRQT_PI= 4.71238898038468985769396;

const float PHI = 1.61803398874989484820459;

float rand( in vec2 st ){
    return fract(sin(dot(st, vec2(12.9898,78.233)))*43758.5453123);
}
float rand( in float st, in float seed ){
    return fract(sin(dot(vec2(st,seed), vec2(12.9898,78.233)))*43758.5453123);
}
// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = rand(i);
    float b = rand(i + vec2(1.0, 0.0));
    float c = rand(i + vec2(0.0, 1.0));
    float d = rand(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

const float OCTAVES 6
float fbm (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitude = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(st);
        st *= 2.;
        amplitude *= .5;
    }
    return value;
}

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0,0.0,1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

float getAngle(in vec2 st){
    return atan(0.5-st.y,0.5-st.x);
}
float getRadius(in vec2 st){
    return length(0.5-st)*2.0;
}
// better performance than sqrt versions
float drawCircle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1.-smoothstep(_radius-(_radius*0.01),_radius+(_radius*0.01),dot(dist,dist)*4.0);
}

mat2 scale(vec2 _scale){
    return mat2(_scale.x,0.0,
                0.0,_scale.y);
}
mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}
// messed up space this helps me move nicly (ish)
vec2 translate(vec2 _t){
    return vec2(-_t.y,_t.x);
}

void fill(inout vec3 bg, in vec2 st, in float a){
    if (a < 1.0){
        bg = hsb2rgb(vec3(getRadius(st)*0.2+sin(0.676+iTime)*.2,0.2,clamp(1.0 - fbm(st*10.)*.5,0.5,0.7)));
    }
}

float positive(in float x){
    if ( x <= 0.0){
        return 0.0;
    }else{
        return x;
    }
}
float drawMoon(in vec2 st, in float offset, in float smallRad){
    return positive(drawCircle(st+.5,.4)-drawCircle(st+.5-offset,smallRad));
}
float partMoon(in vec2 st, in float angle){
    if (angle < 1.0)
    	return getAngle(st) > angle ? positive(drawCircle(st+.5,.4)-drawCircle(st+.4,.4)) : 0.0;
    else
        return getAngle(st) < fract(angle) ? positive(drawCircle(st+.5,.4)-drawCircle(st+.4,.4)) : 0.0;
}
float drawSpike(in vec2 st){
    float a=1.0;
    st.y -= .5;
    if (abs(st.y)-pow((st.x-0.5)*4.+0.036,3.)*0.01 < 0.017 && st.x < 0.936){
        a = 0.;
    }
    
    return 1.-a;
}


//really awful transformations due to drawn objects not having an origin and me trying to account for that by switching around some things
float glyph2(in vec2 _st, in float seed){
    float r = rand(seed, PHI);
    float a = 0.0;

    _st -= .5;
    if(r <= 1./24.){
        a = drawSpike(_st * rotate2d(TRQT_PI)+vec2(0.470,0.480));
    }else{
        // 7 have same cresent
        if(r <= 7./24.){
            a += drawMoon(_st, .1, .4);
            if(r <= 2./24.){ // Iron
                a += drawSpike(_st * rotate2d(-1.992) * scale(vec2(1.990,1.460)) + translate(vec2(0.430,-0.050)));
                a += drawSpike(_st * rotate2d(-2.648) * scale(vec2(1.990,1.460)) + translate(vec2(0.490,0.020)));
                a += drawCircle(_st-vec2(-0.560,-0.180),0.006);
            }else if(r <= 3./24.){ // Zinc
                a += drawSpike(_st * rotate2d(-1.032) * scale(vec2(1.690,1.560)) + translate(vec2(0.530,-1.080)));
                a += drawSpike(_st * rotate2d(-1.060) * scale(vec2(1.690,1.560)) + translate(vec2(0.300,-0.990)));
                a += drawCircle(_st-vec2(-0.360,-0.390),0.006);
            }else if(r <= 4./24.){ // unkown/H
                a += drawSpike(_st * rotate2d(-0.704) * scale(vec2(1.690,1.560)) + translate(vec2(0.600,-1.070)));
                a += drawSpike(_st * rotate2d(0.348) * scale(vec2(1.690,1.560)) + translate(vec2(0.450,-1.070)));
                a += drawCircle(_st-vec2(-0.360,-0.390),0.006);
            }else if(r <= 5./24.){ // Malatium
                a += drawSpike(_st * rotate2d(2.312) * scale(vec2(1.990,0.800)) + vec2(1.490,0.470));
                a += drawSpike(_st * rotate2d(-1.824) * scale(vec2(1.790,1.560)) + translate(vec2(0.530,-1.120)));
                a += drawSpike(_st * rotate2d(0.548) * scale(vec2(1.690,1.560)) + translate(vec2(0.460,-1.160)));
                a += drawSpike(_st * rotate2d(-0.260) * scale(vec2(1.990,1.660)) + translate(vec2(0.450,-1.150)));
                a += drawSpike(_st * rotate2d(-0.916) * scale(vec2(1.990,1.660)) + translate(vec2(0.500,-1.120)));
                a += drawCircle(_st-vec2(-0.360,-0.390),0.006);
            }else if(r <= 6./24.){ // Lerasium
                _st += 0.012;
                a += drawSpike(_st * rotate2d(1.928) * scale(vec2(1.690,1.560)) + translate(vec2(0.400,-0.270)));
                a += drawSpike(_st * scale(vec2(1.430,1.360)) * rotate2d(2.648)  + translate(vec2(0.590,-0.30))); //slight curve to nail with different order of transforms failed
                a += drawCircle(_st-vec2(-0.360,-0.390),0.006);
                a += partMoon(_st* rotate2d(0.488) * scale(vec2(1.290,0.910))+ vec2(+0.230,+0.110),1.648);
            }else if(r <= 7./24.){ // Electrum
                a += partMoon(_st  * rotate2d(7.088)* scale(vec2(1.3,1.000))+vec2(0.080,-0.020),0.472);
                _st += 0.012;
                a += drawSpike(_st  * rotate2d(3.952) * scale(vec2(1.290,1.260))  + translate(vec2(0.590,-0.30))); //slight curve to nail with different order of transforms failed
                a += drawCircle(_st-vec2(-0.350,-0.570),0.006);
            }
        }else if(r <= 10./24.){
            a += drawMoon(_st* rotate2d(5.512)* scale(vec2(0.960,0.980)),0.050, .28);
            if(r <= 8./24.){ // Cadmium
                a += drawSpike(_st * rotate2d(-PI) * scale(vec2(1.090,1.260)) + translate(vec2(0.580,-0.470)));
                a += drawSpike(_st * rotate2d(-HALF_PI) * scale(vec2(1.990,1.460)) + translate(vec2(0.490,-1.120)));
                a += drawCircle(_st-vec2(-0.480,-0.200),0.006);
            }else if(r <= 9./24.){ // Chromium
                a += drawSpike(_st * rotate2d(-2.160) * scale(vec2(1.390,1.060)) + translate(vec2(0.580,-0.870)));
				a += partMoon(_st  * rotate2d(5.076)* scale(vec2(1.3,1.300))+vec2(-0.110,-0.050),1.968);
                a += drawCircle(_st-vec2(-0.480,-0.200),0.006);
            }else if(r <= 10./24.){ // Malatium
                _st = _st * rotate2d(-1.104); 
                a += drawSpike(_st * rotate2d(-2.524) * scale(vec2(1.790,1.560)) + translate(vec2(0.530,-1.120)));
                a += drawSpike(_st * rotate2d(3.740) * scale(vec2(1.690,1.560)) + translate(vec2(0.560,-0.060)));
				a += drawSpike(_st * rotate2d(-1.500) * scale(vec2(1.990,1.660)) + translate(vec2(0.500,-1.120)));
                a += drawSpike(_st * rotate2d(-0.404) * scale(vec2(1.990,1.660)) + translate(vec2(0.500,-1.120)));
                a += drawCircle(_st-vec2(-0.310,-0.350),0.006);
            }
        }else if(r <= 14./24.){
            if (r <= 12./24.) _st *= rotate2d(PI); // two left two right
            a += drawMoon(_st* rotate2d(-0.600)* scale(vec2(0.780,-0.910))+ vec2(0.010,0.000),0.060, .29);
            if(r <= 11./24.){ // unknown/C
                a += drawSpike(_st * rotate2d(-HALF_PI) * scale(vec2(1.990,1.460)) + translate(vec2(0.490,-1.120)));
                a += drawSpike(_st * rotate2d(+HALF_PI) * scale(vec2(1.990,1.460)) + translate(vec2(0.490,-1.120)));
                a += drawCircle(_st-vec2(-0.490,-0.500),0.006);
            }else if(r <= 12./24.){ // unknown/X
                a += drawSpike(_st * rotate2d(-HALF_PI) * scale(vec2(0.790,1.460)) + translate(vec2(0.540,-0.580)));
                a += drawCircle(_st-vec2(-0.60,-0.500),0.006);
            }else if(r <= 13./24.){ // unknown/J
                a += drawSpike(_st * rotate2d(-HALF_PI) * scale(vec2(1.990,1.460)) + translate(vec2(0.490,-1.120)));
                a += drawCircle(_st-vec2(-0.310,-0.520),0.006);
            }else if(r <= 14./24.){ // Bendalloy
                a += drawSpike(_st * rotate2d(-HALF_PI) * scale(vec2(0.790,1.460)) + translate(vec2(0.540,-0.580)));
                a += drawSpike(_st * rotate2d(-PI) * scale(vec2(0.790,1.460)) + translate(vec2(0.740,-0.580)));
                a += drawCircle(_st-vec2(-0.350,-0.470),0.006);
            }
        }else if(r <= 21./24.){
            if (r > 17./24.) _st *= rotate2d(PI) * scale(vec2(.8)); // three down rest up
            a += drawMoon(_st* rotate2d(TRQT_PI/2.) * scale(vec2(1.3))+ vec2(0.010,0.000),0.036, .29);
            if(r <= 15./24.){ // Tin
                a += drawSpike(_st * rotate2d(-HALF_PI) * scale(vec2(1.00,1.460)) + translate(vec2(0.520,-0.520)));
                a += drawCircle(_st-vec2(-0.490,-0.040),0.006);
                a += drawMoon(_st* rotate2d(TRQT_PI/2.) * scale(vec2(0.8))+ vec2(0.010,0.000),0.036, .29);
            }else if(r <= 16./24.){ // unknown/X
                a += drawSpike(_st * rotate2d(-2.440) * scale(vec2(1.00,1.460)) + translate(vec2(0.520,-0.520)));
                a += drawCircle(_st-vec2(-0.470,-0.640),0.006);
                a += drawMoon(_st* rotate2d(TRQT_PI/2.) * scale(vec2(0.8))+ vec2(0.010,0.000),0.036, .29);
            }else if(r <= 17./24.){ // Pewter
                a += drawSpike(_st * rotate2d(-2.440) * scale(vec2(1.00,1.460)) + translate(vec2(0.520,-0.520)));
                a += drawCircle(_st-vec2(-0.580,-0.590),0.006);
                a += partMoon(_st* rotate2d(TRQT_PI/2.376) * scale(vec2(0.8,1.2))+ vec2(0.010,0.200), 0.610);
            }else if(r <= 18./24.){ // Copper
                a += drawSpike(_st * rotate2d(0.720) * scale(vec2(0.990,1.460)) + translate(vec2(0.470,-0.7040)));
                a += drawSpike(_st * rotate2d(0.736) * scale(vec2(1.990,1.370)) + translate(vec2(0.60,-1.120)));
                a += drawCircle(_st-vec2(-0.350,-0.470),0.006);
            }else if(r <= 19./24.){ // Bronze
                a += drawSpike(_st * rotate2d(4.336) * scale(vec2(1.10,1.460)) + translate(vec2(0.490,-0.5240)));
                a += drawSpike(_st * rotate2d(3.992) * scale(vec2(1.390,1.370)) + translate(vec2(0.40,-0.320)));
                a += drawCircle(_st-vec2(-0.590,-0.640),0.006);
            }else if(r <= 20./24.){ // Atrium
                _st = _st * rotate2d(2.192); 
                a += drawSpike(_st * rotate2d(-2.524) * scale(vec2(2.990,1.560)) + translate(vec2(0.530,-1.380)));
                a += drawSpike(_st * rotate2d(3.740) * scale(vec2(2.890,1.60)) + translate(vec2(0.540,-0.130)));
				a += drawSpike(_st * rotate2d(-1.500) * scale(vec2(2.890,1.660)) + translate(vec2(0.600,-1.220)));
                a += drawSpike(_st * rotate2d(-0.404) * scale(vec2(2.80,1.660)) + translate(vec2(0.540,-1.220)));
                a += drawCircle(_st-vec2(-0.310,-0.350),0.006);
            }else if(r <= 21./24.){ // Aluminum
                _st = _st * rotate2d(2.192); 
                a += drawSpike(_st * rotate2d(-2.588) * scale(vec2(2.990,1.560)) + translate(vec2(0.530,-1.380)));
                a += drawSpike(_st * rotate2d(1.092) * scale(vec2(2.890,1.60)) + translate(vec2(0.460,-1.280)));
                a += drawSpike(_st * rotate2d(-0.740) * scale(vec2(2.80,1.660)) + translate(vec2(0.540,-1.220)));
                a += drawCircle(_st-vec2(-0.310,-0.350),0.006);
            }
        }else if(r <= 22./24.){//Duralumin
        	a += drawMoon(_st* rotate2d(TRQT_PI/1.520) * scale(vec2(-0.900,0.900))+ vec2(-0.010,0.040),0.036, .29);
            a += drawSpike(_st * rotate2d(0.836) * scale(vec2(2.290,1.560)) + translate(vec2(0.480,-1.380)));
            a += drawSpike(_st * rotate2d(2.364) * scale(vec2(2.000,1.560)) + translate(vec2(0.380,-1.380)));
            a += drawSpike(_st * rotate2d(2.364) * scale(vec2(2.000,1.560)) + translate(vec2(0.580,-1.380)));
            a += drawSpike(_st * rotate2d(2.364+PI) * scale(vec2(2.000,1.560)) + translate(vec2(0.650,-1.380)));
            a += drawSpike(_st * rotate2d(2.364+PI) * scale(vec2(2.000,1.560)) + translate(vec2(0.450,-1.380)));
            a += drawCircle(_st-vec2(-0.470,-0.50),0.006);
        }else if(r <= 23./24.){//Duralumin
            _st *= rotate2d(3.304);
        	a += drawMoon(_st* rotate2d(TRQT_PI/1.520) * scale(vec2(-0.900,0.900))+ vec2(-0.010,0.040),0.076, 0.402);
            a += drawSpike(_st * rotate2d(2.024) * scale(vec2(0.990,1.460)) + translate(vec2(0.770,-0.6040)));
            a += drawSpike(_st * rotate2d(2.054) * scale(vec2(1.890,1.570)) + translate(vec2(0.640,-0.210)));
            a += drawCircle(_st-vec2(-0.350,-0.470),0.006);
        }else{ // 24.  Brass
	        a += drawMoon(_st* rotate2d(-1.792) * scale(vec2(-0.900,0.900))+ vec2(-0.010,0.040),0.044, 0.282);
            _st = _st * rotate2d(-2.584) * 0.98+vec2(0.030,0.080); 
            a += drawSpike(_st * rotate2d(-2.524) * scale(vec2(1.790,1.560)) + translate(vec2(0.530,-1.120)));
            a += drawSpike(_st * rotate2d(1.644) * scale(vec2(1.690,1.560)) + translate(vec2(0.490,-1.090)));
			a += drawSpike(_st * rotate2d(-1.500) * scale(vec2(1.990,1.660)) + translate(vec2(0.500,-1.120)));
            a += drawSpike(_st * rotate2d(-0.404) * scale(vec2(1.990,1.660)) + translate(vec2(0.500,-1.120)));
            a += drawCircle(_st-vec2(-0.490,-0.500),0.006);
        }
    }

      
    return 1.-a;
}

//simple domain warping
vec3 smoke(in vec2 st){
    float a = fbm(st* 10. + (sin(iTime),iTime+cos(iTime*.5+.1)));
    float b = fbm(st*4.+ a* vec2(sin(iTime),sin(iTime*.56))*.3);
    float c = fbm(st * vec2(a,b));
    return hsb2rgb(vec3(a*.2+0.832,b-.3,.3+c));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 st = fragCoord.xy/iResolution.xy;
    st.x *= iResolution.x/iResolution.y;
	//st *= 20.;
    vec3 color = smoke(st);
    
    st*=7.0;
    vec2 ipos = floor(st);
	 
    st.y += +iTime * (rand(ipos.x,PI) * 2.+.2);
    ipos.y = floor(st.y);
    vec2 fpos = fract(st);
    float a = glyph2(fpos, rand(ipos));
	fill(color, fpos, a);
    fragColor = vec4(color,1.0);
}