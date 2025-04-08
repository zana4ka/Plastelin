shader_type canvas_item;

uniform sampler2D Mask : filter_nearest, hint_default_transparent;
uniform vec3 MaskColor: source_color = vec3(0.4, 1.0, 0.4);

void fragment() {
	vec4 DefaultColor = texture(TEXTURE, UV);
	COLOR.rgb = max(COLOR.rgb, vec3(0.1, 0.1, 0.1));
}

void light() {
	
	vec3 DefaultColor = COLOR.rgb * LIGHT_COLOR.rgb;
	
	vec3 MaskLight = COLOR.rgb * texture(Mask, UV).a * MaskColor;
	MaskLight = MaskLight * pow(LIGHT_COLOR.a, 10.0) * 5.0;
	LIGHT = vec4(DefaultColor + MaskLight, LIGHT_COLOR.a) * LIGHT_ENERGY;
}
