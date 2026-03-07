#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float time;
} ubuf;

// sRGB <-> linear (needed for OKLab)
vec3 toLinear(vec3 c) { return pow(clamp(c, 0.0, 1.0), vec3(2.2)); }
vec3 toSrgb(vec3 c)   { return pow(clamp(c, 0.0, 1.0), vec3(1.0 / 2.2)); }

// OKLab for perceptually uniform gradient interpolation
vec3 linearToOklab(vec3 c) {
    float l = 0.4122214708*c.r + 0.5363325363*c.g + 0.0514459929*c.b;
    float m = 0.2119034982*c.r + 0.6806995451*c.g + 0.1073969566*c.b;
    float s = 0.0883024619*c.r + 0.2817188376*c.g + 0.6299787005*c.b;
    float l_ = pow(l, 1.0/3.0), m_ = pow(m, 1.0/3.0), s_ = pow(s, 1.0/3.0);
    return vec3(
        0.2104542553*l_ + 0.7936177850*m_ - 0.0040720468*s_,
        1.9779984951*l_ - 2.4285922050*m_ + 0.4505937099*s_,
        0.0259040371*l_ + 0.7827717662*m_ - 0.8086757660*s_
    );
}

vec3 oklabToLinear(vec3 c) {
    float l_ = c.x + 0.3963377774*c.y + 0.2158037573*c.z;
    float m_ = c.x - 0.1055613458*c.y - 0.0638541728*c.z;
    float s_ = c.x - 0.0894841775*c.y - 1.2914855480*c.z;
    float l = l_*l_*l_, m = m_*m_*m_, s = s_*s_*s_;
    return vec3(
        +4.0767416621*l - 3.3077115913*m + 0.2309699292*s,
        -1.2684380046*l + 2.6097574011*m - 0.3413193965*s,
        -0.0041960863*l - 0.7034186147*m + 1.7076147010*s
    );
}

vec3 mixOklab(vec3 a, vec3 b, float t) {
    return toSrgb(oklabToLinear(mix(
        linearToOklab(toLinear(a)),
        linearToOklab(toLinear(b)),
        t
    )));
}

// Value noise (approximation of simplex noise)
float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float valueNoise(vec2 p) {
    vec2 i = floor(p), f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(hash21(i),             hash21(i + vec2(1, 0)), u.x),
        mix(hash21(i + vec2(0, 1)), hash21(i + vec2(1, 1)), u.x),
        u.y
    );
}

void main() {
    vec2 uv = qt_TexCoord0;
    float t = ubuf.time;

    // 1. LinearGradient — vertical, OKLab interpolation
    //    colorA: #071445
    //    colorB: #173285
    vec3 colorA = vec3(0.027, 0.078, 0.271);
    vec3 colorB = vec3(0.090, 0.196, 0.522);
    vec3 color = mixOklab(colorA, colorB, uv.y);

    // 2. SineWave — color2 #284BC9
    //    amplitude=0.2, frequency=0.15, position.y=0.35
    //    thickness=0.4, softness=0.43, speed=0.3, opacity=0.56
    float waveY   = 0.35 + 0.2 * sin(uv.x * 0.15 * 6.28318 + t * 1.0);
    float waveDist = abs(uv.y - waveY);
    float wave = 1.0 - smoothstep(0.4*0.5 - 0.43*0.5, 0.4*0.5 + 0.43*0.5, waveDist);
    vec3 waveColor = vec3(0.157, 0.294, 0.788);
    color = mix(color, waveColor, wave * 0.56);

    // 3. SimplexNoise (value noise approximation)
    //    scale=1.5, speed=1.5, balance=0.3, contrast=-0.6, opacity=0.15
    float n = valueNoise(uv * 1.5);
    n = clamp((n - 0.5) * (1.0 - 0.6) + 0.3, 0.0, 1.0);
    color += n * 0.15;

    fragColor = vec4(clamp(color, 0.0, 1.0), ubuf.qt_Opacity);
}
