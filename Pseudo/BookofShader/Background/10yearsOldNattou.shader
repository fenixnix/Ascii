shader_type canvas_item;

//Number of layers.
//Higher value shows more layers of effects.
//Lower value higher FPS.
const int numLayers = 16;

//Length of worm
const int wormLength = 8;

//Write output color from anywhere to see value of temporary variable.
//vec3 cout;

float rand(vec3 pos)
{
  vec3 p = pos + vec3(2.);
  vec3 fp = fract(p*p.yzx*222.)+vec3(2.);
  p.y *= p.z * fp.x;
  p.x *= p.y * fp.y;
  return
    fract
    (
		p.x*p.x
    );
}

float skewF(float n)
{
/*
n∈N
X∈R^n
X'∈R^n
A∈R^n ∧ |A| = 1
s∈R
f is a non-uniform scaling along direction A and s is the scaling factor.
f:R^n → R^n
X' = f(X)
   = X・A*s*A - X・A*A + X
   = X・A*(s-1)*A + X

∀B(B∈R^n ∧ B・A = 0 ⇒ f(X)・B = X)

X' = f^-1(X)
   = X・A*(1/s-1)*A + X

f^-1(f(X)) = X
X' = X・A*(s-1)*A + X
X = X'・A*(1/s-1)*A + X'
  = (X・A*(s-1)*A + X)・A*(1/s-1)*A + X・A*(s-1)*A + X
  = X・A*(s-1)*(A・A)*(1/s-1)*A + X・A*(1/s-1)*A + X・A*(s-1)*A + X
  = X・A*(1-s-1/s+1)*A          + X・A*(1/s-1)*A + X・A*(s-1)*A + X
  = -X・A*(s-1)*A - X・A*(1/s-1)*A + X・A*(1/s-1)*A + X・A*(s-1)*A + X
  = X

When creating simplex noise, A is a unit vector parallel to a unit hypercube's longest diagonal.
A = (1/√(n), 1/√(n), ...)
  = 1/√(n)(1, 1, ...)

X' = f(X) = (s-1)/n*X・(1, 1, ...)*(1, 1, ...) + X

In skewed coordinate system, basis is not orthogonal.
Any points P in skewed coordinate system such that P∈Z^n become a vertex of a simplex.
In the Cartesian coordinate, all edge of a simplex should have a same length.
But it is not possible in 3D and higher dimension.
Equilateral triangle alone can fill space, but regular tetrahedra alone do not.
Find 's' such that |f^-1((1, 0, 0, ...))| = |f^-1((1, 1, 1, ...))|
|(1/s-1)/n*(1, 0, 0, ...)・(1, 1, ...)*(1, 1, ...) + (1, 0, 0, ...)| = |(1/s-1)/n*(1, 1, ...)・(1, 1, ...)*(1, 1, ...) + (1, 1, 1)|
|(1/s-1)/n*(1, 1, ...) + (1, 0, 0, ...)| = |(1/s-1)*(1, 1, ...) + (1, 1, 1)|
((1/s-1)/n+1)^2 + (((1/s-1)/n)^2)*(n-1) = ((1/s)^2)*n
(1/s-1)*(1/s-1)/(n*n)+ 2*(1/s-1)/n + 1 + (1/s-1)*(1/s-1)*(n-1)/(n*n) = n/(s*s)
2*(1/s-1)/n + 1 + (1/s-1)*(1/s-1)*n/(n*n) = n/(s*s)
2*(1/s-1)/n + 1 + (1/s-1)*(1/s-1)/n = n/(s*s)
(1/s-1)/n*(2 + (1/s-1)) + 1 = n/(s*s)
(1/s-1)/n*(1 + 1/s) + 1 = n/(s*s)
(1-s)/n*(s + 1) + s*s = n
(1-s)*(s + 1) + s*s*n = n*n
(n-1)*s*s + 1 = n*n
s*s = (n*n - 1)/(n-1) = (n+1)(n-1)/(n-1) = n+1
s = sqrt(n+1)

X' = f(X) = (√(n+1)-1)/n*X・(1, 1, ...)*(1, 1, ...) + X
f^-1(X) = (1/√(n+1)-1)/n*X・(1, 1, ...)*(1, 1, ...) + X

Length of edge of a simplex in Cartesian coordinate system:
 f^-1((1, 0, 0, ...))  = (1/√(n+1)-1)/n*(1, 0, 0, ...)・(1, 1, ...)*(1, 1, ...) + (1, 0, 0, ...)
                       = (1/√(n+1)-1)/n*(1, 1, ...) + (1, 0, 0, ...)
|f^-1((1, 0, 0, ...))| = √( ((1/√(n+1)-1)/n+1)^2 + (((1/√(n+1)-1)/n)^2)*(n-1) )
                       = √( ((1/√(n+1)-1)/n)^2 + 2*(1/√(n+1)-1)/n + 1 + (((1/√(n+1)-1)/n)^2)*(n-1) )
                       = √( (((1/√(n+1)-1)/n)^2)*n + 2*(1/√(n+1)-1)/n + 1 )
                       = √( (1/√(n+1)-1)/n*(1/√(n+1)-1 + 2) + 1 )
                       = √( (1/(n+1) - 1)/n + 1 )
                       = √( -n/(n+1)/n + 1 )
                       = √( -1/(n+1) + 1 )
                       = √( n/(n+1) )
https://www.wolframalpha.com/input/?i=sqrt(+((1%2Fsqrt(n%2B1)-1)%2Fn%2B1)^2+%2B+(((1%2Fsqrt(n%2B1)-1)%2Fn)^2)*(n-1)+)

Length of edges of a simplex in Cartesian coordinate system in 3 or higher dimension are not equal.
Y∈{0,1}^n
m = Y・(1, 1, ...)
f^-1(Y) = m*(1/√(n+1)-1)/n*(1, 1, ...) + Y
|f^-1(Y)| = √( ((m*(1/√(n+1)-1)/n+1)^2)*m + ((m*(1/√(n+1)-1)/n)^2)*(n-m) )
          = √( ((m*(1/√(n+1)-1)/n)^2)*m + 2*m*m*(1/√(n+1)-1)/n + m + ((m*(1/√(n+1)-1)/n)^2)*(n-m) )
          = √( ((m*(1/√(n+1)-1)/n)^2)*n + 2*m*m*(1/√(n+1)-1)/n + m )
          = √( (m*(1/√(n+1)-1)/n)*( (m*(1/√(n+1)-1)) + 2*m ) + m )
          = √( (m*(1/√(n+1)-1)/n)*m*( 1/√(n+1)+1 ) + m )
          = √( m*m*(1/(n+1)-1)/n + m )
          = √( m*m*(-n)/(n+1)/n + m )
          = √( -m*m/(n+1) + m )
d/dm(|f^-1(Y)|) = 0.5*(1 - 2*m/(n+1))/√( -m*m/(n+1) + m )
d/dm(|f^-1(Y)|) = 0 when m = 0.5*(n+1)
d/dm(|f^-1(Y)|) = 0.5*(1 - 2/(n+1))/√( n/(n+1) )
                = 0.5*(n-1)/√( n*(n+1) ) > 0 when m = 1
d/dm(|f^-1(Y)|) = 0.5*(1 - 2*n/(n+1))/√( n/(n+1) )
                = 0.5*(1-n)/√( n*(n+1) ) < 0 when m = n

So length of edge is shortest when m = 1 or m = n and other edge is longer than them.

Shortest distance between a vertex on simplex and the opposite edge:
L = √( n/(n+1) )*√(3)/2

References:
https://en.wikipedia.org/wiki/Simplex_noise
http://staffwww.itn.liu.se/~stegu/simplexnoise/simplexnoise.pdf
*/
    return (sqrt(n + 1.0) - 1.0)/n;
}

