import <c2t_cartographyHunt.ash>
import <fizz-sccs-lib.ash>
import <fizz-sccs-iotms.ash>
import <fizz-sccs-quests.ash>
import <fizz-sccs-combat.ash>

/*
pre-coil and leveling events (these restore gear and familiar)
*/
void digitizeSausageGoblin() {
	if (get_property("_sausageFights").to_int() == 0) {
		saveGear($slots[back, off-hand]);
		equip($slot[back], $item[protonic accelerator pack]);
		equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
		if (my_hp() < my_maxhp()) cli_execute("hottub");
		ensureMp(29);
		adv1($location[Noob Cave], -1, mNew()
			.mEnsureMonster($monster[sausage goblin])
			.mSkill($skill[Sing Along])
			.mSkill($skill[Micrometeorite])
			.mSkill($skill[Digitize])
			.mCandyKill());
		assert(get_property("ghostLocation").to_location() != $location[none], "Failed to get protonic ghost notice");
		restoreGear();
	}
}

void getMimicCandy() {
	location ghostLocation = get_property("ghostLocation").to_location();
	if (ghostLocation != $location[none]) {
		saveGear($slots[back]);
		saveFamiliar();
		equip($slot[back], $item[protonic accelerator pack]);
		use_familiar($familiar[Stocking Mimic]);
		adv1(ghostLocation, -1, mNew().mBustGhost());
		check($item[bag of many confections]);
		restoreGear();
		restoreFamiliar();
	}
}

