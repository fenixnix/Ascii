shader_type canvas_item;

float potential(vec2 coord, float time)
{
    float t = time * 2.0;
    return saturate(dot(sin(coord * 0.015 + t) + 1.0, vec2(0.4)));
}

float line(vec2 coord, float time)
{
    float reso = 24.0;
    float cw = iResolution.x / reso;

    vec2 pc = floor(coord / cw) * cw;
    vec2 pd = fract(coord / cw) * cw;
    
    float pt = potential(pc,time);
    float lw = pt + 0.5;
    float grad = 1.0 - pt * 2.0;

    return saturate(lw - abs(grad * pd.y - pd.x + cw * pt));
}

void main()
{
    float c = line(FRAGCOORD.xy);
    gl_FragColor = vec4(vec3(c, c, c), 1);
}