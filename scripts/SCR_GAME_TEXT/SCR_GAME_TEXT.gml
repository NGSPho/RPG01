/// @param text_id
function scr_game_text(_text_id){
	switch(_text_id) {
		case "npc 1":
			scr_text("Hello my friend.", "denea")
			scr_text("How do you fare so far ?", "denea")
			scr_text("Good and you ?")
			scr_text("...", "denea")
			scr_text("I want to die.", "denea")
			break;
			
		case "npc 2": scr_text("Dub !"); break;
		
		case "npc 3": 
			scr_text("Bubu gak dubu ?", "slime 1"); 
			scr_option("Dub.", "npc 3 - yes");
			scr_option("Dud !", "npc 3 - no");
			break;
		case "npc 3 - yes": scr_text("Gak...", "slime 1"); break;
		case "npc 3 - no": scr_text("Daba dub, dub!", "slime 1"); break;
		break;
		default: break;
	}
	
}