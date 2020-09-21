// TODO: Use the actual distance fields for advancing the ray!

//#define RENDER_DEPTH
#define ENABLE_FOG
//#define ANIMATE_CUBES

const int max_shadow_ray_samples = 32;
const int max_ray_samples = 512;	// TODO: Rename to "max_view_ray_samples".
const float max_view_distance = 12.0;	// TODO: Adjust!
const float wall_distance = 0.3;

const vec3 light_color_blue = vec3(0.2, 0.275, 1.0) * 40.0;
const vec3 light_color_pink = vec3(1.0, 0.325, 0.35) * 10.0;

//const vec3 fog_color = vec3(0.2, 0.2, 1.0) * 1.7;
const vec3 fog_color = light_color_blue * 0.1;

// Perlin noise:
float mod289(float x)
{
	return(x - floor(x * (1.0 / 289.0)) * 289.0);
}

vec4 mod289(vec4 x)
{
	return(x - floor(x * (1.0 / 289.0)) * 289.0);
}

vec4 perm(vec4 x)
{
	return(mod289(((x * 34.0) + 1.0) * x));
}

float perlin_2d(vec2 p)
{
    vec2 a = floor(p);
    vec2 d = p - a.xy;
    d = d * d * (3.0 - 2.0 * d);

    vec4 b = vec4(a.x, a.x + 1.0, 0.0, 1.0);
    vec4 k1 = perm(b.xyxy);
    vec4 k2 = perm(k1.xyxy + b.zzww);

    vec4 c = k2 + a.yyyy;
    vec4 k3 = perm(c);
    vec4 k4 = perm(c + 1.0);

    vec4 o1 = fract(k3 * (1.0 / 41.0));
    vec4 o2 = fract(k4 * (1.0 / 41.0));

    vec4 o3 = o2 * d.y + o1 * (1.0 - d.y);
    vec2 o4 = o3.yw * d.x + o3.xz * (1.0 - d.x);

    return(o4.y * 0.0 + o4.x * 1.0);
}

float calculate_height(vec3 position)
{
    vec2 p = round(position.yz * 3.0) / 3.0;	// Round the coordinates so we get a blocky heightmap.
     
	float n = //perlin_2d(p) +
              //0.5 * perlin_2d(p * 2.0) +
                0.25 * perlin_2d(p * 4.0) +
                0.125 * perlin_2d(p * 8.0) +
                0.0625 * perlin_2d(p * 16.0) +	// TODO: PERFORMANCE: How detailed does the noise function need to be?
                0.03125 * perlin_2d(p * 32.0);
              //+ 0.015625 * perlin_2d(p * 64.0);
    
    
    
   
    
    // TODO: Instead of calculating an offset for the noise every frame,
    //       how about simply transforming the ray instead?
    
    /*
#ifdef ANIMATE_CUBES
    float noise_value = wall_distance + max(n * sin(n * 31.42 + iTime * 2.0) * 0.5, 0.0);
        
#else
    float noise_value = wall_distance + n * 0.3;
#endif
    */
    float noise_value = n;
    
    return(noise_value);
    
    /*
    float offset_y = step(mod(uv.y * 4.0, 7.0), 1.0);
    offset_y += step(mod(uv.x * 40.0, 3.0), 1.0);
    offset_y *= step(mod(uv.x * 40.0, 3.0), 1.0);

	return(offset_y); 
	*/
}    

// Source: http://iquilezles.org/www/articles/distfunctions/distfunctions.htm
float repeated_box(vec3 p, vec3 c)
{
    vec3 q = mod(p, c) - 0.5 * c;
    //return primitve(q);
    return(0.0);
}

