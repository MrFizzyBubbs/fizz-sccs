import <fizz-sccs-lib.ash>

record QuestRecord { int id; string service; };

QuestRecord [string] quests = {
	'HP': new QuestRecord(1, 'Donate Blood'),
	'Muscle': new QuestRecord(2, 'Feed The Children'),
	'Mysticality': new QuestRecord(3, 'Build Playground Mazes'),
	'Moxie': new QuestRecord(4, 'Feed Conspirators'),
	'FamiliarWeight': new QuestRecord(5, 'Breed More Collies'),
	'WeaponDamage': new QuestRecord(6, 'Reduce Gazelle Population'),
	'SpellDamage': new QuestRecord(7, 'Make Sausage'),
	'CombatFrequency': new QuestRecord(8, 'Be a Living Statue'),
	'ItemDrop': new QuestRecord(9, 'Make Margaritas'),
	'HotResist': new QuestRecord(10, 'Clean Steam Tunnels'),
	'CoilWire': new QuestRecord(11, 'Coil Wire'),
	'Donate': new QuestRecord(30, 'Donate Your Body To Science'),
	
	'Beginning': new QuestRecord(100, ''),
	'Leveling': new QuestRecord(101, ''),
	'DeepDark': new QuestRecord(102, ''),
};

record QuestPrepRecord { 
	boolean [effect] acquire; 
	boolean [effect] check; 
	item [slot] equipment; 
	string retrocape;
	familiar fam;
};

QuestPrepRecord [int] questPreps;

