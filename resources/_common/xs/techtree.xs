include "ability.xs";


//  Initialization
void Init(int playerId = -1)
{
    //  Get Players' Team IDs
    if (xsPlayerAttribute(playerId, cAttributeTeam) > 0)
        return;
    int TeamNum = 0;
    int i = 0;
    int j = 0;
    for (i = 0; <= xsGetNumPlayers())
        if (xsPlayerAttribute(i, cAttributeTeam) == 0)
        {
            TeamNum ++;
            xsResearchTechnology(3149, true, false, i);
            for (j = 0; <= xsGetNumPlayers())
                if (xsPlayerAttribute(j, cAttributeTeam) == 10)
                    SetResource(j, cAttributeTeam, TeamNum);
        }
}


// 10001 - Tech Tree Adjustment (takes effect from feudal age)
void EffectFunction10001(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cFranks:
        {
            //  Enable Bracer
            EnableTech(playerId, 201);
            break;
        }
        case cJapanese:
        {
            //  Enable Bombard Cannon
            EnableTech(playerId, 188);
            break;
        }
        case cChinese:
        {
            EnableTech(playerId, 12);   //  Enable Crop Rotation
            EnableTech(playerId, 37);   //  Enable Cannon Galleon
            EnableTech(playerId, 85);   //  Enable Hand Cannoneer
            EnableTech(playerId, 188);  //  Enable Bombard Cannon
            EnableTech(playerId, 376);  //  Enable Elite Cannon Galleon
            EnableTech(playerId, 875);  //  Enable Gambesons
            EnableTech(playerId, 379);  //  Enable Hoardings
            EnableTech(playerId, 428);  //  Enable Hussar
            break;
        }
        case cByzantines:
        {
            EnableTech(playerId, 50);   //  Enable Masonry
            EnableTech(playerId, 51);   //  Enable Architecture
            break;
        }
        case cTurks:
        {
            //  Enable Steppe Lancer
            EnableTech(playerId, 714);
            EnableTech(playerId, 715);
            //  Elite Steppe Lancer and Heavy Camel Rider upgrades -33% cost
            xsEffectAmount(cModifyTech, 715, cAttrMulAllCosts, 0.666666, playerId);
            xsEffectAmount(cModifyTech, 236, cAttrMulAllCosts, 0.666666, playerId);
            break;
        }
        case cHuns:
        {
            EnableTech(playerId, 714);  //  Enable Steppe Lancer
            break;
        }
        case cMagyars:
        {
            //  Enable Steppe Lancer
            EnableTech(playerId, 714);
            EnableTech(playerId, 715);
            //  Enable Hand Cannoneer
            EnableTech(playerId, 85);
            break;
        }
        case cMalians:
        {
            //  Enable Blast Furnace
            EnableTech(playerId, 75);
        }
        case cBurmese:
        {
            EnableTech(playerId, 85);   //  Enable Hand Cannoneer
            break;
        }
        case cBulgarians:
        {
            EnableTech(playerId, 264);  //  Enable Champion
            break;
        }
        case cCumans:
        {
            EnableTech(playerId, 39);   //  Enable Husbandry
            break;
        }
        default:
        {
          break;
        }
    }
}


