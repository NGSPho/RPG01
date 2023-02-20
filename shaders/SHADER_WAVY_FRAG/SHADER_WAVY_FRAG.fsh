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
// the duration of the animation
uniform float delta_time;

void main() {

       // oscillate shape

       vec2 coord = v_vTexcoord;
       float number_of_pixels_moved = 200.;
       float offset_y = v_vTexcoord.y * height;
       // analog pattern
       float delta_x =  sin((floor(offset_y/modulo ) + floor((time-start_time)/(10.*modulo))) * 90.) * 10000.;
       // translation

       float translation_time_start = 0.3 * 1000.; // in milli seconds
       float translation_delta_y = time - start_time - translation_time_start;
       float translation_delta_x = time - start_time - translation_time_start;
       float translation_delta_x_multiplicator = 0.0001;
       float translation_delta_y_multiplicator = 0.0003;
       float translation_div = 1. * 10.;

       if (time - start_time > translation_time_start) {
               coord.x = coord.x - (translation_delta_x * translation_delta_x_multiplicator)/translation_div;
               coord.y = coord.y + (translation_delta_y * translation_delta_y_multiplicator)/translation_div;
       }

       vec4 base_tex_color = texture2D(gm_BaseTexture, coord);

       // fragmentation

       float _x = v_vTexcoord.x * width;
       float _y = v_vTexcoord.y * height;


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
