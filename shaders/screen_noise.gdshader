shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform float noise_strength : hint_range(0.0, 1.0) = 0.0;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
uniform ivec2 albedo_texture_size;
uniform float point_size : hint_range(0.1, 128.0, 0.1);

uniform float roughness : hint_range(0.0, 1.0);
uniform sampler2D texture_metallic : hint_default_white, filter_linear_mipmap, repeat_enable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_roughness_r, filter_linear_mipmap, repeat_enable;

uniform float specular : hint_range(0.0, 1.0, 0.01);
uniform float metallic : hint_range(0.0, 1.0, 0.01);

uniform sampler2D texture_emission : source_color, hint_default_black, filter_linear_mipmap, repeat_enable;
uniform vec4 emission : source_color;
uniform float emission_energy : hint_range(0.0, 100.0, 0.01);

uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

float rand(vec2 coord) {
	return fract(sin(dot(coord.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
	UV = UV * uv1_scale.xy + uv1_offset.xy;
}

void fragment() {
	vec2 uv = UV;
	
	float noise_val = rand(uv + vec2(TIME * 10.0, 0.0));
	vec3 noise_tex = vec3(noise_val);

	vec4 albedo_tex = texture(texture_albedo, uv);
	ALBEDO = mix((albedo.rgb * albedo_tex.rgb), noise_tex.rgb, noise_strength);

	float metallic_tex = dot(texture(texture_metallic, uv), metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	SPECULAR = specular;

	vec4 roughness_texture_channel = vec4(1.0, 0.0, 0.0, 0.0);
	float roughness_tex = dot(texture(texture_roughness, uv), roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;

	// Emission: Enabled
	vec3 emission_tex = texture(texture_emission, uv).rgb;
	// Emission Operator: Add
	EMISSION = mix((emission.rgb + emission_tex), noise_tex.rgb, noise_strength) * emission_energy;
}