// 10002 - Tech Tree Adjustment (takes effect from dark age)
void EffectFunction10002(int playerId = -1)
{
    AbilityApplier();
    Init();

    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cGoths:
        {
            DisableTech(playerId, 127);
            break;
        }
        case cJapanese:
        {
            DisableTech(playerId, 85);  //  Disable Hand Cannoneer
            DisableTech(playerId, 100); //  Disable Crossbowman
            DisableTech(playerId, 151); //  Disable Archer
            DisableTech(playerId, 237); //  Disable Arbalester
            break;
        }
        case cChinese:
        {
            //  Chinese civ bonus, trade units +50% training speed
            MulAttribute(playerId, cTradeBoatClass, cTrainTime, 2.0 / 3);
            MulAttribute(playerId, cTradeCartClass, cTrainTime, 2.0 / 3);
            //  Chinese civ bonus, tech cost discount
            SetResource(playerId, cAttributeResearchCostMod, 0.9);
            //  Chinese +50 start wood
            ModResource(playerId, cAttributeStartingWood, 50);
            break;
        }
        case cByzantines:
        {
            //  Byzantines civ bonus, Free Heresy
            SetTechAuto(playerId, 439);
            break;
        }
        case cPersians:
        {
            DisableTech(playerId, 192);
            DisableTech(playerId, 218);
            //  Persians civ bonus, free market techs
            SetTechAuto(playerId, 48);
            SetTechAuto(playerId, 23);
            SetTechAuto(playerId, 17);
            SetTechAuto(playerId, 15);
            break;
        }
        case cSaracens:
        {
            //  Saracens civ bonus + camel lancer
            MulAttribute(playerId, CamelLancerID, cHitpoints, 1.25);
            MulAttribute(playerId, EliteCamelLancerID, cHitpoints, 1.25);
            break;
        }
        case cTurks:
        {
            xsEffectAmount(cDisableTech, 166, 0, 0, playerId);
            //  Turks civ bonus, cannon galleon on land
            xsEffectAmount(cSetAttribute, CannonGalleonID, cTerrainTable, 0, playerId);
            xsEffectAmount(cSetAttribute, EliteCannonGalleonID, cTerrainTable, 0, playerId);
            break;
        }
        case cVikings:
        {
            DisableTech(playerId, 127);
            break;
        }
        case cMongols:
        {
            //  Mongols civ bonus, cavalries generate gold from attacking buildings
            SetResource(playerId, cAttributeMaintenance, 10003);
            //  Mongols civ bonus, dark age Stable and Scout Cavalry without Barracks
            ForceResearchTech(playerId, 25);
            ForceResearchTech(playerId, 204);
            //  Mongols Knight line replaced by Keshiks
            DisableTech(playerId, 166);
            DisableTech(playerId, 209);
            break;
        }
        case cCelts:
        {
            //  Celts civ bonus, infantries and cavalries harder to be converted
            xsEffectAmount(cAddAttribute, cInfantryClass, cMaxConversionTimeMod, 1, playerId);
            xsEffectAmount(cAddAttribute, cInfantryClass, cMinConversionTimeMod, 1, playerId);
            xsEffectAmount(cAddAttribute, cCavalryClass, cMaxConversionTimeMod, 1, playerId);
            xsEffectAmount(cAddAttribute, cCavalryClass, cMinConversionTimeMod, 1, playerId);
            break;
        }
        case cSpanish:
        {
            //  Enable Genitour
            SetTechAuto(playerId, 601);
            xsEffectAmount(cModifyTech, 599, cAttrSetButton, 26, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrSetHotkey, 18022, playerId);
            //  Spanish civ bonus, Elite Genitour upgrade -50% food cost
            xsEffectAmount(cModifyTech, 599, cAttrMulFoodCost, 0.5, playerId);
            break;
        }
        case cAztecs:
        {
            DisableTech(playerId, 35);
            DisableTech(playerId, 240);
            //  Enable Lembos
            EnableObject(playerId, LembosID);
            break;
        }
        case cMayans:
        {
            //  Disable Mill Techs
            DisableTech(playerId, 12);
            DisableTech(playerId, 13);
            DisableTech(playerId, 14);
            DisableTech(playerId, 35);
            DisableTech(playerId, 240);
            //  Mayans civ bonus, free masonry
            SetTechAuto(playerId, 50);
            //  Mayans civ bonus, get food based on the number of researched techs
            SetResource(playerId, cAttributeTechnologyRewardEffect, 3121);
            //  Mayans civ bonus, farm -60% cost, -50% production
            xsEffectAmount(cModResource, cAttributeFarmFood, 1, -87.5, playerId);
            MulAttribute(playerId, 50, cWoodCost, 0.4);
            //  Enable Lembos
            EnableObject(playerId, LembosID);
            break;
        }
        case cHuns:
        {
            DisableTech(playerId, 127);
            break;
        }
        case cKoreans:
        {
            //  Koreans civ bonus, Treadmill Crane, Murder Holes and Arrowslits -50% cost
            xsEffectAmount(cModifyTech, 54, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, 322, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, 608, cAttrMulAllCosts, 0.5, playerId);
            break;
        }
        case cIndians:
        {
            //  Hindustanis civ bonus, university techs (except unique techs) free, +100% research time
            xsEffectAmount(cModifyTech, 50, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 51, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 54, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 380, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 93, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 47, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 64, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 377, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 322, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 194, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 140, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 63, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 608, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 50, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 51, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 54, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 380, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 93, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 47, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 64, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 377, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 322, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 194, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 140, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 63, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 608, cAttrMulTime, 2, playerId);
            //  曼沙布达尔骑兵替代轻骑兵
            SetTechAuto(playerId, 3146);
            break;
        }
        case cIncas:
        {
            DisableTech(playerId, 35);
            DisableTech(playerId, 240);
            //  印加文明加成, 可蓄养动物视野 +2
            ModAttribute(playerId, cLivestockClass, cLineOfSight, 2);
            //  印加文明加成, 兵营, 靶场, 马厩, 攻城武器厂 +100% 建造速度
            MulAttribute(playerId, 12, cTrainTime, 0.5);
            MulAttribute(playerId, 20, cTrainTime, 0.5);
            MulAttribute(playerId, 132, cTrainTime, 0.5);
            MulAttribute(playerId, 498, cTrainTime, 0.5);
            MulAttribute(playerId, 10, cTrainTime, 0.5);
            MulAttribute(playerId, 14, cTrainTime, 0.5);
            MulAttribute(playerId, 87, cTrainTime, 0.5);
            MulAttribute(playerId, 86, cTrainTime, 0.5);
            MulAttribute(playerId, 101, cTrainTime, 0.5);
            MulAttribute(playerId, 153, cTrainTime, 0.5);
            MulAttribute(playerId, 49, cTrainTime, 0.5);
            MulAttribute(playerId, 150, cTrainTime, 0.5);
            //  小艇
            EnableObject(playerId, LembosID);
            xsEffectAmount(cEnableObject, LembosID, 1, 0, playerId);
            break;
        }
        case cMagyars:
        {
            //  马扎尔文明加成, 可在城堡以 +75% 速度训练单位
            FasterCastleUnits(playerId, 74, 21, 16079);
            FasterCastleUnits(playerId, 75, 21, 16079);
            FasterCastleUnits(playerId, 77, 21, 16079);
            FasterCastleUnits(playerId, 473, 21, 16079);
            FasterCastleUnits(playerId, 567, 21, 16079);
            FasterCastleUnits(playerId, 93, 22, 16068);
            FasterCastleUnits(playerId, 358, 22, 16068);
            FasterCastleUnits(playerId, 359, 22, 16068);
            FasterCastleUnits(playerId, 882, 23, 16085);
            FasterCastleUnits(playerId, 1010, 24, 16086);
            FasterCastleUnits(playerId, 1012, 24, 16086);
            FasterCastleUnits(playerId, 4, 26, 18022);
            FasterCastleUnits(playerId, 24, 26, 18022);
            FasterCastleUnits(playerId, 492, 26, 18022);
            FasterCastleUnits(playerId, 7, 27, 18045);
            FasterCastleUnits(playerId, 6, 27, 18045);
            FasterCastleUnits(playerId, 1155, 27, 18045);
            FasterCastleUnits(playerId, 39, 28, 18008);
            FasterCastleUnits(playerId, 474, 28, 18008);
            FasterCastleUnits(playerId, 448, 31, 18090);
            FasterCastleUnits(playerId, 546, 31, 18090);
            FasterCastleUnits(playerId, 441, 31, 18090);
            FasterCastleUnits(playerId, 1707, 31, 18090);
            FasterCastleUnits(playerId, 38, 32, 18039);
            FasterCastleUnits(playerId, 283, 32, 18039);
            FasterCastleUnits(playerId, 569, 32, 18039);
            FasterCastleUnits(playerId, 1370, 33, 18258);
            FasterCastleUnits(playerId, 1372, 33, 18258);
            break;
        }
        case cPortuguese:
        {
            //  Enable Genitour
            SetTechAuto(playerId, 601);
            xsEffectAmount(cModifyTech, 599, cAttrSetButton, 26, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrSetHotkey, 18022, playerId);
            //  Portuguese civ bonus, Genitour + 2 archer armor
            ModAttack(playerId, 1010, cDamageClassArchers, 2);
            ModAttack(playerId, 1012, cDamageClassArchers, 2);
            break;
        }
        case cMalians:
        {
            //  Malians civ bonus, Hand Cannoneers +66% training speed
            MulAttribute(playerId, cHandCannoneerClass, cTrainTime, 0.6);
            break;
        }
        case cKhmer:
        {
            //  Khmer civ bonus, Monks strengthen Battle Elephants
            SetResource(playerId, cAttributeMaintenance, 10012);
            break;
        }
        case cMalay:
        {
            //  Malay civ bonus, warships generate food
            MalayShipInit(playerId);
            break;
        }
        case cBurmese:
        {
            //  Enable Hand Cannoneer
            EnableTech(playerId, 85);
            break;
        }
        case cVietnamese:
        {
            DisableTech(playerId, 218);  //  Disable Heavy Cavalry Archer
            //  Vietnamese civ bonus + newly added economic techs
            xsEffectAmount(cModifyTech, 3054, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3054, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, 3055, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3055, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, 3056, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3056, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, 3057, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3057, cAttrSetWoodCost, 0, playerId);
            break;
        }
        case cBulgarians:
        {
            //  Bulgarians civ bonus + Military Training
            xsEffectAmount(cModifyTech, 3058, cAttrMulFoodCost, 0.5, playerId);
            break;
        }
        case cTatars:
        {
            //  Tatars Knight line replaced by Keshiks
            DisableTech(playerId, 166);
            DisableTech(playerId, 209);
            //  Tatars civ bonus, Keshiks generate gold
            SetResource(playerId, 213, 75);            
            break;
        }
        case cCumans:
        {
            //  Disable former cavalry movement speed techs
            DisableTech(playerId, 727);
            DisableTech(playerId, 728);
            //  Cumans civ bonus, cavalry techs +200% research speed
            xsEffectAmount(cModifyTech, 80, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 81, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 82, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 67, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 68, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 75, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 39, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 435, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 254, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 428, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 209, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 265, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 526, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 218, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 236, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 521, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 715, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 786, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 1033, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 1589, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 1628, cAttrMulTime, 0.333333, playerId);
            //  Cumans civ bonus, hunters don't need to drop off food
            SetResource(playerId, cAttributeHunterFoodProductivity, 41);
            MulResource(playerId, cAttributeHuntingProductivity, 0.0000000000000001);
            SetResource(playerId, cAttributeMaintenance, 10008);
            break;
        }
        case cLithuanians:
        {
            //  Lithuanians civ bonus, Skirmishers and Genitours upgrade -50% cost, -50% research time
            xsEffectAmount(cModifyTech, 98, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 655, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 98, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, 655, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrMulAllCosts, 0.5, playerId);
            break;
        }
        case cBurgundians:
        {
            //  Bugrundians civ bonus + newly added economic techs
            xsEffectAmount(cModifyTech, 3054, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, 3055, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, 3056, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, 3057, cAttrMulFoodCost, 0.66666667, playerId);
            break;
        }
        case cBohemians:
        {
            //  Bohemians civ bonus, Barrack and Archery Range units + attack bonus
            MulBarrackUnitAttackBonus(playerId, 1.25);
            MulAttackBonus(playerId, SpearmanID, 0.8);
            MulAttackBonus(playerId, PikemanID, 0.8);
            MulAttackBonus(playerId, HalberdierID, 0.8);
            MulArcheryRangeUnitAttackBonus(playerId, 1.25);
            break;
        }
        case cDravidians:
        {
            //  Dravidians civ bonus, advanced Arson, Squires and Gambesons
            ForceEnableTech(playerId, 602);
            break;
        }
        case cBengalis:
        {
            //  Bengalis new civ bonus, cavalries +50% base attack vs skirmishers
            ModAttack(playerId, cScoutCavalryClass, cDamageClassSkirmishers, -2);
            ModAttack(playerId, cCavalryClass, cDamageClassSkirmishers, -2);
            BengalisCavalryVSSkirmisher(playerId);
            //  Bengalis Scout Cavalry line replaced by 
            SetTechAuto(playerId, 3146);
            break;
        }
        case cGurjaras:
        {
            //  Gurjaras civ bonus, Monastries +10 population headroom
            ModAttribute(playerId, 30, cAmountFirstStorage, 10);
            ModAttribute(playerId, 31, cAmountFirstStorage, 10);
            ModAttribute(playerId, 32, cAmountFirstStorage, 10);
            ModAttribute(playerId, 104, cAmountFirstStorage, 10);
            break;
        }
        case cRomans:
        {
            //  Romans civ bonus, walls and gates +100% building speed
            MulAttribute(playerId, cWallClass, cTrainTime, 0.5);
            MulAttribute(playerId, cGateClass, cTrainTime, 0.5);
            break;
        }
        case cGeorgians:
        {
            //  Georgians civ bonus, Repairers +100% work rate
            MulAttribute(playerId, 156, cWorkRate, 2);
            MulAttribute(playerId, 222, cWorkRate, 2);
            break;
        }
        case cShu:
        {
            //  Enable Wubao
            SetTechAuto(playerId, 3016);
            //  Shu civ bonus, infantries generate food from attacking farms
            SetResource(playerId, cAttributeInfantryLootFarmFoodProductivity, 25);
            SetResource(playerId, cAttributeMaintenance, 10010);
            break;
        }
        case cWu:
        {
            //  Enable Wubao
            SetTechAuto(playerId, 3016);
            break;
        }
        case cWei:
        {
            //  Enable Wubao
            SetTechAuto(playerId, 3016);
            break;
        }
        case cJurchens:
        {
            //  Jurchens civ bonus, TC spawns deers
            SetAttribute(playerId, 890, cDeadUnitId, InvisibleDeerSpawnerID);
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, 0.0 - 60.0 / 325);
            break;
        }
        case cKhitans:
        {
            //  Disable newly added economic techs
            DisableTech(playerId, 3054);
            DisableTech(playerId, 3055);
            DisableTech(playerId, 3056);
            DisableTech(playerId, 3057);
            break;
        }
        default:
            break;
    }

    //  Genitour Adjustment
    SetAttribute(playerId, 1010, cTrainButton, 21);
    SetAttribute(playerId, 1010, cHotkeyId, 16079);
    SetAttribute(playerId, 1012, cTrainButton, 21);
    SetAttribute(playerId, 1012, cHotkeyId, 16079);
    //  Missionary Adjustment
    SetAttribute(playerId, 775, cTrainButton, 22);
    SetAttribute(playerId, 775, cHotkeyId, 16078);
    //  Relic gold production, 30 → 45
    MulResource(playerId, cAttributeRelicRate, 1.5);
    //  Varangians Gold Productivity
    SetResource(playerId, cAttributeVarangianLootProductivity, 1);
    //  WarriorPriest Adjustment
    SetAttribute(playerId, WarriorPriestID, cTrainButton, 21);
    SetAttribute(playerId, WarriorPriestID, cHotkeyId, 16079);
    //  Wubao Food and Wood Productivity
    SetResource(playerId, cAttributeWubaoFoodWoodProductivity, 1);
    //  Condottiero Adjustment
    SetAttribute(playerId, CondottieroID, cTrainButton, 21);
    SetAttribute(playerId, CondottieroID, cHotkeyId, 16079);
    //  Taborite Warrior Productivity
    SetResource(playerId, cAttributeTaboriteWarriorProductivity, 1);
    //  Lou Chuan Adjustment
    SetAttribute(playerId, 1948, cTrainButton, 24);
    SetAttribute(playerId, 1948, cHotkeyId, 16106);
    //  Legionary upgrade Adjustment
    xsEffectAmount(cModifyTech, 885, cAttrSetTime, 80, playerId);
    //  Feitoria Adjustment
    SetAttribute(playerId, 1021, cAmountFirstStorage, -15);
    SetAttribute(playerId, 1021, cAmountSecondStorage, 15);
    SetAttribute(playerId, 1021, cAmountThirdStorage, 15);
    //  Some civs' Tithe descriptions adjustment
    if ((playerCiv == cChinese) || (playerCiv == cJapanese) || (playerCiv == cKoreans) || (playerCiv == cVietnamese) || (playerCiv == cBurmese))
    {
        xsEffectAmount(cModifyTech, 3059, cAttrSetName, 500078, playerId);
        xsEffectAmount(cModifyTech, 3059, cAttrSetDescription, 521078, playerId);
    }
    //  Berserks Adjustment
    ModAttribute(playerId, BerserkID, cRegenerationRate, -40);
    ModAttribute(playerId, EliteBerserkID, cRegenerationRate, -40);
    //  Keshik adjustment before Castle Age
    ModAttribute(playerId, KeshikID, cHitpoints, -20);
    ModAttack(playerId, KeshikID, cDamageClassMelee, -2);
    ModAttribute(playerId, KeshikID, cShownAttack, -2);
}


