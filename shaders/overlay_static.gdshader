shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float noise_speed = 2.5;
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
    vec2 uv = SCREEN_UV;
	vec2 noise_uv = SCREEN_UV;
	noise_uv.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;

    float n = rand(floor(noise_uv * noise_scale) + vec2(TIME * noise_speed, 0.0));
    vec3 noise_col = vec3(n);

    vec3 screen_col = texture(SCREEN_TEXTURE, uv).rgb;

    vec3 out_col = mix(screen_col, noise_col, noise_strength);

    COLOR = vec4(out_col, 1.0);

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
