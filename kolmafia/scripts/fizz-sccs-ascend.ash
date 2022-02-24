import <fizz-sccs-lib.ash>

void prepareAscension(item workshed, item garden, item eudora, item chateauDesk, item chateauCeiling, item chateauNightstand) {
	if (get_workshed() != workshed) {
		assert(have(workshed), `I'm sorry buddy, but you don't seem to own a {workshed}. Which makes it REALLY hard for us to plop one into your workshed.`);
		assert(use(1, workshed) && get_workshed() == workshed, `We really thought we changed your workshed to a {workshed}, but Mafia is saying otherwise.`);
	}
	
	if (!(get_campground() contains garden)) {
		assert(have(garden), `I'm sorry buddy, but you don't seem to own a {garden}. Which makes it REALLY hard for us to plant one into your garden.`);
		assert(use(1, garden) && get_campground() contains garden, `We really thought we changed your garden to a {garden}, but Mafia is saying otherwise.`);
	}
	
	if (eudora_item() != eudora) {
		assert(have(eudora), `I'm sorry buddy, but you don't seem to be subscribed to {eudora}. Which makes it REALLY hard to correspond with them.`);
		assert(eudora(eudora.name) && eudora_item() == eudora, `We really thought we changed your eudora to a {eudora}, but Mafia is saying otherwise.`);
	}
	
	boolean [item] desks = $items[fancy stationery set, Swiss piggy bank, continental juice bar];
	if (!(get_chateau() contains chateauDesk)) {
		assert(desks contains chateauDesk, `Invalid chateau desk: {chateauDesk}`);
		buy(1, chateauDesk);
		assert(get_chateau() contains chateauDesk, `We tried, but were unable to change your chateau desk to {chateauDesk}. Probably.`);
	}
	
	boolean [item] ceilings = $items[antler chandelier, ceiling fan, artificial skylight];
	if (!(get_chateau() contains chateauCeiling)) {
		assert(ceilings contains chateauCeiling, `Invalid chateau ceiling: {chateauCeiling}`);
		buy(1, chateauCeiling);
		assert(get_chateau() contains chateauCeiling, `We tried, but were unable to change your chateau ceiling to {chateauCeiling}. Probably.`);
	}
	
	boolean [item] nightstands = $items[foreign language tapes, bowl of potpourri, electric muscle stimulator];
	if (!(get_chateau() contains chateauNightstand)) {
		assert(nightstands contains chateauNightstand, `Invalid chateau nighstand: {chateauNightstand}`);
		buy(1, chateauNightstand);
		assert(get_chateau() contains chateauNightstand, `We tried, but were unable to change your chateau nightstand to {chateauNightstand}. Probably.`);
	}
}

void checkReadyToAscend() {
	boolean [string] badDays = $strings["april fool\'s day"];
	string [int] today = holiday().split_string("/");
	foreach _, holiday in today {
		assert(!(badDays contains holiday), `Don't want to ascend during {holiday}`);
	}
	
	assert(my_spleen_use() >= spleen_limit() && my_fullness() >= fullness_limit() && my_inebriety() >= inebriety_limit(), "Organ space available");
	assert(my_adventures() == 0, "Spend your adventures");
	assert(pvp_attacks_left() == 0, "Spend your pvp fites");
	
	prepareAscension(
		$item[Little Geneticist DNA-Splicing Lab], 
		$item[Peppermint Pip Packet], 
		$item[New-You Club Membership Form], 
		$item[Swiss piggy bank], 
		$item[ceiling fan], 
		$item[foreign language tapes]
	);
}

int [string] moonIds {
	"Mongoose": 1,
	"Wallaby": 2,
	"Vole": 3,
	"Platypus": 4,
	"Opossum": 5,
	"Marmot": 6,
	"Wombat": 7,
	"Blendar": 8,
	"Packrat": 9
};