questPreps[quests['Beginning'].id] = new QuestPrepRecord(
	$effects[Inscrutable Gaze], 
	$effects[none], 
	{
		$slot[hat]: $item[Iunion Crown],
		$slot[back]: $item[protonic accelerator pack],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[familiar scrapbook],
		$slot[pants]: $item[Cargo Cultist Shorts],
		$slot[acc1]: $item[hewn moon-rune spoon],
		$slot[acc2]: $item[Powerful Glove],
		$slot[acc3]: $item[Kremlin's Greatest Briefcase]
	}, 
	'', 
	$familiar[Melodramedary]
);

questPreps[quests['CoilWire'].id] = new QuestPrepRecord(
	$effects[none], 
	$effects[none], 
	{
		$slot[hat]: $item[Iunion Crown],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[wrench],
		$slot[pants]: $item[Cargo Cultist Shorts],
		$slot[acc1]: $item[hewn moon-rune spoon],
		$slot[acc2]: $item[Powerful Glove],
		$slot[acc3]: $item[Kremlin's Greatest Briefcase]
	}, 
	'heck thrill', 
	$familiar[none]
);

questPreps[quests['Leveling'].id] = new QuestPrepRecord(
	$effects[
		Billiards Belligerence,
		Broad-Spectrum Vaccine,
		Favored by Lyle,
		Puzzle Champ,
		Starry-Eyed,
		Total Protonic Reversal,
		Glittering Eyelashes,
		substats.enh,
		items.enh,
		meat.enh,
		Uncucumbered,
		// beach comb
		Hot-Headed,
		Cold as Nice,
		A Brush with Grossness,
		Does It Have a Skull In There??,
		Oiled\, Slick,
		Resting Beach Face,
		Do I Know You From Somewhere?,
		You Learned Something Maybe!,
		// skills
		Big,
		Blessing of the Bird, // for sauceror CS day 1: 75% mox, 2 spooky res, 20% items, 100 DA and 5 DR
		Blood Bond,
		Blood Bubble,
		Carol of the Bulls,
		Carol of the Hells,
		Carol of the Thrills,
		Feeling Excited,
		Feeling Peaceful,
		Frenzied\, Bloody,
		Inscrutable Gaze,
		Ruthlessly Efficient,
		Song of Bravado,
		Stevedave's Shanty of Superiority,
		Triple-Sized,
		// class skills
		Astral Shell,
		Elemental Saucesphere,
		Empathy,
		Ghostly Shell,
		Leash of Linguini,
		// items
		Mystically Oiled,
	],
	$effects[Synthesis: Smart, Synthesis: Learning, That's Just Cloud-Talk\, Man], 
	{
		$slot[hat]: $item[Daylight Shavings Helmet],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[weeping willow wand],
		$slot[pants]: $item[Cargo Cultist Shorts],
		$slot[acc1]: $item[hewn moon-rune spoon],
		$slot[acc2]: $item[gold detective badge],
		$slot[acc3]: $item[your cowboy boots]
	}, 
	'heck thrill', 
	$familiar[Melodramedary]
);

questPreps[quests['Muscle'].id] = new QuestPrepRecord(
	$effects[Expert Oiliness, Quiet Determination, Rage of the Reindeer], 
	$effects[Giant Growth], 
	{
		$slot[hat]: $item[wad of used tape],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[dented scepter],
		$slot[acc1]: $item[Brutal brogues],
		$slot[acc3]: $item[&quot;I Voted!&quot; sticker]
	}, 
	'muscle', 
	$familiar[none]
);

questPreps[quests['Moxie'].id] = new QuestPrepRecord(
	$effects[Expert Oiliness, Quiet Desperation, Disco Fever, Pomp & Circumsands], 
	$effects[none], 
	{
		$slot[hat]: $item[very pointy crown],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[industrial fire extinguisher],
		$slot[acc2]: $item[Beach Comb],
		$slot[acc3]: $item[&quot;I Voted!&quot; sticker]
	}, 
	'moxie', 
	$familiar[none]
);

questPreps[quests['HP'].id] = new QuestPrepRecord(
	$effects[A Few Extra Pounds, Reptilian Fortitude, Quiet Determination, Power Ballad of the Arrowsmith], // TODO perm Song of Starch
	$effects[none], 
	{
		$slot[hat]: $item[wad of used tape],
		$slot[back]: $item[vampyric cloake],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[dented scepter],
		$slot[pants]: $item[Cargo Cultist Shorts],
		$slot[acc1]: $item[Brutal brogues],
		$slot[acc2]: $item[Eight Days a Week Pill Keeper],
		$slot[acc3]: $item[Kremlin's Greatest Briefcase]
	}, 
	'', 
	$familiar[none]
);

questPreps[quests['Mysticality'].id] = new QuestPrepRecord(
	$effects[Quiet Judgement], 
	$effects[none], 
	{
		$slot[hat]: $item[wad of used tape],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[acc1]: $item[battle broom],
		$slot[acc3]: $item[&quot;I Voted!&quot; sticker]
	}, 
	'mysticality', 
	$familiar[none]
);

questPreps[quests['HotResist'].id] = new QuestPrepRecord(
	$effects[Astral Shell, Elemental Saucesphere, Feeling Peaceful, Empathy, Leash of Linguini], 
	$effects[Fireproof Foam Suit],
	{
		$slot[hat]: $item[Daylight Shavings Helmet],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[industrial fire extinguisher],
		$slot[acc1]: $item[Brutal brogues],
		$slot[acc2]: $item[hewn moon-rune spoon],
		$slot[acc3]: $item[Kremlin's Greatest Briefcase],
		$slot[familiar]: $item[cracker]
	}, 
	'vampire hold', 
	$familiar[Exotic Parrot]
);

questPreps[quests['CombatFrequency'].id] = new QuestPrepRecord(
	$effects[
		Feeling Lonely,
		Gummed Shoes,
		Invisible Avatar,
		Silent Running,
		Smooth Movements,
		The Sonata of Sneakiness,
		Throwing Some Shade,
		Become Superficially interested
	],
	$effects[Silence of the God Lobster],
	{
		$slot[hat]: $item[very pointy crown],
		$slot[back]: $item[protonic accelerator pack],
		$slot[pants]: $item[pantogram pants],
		$slot[acc3]: $item[Kremlin's Greatest Briefcase]
	}, 
	'', 
	$familiar[Disgeist]
);

questPreps[quests['FamiliarWeight'].id] = new QuestPrepRecord(
	$effects[Empathy, Leash of Linguini, Robot Friends, Do I Know You From Somewhere?, Human-Machine Hybrid, Blood Bond],
	$effects[Meteor Showered, Open Heart Surgery, Human-Fish Hybrid],
	{
		$slot[hat]: $item[Daylight Shavings Helmet],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[off-hand]: $item[rope],
		$slot[acc1]: $item[Brutal brogues],
		$slot[acc2]: $item[hewn moon-rune spoon],
		$slot[acc3]: $item[Beach Comb],
		$slot[familiar]: $item[cracker]
	}, 
	'', 
	$familiar[Exotic Parrot]
);

questPreps[quests['WeaponDamage'].id] = new QuestPrepRecord(
	$effects[
		Bow-Legged Swagger,
		Cowrruption,
		Song of the North,
		Carol of the Bulls,
		Blessing of your favorite Bird,
		Frenzied\, Bloody,
		The Power of LOV,
		Billiards Belligerence,
		Lack of Body-Building,
		Jackasses' Symphony of Destruction,
		Rage of the Reindeer,
		// TODO perm Scowl of the Auk
		Tenacity of the Snapper,
		// TODO perm Claws of the Walrus
		Disdain of the War Snapper
	],
	$effects[Meteor Showered, Do You Crush What I Crush?, Inner Elf, Spit Upon],
	{
		$slot[weapon]: $item[broken champagne bottle],
		$slot[off-hand]: $item[dented scepter],
		$slot[acc1]: $item[Brutal brogues],
		$slot[acc2]: $item[Powerful Glove],
		$slot[acc3]: $item[Kremlin's Greatest Briefcase]
	}, 
	'', 
	$familiar[none]
);

questPreps[quests['DeepDark'].id] = new QuestPrepRecord(
	$effects[Astral Shell, Elemental Saucesphere, Feeling Peaceful, Empathy, Leash of Linguini], 
	$effects[none],
	{
		$slot[hat]: $item[Daylight Shavings Helmet],
		$slot[back]: $item[vampyric cloake],
		$slot[weapon]: $item[Fourth of May Cosplay Saber],
		$slot[pants]: $item[Cargo Cultist Shorts],
		$slot[acc1]: $item[Brutal brogues],
		$slot[acc2]: $item[hewn moon-rune spoon],
		$slot[acc3]: $item[Beach Comb],
		$slot[familiar]: $item[cracker]
	}, 
	'', 
	$familiar[Exotic Parrot]
);

questPreps[quests['SpellDamage'].id] = new QuestPrepRecord(
	$effects[
		Cowrruption,
		Warlock\, Warstock\, and Warbarrel,
		The Magic of LOV,
		Song of Sauce,
		Carol of the Hells,
		Mental A-cue-ity,
		We're All Made of Starfish,
		Concentration,
		Jackasses' Symphony of Destruction,
		// TODO perm Arched Eyebrow of the Archmage
	],
	$effects[Meteor Showered, Do You Crush What I Crush?, Inner Elf, Spit Upon, Simmering, Visions of the Deep Dark Deeps, Pointy Wizard Beard],
	{
		// $slot[weapon]: $item[wrench],
		$slot[weapon]: $item[Staff of Simmering Hatred],
		$slot[off-hand]: $item[weeping willow wand],
		$slot[pants]: $item[pantogram pants],
		$slot[acc1]: $item[battle broom],
		$slot[acc2]: $item[Powerful Glove],
		$slot[acc3]: $item[hewn moon-rune spoon],
		$slot[familiar]: $item[enchanted fire extinguisher]
	}, 
	'', 
	$familiar[Left-Hand Man]
);

questPreps[quests['ItemDrop'].id] = new QuestPrepRecord(
	$effects[
		Steely-Eyed Squint,
		// Certainty,
		Human-Pirate Hybrid,
		Feeling Lost,
		I See Everything Thrice!,
		items.enh,
		Fat Leon's Phat Loot Lyric,
		Blessing of the Bird,
		Singer's Faithful Ocelot,
		The Spirit of Taking,
		Uncucumbered,
		Nearly All-Natural,
		Ermine Eyes
	],
	$effects[Bat-Adjacent Form],
	{
		$slot[hat]: $item[wad of used tape],
		$slot[back]: $item[vampyric cloake],
		$slot[off-hand]: $item[Kramco Sausage-o-Matic&trade;],
		$slot[acc1]: $item[gold detective badge],
		$slot[acc2]: $item[your cowboy boots],
		$slot[acc3]: $item[government-issued night-vision goggles],
		$slot[familiar]: $item[li'l ninja costume]
	}, 
	'', 
	$familiar[Trick-or-Treating Tot]
);

void prep(QuestRecord quest) {
	QuestPrepRecord data = questPreps[quest.id];
	item back = data.equipment[$slot[back]];
	assert(back == $item[none] || data.retrocape == '', `Multiple back items for {quest.id}`);
	
	// TODO handle shrugging extra songs?
	foreach ef in data.acquire { acquire(ef); }
	foreach ef in data.check { check(ef); }
	
	if (data.fam != $familiar[none]) use_familiar(data.fam);
	if (data.retrocape != '') cli_execute(`retrocape {data.retrocape}`);
	foreach s, it in data.equipment {
		if (!have(it)) {
			if (it.get_related('fold') contains it) cli_execute(`fold {it}`);
			else abort(`Unable to find {it}`);
		}
		equip(s, it);
	}
}

boolean haveQuest(QuestRecord quest) {
	if (quest.id == quests['Donate'].id) return visit_url('council.php').contains_text(`<input type=hidden name=option value={quest.id}>`);
	assert(quest.id > 0 && quest.id <= quests['CoilWire'].id, `Invalid quest {quest.id}: {quest.service}!`);
	return !get_property('csServicesPerformed').contains_text(quest.service);
}

int getQuestCost(QuestRecord quest) {
	string page = visit_url('council.php');
	matcher m = create_matcher(`whichchoice value=1089><input type=hidden name=option value={quest.id}.*?Perform Service [(](\\d+) Adventures[)]`, page);
	assert(m.find(), `Failed to find quest {quest.id}: {quest.service}`);
	return group(m, 1).to_int();

}

boolean isQuestThresholdMet(QuestRecord quest) {
	if (quest.id >= quests['CoilWire'].id) return true;

	string [int] arr = split_string(get_property('fizz_sccs_thresholds'), ',');
	int threshold = arr[quest.id - 1].to_int();

	if (count(arr) == 10 && threshold > 0 && threshold <= 60) {
		return getQuestCost(quest) <= threshold;
	} else {
		print("Warning: the fizz_sccs_thresholds property is broken for this quest; defaulting to a 1-turn threshold.", 'red');
		return getQuestCost(quest) <= 1;
	}
}

void prepAndDoQuest(QuestRecord quest) {
	if (haveQuest(quest)) {
		prep(quest);
		
		assert(isQuestThresholdMet(quest), `Failed to meet threshold for quest {quest.id}: {quest.service}`);
		assert(!get_property('fizz_haltBeforeTest').to_boolean(), `Halting before quest {quest.id}: {quest.service}`);
		int before = my_turncount();
		
		visit_url('council.php');
		visit_url(`choice.php?whichchoice=1089&option={quest.id}`);
		assert(!haveQuest(quest), `Couldn't complete quest {quest.id}: {quest.service}?`);
		
		int actual = my_turncount() - before;
	}
}