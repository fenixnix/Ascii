shader_type canvas_item;

uniform int itera = 128;
uniform float iTime;

float sdHexPrism( vec3 p, vec2 h ) {
    vec3 q = abs(p);
    return max(q.z-h.y,max((q.x*0.866025+q.y*0.5),q.y)-h.x);
}

float opRep( vec3 p, vec3 spacing ) {
    vec3 q = mod(p, spacing) - 0.5 * spacing;
    return sdHexPrism( q, vec2( 0.2 + 0.1 * cos(iTime/2.), 1.0 + 0.9 * sin(3.14 + iTime/2.) ) );
}

void fragment()
{
	vec2 iResolution = vec2(1.);
	vec2 fragCoord = UV;
    // 1 : retrieve the fragment's coordinates
	vec2 uv = fragCoord.xy / iResolution.xy;
    uv -= vec2(0.5, 0.5);
	uv.x *= iResolution.x / iResolution.y;		// Correct for aspect ratio
	
    // 2 : camera position and ray direction
	// vec3 pos = vec3( sin(iTime), 0, sin(iTime) * 5. );
	vec3 pos = vec3( sin(iTime), 0, iTime / 20. );
	vec3 dir = normalize( vec3( uv, 1. ) );
 
	// 3 : ray march loop
    // ip will store where the ray hits the surface
	vec3 ip;
 
	// variable step size
	float t = 0.0;
	float findThresh = 0.001;
	int found = 0;
    int last_i = 0;
    
	for(int i = 0; i < itera; i++) {
		last_i = i;
        
        //update position along path
        ip = pos + dir * t;
 
        //gets the shortest distance to the scene
        //break the loop if the distance was too small
        //this means that we are close enough to the surface
 		float temp;

		// make a repeating SDF shape
		temp = opRep( ip, vec3(2.5 + 2.0 * sin(iTime/2.) ) );
		if( temp < findThresh ) {
			float r = 0.7 + 0.3 * sin(ip.z/8. + ip.x/2.);
			float g = 0.6 + 0.3 * cos(ip.z/8. + ip.y/2.);
			float b = 0.5 + 0.4 * sin(ip.z/8. + ip.x);
			ip = vec3(r, g, b);
			found = 1;
			break;
		}
		
		//increment the step along the ray path
		t += temp;
	}
	
	// make background black if no shape was hit
	if(found == 0) {
		ip = vec3(0,0,0);
	}
 
	// 4 : apply color to this fragment
    // subtract from color as distance increases
	COLOR = vec4(ip - float(last_i) / float(itera), 1.0 );
}