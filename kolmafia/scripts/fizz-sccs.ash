since r25973;

import <c2t_cartographyHunt.ash>
import <fizz-sccs-lib.ash>
import <fizz-sccs-combat.ash>
import <fizz-sccs-quests.ash>
import <fizz-sccs-events.ash>
import <fizz-sccs-ascend.ash>

/*
Boolean indicating if the script should skip the user confirmation before ascending
*/
if (!property_exists('fizz_sccs_noconfirm', false))
	set_property('fizz_sccs_noconfirm', 'false');

/*
Name of the clan that the script will join for the VIP lounge
*/
if (!property_exists('fizz_sccs_vipClan', false))
	set_property('fizz_sccs_vipClan', 'Margaretting Tye');

/*
Name of the clan that the script will join to fight Mother Slime for the Inner Elf effect
*/
if (!property_exists('fizz_sccs_motherSlimeClan', false))
	set_property('fizz_sccs_motherSlimeClan', 'Hobopolis Vacation Home');

/*
Aborts after prepping for each test but before actually doing it at the council
*/
if (!property_exists('fizz_sccs_haltBeforeTest', false))
	set_property('fizz_sccs_haltBeforeTest', 'false');

/*
These are the 10 thresholds corresponding to the minimum turns to allow each test to take
The order is hp, mus, mys, mox, fam, weapon, spell, nc, item, hot -- which is the same as the game
The script will stop just before doing a test if a threshold is not met after doing all the pre-test stuff
Example: 1,1,1,1,35,1,31,1,1,1 will allow the familiar test to take 35 turns, the spell test to take 31 turns, and all others must be 1 turn
*/
if (!property_exists('fizz_sccs_thresholds', false))
	set_property('fizz_sccs_thresholds', '1,1,1,1,24,1,18,1,1,1');

void enterScript() {
	print("Save the Kingdom, save the world. Community Service time!", 'blue');
	
	if (!property_exists('_fizz_sccs_startTime', false))
		set_property('_fizz_sccs_startTime', now_to_int());
	
	// buy from NPCs
	set_property('autoSatisfyWithNPCs', 'true');
	// buy from coinmasters/hermit
	set_property('autoSatisfyWithCoinmasters', 'true');	
	// no mana burn, every mp is sacred
	set_property('manaBurningThreshold', '-0.05');
	// custom combat script
	set_property('customCombatScript', 'fizz_sccs');
	// turn off Lil' Doctor quests
	set_property('choiceAdventure1340', '3');
	// set cosplay saber to get items
	set_property('choiceAdventure1387', '3');
	// skip NEP quest
	set_property('choiceAdventure1322', '2');
	set_property('choiceAdventure1324', '5');
	// backup camera settings
	if (!get_property('backupCameraReverserEnabled').to_boolean()) cli_execute('backupcamera reverser on');
	if (get_property('backupCameraMode') != 'ml') cli_execute('backupcamera ml');
	// terminal settings
	if (get_property('sourceTerminalEducate1') != 'digitize.edu') cli_execute('terminal educate digitize');
	if (get_property('sourceTerminalEducate2') != 'portscan.edu') cli_execute('terminal educate portscan');
	
	// initial clan
	set_property('fizz_sccs_initialClan', get_clan_name());
	joinClan(get_property('fizz_sccs_vipClan'));
	
	// initialize council
	visit_url('council.php'); 
}

void exitScript() {
	joinClan(get_property('fizz_sccs_initialClan'));
	
	if (get_property('kingLiberated').to_boolean()) {
		float milliseconds = now_to_int().to_float() - get_property('_fizz_sccs_startTime').to_float();
		print(`This run took {milliseconds / 1000} seconds`, 'blue');
	}
}

void openQuestZones() {
	string [string] shops = {
		'questM23Meatsmith': 'meatsmith',
		'questM24Doc': 'doc',
		'questM25Armorer': 'armory'
	};
	
	foreach prop, id in shops {
		if (get_property(prop).to_lower_case() == 'unstarted') {
			visit_url(`shop.php?whichshop={id}&action=talk`);
			run_choice(1);
		}
	}
}

