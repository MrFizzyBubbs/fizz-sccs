void assert(boolean condition, string message) {
	if (!condition) abort(message);
}

/*
items
*/
boolean have(item it, int amount) {
	return available_amount(it) >= amount;
}

boolean have(item it) {
	return have(it, 1);
}

void acquire(item it) {
	if (!have(it)) retrieve_item(1, it);
	assert(have(it), `Failed to acquire item {it}`);
}

void pull(item it, int price) {
	if (storage_amount(it) < 1) buy_using_storage(1, it, price);
	assert(take_storage(1, it), `Failed to pull item {it} with a max price {price} meat`);
}

void pull(item it) {
	pull(it, 0);
}

void check(item it, int amount) {
	assert(have(it, amount), `Missing {amount} of {it}`);
}

void check(item it) {
	check(it, 1);
}

void tryUse(item it) {
	if (available_amount(it) > 0) use(1, it);
}

/*
effects
*/
boolean have(effect ef) {
	return have_effect(ef).to_boolean();
}

void acquire(effect ef) {
	if (ef != $effect[none]) {
		assert(have(ef) || !ef.default.starts_with("cargo"), `Can't obtain {ef}?`);
		if (!have(ef)) cli_execute(ef.default);
		assert(have(ef), `Failed to acquire effect {ef}`);
	}
}

void check(effect ef) {
	if (ef != $effect[none]) assert(have(ef), `Missing effect {ef}`);
}

/*
character
*/
void ensureMp(int mp) {
    while (my_mp() < mp) {
		if (have($item[psychokinetic energy blob])) {
			use(1, $item[psychokinetic energy blob]);
		} else {
			acquire($item[Doc Galaktik's Invigorating Tonic]);
			use(1, $item[Doc Galaktik's Invigorating Tonic]);
		}
    }
}

void ensureHp(float percent) {
	if (my_hp() < percent * my_maxhp()) {
		ensureMp(mp_cost($skill[Cannelloni Cocoon]));
		use_skill(1, $skill[Cannelloni Cocoon]);
	}
}

void ensureHp() {
	ensureHp(1.0);
}

int [string] clanCache;
void joinClan(string target) {
	if (get_clan_name() != target) {
		if (!(clanCache contains target)) {
			string recruiter = visit_url("clan_signup.php");
			matcher m = create_matcher("<option value=([0-9]+)>([^<]+)</option>", recruiter);
			while (m.find()) {
				clanCache[m.group(2)] = m.group(1).to_int();
			}
		}
		visit_url("showclan.php?whichclan=" + clanCache[target] + "&action=joinclan&confirm=on&pwd=" + my_hash());
		assert(get_clan_name() == target, "Failed to switch clans to " + target + ". Did you spell it correctly? Are you whitelisted?");
	}
}

item [slot] savedGear;
familiar savedFamiliar;

void saveGear(boolean [slot] slots) {
	clear(savedGear);
	foreach s in slots { savedGear[s] = equipped_item(s); }
}

void saveGear() {
	saveGear($slots[hat, back, weapon, off-hand, pants, acc1, acc2, acc3, familiar]);
}

void restoreGear() {
	foreach s, it in savedGear { equip(s, it); }
}

void saveFamiliar() {
	savedFamiliar = my_familiar();
}

void restoreFamiliar() {
	use_familiar(savedFamiliar);
}