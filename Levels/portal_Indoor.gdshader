shader_type spatial;

uniform vec2 mouse_position = vec2(0.5, 0.5);
uniform vec4 wave_color : source_color = vec4(1.0, 2.0, 4.0, 1.0);
uniform float wave_transparency : hint_range(0.0, 1.0) = 1.0;

mat2 rotate2D(float r) {
    // 2D Rotation Matrix
    return mat2(vec2(cos(r), sin(r)), vec2(-sin(r), cos(r)));
}

void fragment() {
    // Adjust the UV coordinates for 3D
    vec2 uv = (SCREEN_UV * 2.0 - 1.0) * 0.5;
    vec3 col = vec3(0.0);
    float t = TIME;
    
    vec2 n = vec2(0.0), q;
    vec2 N = vec2(0.0);
    vec2 p = uv + sin(t * 0.1 / 10.0);
    float S = 10.0;
    mat2 m = rotate2D(1.0 - (mouse_position.x * 0.001));
    
    for (float j = 0.0; j < 30.0; j++) {
        p *= m;
        n *= m;
        q = p * S + j + n + t;
        n += sin(q);
        N += cos(q) / S;
        S *= 1.2;
    }

    float lengthN = max(length(N), 0.001);
    col = wave_color.rgb * pow((N.x + N.y + 0.4) + 0.005 / lengthN, 2.1);
    ALBEDO = col;
    ALPHA = wave_transparency;
}