float unskewG(float n)
{
    return (1.0/sqrt(n + 1.0) - 1.0)/n;
}

vec2 smplxNoise2DDeriv(vec2 x, float m, vec2 g)
{
    vec2 dmdxy = min(dot(x, x) - vec2(0.5), 0.0);
	dmdxy = 8.*x*dmdxy*dmdxy*dmdxy;
	return dmdxy*dot(x, g) + m*g;
}

float smplxNoise2D(vec2 p, out vec2 deriv, float randKey, float roffset, float iTime)
{
    //i is a skewed coordinate of a bottom vertex of a simplex where p is in.
    vec2 i0 = floor(p + vec2( (p.x + p.y)*skewF(2.0) ));
    //x0, x1, x2 are unskewed displacement vectors.
    float unskew = unskewG(2.0);
    vec2 x0 = p - (i0 + vec2((i0.x + i0.y)*unskew));

    vec2 ii1 = x0.x > x0.y ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec2 ii2 = vec2(1.0);

//  vec2 i1 = i0 + ii1;
//  vec2 x1 = p - (i1 + vec2((i1.x + i1.y)*unskew));
//          = p - (i0 + ii1 + vec2((i0.x + i0.y + 1.0)*unskew));
//          = p - (i0 + vec2((i0.x + i0.y)*unskew)) - ii1 - vec2(1.0)*unskew;
    vec2 x1 = x0 - ii1 - vec2(unskew);
//  vec2 i2 = i0 + ii2;
//  vec2 x2 = p - (i2 + vec2((i2.x + i2.y)*unskew));
//          = p - (i0 + ii2 + vec2((i0.x + i0.y + 2.0)*unskew));
//          = p - (i0 + vec2((i0.x + i0.y)*unskew)) - ii2 - vec2(2.0)*unskew;
    vec2 x2 = x0 - ii2 - vec2(2.0*unskew);

    vec3 m = max(vec3(0.5) - vec3(dot(x0, x0), dot(x1, x1), dot(x2, x2)), 0.0);
    m = m*m;
    m = m*m;

    float r0 = 3.1416*2.0*rand(vec3(mod(i0, 16.0)/16.0, randKey));
    float r1 = 3.1416*2.0*rand(vec3(mod(i0 + ii1, 16.0)/16.0, randKey));
    float r2 = 3.1416*2.0*rand(vec3(mod(i0 + ii2, 16.0)/16.0, randKey));

    float randKey2 = randKey + 0.01;
    float spmin = 0.5;
    float sps = 2.0;
    float sp0 = spmin + sps*rand(vec3(mod(i0, 16.0)/16.0, randKey2));
    float sp1 = spmin + sps*rand(vec3(mod(i0 + ii1, 16.0)/16.0, randKey2));
    float sp2 = spmin + sps*rand(vec3(mod(i0 + ii2, 16.0)/16.0, randKey2));

    r0 += iTime*sp0 + roffset;
    r1 += iTime*sp1 + roffset;
    r2 += iTime*sp2 + roffset;
    //Gradients;
    vec2 g0 = vec2(cos(r0), sin(r0));
    vec2 g1 = vec2(cos(r1), sin(r1));
    vec2 g2 = vec2(cos(r2), sin(r2));

    deriv = smplxNoise2DDeriv(x0, m.x, g0) + smplxNoise2DDeriv(x1, m.y, g1) + smplxNoise2DDeriv(x2, m.z, g2);
    return dot(m*vec3(dot(x0, g0), dot(x1, g1), dot(x2, g2)), vec3(1.0));
//    return dot(m*vec3(length(x0), length(x1), length(x2)), vec3(1.0));
}