// Source: http://iquilezles.org/www/articles/distfunctions/distfunctions.htm
float signed_distance_box_repeating(vec3 p, vec3 box_position, vec3 box_dimensions, vec3 spacing)
{
    // Translation:
    p -= box_position;
    
    // Repetition:
    //const vec3 c = vec3(0.0, 0.0, 2.5);
    //p = mod(p, c) - 0.5 * c;
    p = mod(p, spacing) - 0.5 * spacing;
    
    
	vec3 d = abs(p) - box_dimensions;
	return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
}

// Source: http://iquilezles.org/www/articles/distfunctions/distfunctions.htm
float signed_distance_box(vec3 p, vec3 box_position, vec3 box_dimensions)
{
    // Translation:
    p -= box_position;
        
	vec3 d = abs(p) - box_dimensions;
	return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
}

float signed_distance_plane(vec3 p, vec3 plane_normal, float plane_distance)
{
    // Project the point onto the plane:
    return(dot(plane_normal, p) + plane_distance);
}

vec3 get_surface_color(vec3 point_of_intersection, float surface_height)
{
    
    if(abs(point_of_intersection.x) - surface_height > 0.01)
    {
        return(vec3(0.1, 0.17, 1.0) * 5.0);
    }
    else if(abs(point_of_intersection.x) - surface_height > 0.01)
    {
        return(vec3(0.5, 0.2, 0.2) * 5.0);
    }

    // TODO: Fix the coordinate offset!
    float cube_corner_step_z = step(mod(point_of_intersection.z - 0.48, 1.0 / 3.0), 0.025);
    float cube_corner_step_y = step(mod(point_of_intersection.y - 0.48, 1.0 / 3.0), 0.025);

    vec3 cube_corner_glow = vec3(0.0);
    cube_corner_glow = mix(cube_corner_glow, vec3(0.5, 0.08, 0.08) * 3.0, cube_corner_step_z);
    cube_corner_glow = mix(cube_corner_glow, vec3(0.5, 0.08, 0.08) * 3.0, cube_corner_step_y);

    return(cube_corner_glow);

    return(vec3(0.0));
    return(vec3(surface_height));
}


