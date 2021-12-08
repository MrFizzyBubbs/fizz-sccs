# fizz-sccs

 This is a Kingdom of Loathing script inspired by [seventy-hccs](https://github.com/s-k-z/seventy-hccs) and [c2t_hccs](https://github.com/C2Talon/c2t_hccs) to do 1-day Softcore Community Service runs with minimal resource usage. This script requires a large swath of Mr. Store items and permed skills which are too exhaustive to list here. At present, [Baden](https://cheesellc.com/kol/profile.php?u=Baden) can run this script to achieve a 111 turn run with 0/0(5)/2 organ usage.

 ## Installation

Run this command in KoLmafia's graphical CLI:
```
svn checkout https://github.com/MrFizzyBubbs/fizz-sccs/branches/master/KoLmafia
```

## Requirements

1. Acces to a Slimetube with [Mother Slime](https://kol.coldfront.net/thekolwiki/index.php/Showdown) ready
2. Access to a fully stocked clan [VIP Lounge](https://kol.coldfront.net/thekolwiki/index.php/VIP_Lounge)
3. All 11 beach heads unlocked for the [Beach Comb](https://kol.coldfront.net/thekolwiki/index.php/Beach_Comb)
4. A 100% Weapon damage favorite bird from the [Bird-a-Day calendar](https://kol.coldfront.net/thekolwiki/index.php/Bird-a-Day_calendar)
5. [Chateau Mantegna](https://kol.coldfront.net/thekolwiki/index.php/Chateau_Mantegna) containing:
   - ceiling fan
   - foreign language tapes
   - a piggy bank
6. [Little Geneticist DNA-Splicing Lab](https://kol.coldfront.net/thekolwiki/index.php/Little_Geneticist_DNA-Splicing_Lab) installed into your workshed
7. A [Gold detective badge](https://kol.coldfront.net/thekolwiki/index.php/Gold_detective_badge) purchased from the [11th Precinct](https://kol.coldfront.net/thekolwiki/index.php/The_Precinct)
8. [Your cowboy boots](https://kol.coldfront.net/thekolwiki/index.php/Your_cowboy_boots) from the LT&T Office with nicksilver spurs and frontwinder skin applied (item drops and mysticality stats)
9. A [Peppermint patch](https://kol.coldfront.net/thekolwiki/index.php/A_Peppermint_Patch) growing in your garden
10. [Source Terminal](https://kol.coldfront.net/thekolwiki/index.php/Source_Terminal) fully upgraded
11. [Spacegate Vaccination Machine](https://kol.coldfront.net/thekolwiki/index.php/Spacegate_Vaccination_Machine) with the Broad-Spectrum Vaccine unlocked
12. All 150 [Witchess puzzles](https://kol.coldfront.net/thekolwiki/index.php/Witchess_Puzzles) completed

The script can be run either in Aftercore, or in Community Service provided that the following are selected:

- Astral six-pack from The Deli Lama
- Sauceror class
- Wallaby moon sign

## Usage

1. Ensure you have KoLMafia r25973 or later [available here](https://ci.kolmafia.us/view/all/job/Kolmafia/lastSuccessfulBuild/)
2. Ensure **fizz_sccs.ccs** exists in the the KoLMafia ccs folder
3. Set properties in KoLmafia to appropriate values:
    - fizz_sccs_vipClan - Name of a clan with a fully stocked VIP lounge. Defaults to `'Margaretting Tye'`.
    - fizz_sccs_motherSlimeClan - Name of the clan with Mother Slime ready. Defaults to `'Hobopolis Vacation Home'`.
    - fizz_sccs_haltBeforeTest - A boolean indicating whether or not the script stops before actually doing a quest. Defaults to `false`.
    - fizz_sccs_thresholds - The 10 thresholds corresponding to the minimum turns to allow each quest to take in order of hp, mus, mys, mox, fam, weapon, spell, nc, item, hot. Defaults to `'1,1,1,1,24,1,18,1,1,1'`.

4. Run the script file named **fizz-sccs.ash** using KoLmafia