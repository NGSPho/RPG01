width = 1;
height = 0;
// distance from text box side to text
op_border = 8;
// distance between each option
op_space = 80

// pause menu
options[0,0] = "Start Game"
options[0,1] = "Settings"
options[0,2] = "Quit Game"

// settings menu
options[1,0] = "Windows Size"
options[1,1] = "Brightness"
options[1,2] = "Controls"
options[1,3] = "Back"

pos = 0;


menu_level = 0;

instance_create_depth(0, 0, 0, OBJ_X_PAUSER)

agents_hide()