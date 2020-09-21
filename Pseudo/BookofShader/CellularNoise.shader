shader_type canvas_item;
const float PI = 3.14159265358979323846;

uniform float x_offset = 1.0;
uniform float scale = 1.0;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

void fragment(){
    vec2 st = UV;
    vec3 color = vec3(0.0);
	
	 st *= scale;

    // Tile the space
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);

    float m_dist = 1.;  // minimun distance

    for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            // Neighbor place in the grid
            vec2 neighbor = vec2(float(x),float(y));

            // Random position from current + neighbor place in the grid
            vec2 point = random2(i_st + neighbor);

			// Animate the point
            point = 0.5 + 0.5*sin(TIME + 6.2831*point);

			// Vector between the pixel and the point
            vec2 diff = neighbor + point - f_st;

            // Distance to the point
            float dist = length(diff);

            // Keep the closer distance
            m_dist = min(m_dist, dist);
		}
    }

    // Draw the min distance (distance field)
    color += smoothstep(0,1.0,m_dist);

    // Draw cell center
    color += 1.-step(.02, m_dist);

    // Draw grid
    //color.r += step(.98, f_st.x) + step(.98, f_st.y);

    COLOR =  vec4(color,1.0);
}