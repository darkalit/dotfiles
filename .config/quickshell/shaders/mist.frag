#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float opacity;
    float time;

    vec2 uResolution;
    vec2 uOffset;

    vec3 uColorBg; 
    vec3 uColorBlob;
    vec3 uColorShadow;

    float uZoom;
    float uSpeed;
};

layout(binding = 1) uniform sampler2D source;

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9818,79.279)))*43758.5453123);
}

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)), dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

float fractal_brownian_motion(vec2 coord) {
	float value = 0.0;
	float scale = 0.2;
    float gain = 0.4;
	for (int i = 0; i < 6; i++) {
		value += noise(coord) * scale;
		coord *= 2.0;
		scale *= gain;
	}
	return value + 0.2;
}

void main() {
    vec4 tex = texture(source, qt_TexCoord0);
    if (tex.a < 0.1) discard;

    vec2 globalPos = qt_TexCoord0 * uResolution + uOffset;
    vec2 pos = globalPos * uZoom; 
    float t = time * uSpeed; 

    vec2 motion = vec2(fractal_brownian_motion(pos + vec2(t * 1.2, t)));
	float final = fractal_brownian_motion(pos + motion) * 1.0;
    vec4 color  = vec4(mix(uColorBg, uColorBlob, final), opacity);
    fragColor = color;
}
