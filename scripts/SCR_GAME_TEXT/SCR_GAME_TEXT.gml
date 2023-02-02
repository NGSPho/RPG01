/// @param text_id
function scr_game_text(_text_id){
	switch(_text_id) {
		case "npc 1":
			scr_text("Hello my friend.")
			scr_text("How do you fare so far ?")
			scr_text("...")
			scr_text("I want to die.")
			break;
		case "npc 2": scr_text("Dub !"); break;
		case "npc 3": 
			scr_text("Bubu gak dubu ?"); 
			scr_option("Dub.", "npc 3 - yes");
			scr_option("Dud !", "npc 3 - no");
			break;
		case "npc 3 - yes": scr_text("Gak..."); break;
		case "npc 3 - no": scr_text("Daba dub, dub!"); break;
		break;
		default: break;
	}
	
}