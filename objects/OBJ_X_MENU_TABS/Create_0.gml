
enum MENU_TABS {
	CHARACTERISTICS,
	ITEMS,
	SKILLS
}

tabs = [ MENU_TABS.CHARACTERISTICS, MENU_TABS.ITEMS, MENU_TABS.SKILLS ];
tab_pos = 0;
box_sprite = SPR_X_MENU;
box_sprite_off = SPR_X_MENU_OFF;

audio_play_sound(SOUND_EFFECT_MENU_OPEN, 1, -1);

function open_characteristics_menu() {
}

function open_generic_menu(_obj_tab_menu) {
	// ----------- close all others tab ------------------------ //
	close_tabs();
	instance_create_depth(0, 0, -10000, _obj_tab_menu)
	if !instance_exists(OBJ_X_MENU_TEAM_OVERVIEW)
		instance_create_depth(0, 0, -10001, OBJ_X_MENU_TEAM_OVERVIEW)
}

function close_tabs() {
	instance_destroy(OBJ_X_MENU_TAB_ABSTRACT);
}

function menu_tabs_label(_tab) {
	switch(_tab) {
		case MENU_TABS.CHARACTERISTICS : return "Characteristics";
		case MENU_TABS.SKILLS : return "Skills";
		case MENU_TABS.ITEMS : return "Items";
		default : TODO();
	}
}

function open_menu() {
	switch(tabs[tab_pos]) {
		case MENU_TABS.CHARACTERISTICS : open_generic_menu(OBJ_X_MENU_TAB_CHARACTERISTICS); break;
		case MENU_TABS.SKILLS : open_generic_menu(OBJ_X_MENU_TAB_SKILLS); break;
		case MENU_TABS.ITEMS : open_generic_menu(OBJ_X_MENU_TAB_ITEMS); break;
		default : TODO(); break;
	}
}


open_menu();