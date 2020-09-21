shader_type canvas_item;

void fragment()
{
	float iTime = TIME;
	vec2 uv = UV;
	//vec2 uv = fragCoord.xy / iResolution.xy;

	vec3 wave_color = vec3(0.0);

	float wave_width = 0.0;
	uv  = -3.0 + 2.0 * uv;
	uv.y += 0.0;
	for(float i = 0.0; i <= 28.0; i++) {
		uv.y += (0.2+(0.9*sin(iTime*0.4) * sin(uv.x + i/3.0 + 3.0 *iTime )));
        uv.x += 1.7* sin(iTime*0.4);
		wave_width = abs(1.0 / (200.0*abs(cos(iTime)) * uv.y));
		wave_color += vec3(wave_width *( 0.4+((i+1.0)/18.0)), wave_width * (i / 9.0), wave_width * ((i+1.0)/ 8.0) * 1.9);
	}

	COLOR = vec4(wave_color, 1.0);
}