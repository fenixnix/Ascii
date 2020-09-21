const float PI = 3.1415926535897932384626433832795;
const float PI2 = PI * 2.0;

const vec3 col = vec3(0,0,0);

struct CircleData
{
    float radius;
    float thickness;
    int flags;
    float flagCount;
};
    
float aliasResolution()
{
    float res = 1.0 / (0.55 * max(iResolution.x, iResolution.y));
    return res;
}

float ditherOffset(int index)
{
    const float offsets[] = float[](-0.04, 0.02, 0.0, -0.015, 0.05, 0.03);
    //return float(index-2*0.01)
    return offsets[index%offsets.length()];
}

float circleFill(float dist, float radius, float thickness)
{
    if (dist <= thickness) { return 1.0; }
    return 0.0;
}

float circleMask(float angle, float dist, int mask, float maskCount)
{
    float value = mod(angle + PI, PI2);
    int pos = int(value / (PI2 / maskCount));
    return float((mask & (1 << pos)) != 0);
}

float samplePoint(vec2 pt, int index, CircleData entry, float time)
{
    float dir = (index%2)==0 ? 1.0 : -1.0;
    float len = length(pt);
    float dist = abs(len - entry.radius/2.0);
    float angle = atan(pt.y, pt.x);
    float curAngle = angle + (time + (1.0/float(index + 1) * time)) * dir;
    
    return circleFill(dist, entry.radius/2.0, entry.thickness/2.0)
            * circleMask(curAngle, len, entry.flags, entry.flagCount);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 resolution;
    resolution.x = resolution.y = min(iResolution.x, iResolution.y);
    vec2 uv = fragCoord/resolution;
    vec2 coord = uv - vec2(0.5, 0.5) + (((resolution - iResolution.xy)/2.0)/resolution);
    

    //TODO: Input buffer?
    CircleData datas[] = CircleData[](
        CircleData( 0.28,	0.008, 	0x3636,		16.0 ),
        CircleData( 0.304,	0.016, 	0x5555,		16.0 ),
        CircleData( 0.36,	0.04,	0xFCD9,		16.0 ),
        CircleData( 0.44,	0.04,	0xACAC,		8.0  ),
        CircleData( 0.52,	0.04,	0xA6A6,		8.0  ),
        CircleData( 0.6,	0.04,	0x5BAA,		16.0 ),
        CircleData( 0.68,	0.04,	0x18B5,		16.0 ),
        CircleData( 0.76,	0.04,	0xFEFE,		16.0 ),
        CircleData( 0.88,	0.08, 	0x5973,		16.0 ),
        CircleData( 0.98,	0.02,	0x155793B1, 32.0 )
    );
    
    float alpha = 0.0;
    float time = iTime / 8.0;
    
    const int SAMPLE_COUNT = 8;
    for (int i = 0; i < datas.length(); ++i)
    {
    	CircleData entry = datas[i];
        
        float accumulated = samplePoint(coord, i, datas[i], time);
        float total = 0.0;
        // radial sampling (better results than square at least)
        for (int j = 0; j < SAMPLE_COUNT; ++j)
        {
            float perc = float(j) / float(SAMPLE_COUNT);
            float turn = perc * PI * 4.0 + PI / 3.0;
            float x = cos(turn) * perc;
            float y = sin(turn) * perc;
            vec2 offset = vec2(x, y);
            total += samplePoint(coord + (offset * aliasResolution()), i, datas[i], time);
        }
        accumulated = total / float(SAMPLE_COUNT);
        
        
        // cumulative so no weird edge artifacts
        alpha += accumulated;
    }
    
    // Output to screen
    fragColor = vec4(col,1.0) * clamp(alpha, 0.0, 1.0);
    
    float yDither = clamp(uv.y + ditherOffset(int(fragCoord.x + fragCoord.y*8.0)), 0.0, 1.0);
    vec3 gradient = vec3(0.0, 0.18, 0.25) * yDither + vec3(0.0, 0.09, 0.125) * (1.0-yDither);
    fragColor += vec4(gradient, 1.0) * (1.0 - fragColor.w);
}