//  10024 - Feudal Age Effect
void EffectFunction10024(int playerId = -1)
{
    //  Knight Adjustment
    ModAttribute(playerId, 38, cHitpoints, -20);
    ModAttack(playerId, 38, cDamageClassMelee, -2);
    ModAttribute(playerId, 38, cShownAttack, -2);
    MulAttribute(playerId, 38, cTrainTime, 4.0 / 3);
    //  Mansabdar Upgrade
    ModAttack(playerId, MansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, MansabdarID, cDamageClassSkirmishers, 1);
    ModAttribute(playerId, MansabdarID, cShownAttack, 2);
    ModAttribute(playerId, MansabdarID, cLineOfSight, 2);
    ModAttribute(playerId, MansabdarID, cSearchRadius, 2);
    ModAttribute(playerId, MansabdarID, cMovementSpeed, 0.3);

    int playerCiv = xsGetPlayerCivilization(playerId);
    switch (playerCiv)
    {
        case cGoths:
        {
            EnableObject(playerId, WoodenFortressID);
            ModResource(playerId, cAttributePopulationCap, 10);
            ModResource(playerId, cAttributeUnitLimit, 10);
            break;
        }
        case cTeutons:
        {
            xsEffectAmount(cAddAttribute, 7, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cSearchRadius, 1, playerId);
            break;
        }
        case cJapanese:
        {
            EnableObject(playerId, YumiAshigaruID);
            break;
        }
        case cChinese:
        {
            SetResource(playerId, cAttributeResearchCostMod, 0.85);
            break;
        }
        case cByzantines:
        {
            MulAttribute(playerId, cBuildingClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cWallClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cGateClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cFarmClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cTowerClass, cHitpoints, 1.15 / 1.19999);
            break;
        }
        case cPersians:
        {
            EnableObject(playerId, ParthianCavalryArcherID);
            SetAttribute(playerId, InvisiblePCAID, cRegenerationHpPercent, -30);
            SetAttribute(playerId, InvisibleEPCAID, cRegenerationHpPercent, -30);
            break;
        }
        case cVikings:
        {
            EnableObject(playerId, WoodenFortressID); 
            break;
        }
        case cMongols:
        {
            //  Mongols civ bonus, advanced Keshik
            ForceResearchTech(playerId, 679);
            break;
        }
        case cSpanish:
        {
            //  Spanish civ bonus, advanced Genitour
            ForceResearchTech(playerId, 601);
            break;
        }
        case cAztecs:
        {
            //  Enable Shrine
            SetAttribute(playerId, ShrineID, cAvailableFlag, 1);
            SetAttribute(playerId, ShrineID, cDisabledFlag, 4);
            break;
        }
        case cMayans:
        {
            //  Enable Shrine
            SetAttribute(playerId, ShrineID, cAvailableFlag, 1);
            SetAttribute(playerId, ShrineID, cDisabledFlag, 4);
            break;
        }
        case cHuns:
        {
            EnableObject(playerId, EarlyCavalryArcherID);
            EnableObject(playerId, WoodenFortressID); 
            break;
        }
        case cIndians:
        {
            xsEffectAmount(cUpgradeUnit, 448, MansabdarID, 0, playerId);
            break;
        }
        case cIncas:
        {
            //  Enable Shrine
            SetAttribute(playerId, ShrineID, cAvailableFlag, 1);
            SetAttribute(playerId, ShrineID, cDisabledFlag, 4);
            break;
        }
        case cBurgundians:
        {
            EnableObject(playerId, KnightID);
            break;
        }
        case cPoles:
        {
            //  Poles civ bonus, advanced Light Cavalry
            ForceEnableTech(playerId, 254);
            break;
        }
        case cDravidians:
        {
            ForceEnableTech(playerId, 215);
            ForceEnableTech(playerId, 875);
            break;
        }
        case cBengalis:
        {
            xsEffectAmount(cUpgradeUnit, 448, MansabdarID, 0, playerId);
            break;
        }
        case cRomans:
        {
            //  Romans civ bonus, Feudal Age Monastery and Monk
            EnableObject(playerId, 104);
            EnableObject(playerId, 125);
            break;
        }
        case cWu:
        {
            SetResource(playerId, cAttributeWubaoGoldProductivity, 10);
            break;
        }
        case cWei:
        {
            ModAttribute(playerId, WubaoID, cAvailableFlag, 1);
            break;
        }
        case cJurchens:
        {
            EnableObject(playerId, ConscriptedArmyID);
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, 0.0 - 60.0 / 275);
            break;
        }
        default:
            break;
    }
}


