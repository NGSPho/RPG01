draw_sprite_ext(sprite_index, image_index, target.x, target.y, 1, 1, 0, c_white, 1)


if !has_started &&  target.HP <= 0 {
	audio_play_sound(target.audio_death, 1, 0);
}
has_started = true