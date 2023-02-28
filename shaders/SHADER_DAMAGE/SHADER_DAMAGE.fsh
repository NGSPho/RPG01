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
	float time_to_disappear_1 = 25.;
	float time_to_reappear_1 = 25.;
	float time_to_disappear_2 = 25.;
	float time_to_reappear_2 = 25.;
	
	// from % to seconds
	time_to_disappear_1 = time_to_disappear_1 * duration / 100.;
	time_to_reappear_1 = time_to_reappear_1 * duration / 100.;
	time_to_disappear_2 = time_to_disappear_2 * duration / 100.;
	time_to_reappear_2 = time_to_reappear_1 * duration / 100.;
	
	
	if (execution_time >= duration) {
		
	} else if (execution_time >= time_to_disappear_1 + time_to_reappear_1 + time_to_disappear_2) {
		// ------------- appear --------------------------//
		float time_elapsed = execution_time - time_to_disappear_1 - time_to_reappear_1 - time_to_disappear_2;
		float constant = 1./time_to_reappear_2;
		float alpha = time_elapsed * constant;
		gl_FragColor.a = min(alpha, gl_FragColor.a);
	} else if (execution_time >= time_to_disappear_1 + time_to_reappear_1) {
		// ------------- fading away time_to_disappear_1
		float time_elapsed = execution_time - time_to_disappear_1 - time_to_reappear_1;
		float constant = 1./time_to_disappear_2;
		float alpha = 1. - time_elapsed * constant;
		gl_FragColor.a = min(alpha, gl_FragColor.a);
	} else if (execution_time >= time_to_disappear_1) {
		// ------------- appear --------------------------//
		float time_elapsed = execution_time - time_to_disappear_1;
		float constant = 1./time_to_reappear_1;
		float alpha = time_elapsed * constant;
		gl_FragColor.a = min(alpha, gl_FragColor.a);
	} else if (execution_time <= time_to_disappear_1) {
		// ------------- fading away --------------------------//
		float time_elapsed = execution_time;
		float constant = 1./time_to_disappear_1;
		float alpha = 1. - time_elapsed * constant;
		gl_FragColor.a = min(alpha, gl_FragColor.a);
	}

}