float get_wall_distance(vec3 p, vec3 eye_position)
{
    //const float floor_position_y = -2.0;
    
    const vec3 wall_left_normal = normalize(vec3(2.0, -1.0, 0.0));
    const float wall_left_distance = -1.5;
    
    const vec3 wall_right_normal = normalize(vec3(-2.0, -1.0, 0.0));
    const float wall_right_distance = -1.5;
    
    const vec3 floor_normal = normalize(vec3(0.0, 1.0, 0.0));
    const float floor_distance = -3.0;
    
    // Project the point onto the plane:
    float smallest_distance = dot(wall_left_normal, p) - wall_left_distance;
    smallest_distance = min(smallest_distance, dot(wall_right_normal, p) - wall_right_distance);
    //smallest_distance = min(smallest_distance, dot(floor_normal, p) - floor_distance);	// TODO: This one could be simplified.

    
    
    
    const vec3 bottom_wall_left_normal = normalize(vec3(1.0, 0.0, 0.0));
    const float bottom_wall_left_distance = -3.0;
    
    const vec3 bottom_wall_right_normal = normalize(vec3(-1.0, 0.0, 0.0));
    const float bottom_wall_right_distance = -3.0;
    
    smallest_distance = min(smallest_distance, dot(bottom_wall_left_normal, p) - bottom_wall_left_distance);
    smallest_distance = min(smallest_distance, dot(bottom_wall_right_normal, p) - bottom_wall_right_distance);
    
    
    const vec3 wall_ceiling_left_normal = normalize(vec3(2.5, -1.0, 0.0));
    const float wall_ceiling_left_distance = -0.5;
    
    const vec3 wall_ceiling_right_normal = normalize(vec3(-2.5, -1.0, 0.0));
    const float wall_ceiling_right_distance = -0.5;
    
    
    //smallest_distance = 999.9;
    
    float wall_ceiling_distance = dot(wall_ceiling_left_normal, p) - wall_ceiling_left_distance;
    wall_ceiling_distance = max(wall_ceiling_distance, dot(wall_ceiling_right_normal, p) - wall_ceiling_right_distance);
    
    
	smallest_distance = min(smallest_distance, wall_ceiling_distance);
    
    
    // Blocks near the walls:
    const vec3 block_dimensions = vec3(0.3, 2.0, 0.3);
    const vec3 block_spacing = vec3(0.0, 0.0, 7.0);
	smallest_distance = min(smallest_distance, signed_distance_box_repeating(p, vec3(-2.6, -4.2, 0.0), block_dimensions, block_spacing));
	smallest_distance = min(smallest_distance, signed_distance_box_repeating(p, vec3(2.6, -4.2, 0.0), block_dimensions, block_spacing));

    // Block sticking out of the walls below the above blocks:
    smallest_distance = min(smallest_distance, signed_distance_box_repeating(p, vec3(-2.3, -5.1, 0.0), block_dimensions, block_spacing));
	smallest_distance = min(smallest_distance, signed_distance_box_repeating(p, vec3(2.3, -5.1, 0.0), block_dimensions, block_spacing));

    // "ladders" going across:
    float ladder_thickness = 0.035;
	smallest_distance = min(smallest_distance, signed_distance_box_repeating(p, vec3(-2.6, -3.5, 0.3 - ladder_thickness), vec3(5.0, ladder_thickness, ladder_thickness), block_spacing));
	smallest_distance = min(smallest_distance, signed_distance_box_repeating(p, vec3(-2.6, -3.5, -0.3), vec3(5.0, ladder_thickness, ladder_thickness), block_spacing));
    
    // "ladders" steps:
    smallest_distance = min(smallest_distance, signed_distance_box_repeating(p, vec3(-2.6, -3.5, 0.0 - ladder_thickness), vec3(ladder_thickness, ladder_thickness, block_dimensions.z), vec3(0.5, 0.0, block_spacing.z)));

    // Long bars along the walls:
	smallest_distance = min(smallest_distance, signed_distance_box(p, vec3(-2.6, -13.0, -5.0), vec3(0.3, 10.0, 1000000.0)));
	smallest_distance = min(smallest_distance, signed_distance_box(p, vec3(2.6, -13.0, -5.0), vec3(0.3, 10.0, 1000000.0)));

    
    // Moving platform:
	smallest_distance = min(smallest_distance, signed_distance_box(p, vec3(0.0, -1.45, -0.5) + eye_position, vec3(0.5, 0.1, 1.5)));

    
    
    
    // TODO: Add cubes.

    
    return(smallest_distance);
    
    //return(p.y - floor_position_y);
    //return(distance(vec3(p.x, 0.0, p.z), vec3(0.0)));	// TODO: Use signed distance!
    
    //return(false);
}    

float compute_ambient_occlusion(vec3 position, vec3 normal, float max_distance, int samples, vec3 eye_position)
{
    const float surface_offset = 0.001;
    const float sample_distance = 0.08;
    
    float occlusion = 0.0;
    
    //float sample_sum = 0.0;
    
    for(int i=0; i<8; ++i)
    { 
        float sample_offset_distance = surface_offset + float(i) * sample_distance;
        vec3 sample_position = position + normal * sample_offset_distance;
        float sample_weight = 1.0 / float(i + 1);
        //sample_sum += sample_weight;
        
        //occlusion += sample_weight * sample_offset_distance - get_wall_distance(sample_position, eye_position);
		occlusion += sample_weight * max(sample_offset_distance - get_wall_distance(sample_position, eye_position), 0.0);
    }
    
    return(1.0 - occlusion);
}

