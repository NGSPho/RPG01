//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float width;
void main()
{
	vec2 coord = v_vTexcoord;
	
	float time = time / 100.;
	
	// oscillate shape	
	
	float number_of_pixels_moved = 1.3;
	float osc_per_row = 50.;
	float delta_x =  sin(v_vTexcoord.y * osc_per_row + time);

	coord.x = coord.x + delta_x * number_of_pixels_moved/width;
	
	vec4 base_tex_color = texture2D(gm_BaseTexture, coord);
	
	gl_FragColor = base_tex_color;

	
}