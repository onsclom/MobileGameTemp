shader_type canvas_item;

uniform sampler2D pattern;
uniform vec4 color1 : hint_color = vec4(1.0);
uniform vec4 color2 : hint_color = vec4(1.0);
uniform vec4 color3 : hint_color = vec4(1.0);
uniform vec2 dir;
uniform float zoom = 20.0f;
uniform float time_speed = 0.1f;
uniform float percentage = .5;
uniform float thickness = .01;
uniform bool scroller = false;

uniform bool shakeable = false;

void fragment(){
	//SCREEN_UV
	vec3 cur_val;
	if (scroller && abs(SCREEN_UV.y-thickness-percentage) < thickness) {
		COLOR.rgb = color3.rgb;
	}
	else if (!scroller || SCREEN_UV.y>percentage)
	{
		cur_val = step(.5, texture(pattern, fract(vec2(TIME*time_speed)*dir+SCREEN_UV*zoom/(SCREEN_PIXEL_SIZE)*SCREEN_PIXEL_SIZE.x)).rgb);
		COLOR.rgb = (vec4(cur_val,cur_val.r)*color1 + (vec4(1.0)-vec4(cur_val,0.0))*color2).rgb;
	}
	else
	{
		cur_val = 1.0-step(.5, texture(pattern, fract(vec2(TIME*time_speed)*dir+SCREEN_UV*zoom/(SCREEN_PIXEL_SIZE)*SCREEN_PIXEL_SIZE.x)).rgb);
		COLOR.rgb = (vec4(cur_val,cur_val.r)*color1 + (vec4(1.0)-vec4(cur_val,0.0))*color2).rgb/vec3(2.0);
	}
	
}