float calculate_shadow(vec3 p, vec3 light_position, vec3 eye_position)
{    
    vec3 p_to_light = light_position - p;
    float p_to_light_distance = length(p_to_light);
    vec3 n_ray_direction = normalize(p_to_light);
    
    p += n_ray_direction * 0.05;	// Offset	// TODO: Offset using the normal.
    
    float travelled_distance = 0.0;
    
    float step_size = p_to_light_distance / float(max_shadow_ray_samples - 1);	// Incrase the step size so we step over the light.
        
    for(int i=0; i<max_shadow_ray_samples; ++i)
    {
        travelled_distance += step_size;
        vec3 sample_point = p + n_ray_direction * travelled_distance;
        
        if(get_wall_distance(sample_point, eye_position) < 0.0)
        {
            return(0.0);
        }
        
        if(travelled_distance > p_to_light_distance)
        {
            return(1.0);
        }  
    }
    
    return(0.0);
}

vec3 calculate_lighting(vec3 p, vec3 eye_position, vec3 light_position, vec3 light_color, vec3 n_normal)
{
    float ambient_occlusion = compute_ambient_occlusion(p, n_normal, 0.01, 8, eye_position);

    vec3 p_to_light = light_position - p;
    vec3 n_light_direction = normalize(p_to_light);
    vec3 direct_lighting_diffuse = light_color * max(dot(n_light_direction, n_normal), 0.0);
    float squared_p_to_light_distance = dot(p_to_light, p_to_light);
    direct_lighting_diffuse /= squared_p_to_light_distance;	// Inverse square falloff.
    
    // TODO: Add specular.
    
    float shadow = 1.0;
    
    //if(1.0 / squared_p_to_light_distance > 0.01)
    {
    	shadow = calculate_shadow(p, light_position, eye_position);
    }
            
    
    return(shadow * ambient_occlusion * direct_lighting_diffuse);

}  

