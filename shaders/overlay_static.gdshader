shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float time_speed = 1.0;
uniform float noise_strength : hint_range(0, 1) = 0.0;

uniform float noise_scale = 50.0;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// normalized screen UV (0..1)
    vec2 uv = SCREEN_UV;   // or use UV if your ColorRect fills the whole screen

    // procedural noise (scale controls "grain" size)
    float n = rand(uv * noise_scale + vec2(TIME * time_speed, 0.0));
    vec3 noise_col = vec3(n);

    // sample what's already on screen behind the overlay
    vec3 screen_col = texture(SCREEN_TEXTURE, uv).rgb;

    // blend noise with the scene based on noise_strength
    vec3 out_col = mix(screen_col, noise_col, noise_strength);

    COLOR = vec4(out_col, 1.0);

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