void preCoilWire() {
	visit_url('tutorial.php?action=toot');
	tryUse($item[Letter from King Ralph XI]);
	tryUse($item[pork elf goodies sack]);
	autosell(5, $item[baconstone]);
    autosell(5, $item[hamethyst]);
	
	while (get_property('_universeCalculated').to_int() < get_property('skillLevel144').to_int() && reverse_numberology() contains 69) {
		cli_execute('numberology 69');
	}
	
	if (get_property('_saberMod') == '0') cli_execute('saber familiar');
	if (get_property('_voteModifier') == '') cli_execute('VotingBooth.ash');
	if (get_property('_detectiveCasesCompleted').to_int() < 3) cli_execute('Detective Solver.ash');
	if (!get_property('_chateauDeskHarvested').to_boolean()) visit_url('place.php?whichplace=chateau&action=chateau_desk');
	if (!get_property('_canSeekBirds').to_boolean()) use(1, $item[Bird-a-Day calendar]);
	if (get_property('_horsery') == '') cli_execute('horsery dark');
	if (get_property('boomBoxSong') != 'Total Eclipse of Your Meat') cli_execute('boombox meat');
	cli_execute('Briefcase.ash enchantment weapon hot -combat');
	if (!have($effect[That's Just Cloud-Talk\, Man])) visit_url('place.php?whichplace=campaway&action=campaway_sky');
	
	string [item] cliItems {
		$item[green mana]: 'cheat Giant Growth',
		$item[rope]: 'cheat Rope',
		$item[wrench]: 'cheat Wrench',
		$item[Brutal brogues]: 'Bastille.ash myst brutalist',
		$item[&quot;DRINK ME&quot; potion]: 'clan_viplounge.php?action=lookingglass&whichfloor=2',
		$item[bitchin' meatcar]: 'acquire bitchin\' meatcar',
		$item[anticheese]: 'place.php?whichplace=desertbeach&action=db_nukehouse',
		$item[your cowboy boots]: 'place.php?whichplace=town_right&action=townright_ltt',
		$item[flimsy hardwood scraps]: 'shop.php?whichshop=lathe',
		$item[weeping willow wand]: 'acquire weeping willow wand',
		$item[gold detective badge]: 'place.php?whichplace=town_wrong&action=townwrong_precinct'
	};
	
	foreach it, cmd in cliItems {
		if (!have(it)) cli_execute(cmd);
	}
	
	pantagramming();
	scavengeDaycare();
	smashFreeBarrels();
	openQuestZones();
	equip($slot[acc2], $item[Powerful Glove]); // optimize equipping and unequipping to buff up
	prep(quests['Beginning']); // don't equip shavings helmet here to save buff cycle for after coil test
	if (!get_property('_mummeryUses').contains_text('5')) cli_execute('mummery myst');
	
	digitizeSausageGoblin();
	getMimicCandy();
	getNinjaCostume(); // need a non-protonic ghost combat to start the digitize counter
	fightTropicalSkeleton();
	
	if (!get_property('_borrowedTimeUsed').to_boolean()) {
		if (!have($item[borrowed time])) create($item[borrowed time]);
		use(1, $item[borrowed time]);
	}
}

void postCoilWire() {
	use_skill(1, $skill[Advanced Cocktailcrafting]);
	use_skill(1, $skill[Prevent Scurvy and Sobriety]);
	use_skill(1, $skill[Advanced Saucecrafting]);
	
	if (!get_property('hasRange').to_boolean()) {
		acquire($item[Dramatic&trade; range]);
		use(1, $item[Dramatic&trade; range]);
	}
	
	foreach saucePotion in $items[oil of expertise, ointment of the occult, eyedrops of the ermine, cordial of concentration] { 
		acquire(saucePotion); 
	}
	
	acquire($item[toy accordion]);
	acquire($item[turtle totem]);
	
	if (!have($effect[Synthesis: Smart])) {
		use_skill(1, $skill[Chubby and Plump]);
		sweet_synthesis($item[bag of many confections], $item[Chubby and Plump bar]);
		check($effect[Synthesis: Smart]);
	}

	if (!have($effect[Synthesis: Learning])) {
		cli_execute('garden pick');
		acquire($item[peppermint twist]);
		acquire($item[peppermint patty]);
		sweet_synthesis($item[peppermint twist], $item[peppermint patty]);
		check($effect[Synthesis: Learning]);
	}
}

void main() {
	if (my_path() != 'Community Service') {
		checkReadyToAscend();
		if (can_interact() && (get_property('fizz_sccs_noconfirm').to_boolean() || user_confirm("Ready to Ascend into Community Service?"))) {
			ascend('Community Service', $class[Sauceror], 'softcore', 'Wallaby', $item[astral six-pack], $item[none]);
		} else {
			abort();
		}
	}
	
	try {
		enterScript();
		
		if (haveQuest(quests['CoilWire'])) {
			preCoilWire();
			prepAndDoQuest(quests['CoilWire']);
		}
		
		if (haveQuest(quests['Muscle'])) {
			postCoilWire();		
			prep(quests['Leveling']);
			fightDigitizedMonster(); // we also get giant growth here
			fightProtonicGhost();
			getDNA();
			useLoveTunnel();
			equip($slot[back], $item[LOV Epaulettes]);
			useTenPercentBonus();
			useFreeRests();
			fightSnojo();
			evokeEldritch();
			fightGodLobster();
			cli_execute('fold makeshift garbage shirt');
			equip($slot[shirt], $item[makeshift garbage shirt]);
			fightWitchessWitch();
			equip($slot[acc2], $item[battle broom]);
			fightWitchessKing();
			fightWitchessQueens();
			doDmt();
			chainProfessorLectures();
			getInnerElf();		
			doNEP();
		}
		
		prepAndDoQuest(quests['Muscle']);
		prepAndDoQuest(quests['Moxie']);
		prepAndDoQuest(quests['HP']);
		prepAndDoQuest(quests['Mysticality']);
		
		if (haveQuest(quests['HotResist'])) {
			acquireFamEquip($familiar[Exotic Parrot]);
			getFoamed();
			prepAndDoQuest(quests['HotResist']);
		}
		
		if (haveQuest(quests['CombatFrequency'])) {
			equip($slot[acc2], $item[Powerful Glove]);
			prepAndDoQuest(quests['CombatFrequency']);
		}
		
		// drink 5 pilsners, save 1 for aftercore shotglass
		tryUse($item[astral six-pack]);
		if (available_amount($item[astral pilsner]) == 6) {
			acquire($effect[Ode to Booze]);
			drink(5, $item[astral pilsner]);
		}
		
		if (haveQuest(quests['FamiliarWeight'])) {
			getMeteorShowered();
			prepAndDoQuest(quests['FamiliarWeight']);
		}
		
		if (haveQuest(quests['WeaponDamage'])) {
			getCarolAndShavingBuffs();
			getInnerElf();
			spitAndMeteorUngulith();
			if (!have($effect[cowrruption])) use(1, $item[corrupted marrow]);
			if (!have($effect[Wasabi With You]) && !have($item[wasabi marble soda])) pull($item[wasabi marble soda], 5000);
			acquire($effect[Wasabi With You]);
			prepAndDoQuest(quests['WeaponDamage']);
		}
		
		if (haveQuest(quests['SpellDamage'])) {
			if (!have($effect[Simmering])) use_skill(1, $skill[Simmer]);
			getInnerElf();
			getMeteorShowered();
			getDeepDark();
			if (!have($effect[Pisces in the Skyces]) && !have($item[tobiko marble soda])) pull($item[tobiko marble soda], 5000);
			acquire($effect[Pisces in the Skyces]);
			if (!have($item[Staff of Simmering Hatred])) take_storage(1, $item[Staff of Simmering Hatred]);
			if (!have($item[enchanted fire extinguisher])) take_storage(1, $item[enchanted fire extinguisher]);
			prepAndDoQuest(quests['SpellDamage']);
		}
		
		if (haveQuest(quests['ItemDrop'])) {
			getBatform();
			if (!have($effect[Infernal Thirst])) cli_execute('genie effect infernal thirst');
			prepAndDoQuest(quests['ItemDrop']);
		}
		
		prepAndDoQuest(quests['Donate']);
	} finally {
		exitScript();
	}
}