int [string] pathIds {
	"Unrestricted": 0,
	"Boozetafarian": 1,
	"Teetotaler": 2,
	"Oxygenarian": 3,
	"Bees Hate You": 4,
	"Way of the Surprising Fist": 6,
	"Trendy": 7,
	"Avatar of Boris": 8,
	"Bugbear Invasion": 9,
	"Zombie Slayer": 10,
	"Class Act": 11,
	"Avatar of Jarlsberg": 12,
	"BIG!": 14,
	"KOLHS": 15,
	"Class Act II: A Class For Pigs": 16,
	"Avatar of Sneaky Pete": 17,
	"Slow and Steady": 18,
	"Heavy Rains": 19,
	"Picky": 21,
	"Standard": 22,
	"Actually Ed the Undying": 23,
	"One Crazy Random Summer": 24,
	"Community Service": 25,
	"Avatar of West of Loathing": 26,
	"The Source": 27,
	"Nuclear Autumn": 28,
	"Gelatinous Noob": 29,
	"License to Adventure": 30,
	"Live. Ascend. Repeat.": 31,
	"Pocket Familiars": 32,
	"G-Lover": 33,
	"Disguises Delimit": 34,
	"Dark Gyffte": 35,
	"Two Crazy Random Summer": 36,
	"Kingdom of Exploathing": 37,
	"Path of the Plumber": 38,
	"Low Key Summer": 39,
	"Grey Goo": 40,
	"You, Robot": 41
};

int [string] lifestyleIds {
	"casual": 1,
	"softcore": 2,
	"normal": 2,
	"hardcore": 3
};

boolean [class] getPathClasses(string path) {
	switch (path) {
		case "Avatar of Boris":
			return $classes[Avatar of Boris];
		case "Zombie Slayer":
			return $classes[Zombie Master];
		case "Avatar of Jarlsberg":
			return $classes[Avatar of Jarlsberg];
		case "Avatar of Sneaky Pete":
			return $classes[Avatar of Sneaky Pete];
		case "Actually Ed the Undying":
			return $classes[Ed the Undying];
		case "Avatar of West of Loathing":
			return $classes[Cow Puncher, Beanslinger, Snake Oiler];
		case "Gelatinous Noob":
			return $classes[Gelatinous Noob];
		case "Dark Gyffte":
			return $classes[Vampyre];
		case "Path of the Plumber":
			return $classes[Plumber];
		default:
			return $classes[Seal Clubber, Turtle Tamer, Pastamancer, Sauceror, Disco Bandit, Accordion Thief];
	}
}

void ascend(string path, class playerClass, string lifestyle, string moon, item consumable, item pet) {
	if (!visit_url("charpane.php").contains_text("Astral Spirit")) visit_url("ascend.php?action=ascend&confirm=on&confirm2=on");
	
	assert(visit_url("charpane.php").contains_text("Astral Spirit"), "Failed to ascend");
	assert(getPathClasses(path) contains playerClass, `Invalid class {playerClass} for this path`);
	int pathId = pathIds[path];
	assert(pathIds contains path, `Invalid path {path}`);
	int moonId = moonIds[moon];
	assert(moonIds contains moon, `Invalid moon {moon}`);
	int lifestyleId = lifestyleIds[lifestyle];
	assert(lifestyleIds contains lifestyle, `Invalid lifestyle {lifestyle}`);
	assert($items[none, astral hot dog dinner, astral six-pack, [10883]astral energy drink] contains consumable, `Invalid consumable {consumable}`);
	assert($items[none, astral bludgeon, astral shield, astral chapeau, astral bracer, astral longbow, astral shorts, astral mace, astral ring, astral statuette, astral pistol, astral mask, astral pet sweater, astral shirt, astral belt] contains pet, `Invalid astral item {pet}`);
	visit_url("afterlife.php?action=pearlygates");
	if (consumable != $item[none]) visit_url(`afterlife.php?action=buydeli&whichitem={consumable.to_int()}`);
	if (pet != $item[none]) visit_url(`afterlife.php?action=buyarmory&whichitem={pet.to_int()}`);
	visit_url(`afterlife.php?action=ascend&confirmascend=1&whichsign={moonId}&gender=1&whichclass={playerClass.to_int()}&whichpath={pathId}&asctype={lifestyleId}&nopetok=1&pwd`, true); //&noskillsok=1
	assert(!visit_url("charpane.php").contains_text("Astral Spirit"), "Failed to reincarnate");
}