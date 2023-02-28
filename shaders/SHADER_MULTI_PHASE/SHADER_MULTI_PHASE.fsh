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

void main() {
	
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	float duration = duration / 1000.;
	
	float time = time / 1000.;
	float start_time = start_time/1000.;
	float execution_time = time - start_time; // in seconds
	
	// percentages
	float time_first_step = 10.;
	float time_to_w = 20.;
	float time_to_b = 40.;
	float time_to_disappear = 20.;
	
	// from % to seconds
	time_first_step = time_first_step * duration / 100.;
	time_to_w = time_to_w * duration / 100.;
	time_to_b = time_to_b * duration / 100.;
	time_to_disappear = time_to_disappear * duration / 100.;
	
	
	if (execution_time >= duration) {
		gl_FragColor.a = 0.;
	} else if (execution_time >= time_first_step + time_to_w + time_to_b) {
		// ------------- fading away --------------------------//
		gl_FragColor.rgb = vec3(0, 0, 0);
		float time_elapsed = execution_time - time_first_step - time_to_w - time_to_b;
		float constant = 1./time_to_disappear;
		float alpha = 1. - time_elapsed * constant;
		gl_FragColor.a = min(alpha, gl_FragColor.a);
	} else if (execution_time >= time_first_step + time_to_w) {
		// ------------- fading to black --------------------------//
		gl_FragColor.rgb = vec3(1., 1., 1.);
		float time_elapsed = execution_time - time_first_step - time_to_w;
		float constant = 1./time_to_b;
		gl_FragColor.r = gl_FragColor.r - constant * time_elapsed;
		gl_FragColor.g = gl_FragColor.g - constant * time_elapsed;
		gl_FragColor.b = gl_FragColor.b - constant * time_elapsed;
	} else if (execution_time >= time_first_step) {
		// ------------- fading to white --------------------------//
		float time_elapsed = execution_time - time_first_step;
		float constant = 1./time_to_w;
		gl_FragColor.r = gl_FragColor.r + constant * time_elapsed;
		gl_FragColor.g = gl_FragColor.g + constant * time_elapsed;
		gl_FragColor.b = gl_FragColor.b + constant * time_elapsed;
	} else if (execution_time <= time_first_step) {
		// do nothing
	}

}
