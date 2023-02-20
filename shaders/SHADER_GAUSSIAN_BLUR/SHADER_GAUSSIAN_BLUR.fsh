//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float height;
uniform float width;

void main() {  
	// Should be an odd number
	int sigma = 3; 
	int radius = int((sigma-1)/2);

    float _x = v_vTexcoord.x * width;
    float _y = v_vTexcoord.y * height;

	// Vector used to sum all the values within a pixel
	vec4 sum_vector = vec4(0, 0, 0, 0);
	// Count the number of pixels around the current pixel and within the radius
	float pixel_nb = 0.; 
	
	for (int i=-radius; i<=radius; ++i) {
		for (int j=-radius; j<=radius; ++j) {
			
			if (i + j <= radius) {
				vec2 coord = vec2((_x + float(i))/width, (_y +float(j))/height);
				vec4 pixel = texture2D(gm_BaseTexture, coord);
				if (pixel.a == 0.) continue;
				sum_vector += pixel;
				pixel_nb++;
			}
		}
	}
    
	// Compute the average values
	gl_FragColor = sum_vector / pixel_nb;
	
}
