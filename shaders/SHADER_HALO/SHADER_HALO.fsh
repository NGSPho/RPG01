//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float height;
uniform float width;

void main() {  
	gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
	
	// Max distance in px the halo can glow to


	if (gl_FragColor.a == 0.) {
		int max_dist = 4; 
		
	    float _x = v_vTexcoord.x * width;
	    float _y = v_vTexcoord.y * height;

		float light = 0.;
		
		for (int i=-max_dist; i<=max_dist; ++i) {
			for (int j=-max_dist; j<=max_dist; ++j) {
				float dist = abs(float(i))+abs(float(j));
				if (dist <= float(max_dist)) {
					vec2 coord = vec2((_x + float(i))/width, (_y +float(j))/height);
					vec4 pixel = texture2D(gm_BaseTexture, coord);
				
					if (pixel.a == 1.) {
						light = max(light, 1. - (float(dist)/float(max_dist)));
					}
				}
			}
		}
		gl_FragColor.a = light;
		gl_FragColor.rgb = vec3(1., 1., 1.);
	} else {
		gl_FragColor += 0.2;
	}
	gl_FragColor.b -= 0.6;
	
}
