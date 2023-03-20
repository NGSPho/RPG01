
// ------------ battle stats ------------ //
MAX_HP = 5;
MAX_MP = 10;
ATK = 1;
DEF = 0;

HP = 0;
MP = MAX_MP;
label = 0;

XP = 0;
LVL = 1;

inventory = [];
for (i=0; i<INVENTORY_SIZE; i++) {
	for (j=0; j<INVENTORY_SIZE; j++) {
		inventory[i, j] = noone;
	}
}
inventory[0][0] = {item: global.map_item[? "apple"], quantity: 2};
inventory[1][0] = {item: global.map_item[? "lemon"], quantity: 1};
inventory[2][0] = {item: global.map_item[? "bomb"], quantity: 1};

inventory[1][2] = {item: global.map_item[? "feather"], quantity: 1};

battle_inventory = []; // TODO sorted at insertion inventory, should be sync with inventory
battle_inventory[0] = inventory[0][0];
battle_inventory[1] = inventory[1][0];
battle_inventory[2] = inventory[2][0];
battle_inventory[3] = inventory[1][2];

log("Inventor is ", string(inventory));
