shader_type spatial;

uniform vec4 albedo : source_color = vec4(1.0);
uniform vec4 wire_color_start : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Gradient start color
uniform vec4 wire_color_end : source_color = vec4(0.0, 0.0, 1.0, 1.0);   // Gradient end color
uniform float wire_width : hint_range(0.0, 40.0) = 5.0;
uniform float wire_smoothness : hint_range(0.0, 0.1) = 0.01;
uniform vec4 emission_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Emission color for the wire

varying vec3 barys;

void vertex() {
	int index = VERTEX_ID % 3;
	switch (index) {
		case 0:
			barys = vec3(1.0, 0.0, 0.0);
			break;
		case 1:
			barys = vec3(0.0, 1.0, 0.0);
			break;
		case 2:
			barys = vec3(0.0, 0.0, 1.0);
			break;
	}
}

void fragment() {
	vec3 deltas = fwidth(barys);
	vec3 barys_s = smoothstep(deltas * wire_width - wire_smoothness, deltas * wire_width + wire_smoothness, barys);
	float wires = min(barys_s.x, min(barys_s.y, barys_s.z));
	
	// Calculate gradient color for the wire based on the screen position or vertex position
	vec3 gradient_color = mix(wire_color_start.rgb, wire_color_end.rgb, FRAGCOORD.y / VIEWPORT_SIZE.y);
	
	// Apply gradient to wire color
	ALBEDO = mix(gradient_color, albedo.rgb, wires);

	// Add emissive effect for the wires with the same gradient
	EMISSION = mix(emission_color.rgb, vec3(0.0), wires);
}
