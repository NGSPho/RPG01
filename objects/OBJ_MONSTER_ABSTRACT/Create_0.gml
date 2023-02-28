
width = sprite_get_width(sprite_index)

// --------- stats ---------- //
MAX_HP = 3;
ATK = 1;
DEF = 0;
XP = 0;
HP = 0;

// ----- animation utils --------- //
// a monster is KO when HP are down to 0 AND the animation was completed //
KO = false;
// the time at which to start the ko anim
ko_time = 0;
// is a monster being attacked
is_attacked = false;
// the time at which to start the atk anim
attacked_time = 0;


width = 0;
audio_death = 0;

label = 0;

depth = 0;

