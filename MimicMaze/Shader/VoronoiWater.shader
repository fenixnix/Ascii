shader_type canvas_item;

uniform float scale = 1.2;

void fragment()
{
	vec2 uv = FRAGCOORD.xy;
    float t = TIME;
    mat3 rot = mat3(
		vec3(-2.,-1.,2.),
		vec3(3.,-2.,1.),
		vec3(1.,2.,2.));
	vec3 pos = vec3(uv+t*1e2,t*2e2);
    
    float dist = 1.;
    
    //***rotate the plane&&calc distance to cell center then get minimum of three
    float s[3] = float[3](.32,.28,.26);
    for(int i = 0;i<3;i++)
    {
    	pos *= rot*s[i];
    	dist = min(dist,length(.5-fract(pos/2e2*scale)));
    }
    
    COLOR = pow((dist), 7.)*25.+vec4(0,.35,.5,1.);
}
 