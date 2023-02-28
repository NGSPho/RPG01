//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// total duration of the animation in ms
uniform float duration;
// current time
uniform float time;
// start time
uniform float start_time;
void main()
{
	float time = time / 1000.;
	float start_time = start_time / 1000.;
	float execution_time = time - start_time; // in s
	
	float initial_vertical_velocity = 0.1; // px/s
	float initial_height = 0.2; // px
	float g_acceleration = 3.; // px/s^2
	
	float _x = execution_time / 0.5;
	float vertical_movement = initial_vertical_velocity * _x;
	float hyperbole_movement =  1./2. * g_acceleration * pow(_x, 2.);
	float _y = initial_height + vertical_movement - hyperbole_movement;
	
	vec2 coord = vec2(v_vTexcoord.x - _x, v_vTexcoord.y + _y);
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, coord );
}
