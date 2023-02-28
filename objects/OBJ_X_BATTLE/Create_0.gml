enemy_obj = array_create(0)
enemy = array_create(0)

turn = 0
// [ attacker, action, target ]
actions[0, 0] = 0;

battle_over = false;

battle_id = noone;
triggered_event = noone;


setup_agents = false;

ko_time = 0;

if instance_exists(OBJ_NPC_ABSTRACT) 
	OBJ_NPC_ABSTRACT.visible = false;
	
if instance_exists(OBJ_PLAYER) 
	OBJ_PLAYER.visible = false;