void getNinjaCostume() {
	if (!have($item[li'l ninja costume])) {
		saveGear($slots[acc3]);
		equip($slot[acc3], $item[Lil' Doctor&trade; Bag]);
		
		c2t_cartographyHunt($location[The Haiku Dungeon], $monster[amateur ninja]);
		run_combat(mNew()
			.mSkill($skill[Sing Along])
			.mSkill($skill[Chest X-Ray]));
			
		check($item[li'l ninja costume]);
		restoreGear();
	}
}

void fightTropicalSkeleton() {	
	if (!have($effect[Everything Looks Red])) {
		saveFamiliar();
		use_familiar($familiar[Crimbo Shrub]);
		
		if (!get_property("_shrubDecorated").to_boolean()) {
			int decorations = $item[box of old Crimbo decorations].to_int();
			// we take spooky damage so we don't kill
			visit_url(`inv_use.php?pwd=&which=99&whichitem={decorations}`);
			visit_url("choice.php?whichchoice=999&pwd=&option=1&topper=2&lights=5&garland=3&gift=2");
		}
		
		if (!$location[The Skeleton Store].noncombat_queue.contains_text("Skeletons In Store"))
			adv1($location[The Skeleton Store], -1, "");
		
		c2t_cartographyHunt($location[The Skeleton Store], $monster[novelty tropical skeleton]);
		run_combat(mNew().mSkill($skill[Open a Big Red Present ]).mSkill($skill[Use the Force]));
		run_choice(3);
		
		check($effect[Everything Looks Red]);
		foreach fruit in $items[cherry, grapefruit, lemon, strawberry] {
			check(fruit);
		}
		restoreFamiliar();
	}	
}

void fightDigitizedMonster() {
	if (get_property("_sourceTerminalDigitizeMonster") != "" && get_property("_sourceTerminalDigitizeMonsterCount").to_int() == 0) {
		saveGear($slots[back]);
		equip($slot[back], $item[protonic accelerator pack]);
		ensureHp();
		ensureMp(50);
		
		if (!$location[The Toxic Teacups].noncombat_queue.contains_text("In Your Cups"))
			adv1($location[The Toxic Teacups], -1, "");
		
		adv1($location[The Toxic Teacups], -1, mNew()
			.mEnsureMonster($monster[sausage goblin])
			.mCursing()
			.mSkill($skill[Giant Growth])
			.mCandyKill());
			
		check($effect[Giant Growth]);
		assert(get_property("ghostLocation").to_location() != $location[none], "Failed to get protonic ghost notice");
		restoreGear();
	}
}

void fightProtonicGhost() {
	location ghostLocation = get_property("ghostLocation").to_location();
	if (ghostLocation != $location[none]) {
		saveGear($slots[back]);
		equip($slot[back], $item[protonic accelerator pack]);
		adv1(ghostLocation, -1, mNew().mBustGhost());
		restoreGear();
	}
}

void getDNA() {
	boolean needFishHybrid = !get_property("_dnaHybrid").to_boolean();
	boolean needPirate = !have($item[Gene Tonic: Pirate]);
	boolean needConstruct = !have($item[Gene Tonic: Construct]) && !have($effect[Human-Machine Hybrid]);
	
	// lump fish and pirate together since both use stomping boots familair
	if (needFishHybrid || needPirate) {
		saveFamiliar();
		use_familiar($familiar[Pair of Stomping Boots]);
		int maxRoundDamage = (familiar_weight(my_familiar()) + weight_adjustment() + 5);
		assert(maxRoundDamage < $monster[lava lamprey].base_hp, "Stomping Boots might kill lava lamprey or garbage pirates");
		
		if (needFishHybrid) {
			if (get_property("dnaSyringe") != "fish") {				
				if (!$location[The Bubblin\' Caldera].noncombat_queue.contains_text("Caldera Air"))
					adv1($location[The Bubblin\' Caldera], -1, "");
				
				if (!have($effect[Drenched in Lava]))
					adv1($location[The Bubblin\' Caldera], -1, "");
				
				c2t_cartographyHunt($location[The Bubblin\' Caldera], $monster[lava lamprey]);
				run_combat(mNew()
					.mItem($item[DNA extraction syringe])
					.mRunaway());
			}
			if (have($effect[Drenched in Lava])) cli_execute("hottub");
			cli_execute("camp dnainject");
		}
		
		if (needPirate) {
			if (get_property("dnaSyringe") != "pirate") {
				if (!$location[Pirates of the Garbage Barges].noncombat_queue.contains_text("Dead Men Smell No Tales"))
					adv1($location[Pirates of the Garbage Barges], -1, "");
				
				adv1($location[Pirates of the Garbage Barges], -1, mNew()
					.mEnsureMonster($location[Pirates of the Garbage Barges])
					.mReplace($monster[flashy pirate])
					.mEnsureMonster($location[Pirates of the Garbage Barges])
					.mItem($item[DNA extraction syringe])
					.mRunaway());
			}
			cli_execute("camp dnapotion");
		}
		
		restoreFamiliar();
	}
	
	if (needConstruct) {
		if (get_property("dnaSyringe") != "construct") {
			if (get_property("snojoSetting") != "MUSCLE") {
				visit_url("place.php?whichplace=snojo&action=snojo_controller");
				run_choice(1);
			}
			
			adv1($location[The X-32-F Combat Training Snowman], -1, mNew()
				.mItem($item[DNA extraction syringe])
				.mCursing()
				.mCandyKill());
		}
		
		if (!have($item[Gene Tonic: Construct])) {
			assert(get_property("dnaSyringe") == "construct", "Failed to get construct DNA");
			cli_execute("camp dnapotion");
		}
	}
	
	acquire($effect[Human-Machine Hybrid]);
}

void useLoveTunnel() {
	if (!get_property("_loveTunnelUsed").to_boolean()) {
		ensureHp();
		
		visit_url($location[The Tunnel of L.O.V.E.].to_url());
		run_choice(1); 								// enter tunnel
		run_choice(1, false);						// choose enforcer
		run_combat(mNew().mAttackRepeat()); 		// fight enforcer
		run_choice(2); 								// epaulettes
		run_choice(1, false); 						// choose engineer
		run_combat(mNew().mCandyKill()); 			// fight engineer
		run_choice(2); 								// open heart surgery
		run_choice(1, false); 						// choose equivocator
		run_combat(mNew().mCursing().mCandyKill());	// fight equivocator
		run_choice(3); 								// chocolate
		
		foreach it in $items[LOV Elixir #3, LOV Elixir #6, LOV Epaulettes] {
			check(it);
		}
	}
}

void useTenPercentBonus() {
	if (have($item[a ten-percent bonus])) {
		foreach ef in $effects[That's Just Cloud-Talk\, Man, Inscrutable Gaze, Synthesis: Learning] {
			check(ef);
		}
		saveGear($slots[back, off-hand]);
		equip($slot[back], $item[LOV Epaulettes]);
		equip($slot[off-hand], $item[familiar scrapbook]);
		use(1, $item[a ten-percent bonus]);
		restoreGear();
	}
}

void useFreeRests() {
	if (get_property("timesRested").to_int() < total_free_rests()) {
		saveGear($slots[back, off-hand]);
		equip($slot[back], $item[LOV Epaulettes]);
		equip($slot[off-hand], $item[familiar scrapbook]);
		
		while (get_property("timesRested").to_int() < total_free_rests())
			visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
		
		restoreGear();
	}
}

void fightSnojo() {
	if (get_property("_snojoFreeFights").to_int() < 10) {
		if (get_property("snojoSetting") != "MUSCLE") {
			visit_url("place.php?whichplace=snojo&action=snojo_controller");
			run_choice(1);
		}
		
		for i from get_property("_snojoFreeFights").to_int() to 9 {
			ensureHp(0.8);
			ensureMp(8 * (i + 2));
			adv1($location[The X-32-F Combat Training Snowman], -1, mNew()
				.mCursing()
				.mCandyKill());
		}
	}
	
	if (have($effect[Relaxed Muscles])) cli_execute("hottub");
}

void evokeEldritch() {
	if (!get_property("_eldritchHorrorEvoked").to_boolean()) {
		ensureHp();
		ensureMp(200);
		// can't use_skill otherwise mafia will run combat with CCS
		visit_url(`runskillz.php?action=Skillz&whichskill={$skill[Evoke Eldritch Horror].to_int()}`);
		run_combat(mNew().mCursing().mCandyKill());
	}
	
	// might get beaten up if eldritch boss is summoned
	if (have($effect[Beaten Up])) cli_execute("hottub");
}

void fightGodLobster() {
	if (get_property("_godLobsterFights").to_int() < 3) {
		saveFamiliar();
		use_familiar($familiar[God Lobster]);
		
		while (get_property("_godLobsterFights").to_int() < 3) {
			if (have($item[God Lobster's Ring])) equip($slot[familiar], $item[God Lobster's Ring]);
			else if (have($item[God Lobster's Scepter])) equip($slot[familiar], $item[God Lobster's Scepter]);
			
			ensureHp(0.8);
			ensureMp(50);
			
			visit_url("main.php?fightgodlobster=1");
			run_combat(mNew().mCursing().mCandyKill());
			// get regalia except on last combat
			run_choice(get_property("_godLobsterFights").to_int() < 3 ? 1 : 2);
		}
		
		restoreFamiliar();
	}
}

void fightWitchessWitch() {
	if (!have($item[battle broom])) {
		ensureHp();
		fightWitchessPiece($monster[Witchess Witch], mNew().mAttackRepeat());
	}
}

void fightWitchessKing() {
	if (!have($item[dented scepter])) {
		ensureHp();
		ensureMp(200);
		fightWitchessPiece($monster[Witchess King], mNew().mCursing().mCandyKill());
	}
}

void fightWitchessQueens() {
	while (get_property("_witchessFights").to_int() < 5) {
		ensureHp();
		fightWitchessPiece($monster[Witchess Queen], mNew().mAttackRepeat());
	}
}

void doDmt() {
	if ($familiar[Machine Elf].fights_today < $familiar[Machine Elf].fights_limit) {
		saveFamiliar();
		use_familiar($familiar[Machine Elf]);
		
		while ($familiar[Machine Elf].fights_today < $familiar[Machine Elf].fights_limit) {
			ensureHp(0.8);
			ensureMp(50);
			
			if (get_property("_sourceTerminalPortscanUses").to_int() < 1)
				adv1($location[The Deep Machine Tunnels], -1, mNew()
					.mSkill($skill[Portscan]))
					.mCursing()
					.mCandyKill());
			else
				adv1($location[The Deep Machine Tunnels], -1, mNew()
					.mIfMonster($monster[Government agent], mNew().mSkill($skill[Feel Envy]))
					.mCursing()
					.mCandyKill());
		}
		
		restoreFamiliar();
	}
}

void chainProfessorLectures() {
	if (sausageFightGuaranteed()) {
		saveGear($slots[off-hand, acc1, acc2, acc3]);
		saveFamiliar();
		use_familiar($familiar[Pocket Professor]);
		if (!get_property("_mummeryUses").contains_text("6")) cli_execute("mummery hp");
		equip($slot[off-hand], $item[Kramco Sausage-o-Matic&trade;]);
		equip($slot[acc1], $item[hewn moon-rune spoon]);
		equip($slot[acc2], $item[Brutal brogues]);
		equip($slot[acc3], $item[Beach Comb]);
		ensureHp();
		ensureMp(300);
		
		adv1($location[The Toxic Teacups], -1, mNew()
			.mEnsureMonster($monster[sausage goblin])
			.mTrySkill($skill[lecture on relativity])
			.mCursing()
			.mCandyKill());
			
		restoreGear();	
		restoreFamiliar();
	}
}

void getInnerElf() {
	if (!have($effect[Inner Elf])) {
		assert(my_level() >= 13, "Must be at least level 13 to adventure in the slime tube");
		
		saveFamiliar();
		use_familiar($familiar[Machine Elf]);
		acquire($effect[Blood Bubble]);
		ensureHp();
		ensureMp(50);
		
		try {
			string clan = get_clan_name();
			joinClan(get_property("fizz_sccs_motherSlimeClan"));
			set_property("choiceAdventure326", 1);
			adv1($location[The Slime Tube], -1, mNew().mSkill($skill[Snokebomb]));
		} finally {
			joinClan(clan);
		}
		
		check($effect[Inner Elf]);
		restoreFamiliar();
	}
}

void doNEP() {
	while (get_property("_neverendingPartyFreeTurns").to_int() < 10) {
		ensureHp(0.8);
		ensureMp(50);
		
		adv1($location[The Neverending Party], -1, mNew()
			.mCursing()
			.mTrySkill($skill[Feel Pride])
			.mCandyKill());
	}
}

/*
one-off events (these don't restore gear or familiar)
*/
void getFoamed() {
	if (!have($effect[Fireproof Foam Suit])) {
		equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
		equip($slot[off-hand], $item[industrial fire extinguisher]);
		use_familiar($familiar[Machine Elf]);
		adv1($location[The Dire Warren], -1, mNew()
			.mSkill($skill[Fire Extinguisher: Foam Yourself])
			.mSkill($skill[Use the Force]));
		run_choice(3);
		check($effect[Fireproof Foam Suit]);
	}
}

void getMeteorShowered() {
	if (!have($effect[Meteor Showered])) {
		equip($slot[weapon], $item[Fourth of May Cosplay Saber]);
		use_familiar($familiar[Machine Elf]);
		adv1($location[The Dire Warren], -1, mNew()
			.mSkill($skill[Meteor Shower])
			.mSkill($skill[Use the Force]));
		run_choice(3);
		check($effect[Meteor Showered]);
	}
}

void getCarolAndShavingBuffs() {
	if (!have($effect[Do You Crush What I Crush?])) {
		equip($slot[hat], $item[Daylight Shavings Helmet]);
		equip($slot[acc1], $item[Lil' Doctor&trade; Bag]);
		use_familiar($familiar[Ghost of Crimbo Carols]);
		adv1($location[The Dire Warren], -1, mNew().mSkill($skill[Chest X-Ray]));
		check($effect[Do You Crush What I Crush?]);
		check($effect[Pointy Wizard Beard]);
	}
}

void spitAndMeteorUngulith() {
	if (!get_property("_chateauMonsterFought").to_boolean()) {
		assert(get_property("camelSpit").to_int() >= 100, "Not enough camel spit accumulated");
		equip($item[Fourth of May Cosplay Saber]);
		use_familiar($familiar[Melodramedary]);
		ensureHp();
		visit_url("place.php?whichplace=chateau&action=chateau_painting");
		run_combat(mNew()
			.mTrySkill($skill[%fn\, spit on me!])
			.mSkill($skill[Meteor Shower])
			.mSkill($skill[Use the Force]));
		run_choice(3);
		check($item[corrupted marrow]);
		check($effect[Spit Upon]);
		check($effect[Meteor Showered]);
	}	
}

void getDeepDark() {
	if (!have($effect[Visions of the Deep Dark Deeps])) {
		prep(quests["DeepDark"]);
		assert(my_maxhp() >= 500, "Not enough HP for deep dark visions");
		// TODO check spooky res >= 10 as myst otherwise 11
		ensureHp();
		acquire($effect[Visions of the Deep Dark Deeps]);	
		ensureHp();
	}
}

void getBatform() {
	if (!have($effect[Bat-Adjacent Form])) {
		equip($slot[back], $item[vampyric cloake]);
		equip($slot[acc1], $item[Kremlin's Greatest Briefcase]);
		use_familiar($familiar[Machine Elf]);
		adv1($location[The Dire Warren], -1, mNew()
			.mSkill($skill[Become a Bat])
			.mSkill($skill[KGB tranquilizer dart]));
		check($effect[Bat-Adjacent Form]);
	}
}