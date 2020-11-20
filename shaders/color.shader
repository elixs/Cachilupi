shader_type canvas_item;

uniform vec4 color : hint_color;

void fragment() {
	vec4 tcol = texture(TEXTURE, UV);

	COLOR = vec4(color.rgb, tcol.a);
}