vec3 norm(vec2 deriv)
{
    deriv *= 2000.0;
	vec3 tx = vec3(1.0, 0.0, deriv.x);
	vec3 ty = vec3(0.0, 1.0, deriv.y);
	return normalize(cross(tx, ty));
}

void fragment()
{
	//vec2 uv = (fragCoord.xy*2.0 - iResolution.xy) / iResolution.y;
	vec2 uv = UV;

    vec3 color = vec3(0.0);
    float s = 1.0;
    for(int i=0; i<numLayers; ++i)
    {
        float sn = 0.0;
        float y = 0.0;
        
        vec2 deriv;
        float nx = smplxNoise2D(uv*s*4.0, deriv, 0.1+1./s, 0.0,TIME);
        float ny = smplxNoise2D(uv*s*4.0, deriv, 0.11+1./s, 0.0,TIME);
        for(int j=0; j<wormLength; ++j)
        {
        	vec2 deriv1;

			sn += smplxNoise2D(uv*s+vec2(1./s, 0.)+vec2(nx,ny)*4., deriv1, 0.2+1./s, y,TIME);
        	color += vec3(norm(deriv1).z)/s;
            y += 0.1;
        }
        s *= 1.1;
    }
    color /= 4.;

    vec2 deriv;
    float delay = smplxNoise2D(uv*s*1.0, deriv, 0.111, 0.0,TIME);
    color = mix(color, vec3(1.0) - color, clamp(sin(TIME*0.25+uv.x*0.5+delay*32.)*32., 0.0, 1.0));

    vec3 cout = color;

	COLOR = vec4(cout, 1.0);
}
