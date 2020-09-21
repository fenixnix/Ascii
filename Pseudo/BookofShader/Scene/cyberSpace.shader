shader_type canvas_item;
// Some code swiped and mangled from fb39ca4 :)

const int MAX_RAY_STEPS = 17;

vec2 rotate2d(vec2 v, float a) {
	float sinA = sin(a);
	float cosA = cos(a);
	return vec2(v.x * cosA - v.y * sinA, v.y * cosA + v.x * sinA);	
}

void fragment()
{
	float iTime = TIME*.3;
	//vec2 screenPos = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
	vec2 screenPos = UV*2.-1.;
    screenPos.y += 0.01;
	vec3 cameraDir = vec3(0.0, 0.0, 0.8);
	vec3 cameraPlaneU = vec3(1.0, 0.0, 0.0);
	vec3 cameraPlaneV = vec3(0.0, 1.0, 0.0);// * iResolution.y / iResolution.x;
	vec3 rayDir = cameraDir + screenPos.x * cameraPlaneU + screenPos.y * cameraPlaneV;
    rayDir = normalize(rayDir);
	vec3 rayPos = vec3(0.5*sin(iTime * 0.17), 0.5 * sin(iTime * 0.23), 0.5 * sin(iTime * 0.3));
    rayPos += 1.5;
    rayPos.z += iTime*5.0;
	rayDir.xz = rotate2d(rayDir.xz, 0.5+0.3*sin(iTime*0.2));
    	
    // This is just the basic voxel marching setup used throughout shadertoy, developed by fb39ca4 and others
	vec3 mapPos = vec3(floor(rayPos));
	vec3 deltaDist = abs(vec3(length(rayDir)) / rayDir);
	vec3 rayStep = sign(rayDir);
	vec3 sideDist = (sign(rayDir) * (mapPos - rayPos) + (sign(rayDir) * 0.5) + 0.5) * deltaDist; 
	vec3 mask;
    
    // Additionally, keep track of...
    int spacefilling=0; // How many empty voxels were marched through
    bool filled=false;  // Was the final voxel filled
    float dist = 0.0; float ddist = 1.0;
    
    // This is the only loop
    // The steps taken will be some mix of:
    //    a] Step forwards into an empty voxel
    // and
    //    b] Move down the hierarchy of the menger
	for (int i = 0; i < MAX_RAY_STEPS; i++) {
        mask = step(sideDist.xyz, sideDist.yzx) * step(sideDist.xyz, sideDist.zxy);
        
        // This checks the current map position to see if it intersects the menger
        ivec3 relPos = ((ivec3(mapPos)+3333) % 3)-1;
        bvec3 bb= bvec3(relPos);
        bool b2 = false; //(int(mapPos.z) + int(mapPos.x) % 17) % 21 == 0;
        bool isHit = (!bb.x && !bb.y) || (!bb.y && !bb.z) || (!bb.x && !bb.z) || b2;
        
        if (!isHit) { // No intersect - march forward one voxel
            sideDist += mask * deltaDist;
            mapPos += mask * rayStep;
            
            spacefilling++;
            filled=true;
            dist += ddist;
            
            ivec3 esc = ivec3(mask*sign(rayDir))*relPos;
            if (esc.x + esc.y + esc.z > 0) {

                // Set the new ray origin just slightly back of where the voxel would have been hit
                rayPos = dot(mask, sideDist-sign(rayPos)*0.001)*rayDir + rayPos;

                    // Scale ray origin up by 3x. This is equivalent to moving down-hierarchy
                rayPos /= 3.;


                // Reset the voxel marching
                mapPos = vec3(floor(rayPos));
                sideDist = (sign(rayDir) * (mapPos - rayPos) + (sign(rayDir) * 0.5) + 0.5) * deltaDist;
                
                ddist *= 2.0;
            }
            
    	} else {// Intersect - move down-hierarchy instead of marching forward
			
            // Set the new ray origin just slightly back of where the voxel would have been hit
            rayPos = dot(mask, sideDist-sign(rayPos)*0.001)*rayDir + rayPos;
            
            // Scale ray origin up by 3x. This is equivalent to moving down-hierarchy
            rayPos *= 3.;
            
            // Reset the voxel marching
            mapPos = vec3(floor(rayPos));
            sideDist = (sign(rayDir) * (mapPos - rayPos) + (sign(rayDir) * 0.5) + 0.5) * deltaDist;
            
            filled = false;
            ddist *= 0.5;
        } 
	}
	
    if (!filled) spacefilling++;
    float f = float(spacefilling)/float(MAX_RAY_STEPS); 
	float brightness = pow(0.85, dist);
    vec3 color = vec3(sin(float(f)*2.33), 1.0, cos(float(f)*4.0));
    color.r = 0.5 + 0.5*sin(f*20.0);
    color.g = 0.5 + 0.5*cos(f*20.0);
    color.b = 5.0*dist/float(MAX_RAY_STEPS);

	COLOR = vec4(color,1.);
	//fragColor.rgb = texelFetch(iChannel0, ivec2(fragCoord), 0).rgb*0.8 + 0.25*color*brightness;
}