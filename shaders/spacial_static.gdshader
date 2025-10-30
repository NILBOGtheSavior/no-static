shader_type spatial;

uniform float scale = 500.0;
uniform float brightness = 0.2;

float rand(vec2 coord) {
	return fract(sin(dot(coord.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = SCREEN_UV.xy;
	uv.x *= VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;

	float noise_val = rand(floor(uv * scale) + vec2(TIME * 10.0, 0.0));
	vec3 noise_tex = vec3(noise_val);

	ALBEDO = noise_tex;
	EMISSION = noise_tex * brightness;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
