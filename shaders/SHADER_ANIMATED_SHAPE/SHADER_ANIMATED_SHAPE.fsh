//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D shape_texture;
void main()
{	
	vec4 base_tex_color = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 shape_tex_color = texture2D(shape_texture, v_vTexcoord);
	
	vec4 uni_tex_color = vec4(1.0, 0.0, 0.0, 1.0);
	
	vec4 final_tex_color = vec4(base_tex_color.rgb, min(base_tex_color.a, shape_tex_color.a));
	
    gl_FragColor = final_tex_color;
}
