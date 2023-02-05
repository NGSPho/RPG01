/// @param text_id
/// @param
function scr_game_text(_text_id){
	switch(_text_id) {
		case "npc 1":
			scr_text("Hello my friend.", "denea", -1)
			scr_text("How do you fare so far ?", "denea", -1)
			scr_text("Good and you ?", "slime0 joy", 1)
			scr_text("...", "denea", -1)
			scr_text("I want to die.", "denea", -1)
			break;
			
		case "npc 2":
			scr_text("Hey darling.  Pret a vivre la Macarena du siecle ? Je plaisante. Hi, Hi!", "dancer", -1); 
			scr_text("...");
			scr_text("Oh la la, je rigole !", "dancer", -1); 
			break;
		
		case "npc 3": 
			scr_text("Bubu gak dubu ?", "slime1", -1); 
				scr_option("Dub.", "npc 3 - yes");
				scr_option("Dud !", "npc 3 - no");
			break;
		case "npc 3 - yes": scr_text("Gak...", "slime1 cry", -1); break;
		case "npc 3 - no": scr_text("Daba dub, dub!", "slime1 shy", -1); break;
		break;
		default: break;
	}
	
}