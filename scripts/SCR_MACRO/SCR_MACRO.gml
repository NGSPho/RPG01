#macro RIGHT 0
#macro UP 1
#macro LEFT 2
#macro DOWN 3

#macro INVENTORY_SIZE 3

enum EVENT_TYPE {
	BATTLE,
	OPTION,
	TEXT,
	JOIN,
	SCENE
}

function EVENT_TYPE_get(name) {
	switch(name) {
		case "TEXT": return EVENT_TYPE.TEXT;
		case "OPTION": return EVENT_TYPE.OPTION;
		case "BATTLE": return EVENT_TYPE.BATTLE;
		case "JOIN": return EVENT_TYPE.JOIN;
		case "SCENE": return EVENT_TYPE.SCENE;
		default: log("Name ", name); TODO()
	}
}

