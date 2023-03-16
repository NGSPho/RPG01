/// @description Characteristics menu

if menu_opened() == true {
	log("Can't open menu here");
	exit;
}
instance_create_depth(0, 0, -10000, OBJ_X_MENU_TABS)