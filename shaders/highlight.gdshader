shader_type spatial;

uniform sampler2D tex : source_color;

uniform float highlight_strength : hint_range(0, 1) = 0.02;
uniform float time_speed = 2.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 base_color = texture(tex, UV).rgb * 0.02;
	vec3 highlight_color = vec3(0.25, 1.0, 0.25);

    ALBEDO = mix(base_color, highlight_color, 1.0);
	EMISSION = mix(base_color, highlight_color, highlight_strength);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
