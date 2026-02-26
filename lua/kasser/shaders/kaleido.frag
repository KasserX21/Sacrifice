/*
  Krasohled 1.0
   Written by Blokatt (Jan Vorisek)
  blokatt.net | @blokatt | github.com/blokatt
   20/09/18
*/

#version 120
#define TIME_SHIFT 0.
#define SEGMENTS 6.0
#define NOISE_ALPHA 0.055
#define SHARPNESS 3.81

#define PI 3.141592653589793238462643
#define TAU PI * 2.0

uniform sampler2D sampler0;
uniform vec2 textureSize;
uniform vec2 imageSize;
uniform float time;
uniform float speed;
uniform float amount;

vec2 img2tex( vec2 v ) { return v / textureSize * imageSize; }


mat2 rot(in float a){
    return mat2(cos(a),-sin(a),
                sin(a),cos(a));
}

vec4 tex(in vec2 uv, in float amount){
    float t = sin(amount * .1) * .5 + .5;   
    float l = length(uv - .5);
    uv = (uv - .5) * rot(-amount * .4 + (l * 1.3)) + .5;    
    uv.x += sin(amount * .05 + .2);
    uv.y += cos(amount * .025 + .4);
    
    return  texture2D(sampler0, img2tex(uv));
}


float smoothmod(float v, float d){
	float res = mod(v, d);
    return res * (1. - smoothstep(d - d / SHARPNESS, d, res)); 
}

vec4 weird(in vec2 inUv, in float amount){   
    inUv -= .5;   
    inUv.x *= imageSize.x / imageSize.y;
    vec2 uv = inUv;
    float baseA = atan(uv.y, uv.x);
    float l = length(uv) + sin(baseA * 5. - amount) * sin(amount * .1 + .7) * .005;          
    float a = baseA + l * (.5 + .2 * sin(l * 5. + amount * 2.5 + .2));    
    a = amount + smoothmod(a + 1. * (amount * .5 - l) + 2. + 2. * sin(amount * .1), TAU / SEGMENTS) + (TAU / 10.) * (1. -  (smoothstep(1.0, 1.02, smoothmod(a, TAU / 10.) * (2. / (TAU / 10.))) / 2.));    
    uv = vec2(cos(a) * l, sin(a) * l);
    uv *= (1. + l + sin(amount * .5) * 2.);
    vec4 outCol = tex(vec2(uv.x, uv.y) + .5, amount) * (1. + 7. * smoothstep(.8, 1.4, l));
    return outCol - (NOISE_ALPHA * texture2D(sampler0, img2tex(inUv * 9. * rot(-amount * 1.))));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/imageSize.xy;
    vec4 t0 = vec4(weird(uv, amount - .02).r, weird(uv, amount).g, weird(uv, amount + .02).b, 1.);
    vec4 t1 = vec4(weird(uv, amount - .02 - .01).r, weird(uv, amount - .01).g, weird(uv, amount + .02 - .01).b, 1.);
    vec4 t2 = vec4(weird(uv, amount - .02 - .02).r, weird(uv, amount - .02).g, weird(uv, amount + .02 - .02).b, 1.);
    fragColor = mix(mix(t0, t1, .5), t2, .5) * vec4(1., .75, .9, 1.) + vec4(.01, 0., .02, 1.);
    //fragColor = tex(uv, amount);
}

void main() {
    mainImage(gl_FragColor.rgba, gl_FragCoord.xy);
}