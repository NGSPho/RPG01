#macro APPLE_ID "apple"
#macro LEMON_ID "lemon"
global.inventory_folder = "inventory/";

function load_item() {
	var _item = noone;
	var _csv = load_csv(global.inventory_folder+"items.csv")
	var _height = ds_grid_height(_csv);
	var _item_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		// ----- ignore if id does not match the argument --------- //
		var _item_id = _csv[# 0, i]			
		var _item_label = _csv[# 1, i];
		var _item_description = _csv[# 2, i];
		var _item_sprite = asset_get_index(_csv[# 3, i]);
		var _item_effects = _csv[# 4, i];
		var _parse_result = parse_constraint_str( _csv[# 4, i]);
		_item_effects = {
			attribute : _parse_result.constraint_attribute,
			operator : _parse_result.constraint_operator,
			value : _parse_result.constraint_value
		}
		
		var _item_type = parse_item_type(_csv[# 5, i]);
		var _item_use = parse_item_use(_csv[# 6, i]);
		
		var _item_data = {
			item_id : _item_id,
			label : _item_label,
			description : _item_description,
			sprite : _item_sprite,
			effect : _item_effects,
			type : _item_type,
			use : _item_use
		}
		
		
		log("Add item data " + string(_item_data))
		item_map_build(_item_map, _item_id, _item_data)
		

	}
	ds_grid_destroy(_csv);
	return _item_map;
}


enum ITEM_TYPE {
	HEAL,
	MISC,
	ATK
}

enum ITEM_USE {
	MAP,
	BATTLE,
	BOTH
}

function parse_item_type(_str) {
	switch(_str) {
		case "HEAL": return ITEM_TYPE.HEAL;
		case "ATTACK": return ITEM_TYPE.ATK;
		case "MISC": return ITEM_TYPE.MISC;
		default: TODO();
	}
}

function parse_item_use(_str) {
	switch(_str) {
		case "MAP": return ITEM_USE.MAP;
		case "BATTLE": return ITEM_USE.BATTLE;
		case "BOTH": return ITEM_USE.BOTH;
		default: TODO();
	}
}

function consume_item_stack(_stack, _target) {
	var _item = _stack.item;
	log("Item data is ", string(_item));
	switch(_item.type) {
		case ITEM_TYPE.HEAL : audio_play_sound(SOUND_EFFECT_MENU_ITEM_HEAL, 1, -1); break;
		case ITEM_TYPE.ATK : audio_play_sound(SOUND_EFFECT_MENU_ITEM_HEAL, 1, -1); break;
		case ITEM_TYPE.MISC : audio_play_sound(SOUND_EFFECT_MENU_ITEM_HEAL, 1, -1); break;
		default : debug("TODO item type of item ", _item.label," not supported");
	}
	
	item_effects_apply(_item, _target);
	_stack.quantity--;
}



