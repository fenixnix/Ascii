shader_type canvas_item;

uniform float ANIMATE = 10.0;
uniform float INV_ANIMATE_FREQ =  0.05;
uniform float RADIUS = 1.3;
uniform float FREQ = 10.0;
uniform float LENGTH = 2.0;
uniform float SOFTNESS = 0.1;
uniform float WEIRDNESS = 0.1;

uniform bool ASPECT_AWARE = true;
uniform vec4 color : hint_color;

float lofi(float x, float d){
	return floor((x/d)*(d));
}

float hash( vec2 v ) {
  return fract( sin( dot( v, vec2( 89.44, 19.36 ) ) ) * 22189.22 );
}

float iHash( vec2 v, vec2 r ) {
  vec4 h = vec4(
    hash( vec2( floor( v * r + vec2( 0.0, 0.0 ) ) / r ) ),
    hash( vec2( floor( v * r + vec2( 0.0, 1.0 ) ) / r ) ),
    hash( vec2( floor( v * r + vec2( 1.0, 0.0 ) ) / r ) ),
    hash( vec2( floor( v * r + vec2( 1.0, 1.0 ) ) / r ) )
  );
  vec2 ip = vec2( smoothstep(
    vec2( 0.0 ),
    vec2( 1.0 ),
    mod( v * r, 1.0 ) )
  );
  return mix(
    mix( h.x, h.y, ip.y ),
    mix( h.z, h.w, ip.y ),
    ip.x
  );
}

float noise( vec2 v ) {
  float sum = 0.0;
  for( int i = 1; i < 7; i ++ ) {
    sum += iHash(
      v + vec2(float(i)),
      vec2( 2.0 * pow( 2.0, float( i ) ) ) ) / pow( 2.0, float( i )
    );
  }
  return sum;
}

void fragment() {
	float iTime = TIME;
	vec2 uv = UV-0.5;
	uv*=2.;
//	if (ASPECT_AWARE){
//		vec2 uv = ( fragCoord.xy * 2.0 - iResolution.xy ) / iResolution.xy;
//	}else{
//		vec2 uv = ( fragCoord.xy * 2.0 - iResolution.xy ) / iResolution.y;
//	}
  vec2 puv = vec2(
    WEIRDNESS * length( uv ) + ANIMATE * lofi( iTime, INV_ANIMATE_FREQ ),
    FREQ * atan( uv.y, uv.x )
  );
  float value = noise( puv );
  value = length( uv ) - RADIUS - LENGTH * ( value - 0.5 );
  value = smoothstep( -SOFTNESS, SOFTNESS, value );
	vec3 clr = value * color.rgb;
  COLOR = vec4(clr,value);
}
