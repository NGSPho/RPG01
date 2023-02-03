// textbox param
textbox_width = 581;
textbox_height = 149;
textbox_x = 0;
textbox_y = 0;
border = 8;
line_sep = 12;
line_width = textbox_width - border * 2; // use for line break
txtb_spr[0] = SPR_TEXT_BOX // todo it's not needed to inti here
txtb_img = 0;
txtb_img_spd = 6/60;

// the text
page = 0;
page_number = 0;
text[0] = "";
text_length[0] = string_length(text[0]);


line_break_pos[0] = 0;
line_break_num[0] = 0;
line_break_offset[0] = 0;

char[0, 0] = "";
char_x[0, 0] = 0;
char_y[0, 0] = 0;

draw_char = 0;
text_spd = 1;
//options

option[0]="";
option_link_id[0]= -1;
option_pos = 0;
option_number = 0;

setup = false;

// effects
scr_set_default_for_text();
last_free_space = 0;
text_pause_timer = 0;
text_pause_time = 16;

