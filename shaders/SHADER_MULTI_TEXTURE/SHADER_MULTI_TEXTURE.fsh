varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D texture_overlay;
uniform float time;
void main()
{
	vec2 coord = v_vTexcoord;
	
	float time = time / 100.;
	vec4 texture_shape = texture2D(gm_BaseTexture, coord);
	vec4 texture_overlay = texture2D(texture_overlay, coord);
	
	// superpose texture according to time
	float time_texture_value = sin(time) / 2. + 0.5;
	vec4 time_texture_color = mix(texture_shape, texture_overlay, time_texture_value);
	
	
	// fusion 
	vec4 final_tex_color = vec4(time_texture_color.rgb, texture_shape.a);
	
	gl_FragColor = final_tex_color;
	gl_FragColor.g -= 0.6;

	
}