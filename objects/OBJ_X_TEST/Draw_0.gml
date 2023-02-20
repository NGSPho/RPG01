/// @description shader experimentation ground
enum SHADER {
	
	WAVY,
	ANIMATION,
	FRAGMENT_SQUARE,
	FRAGMENT_CIRCLE,
	MULTI_PHASE,
	MULTI_TEXTURE,
	GAUSSIAN_BLUR,
	HALO
}

var _shaders = [ SHADER.HALO, SHADER.GAUSSIAN_BLUR,
SHADER.MULTI_TEXTURE, SHADER.MULTI_PHASE, SHADER.WAVY, SHADER.ANIMATION, 
SHADER.FRAGMENT_SQUARE, SHADER.FRAGMENT_CIRCLE ]

var _next = keyboard_check_pressed(vk_space)
if _next == true  {
	i = (i+1) mod array_length(_shaders)
	log("New i is ",i);
	start_time = current_time;
	img_animation = 0;
}
var _shader = _shaders[i];
var _shader_index = -1;


if _shader == SHADER.MULTI_TEXTURE {
	var _shader_index = SHADER_MULTI_TEXTURE;
	shader_set(_shader_index);

	var _sampler_overlay = shader_get_sampler_index(_shader_index, "texture_overlay");
	texture_set_stage(_sampler_overlay, sprite_get_texture(SPR_TEXTURE_CLOUDS, 0))
} 
else if _shader == SHADER.WAVY {
	var _shader_index = SHADER_WAVY;
	shader_set(_shader_index);
} 
else if _shader == SHADER.ANIMATION {
	var _shader_index = SHADER_ANIMATED_SHAPE;
	var _sprite_anim = SPR_SHADER_MONSTER_MIRROR_BREAK;
	shader_set(_shader_index);
	
	var _sampler_shape = shader_get_sampler_index(_shader_index, "shape_texture");
	texture_set_stage(_sampler_shape, sprite_get_texture(_sprite_anim, floor(img_animation/20)));
	if (img_animation <= (sprite_get_number(_sprite_anim)+2) * sprite_get_speed(_sprite_anim)) {
		img_animation++;
	}
	// sprite stops moving
	img_sprite--;
} 
else if _shader == SHADER.FRAGMENT_CIRCLE || _shader == SHADER.FRAGMENT_SQUARE {
	if _shader == SHADER.FRAGMENT_CIRCLE _shader_index = SHADER_FRAG_CIRCLE;
	else _shader_index = SHADER_FRAG_SQUARE;
	shader_set(_shader_index);
	
	var _modulo = 10.;
	var _sampler_modulo = shader_get_uniform(_shader_index, "modulo");
	shader_set_uniform_f(_sampler_modulo, _modulo)
} 
else if _shader == SHADER.MULTI_PHASE {
	var _shader_index = SHADER_MULTI_PHASE;	
	shader_set(_shader_index);
	
	var _sampler_duration = shader_get_uniform(_shader_index, "duration");
	shader_set_uniform_f(_sampler_duration, 1300.)
} 
else if _shader == SHADER.GAUSSIAN_BLUR {
	var _shader_index = SHADER_GAUSSIAN_BLUR;
	shader_set(_shader_index);
}
else if _shader == SHADER.HALO {
	var _shader_index = SHADER_HALO;
	shader_set(_shader_index);
}

var _sprite = SPR_MONSTER_SUCCUBUS
var _sprite_width = sprite_get_width(_sprite)
var _sprite_height = sprite_get_height(_sprite)


// ------- common samplers -------------- //
	
var _sampler_time = shader_get_uniform(_shader_index, "time");
shader_set_uniform_f(_sampler_time, current_time)

	
var _sampler_start_time = shader_get_uniform(_shader_index, "start_time");
shader_set_uniform_f(_sampler_start_time, start_time)

 
var _sampler_width = shader_get_uniform(_shader_index, "width");
shader_set_uniform_f(_sampler_width, _sprite_width)
	
var _sampler_height = shader_get_uniform(_shader_index, "height");
shader_set_uniform_f(_sampler_height, _sprite_height)

// ------------------------------------------ //



draw_sprite_ext(_sprite, img_sprite/10, x, y, 1, 1,0, c_white, 1)
shader_reset()

draw_text(0, 0, string(floor((current_time - start_time)/1000.)) + "s")
draw_text(0, 20, shader_get_name(_shader_index))

count++;
img_sprite++;