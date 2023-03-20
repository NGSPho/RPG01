
draw_sprite_ext(sprite_index, image_index, target.x, target.y, 1, 1, 0, c_white, 1)

// has started is used to avoid loopin sounds or animation
if !has_started {
	target.is_attacked = true;
	if target.HP <= 0 {
		audio_play_sound(target.audio_death, 1, 0);
	}
}
has_started = true
