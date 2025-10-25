shader_type spatial;

uniform float highlight_strength : hint_range(0, 1) = 0.0;
uniform float time_speed = 2.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 base_color = vec3(1.0); // white base
    // Simple flicker/noise effect
    //float flicker = sin(TIME * time_speed * (0.5 + rand(UV))) * 0.1;
    base_color += highlight_strength;

    ALBEDO = base_color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