// Parallax mapping basically:
vec3 trace_ray(vec3 ray_origin, vec3 n_ray_direction, inout float depth)
{
    vec3 eye_position = ray_origin;
    
    /*
    // TODO: Use dot product between Z and X axis only!
    //float dot_product = max(dot(n_ray_direction, vec3(0.0, 0.0, -1.0)), 0.0);
    float dot_product = max(dot(normalize(n_ray_direction.xz), vec2(0.0, -1.0)), 0.0);
    
    
    //dot_product = 1.0 - pow(1.0 - dot_product, 2.0);	// Make the value go bigger towards the center of the screen.
    dot_product = pow(dot_product, 10.0);	// Make the value go bigger towards the center of the screen.
    //return vec3(dot_product);
    
    dot_product *= 0.1;
  
    
    // TODO: Do a binary search?
    
    float step_size = max(dot_product, 0.01);
    */
    
    
    /*
    float intersection_distance = max_view_distance;
    vec3 bounding_plane_point_of_intersection = intersect_wall_bounding_plane(ray_origin, n_ray_direction, intersection_distance);
    
    if(intersection_distance >= max_view_distance)
    {
    	return(fog_color);
    }    
    
    // Offset the ray to the intersection of the bounding plane to speed up the parallax mapping.
    ray_origin = bounding_plane_point_of_intersection;
    
    */
        
    
    //float step_size = 0.001;	// TODO: Base step size on something proper.
    float step_size = max_view_distance / float(max_ray_samples);	// TODO: Base step size on something proper.
    float min_step_size = max_view_distance / float(max_ray_samples);	// TODO: Base step size on something proper.
        
    for(int i=0; i<max_ray_samples; ++i)
    {
        float distance_to_nearest_surface = get_wall_distance(ray_origin, eye_position);
        //step_size = max(distance_to_nearest_surface, min_step_size * 0.01);
        
        //ray_origin += n_ray_direction * 0.01;
        ray_origin += n_ray_direction * step_size;
        
        //depth = distance(ray_origin, eye_position);	// TODO: Calculate this differently?
        
        
        if(distance_to_nearest_surface < 0.0)
        {
            depth = abs(ray_origin.z - eye_position.z);
            
            const float offset = 0.0001;	// Small enough to hide artifacts but still be correct.
            
            vec3 n_normal;
			n_normal.x = get_wall_distance(ray_origin + vec3(offset, 0.0, 0.0), eye_position) - get_wall_distance(ray_origin - vec3(offset, 0.0, 0.0), eye_position);            
			n_normal.y = get_wall_distance(ray_origin + vec3(0.0, offset, 0.0), eye_position) - get_wall_distance(ray_origin - vec3(0.0, offset, 0.0), eye_position);            
			n_normal.z = get_wall_distance(ray_origin + vec3(0.0, 0.0, offset), eye_position) - get_wall_distance(ray_origin - vec3(0.0, 0.0, offset), eye_position);            
            n_normal = normalize(n_normal);
            
            
            /*
            float brightness = (sin(ray_origin.z * 10.0) * 0.5 + 0.5) *
                 			   (sin(ray_origin.y * 10.0) * 0.5 + 0.5) *
                			   (sin(ray_origin.x * 10.0) * 0.5 + 0.5);
            */
            float wire_texture = step(sin(abs(ray_origin.z) * 10.0), 0.9) *
                 			   step(sin(abs(ray_origin.y) * 10.0), 0.9) *
                			   step(sin(abs(ray_origin.x) * 10.0), 0.9);
            //brightness = pow(brightness, 2.0);            
			//brightness = step(brightness, 0.5);
            wire_texture = clamp(1.0 - wire_texture, 0.0, 1.0);
            
            //vec3 light_direction = normalize(vec3(0.5, 0.5, 0.5));
            //vec3 light_direction = normalize(vec3(0.0, 0.0, -1.0));
            //vec3 light_position = eye_position - vec3(1.0, 0.0, 3.0);
            
            vec3 albedo = vec3(wire_texture);
            //vec3 light_position_pink = eye_position - vec3(0.0, 1.0, 2.0);
            vec3 light_position_pink = eye_position + vec3(0.0, -4.5, -2.0);
            
            vec3 light_position_blue = eye_position + vec3(0.0, -1.0, -10.0);
            
            
            vec3 lighting = vec3(0.0);
            
            lighting += calculate_lighting(ray_origin, eye_position, light_position_pink, light_color_pink, n_normal);
           	lighting += calculate_lighting(ray_origin, eye_position, light_position_blue, light_color_blue, n_normal);
           
            //float ambient_occlusion = compute_ambient_occlusion(ray_origin, normal, 0.01, 8, original_ray_origin);
            //return(vec3(ambient_occlusion));
            
            if(ray_origin.y > -2.0)
            {
                lighting += vec3(step(calculate_height(ray_origin * vec3(10.0, 10.0, 5.0)), 0.15)) * 
                    step(sin(0.5 + ray_origin.y * 3.0), 0.0) * 
                    step(sin(ray_origin.z * 2.0), 0.0) *
                    (sin(iTime * 10.0 + ray_origin.y * 10.0 + ray_origin.z * 10.0 + ray_origin.x * 10.0) * 0.5 + 0.5);
            }
            
            //return vec3(shadow);
            
            return(lighting);
            
            return(albedo * lighting);
            
            //return ray_origin;            
            
            //return vec3(max(dot(vec3(0.0, 1.0, 0.0), normal), 0.0));
            
            //return normal;

            //return vec3(mod(distance(ray_origin, light_position), 1.0));
            

            return vec3(wire_texture);
            
    		return(vec3(wire_texture + 0.5)) * 0.25;
            
    		return(vec3(0.0, 0.5, 0.0));
        }
        
        /*
        float surface_height = calculate_height(ray_origin);
        //surface_height = 0.1;
        if(abs(ray_origin.x) > surface_height)	// TODO: Do the ABS before entering this loop!
        {
            depth = distance(ray_origin, eye_position);	// TODO: Calculate this differently?

            if(depth >= max_view_distance)
            {
                depth = max_view_distance;
                return(fog_color);
            }

            return(get_surface_color(ray_origin, surface_height));
        }
        */
    }
    
    depth = max_view_distance;

    return(vec3(0.0));
    return(fog_color);
    return(vec3(0.0, 1.0, 0.0));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 clean_uv = fragCoord / iResolution.xy;
    
    //vec2 half_resolution = vec2(iResolution.x * 0.5, iResolution.y);
    //vec2 half_resolution = iResolution.xy * 0.5;
    //vec2 distance_to_screen_center = abs(fragCoord.xy - half_resolution);
    
    //float dist = 0.075 + 0.9 * (distance_to_screen_center.x / half_resolution.x);
    /*
	vec2 uv;
    uv.x = (distance_to_screen_center.x / dist) / iResolution.x;
    uv.y = ((fragCoord.y - half_resolution.y) / dist) / iResolution.x;
    
    uv.x -= iTime * 0.1;
    */
    // TODO: Reset camera position so it loops (because we are getting precsion issues!).
    
    vec3 ray_origin = vec3(0.0, 0.0, 0.0);
    ray_origin.z -= iTime * 3.0;
    //vec3 n_ray_direction = normalize(vec3(clean_uv * 2.0 - vec2(1.0), -1.0));	// OpenGL coordinate system. Z pointing outside the screen.
    vec3 n_ray_direction = (vec3(clean_uv * 3.0 - vec2(1.5), -1.0));	// OpenGL coordinate system. Z pointing outside the screen.
    
    /*
    // TODO: Why doesn't the rotation work?
    // TODO: Add the ability to look around using the mouse.
    float angle = iTime;
    n_ray_direction.x = cos(angle) * n_ray_direction.x - sin(angle) * n_ray_direction.z;
    n_ray_direction.z = sin(angle) * n_ray_direction.x + cos(angle) * n_ray_direction.z;
    //n_ray_direction = normalize(n_ray_direction);
    */
    
    // TODO: Use view plane depth or actual distance?
    float depth = max_view_distance;
    vec3 trace_result = trace_ray(ray_origin, n_ray_direction, depth);
    
    float normalized_depth = depth / max_view_distance;
    
    
#ifdef RENDER_DEPTH
    fragColor = vec4(normalized_depth, normalized_depth, normalized_depth, 1.0);
    return;
#endif
    
    
	///fragColor = vec4(uv,0.5+0.5*sin(iTime),1.0);
	//fragColor = vec4(uv.xy, 0.5, 1.0);
    
    
    //fragColor.rgb = calculate_texture(uv);
    
    //fragColor.rgb =  trace_result * n_ray_direction;
    fragColor = vec4(trace_result, 1.0);
    
    //fragColor = vec4(normalized_depth, normalized_depth, normalized_depth, 1.0);
    //return;
    
	//fragColor.rgb = mix(vec3(0.0), fog_color, clamp((1.0 - pow(1.0 - normalized_depth, 2.0)) * 1.0, 0.0, 1.0));
    //return;
    
#ifdef ENABLE_FOG
    //float inverse_depth = 1.0 - dist;
    //inverse_depth = 1.0 - normalized_depth;

    //fragColor.rgb = mix(fragColor.rgb, fog_color, clamp(pow(inverse_depth, 1.8) * 1.2, 0.0, 1.0));
	//fragColor.rgb = mix(fragColor.rgb, fog_color, clamp(pow(normalized_depth, 1.0) * 1.25, 0.0, 1.0));
    
    //float mix_factor = 1.0 - pow(1.0 - normalized_depth, 5.0);
    float mix_factor = pow(normalized_depth, 1.0);
    mix_factor = max((mix_factor - 0.25) * 1.5, 0.0);
    fragColor.rgb = mix(fragColor.rgb, fog_color, mix_factor);
#endif    
    
    //fragColor.rgb = vec3(detailed_noise_flat(uv * 50.0));
    
    
   	//fragColor = vec4(0.0);
    
}