//  10025 - Castle Age effect
void EffectFunction10025(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cBritons:
        {
            EnableObject(playerId, HobelarID);
            break;
        }
        case cGoths:
        {
            ModResource(playerId, cAttributePopulationCap, 5);
            ModResource(playerId, cAttributeUnitLimit, 5);
            break;
        }
        case cTeutons:
        {
            xsEffectAmount(cAddAttribute, 7, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cSearchRadius, 1, playerId);
            xsEffectAmount(cEnableObject, CrusaderKnightID, 1, 0, playerId);
            xsEffectAmount(cAddAttribute, CrusaderKnightID, cArmor, 4 * 256 + 1, playerId);
            break;
        }
        case cChinese:
        {
            SetResource(playerId, cAttributeResearchCostMod, 0.8);
            EnableObject(playerId, FlameThrowerID);
            break;
        }
        case cByzantines:
        {
            EnableObject(playerId, VarangianID);
            MulAttribute(playerId, cBuildingClass, cHitpoints, 1.2 / 1.25);
            MulAttribute(playerId, cWallClass, cHitpoints, 1.2 / 1.25);
            MulAttribute(playerId, cGateClass, cHitpoints, 1.2 / 1.25);
            MulAttribute(playerId, cFarmClass, cHitpoints, 1.2 / 1.25);
            MulAttribute(playerId, cTowerClass, cHitpoints, 1.2 / 1.25);
            EnableObject(playerId, FlameThrowerID);
            SetAttribute(playerId, FlameThrowerID, cNameId, 700042);
            SetAttribute(playerId, FlameThrowerID, cDescriptionId, 701042);
            SetTechStack(playerId, 3139, 32767);
            SetResource(playerId, cAttributeRecruitMercenaryCost, 75);
            break;
        }
        case cPersians:
        {
            EnableObject(playerId, AssassinID);
            break;
        }
        case cSaracens:
        {
            EnableObject(playerId, AssassinID);
            break;
        }
        case cTurks:
        {
            EnableObject(playerId, SipahiID);
            break;
        }
        case cMongols:
        {
            //  Mongols civ bonus, advanced Elite Keshik
            ForceEnableTech(playerId, 680);
            break;
        }
        case cSpanish:
        {
            ForceEnableTech(playerId, 599);
            xsEffectAmount(cUpgradeUnit, 17, ManilaGalleonID, -1, playerId);
            break;
        }
        case cAztecs:
        {
            MulAttribute(playerId, 4, cMovementSpeed, 1.05);
            MulAttribute(playerId, 24, cMovementSpeed, 1.05);
            MulAttribute(playerId, 492, cMovementSpeed, 1.05);
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cMayans:
        {
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cHuns:
        {
            xsEffectAmount(cUpgradeUnit, EarlyCavalryArcherID, CavalryArcherID, -1, playerId);   //  upgrade to cavalry archer
            break;
        }
        case cItalians:
        {
            //  Italians civ bonus, purchase relics
            xsEffectAmount(cModifyTech, 3099, cAttrSetStacking, 1, playerId);
            xsEffectAmount(cModifyTech, 3099, cAttrSetStackingResearchCap, 4, playerId);
            SetResource(playerId, cAttributeRelicPurchaseLimit, 2);
            //  Enable Hospitaller Knight
            SetTechAuto(playerId, 3038);
            break;
        }
        case cIncas:
        {
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cSlavs:
        {
            ModAttack(playerId, KnightID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, CavalierID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, PaladinID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, SavarID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, FireLancerCavalryID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, BoyarID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, EliteBoyarID, cDamageClassStandardBuildings, 2);
            xsEffectAmount(cMulAttribute, SiegeWorkshopID, cWorkRate, 1.25, playerId);
            xsEffectAmount(cMulAttribute, SiegeWorkshop4ID, cWorkRate, 1.25, playerId);
            break;
        }
        case cEthiopians:
        {
            ModResource(playerId, cAttributeFood, 100);
            ModResource(playerId, cAttributeGold, 100);
            //  Enable Battle Elephant
            ForceResearchTech(playerId, 630);
            break;
        }
        case cMalians:
        {
            //  Enable Sofa
            EnableObject(playerId, SofaID);
            break;
        }
        case cBerbers:
        {
            MulAttribute(playerId, cVillagerClass, cMovementSpeed, 1.15 / 1.1);
            break;
        }
        case cBurmese:
        {
            EnableObject(playerId, ToungooWarriorID);
            break;
        }
        case cVietnamese:
        {
            EnableObject(playerId, RungScoutID);
            break;
        }
        case cTatars:
        {
            ModArmor(playerId, cCavalryArcherClass, cDamageClassPierce, 1);
            //  Enable Khan
            SetAttribute(playerId, KhanID, cAvailableFlag, 1);
            SetAttribute(playerId, KhanID, cDisabledFlag, 4);
            break;
        }
        case cCumans:
        {
            MulAttribute(playerId, cScoutCavalryClass, cMovementSpeed, 1.07 / 1.05);
            MulAttribute(playerId, cCavalryClass, cMovementSpeed, 1.07 / 1.05);
            MulAttribute(playerId, cCavalryArcherClass, cMovementSpeed, 1.07 / 1.05);
            MulAttribute(playerId, cConquistadorClass, cMovementSpeed, 1.07 / 1.05);
            break;
        }
        case cSicilians:
        {
            //  Enable Hospitaller Knight
            SetTechAuto(playerId, 3038);
            break;
        }
        case cBohemians:
        {
            EnableObject(playerId, ChariotArcherID);
            break;
        }
        case cDravidians:
        {
            ModResource(playerId, cAttributeWood, 150.0);
            ModAttribute(playerId, cMonkClass, cMaxRange, 1);
            ModAttribute(playerId, cMonkClass, cLineOfSight, 1);
            ModAttribute(playerId, cMonkClass, cSearchRadius, 1);
            break;
        }
        case cGeorgians:
        {
            EnableObject(playerId, KhevsuretiWarriorID);
            break;
        }
        case cWu:
        {
            SetResource(playerId, cAttributeWubaoGoldProductivity, 15);
            break;
        }
        case cWei:
        {
            ModAttribute(playerId, WubaoID, cAvailableFlag, 1);
            break;
        }
        case cJurchens:
        {
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, 0.0 - 60.0 / 225);
            break;
        }
        default:
            break;
    }

    //  Wubao Upgrade
    ModAttribute(playerId, WubaoID, cHitpoints, 300);
    //  Lembos Upgrade
    ModAttribute(playerId, LembosID, cHitpoints, 15);
    ModAttack(playerId, LembosID, cDamageClassPierce, 1);
    ModAttack(playerId, LembosID, cDamageClassShips, 1);
    ModAttack(playerId, LembosID, cDamageClassFishingShips, 1);
    //  Knight Upgrade
    ModAttribute(playerId, 38, cHitpoints, 20);
    ModAttack(playerId, 38, cDamageClassMelee, 2);
    ModAttribute(playerId, 38, cShownAttack, 2);
    MulAttribute(playerId, 38, cTrainTime, 0.75);
    //  Kheshik Upgrade
    ModAttribute(playerId, KeshikID, cHitpoints, 20);
    ModAttack(playerId, KeshikID, cDamageClassMelee, 2);
    ModAttribute(playerId, KeshikID, cShownAttack, 2);
    KeshikStingerCastleAgeUpgrade(playerId);
    //  Conscripted Army Upgrade
    ModAttribute(playerId, ConscriptedArmyID, cMovementSpeed, 0.1);
    ModAttribute(playerId, ExtraConscriptedArmyID, cMovementSpeed, 0.1);
}


//  10026 - Imperial Age effect
void EffectFunction10026(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cFranks:
        {
            EnableObject(playerId, SwissLancerID);
            break;
        }
        case cGoths:
        {
            ModResource(playerId, cAttributePopulationCap, 5);
            ModResource(playerId, cAttributeUnitLimit, -5);
            break;
        }
        case cTeutons:
        {
            xsEffectAmount(cAddAttribute, 7, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cSearchRadius, 1, playerId);
            ModArmor(playerId, CrusaderKnightID, cDamageClassMelee, 1);
            break;
        }
        case cChinese:
        {
            SetResource(playerId, cAttributeResearchCostMod, 0.75);
            break;
        }
        case cByzantines:
        {
            MulAttribute(playerId, cBuildingClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cWallClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cGateClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cFarmClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cTowerClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            break;
        }
        case cAztecs:
        {
            MulAttribute(playerId, 4, cMovementSpeed, 1.1 / 1.05);
            MulAttribute(playerId, 24, cMovementSpeed, 1.1 / 1.05);
            MulAttribute(playerId, 492, cMovementSpeed, 1.1 / 1.05);
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cMayans:
        {
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cIncas:
        {
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cSlavs:
        {
            ModAttack(playerId, KnightID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, CavalierID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, PaladinID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, SavarID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, FireLancerCavalryID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, BoyarID, cDamageClassStandardBuildings, 2);
            ModAttack(playerId, EliteBoyarID, cDamageClassStandardBuildings, 2);
            xsEffectAmount(cMulAttribute, SiegeWorkshopID, cWorkRate, 1.2, playerId);
            xsEffectAmount(cMulAttribute, SiegeWorkshop4ID, cWorkRate, 1.2, playerId);
            break;
        }
        case cEthiopians:
        {
            ModResource(playerId, cAttributeFood, 200);
            ModResource(playerId, cAttributeGold, 200);
            break;
        }
        case cBerbers:
        {
            MulAttribute(playerId, cVillagerClass, cMovementSpeed, 1.2 / 1.15);
            break;
        }
        case cTatars:
        {
            ModArmor(playerId, cCavalryArcherClass, cDamageClassPierce, 1);
            break;
        }
        case cCumans:
        {
            MulAttribute(playerId, cScoutCavalryClass, cMovementSpeed, 1.01869159);
            MulAttribute(playerId, cCavalryClass, cMovementSpeed, 1.01869159);
            MulAttribute(playerId, cCavalryArcherClass, cMovementSpeed, 1.01869159);
            MulAttribute(playerId, cConquistadorClass, cMovementSpeed, 1.01869159);
            break;
        }
        case cDravidians:
        {
            ModResource(playerId, cAttributeWood, 300.0);
            ModAttribute(playerId, cMonkClass, cMaxRange, 1);
            ModAttribute(playerId, cMonkClass, cLineOfSight, 1);
            ModAttribute(playerId, cMonkClass, cSearchRadius, 1);
            break;
        }
        case cWu:
        {
            SetResource(playerId, cAttributeWubaoGoldProductivity, 20);
            break;
        }
        case cWei:
        {
            ModAttribute(playerId, WubaoID, cAvailableFlag, 1);
            break;
        }
        case cJurchens:
        {
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, 0.0 - 60.0 / 175);
            break;
        }
        default:
            break;
    }

    //  Assassin Upgrade
    ModAttribute(playerId, AssassinID, cHitpoints, 15);
    ModAttack(playerId, AssassinID, cDamageClassMelee, 15);
    ModAttribute(playerId, AssassinID, cShownAttack, 15);
    //  Wubao Upgrade
    ModAttribute(playerId, WubaoID, cHitpoints, 300);
    //  Manila Galleon Upgrade
    ModAttribute(playerId, ManilaGalleonID, cHitpoints, 20);
    ModAttack(playerId, ManilaGalleonID, cDamageClassPierce, 1);
    ModAttack(playerId, ManilaGalleonID, cDamageClassShips, 1);
    ModArmor(playerId, ManilaGalleonID, cDamageClassShips, 1);
    //  Lembos Upgrade
    ModAttribute(playerId, LembosID, cHitpoints, 15);
    ModAttack(playerId, LembosID, cDamageClassPierce, 1);
    ModAttack(playerId, LembosID, cDamageClassShips, 1);
    ModAttack(playerId, LembosID, cDamageClassFishingShips, 1);
    //  Chariot Archer Upgrade
    LaunchAura(playerId, ChariotArcherID);
    //  Khan Upgrade
    ModAttack(playerId, KhanID, cDamageClassPierce, 2);
    //  Conscripted Army upgrade
    ModAttribute(playerId, ConscriptedArmyID, cMovementSpeed, 0.1);
    ModAttribute(playerId, ExtraConscriptedArmyID, cMovementSpeed, 0.1);
}


//  Feudal Age start effect
void EffectFunction10061(int playerId = -1)
{
}


//  Castle Age start effect
void EffectFunction10062(int playerId = -1)
{
}


//  Imperial Age start effect
void EffectFunction10063(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cIndians:
        {
            //  Automatically research Veteran Mansabdar
            ForceResearchTech(playerId, 3147);
            break;
        }
        case cBengalis:
        {
            //  Automatically research Veteran Mansabdar
            ForceResearchTech(playerId, 3147);
            break;
        }
        default:
            break;
    }
}


//  Post Imperial Age start effect
void EffectFunction10064(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cIndians:
        {
            //  Automatically research Elite Mansabdar
            ForceResearchTech(playerId, 3148);
            break;
        }
        case cBengalis:
        {
            //  Automatically research Elite Mansabdar
            ForceResearchTech(playerId, 3148);
            break;
        }
        default:
            break;
    }
}