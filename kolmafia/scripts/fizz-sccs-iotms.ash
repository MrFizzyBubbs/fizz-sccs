import <fizz-sccs-lib.ash>

void acquireFamEquip(familiar fam) {
	item it = familiar_equipment(fam);
	if (!have(it)) {
		acquire($item[box of Familiar Jacks]);
		use_familiar(fam);
		use(1, $item[box of Familiar Jacks]);
		check(it);
	}
}

void pantagramming() {
	if (have($item[portable pantogram]) && !have($item[pantogram pants])) {
		visit_url(`inv_use.php?pwd=&whichitem={$item[portable pantogram].to_int()}`);
		// mys, spooky res, +mp, +spell, -combat
		int m = 2;
		int e = 3;
		string s1 = "-2,0";
		string s2 = "-2,0";
		string s3 = "-1,0";
		visit_url(`choice.php?pwd=&whichchoice=1270&option=1&m={m}&e={e}&s1={s1}&s2={s2}&s3={s3}`);
		assert(have($item[pantogram pants]), "Failed to create pantogram pants");
	}	
}

void scavengeDaycare() {
  visit_url("place.php?whichplace=town_wrong&action=townwrong_boxingdaycare");
  if (!get_property("_daycareNap").to_boolean()) run_choice(1);
  if (get_property("_daycareGymScavenges").to_int() < 1) {
    run_choice(3);
    run_choice(2);
  }
}

void smashFreeBarrels() {	
	if (!get_property("barrelShrineUnlocked").to_boolean())
		return;
	
	string page = visit_url("barrel.php");
	matcher m = create_matcher("<div class=\'ex\'>(?:<div class=\'(mimic)\'>!<[/]div>)?<a class=\'spot\' href=\'choice.php[?]whichchoice=1099&pwd=(?:.*?)&option=1&slot=(\\d\\d)\'><img title=\'(.*?)\'", page);
	while(m.find()) {
		string mimic = group(m, 1);
		string slot_id = group(m, 2);
		string state = group(m, 3);
		
		if (mimic == "mimic") {
			continue;
		} else if (state == "A barrel") {
			visit_url("choice.php?whichchoice=1099&pwd&option=1&slot=" + slot_id);
		}
	}
}

void fightWitchessPiece(monster piece, string macro) {
	if (get_campground() contains $item[Witchess Set] && get_property("_witchessFights").to_int() < 5) {
		visit_url("campground.php?action=witchess");
		run_choice(1);
		visit_url(`choice.php?option=1&pwd={my_hash()}&whichchoice=1182&piece={piece.id}`, false);
		run_combat(macro);
	}
}

boolean sausageFightGuaranteed() {
    int goblinsFought = get_property("_sausageFights").to_int();    
    int nextGuaranteed = get_property("_lastSausageMonsterTurn").to_int() + 4 + goblinsFought * 3 + max(0, goblinsFought - 5) ** 3;
    return total_turns_played() >= nextGuaranteed;
}