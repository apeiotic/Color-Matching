shader_type spatial;
render_mode unshaded, cull_disabled;

uniform float detail_strength = 3.0;
uniform float scroll_speed = 1.2;
uniform float fire_height = 1.0;
uniform float fire_shape = 1.5;
uniform float fire_thickness = 0.55;
uniform float fire_sharpness = 1.0;
uniform float intensity = 1.0;
uniform vec4 fire_color : source_color = vec4(1.0, 0.4, 0.1, 1.0); // Updated to vec4 with color picker

uniform int noise_octaves = 6;
uniform float noise_lacunarity = 3.0;
uniform float noise_gain = 0.5;
uniform float noise_amplitude = 1.0;
uniform float noise_frequency = 1.5;

// Hash and Noise functions
float hash(vec2 p) {
    p = fract(p * 0.3183099 + vec2(0.1, 0.1));
    p *= 17.0;
    return fract(p.x * p.y * (p.x + p.y));
}

float noise(vec2 x) {
    vec2 p = floor(x);
    vec2 f = fract(x);

    float n =
        hash(p)       * (1.0 - f.x) * (1.0 - f.y) +
        hash(p + vec2(1.0, 0.0)) * f.x * (1.0 - f.y) +
        hash(p + vec2(0.0, 1.0)) * (1.0 - f.x) * f.y +
        hash(p + vec2(1.0, 1.0)) * f.x * f.y;

    return n;
}

// Fractional Brownian Motion (fbm) function
float fbm(vec2 p) {
    float total = 0.0;
    float amplitude = noise_amplitude;
    float frequency = noise_frequency;

    for (int i = 0; i < noise_octaves; i++) {
        total += noise(p * frequency) * amplitude;
        frequency *= noise_lacunarity;
        amplitude *= noise_gain;
    }

    return total * 0.5;
}

void fragment() {
    vec2 uv = UV;

    vec2 modified_uv = -uv;
    modified_uv.x = mod(modified_uv.x, 1.0) - 0.5;
    modified_uv.y += 0.84;

    float scroll = scroll_speed * detail_strength * TIME;
    float noise_val = fbm(detail_strength * modified_uv - vec2(0.0, scroll));

    float fire_intensity = intensity - 16.0 * fire_sharpness * pow(
        max(0.0, length(modified_uv * vec2((1.0 / fire_thickness) + modified_uv.y * fire_shape, 1.0 / fire_height)) - noise_val),
        1.2
    );

    fire_intensity = clamp(fire_intensity, 0.0, 1.0);
    fire_intensity *= 1.5 - pow(uv.y, 6.0);

    vec3 final_fire_color = fire_color.rgb * fire_intensity;

    ALBEDO = final_fire_color;
    ALPHA = fire_color.a * fire_intensity;  // Use the alpha from the color picker
}
