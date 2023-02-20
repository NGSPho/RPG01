//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float modulo;

uniform float height;
uniform float width;
// current time
uniform float time;
// the time at which anim started
uniform float start_time;

void main() {
	float _x = v_vTexcoord.x * width;
	float _y = v_vTexcoord.y * height;
	
	vec4 base_tex_color = texture2D(gm_BaseTexture, v_vTexcoord);
	// TODO compute thickness incrementation based on height, width and delta time 
	// thickness in pixels
    float thickness = (time - start_time)/200.;


    float mod_x = mod( _x, modulo);
    float mod_y = mod( _y, modulo);
    float d_x = min(mod_x, modulo-mod_x);
    float d_y = min(mod_y, modulo-mod_y);
    // diamonds
    //if (d_x + d_y < thickness) base_tex_color.a = 0.;
    // circles
    if (pow(d_x, 2.) + pow(d_y, 2.) < pow(thickness, 2.)) base_tex_color.a = 0.;
    gl_FragColor = base_tex_color;
}
