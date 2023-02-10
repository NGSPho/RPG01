/// Map a room index to it's bgm from a csv
function populate_bgm_map() {
	var _room_to_bgm = [0];
	var _file_name = "bgm.csv"

	log("Populating bgm map from ", _file_name);
	var _csv = load_csv(_file_name);
	var _csv_w = ds_grid_width(_csv);
	var _csv_h = ds_grid_height(_csv);	
	var _max_room = 1000;

	for (var r=0; r<_max_room; r++) { 
		if !room_exists(r) 
			break;
		var _r_name = room_get_name(r);
		for(var i=0; i<_csv_h; i++) {
			var _csv_room_name = _csv[# 0, i]
			var _csv_bgm_name = _csv[# 1, i]
			
			 //ignore empty lines
			if  _csv_room_name == "" &&  _csv_bgm_name == "" continue
			if _r_name ==_csv_room_name {
				var _bgm = asset_get_index(_csv_bgm_name)
				
				if _bgm == -1 
					throw("No asset " + _csv_bgm_name + " found.")
				else if !audio_exists(_bgm) 
					throw("No audio " + _csv_bgm_name + " found.")
				
				_room_to_bgm[r] = _bgm
				//log("Room " + room_get_name(r) + " is " + audio_get_name(_bgm))
			}

		}
	}
	
	ds_grid_destroy(_csv)
	return _room_to_bgm
	
}
// map room to bgm

room_to_bgm = populate_bgm_map()
log("Room to bgm ", string(room_to_bgm))
current_bgm = noone;


