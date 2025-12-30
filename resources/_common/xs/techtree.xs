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
}


// 10002 - Tech Tree Adjustment (takes effect from dark age)
void EffectFunction10002(int playerId = -1)
{
    AbilityApplier(playerId);
    Init();
    int playerCiv = xsGetPlayerCivilization(playerId);

    //  Some civs' Tithe descriptions adjustment
    if ((playerCiv == cChinese) || (playerCiv == cJapanese) || (playerCiv == cKoreans) || (playerCiv == cVietnamese) || (playerCiv == cBurmese))
    {
        xsEffectAmount(cModifyTech, TitheTechID, cAttrSetName, 500078, playerId);
        xsEffectAmount(cModifyTech, TitheTechID, cAttrSetDescription, 521078, playerId);
    }
    //  Khan
    SetAttribute(playerId, KhanID, cDisabledFlag, 1);

    switch (playerCiv)
    {
        case cChinese:
        {
            //  Chinese civ bonus, tech cost discount
            SetResource(playerId, cAttributeResearchCostMod, 0.95);
            DisableTech(playerId, 350);
            DisableTech(playerId, 351);
            DisableTech(playerId, 352);
            //  Chinese +50 start wood
            ModResource(playerId, cAttributeStartingWood, 50);
            SetResource(playerId, cAttributeExclusiveTechFlag, 1);
            DisableTech(playerId, GuanNingCavalryTechID);
            break;
        }
        case cPersians:
        {
            DisableTech(playerId, CavalryArcherTechID);
            DisableTech(playerId, HeavyCavalryArcherTechID);
            //  Persians civ bonus, free market techs
            SetTechAuto(playerId, CaravanTechID);
            SetTechAuto(playerId, CoinageTechID);
            SetTechAuto(playerId, BankingTechID);
            SetTechAuto(playerId, GuildsTechID);
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
            //  Knight line replaced by Sipahi
            UpgradeUnit(playerId, KnightID, SipahiID);
            xsEffectAmount(cModifyTech, CavalierTechID, cAttrSetEffect, 3013, playerId);
            xsEffectAmount(cModifyTech, CavalierTechID, cAttrSetFoodCost, 450, playerId);
            xsEffectAmount(cModifyTech, CavalierTechID, cAttrSetGoldCost, 300, playerId);
            xsEffectAmount(cModifyTech, CavalierTechID, cAttrSetTime, 80, playerId);
            xsEffectAmount(cModifyTech, CavalierTechID, cAttrSetIcon, 105, playerId);
            xsEffectAmount(cModifyTech, CavalierTechID, cAttrSetName, 500011, playerId);
            xsEffectAmount(cModifyTech, CavalierTechID, cAttrSetDescription, 521011, playerId);
            //  Turks civ bonus, cannon galleon on land
            xsEffectAmount(cSetAttribute, CannonGalleonID, cTerrainTable, 0, playerId);
            xsEffectAmount(cSetAttribute, EliteCannonGalleonID, cTerrainTable, 0, playerId);
            //  Elite Steppe Lancer and Heavy Camel Rider upgrades -33% cost
            xsEffectAmount(cModifyTech, EliteSteppeLancerTechID, cAttrMulAllCosts, 0.666666, playerId);
            xsEffectAmount(cModifyTech, HeavyCamelTechID, cAttrMulAllCosts, 0.666666, playerId);
            break;
        }
        case cVikings:
        {
            DisableTech(playerId, WatchTowerTechID);
            EnableObject(playerId, VikingRaiderID);
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
            SetTechAuto(playerId, GenitourTechID);
            xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrSetButton, 26, playerId);
            xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrSetHotkey, 18022, playerId);
            //  Spanish civ bonus, Elite Genitour upgrade -50% food cost
            xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrMulFoodCost, 0.5, playerId);
            break;
        }
        case cAztecs:
        {
            DisableTech(playerId, GalleonTechID);
            DisableTech(playerId, GalleyTechID);
            DisableTech(playerId, GoldShaftMiningTechID);
            DisableTech(playerId, StoneShaftMiningTechID);
            //  Enable Lembos
            EnableObject(playerId, LembosID);
            break;
        }
        case cMayans:
        {
            //  Disable Mill Techs
            DisableTech(playerId, GalleonTechID);
            DisableTech(playerId, GalleyTechID);
            DisableTech(playerId, StoneShaftMiningTechID);
            DisableTech(playerId, CropRotationTechID);
            //  Mayans civ bonus, free masonry
            SetTechAuto(playerId, MasonryTechID);
            //  Mayans civ bonus, get food based on the number of researched techs
            SetResource(playerId, cAttributeTechnologyRewardEffect, 3121);
            //  Enable Lembos
            EnableObject(playerId, LembosID);
            break;
        }
        case cHuns:
        {
            DisableTech(playerId, WatchTowerTechID);
            break;
        }
        case cKoreans:
        {
            //  Koreans civ bonus, Treadmill Crane, Murder Holes and Arrowslits -50% cost
            xsEffectAmount(cModifyTech, TreadmillCraneTechID, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, MurderHolesTechID, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, ArrowslitsTechID, cAttrMulAllCosts, 0.5, playerId);
            break;
        }
        case cIndians:
        {
            //  Hindustanis civ bonus, university techs (except unique techs) free, +100% research time
            xsEffectAmount(cModifyTech, MasonryTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, ArchitectureTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, TreadmillCraneTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, HeatedShotTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, BallisticsTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, ChemistryTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, BombardTowerTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, SiegeEngineersTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, MurderHolesTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, FortifiedWallTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, GuardTowerTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, KeepTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, ArrowslitsTechID, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, MasonryTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, ArchitectureTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, TreadmillCraneTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, HeatedShotTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, BallisticsTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, ChemistryTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, BombardTowerTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, SiegeEngineersTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, MurderHolesTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, FortifiedWallTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, GuardTowerTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, KeepTechID, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, ArrowslitsTechID, cAttrMulTime, 2, playerId);
            //  Scout Cavalry Line replaced by Mansabdars
            UpgradeUnit(playerId, ScoutCavalryID, MansabdarID);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetEffect, 3134, playerId);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetTime, 30, playerId);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetName, 500095, playerId);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetDescription, 521095, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetEffect, 3135, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetFoodCost, 800, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetGoldCost, 500, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetIcon, 105, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetTime, 60, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetName, 500096, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetDescription, 521096, playerId);
            break;
        }
        case cIncas:
        {
            DisableTech(playerId, GalleonTechID);
            DisableTech(playerId, GalleyTechID);
            DisableTech(playerId, GoldShaftMiningTechID);
            DisableTech(playerId, StoneShaftMiningTechID);
            ModAttribute(playerId, cLivestockClass, cLineOfSight, 2);
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
            FasterCastleUnits(playerId, HandCannoneerID, 29, 18034);
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
            SetTechAuto(playerId, GenitourTechID);
            xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrSetButton, 26, playerId);
            xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrSetHotkey, 18022, playerId);
            //  Portuguese civ bonus, Genitour + 2 archer armor
            ModAttack(playerId, GenitourID, cDamageClassArchers, 2);
            ModAttack(playerId, EliteGenitourID, cDamageClassArchers, 2);
            break;
        }
        case cMalians:
        {
            //  Malians civ bonus, Hand Cannoneers +66% training speed
            MulAttribute(playerId, cHandCannoneerClass, cTrainTime, 0.6);
            xsEffectAmount(cModifyTech, PikemanTechID, cAttrSetName, 500121, playerId);
            xsEffectAmount(cModifyTech, PikemanTechID, cAttrSetDescription, 521121, playerId);
            xsEffectAmount(cModifyTech, PikemanTechID, cAttrSetTime, 30, playerId);
            xsEffectAmount(cModifyTech, PikemanTechID, cAttrSetEffect, 3185, playerId);
            xsEffectAmount(cModifyTech, HalberdierTechID, cAttrSetName, 500122, playerId);
            xsEffectAmount(cModifyTech, HalberdierTechID, cAttrSetDescription, 521122, playerId);
            xsEffectAmount(cModifyTech, HalberdierTechID, cAttrSetTime, 45, playerId);
            xsEffectAmount(cModifyTech, HalberdierTechID, cAttrSetEffect, 3186, playerId);
            xsEffectAmount(cModifyTech, HalberdierTechID, cAttrSetIcon, 105, playerId);
            xsEffectAmount(cUpgradeUnit, SpearmanID, DonsoID, 0, playerId);
            break;
        }
        case cKhmer:
        {
            //  Khmer civ bonus, Monks strengthen Battle Elephants
            SetResource(playerId, cAttributeMaintenance, 10012);
            DisableTech(playerId, CavalryArcherTechID);
            DisableTech(playerId, HeavyCavalryArcherTechID);
            //  Khmer civ bonus, Elephant Archers +10% movement speed
            MulAttribute(playerId, ElephantArcherID, cMovementSpeed, 1.1);
            MulAttribute(playerId, EliteElephantArcherID, cMovementSpeed, 1.1);
            MulAttribute(playerId, EarlyElephantArcherID, cMovementSpeed, 1.1);
            //  Early Elehpant Archer
            ModAttribute(playerId, ElephantArcherID, cHitpoints, -100);
            SetAttribute(playerId, ElephantArcherID, cNameId, 700055);
            SetAttribute(playerId, ElephantArcherID, cDescriptionId, 701055);
            ModAttack(playerId, ElephantArcherID, cDamageClassPierce, -1);
            ModArmor(playerId, ElephantArcherID, cDamageClassPierce, -1);
            ModAttribute(playerId, ElephantArcherID, cShownAttack, -1);
            ModAttribute(playerId, ElephantArcherID, cShownPierceArmor, -1);
            ModAttribute(playerId, ElephantArcherID, cAccuracyPercent, -15);
            DisableTech(playerId, EliteElephantArcherTechID);
            break;
        }
        case cMalay:
        {
            //  Malay civ bonus, warships generate food
            MalayShipInit(playerId);
            DisableTech(playerId, CavalryArcherTechID);
            break;
        }
        case cBurmese:
        {
            DisableTech(playerId, DryDockTechID);
            break;
        }
        case cVietnamese:
        {
            DisableTech(playerId, CavalryArcherTechID);
            DisableTech(playerId, HeavyCavalryArcherTechID);
            //  Vietnamese civ bonus + newly added economic techs
            xsEffectAmount(cModifyTech, HorticultureTechID, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, HorticultureTechID, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, FertilizationTechID, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, FertilizationTechID, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, BreedingTechID, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, BreedingTechID, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, CashCropTechID, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, CashCropTechID, cAttrSetWoodCost, 0, playerId);
            break;
        }
        case cBulgarians:
        {
            //  Bulgarians civ bonus + Military Training
            xsEffectAmount(cModifyTech, MilitaryTrainingTechID, cAttrMulFoodCost, 0.5, playerId);
            break;
        }
        case cCumans:
        {
            //  Disable former cavalry movement speed techs
            DisableTech(playerId, 727);
            DisableTech(playerId, 728);
            //  Cumans civ bonus, Barracks -75 wood cost
            ModAttribute(playerId, BarracksID, cWoodCost, -75);
            ModAttribute(playerId, Barracks2ID, cWoodCost, -75);
            ModAttribute(playerId, Barracks3ID, cWoodCost, -75);
            ModAttribute(playerId, Barracks4ID, cWoodCost, -75);
            //  Cumans civ bonus, hunters don't need to drop off food
            SetResource(playerId, cAttributeHunterFoodProductivity, 41);
            MulResource(playerId, cAttributeHuntingProductivity, 0.0000000000000001);
            SetResource(playerId, cAttributeMaintenance, 10008);
            break;
        }
        case cLithuanians:
        {
            //  Lithuanians civ bonus, Skirmishers and Genitours upgrade -50% cost, -50% research time
            xsEffectAmount(cModifyTech, EliteSkirmisherTechID, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, ImperialSkirmisherTechID, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, EliteSkirmisherTechID, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, ImperialSkirmisherTechID, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrMulAllCosts, 0.5, playerId);
            break;
        }
        case cBurgundians:
        {
            //  Bugrundians civ bonus + newly added economic techs
            xsEffectAmount(cModifyTech, HorticultureTechID, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, FertilizationTechID, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, BreedingTechID, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, CashCropTechID, cAttrMulFoodCost, 0.66666667, playerId);
            break;
        }
        case cBohemians:
        {
            //  Bohemians civ bonus, Barrack and Archery Range units + attack bonus
            MulAttackBonus(playerId, cInfantryClass, 1.25);
            MulAttackBonus(playerId, cArcherClass, 1.25);
            MulAttackBonus(playerId, cCavalryArcherClass, 1.25);
            MulAttackBonus(playerId, cHandCannoneerClass, 1.25);
            MulAttackBonus(playerId, SpearmanID, 0.8);
            MulAttackBonus(playerId, PikemanID, 0.8);
            MulAttackBonus(playerId, HalberdierID, 0.8);
            break;
        }
        case cDravidians:
        {
            //  Dravidians civ bonus, advanced Arson, Squires and Gambesons
            ForceEnableTech(playerId, ArsonTechID);
            break;
        }
        case cBengalis:
        {
            //  Bengalis new civ bonus, cavalries +50% base attack vs skirmishers
            ModAttack(playerId, cScoutCavalryClass, cDamageClassSkirmishers, -2);
            ModAttack(playerId, cCavalryClass, cDamageClassSkirmishers, -2);
            BengalisCavalryVSSkirmisher(playerId);
            //  Bengalis Scout Cavalry line replaced by Mansabdars
            UpgradeUnit(playerId, ScoutCavalryID, MansabdarID);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetEffect, 3134, playerId);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetTime, 30, playerId);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetName, 500095, playerId);
            xsEffectAmount(cModifyTech, LightCavalryTechID, cAttrSetDescription, 521095, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetEffect, 3135, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetFoodCost, 800, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetGoldCost, 500, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetIcon, 105, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetTime, 60, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetName, 500096, playerId);
            xsEffectAmount(cModifyTech, HussarTechID, cAttrSetDescription, 521096, playerId);
            break;
        }
        case cGurjaras:
        {
            //  Gurjaras civ bonus, Monastries +10 population headroom
            ModAttribute(playerId, MonasteryID, cAmountFirstStorage, 10);
            ModAttribute(playerId, Monastery2ID, cAmountFirstStorage, 10);
            ModAttribute(playerId, Monastery3ID, cAmountFirstStorage, 10);
            ModAttribute(playerId, Monastery4ID, cAmountFirstStorage, 10);
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
            MulAttribute(playerId, MaleRepairerID, cWorkRate, 2);
            MulAttribute(playerId, FemaleRepairerID, cWorkRate, 2);
            break;
        }
        case cShu:
        {
            SetTechAuto(playerId, WubaoTechID);
            //  Shu civ bonus, Wubao -20% cost
            MulAttribute(playerId, WubaoID, cResourceCost, 0.8);
            //  Shu civ bonus, infantries generate food from attacking farms
            SetResource(playerId, cAttributeInfantryLootFarmFoodProductivity, 25);
            SetResource(playerId, cAttributeMaintenance, 10010);
            break;
        }
        case cWu:
        {
            //  Enable Wubao
            SetTechAuto(playerId, WubaoTechID);
            //  Wu civ bonus, Wubao technologies -33% cost
            xsEffectAmount(cModifyTech, GentryTechID, cAttrMulAllCosts, 0.67, playerId);
            xsEffectAmount(cModifyTech, MercenaryTechID, cAttrMulAllCosts, 0.67, playerId);
            xsEffectAmount(cModifyTech, StrongFortressTechID, cAttrMulAllCosts, 0.67, playerId);
            break;
        }
        case cWei:
        {
            //  Enable Wubao
            SetTechAuto(playerId, WubaoTechID);
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
            DisableTech(playerId, HorticultureTechID);
            DisableTech(playerId, FertilizationTechID);
            DisableTech(playerId, BreedingTechID);
            DisableTech(playerId, CashCropTechID);
            break;
        }
        default:
            break;
    }
}


//  10024 - Feudal Age Effect
void EffectFunction10024(int playerId = -1)
{
    //  Mansabdar Upgrade
    ModAttack(playerId, MansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, MansabdarID, cDamageClassSkirmishers, 1);
    ModAttribute(playerId, MansabdarID, cShownAttack, 2);
    ModAttribute(playerId, MansabdarID, cLineOfSight, 2);
    ModAttribute(playerId, MansabdarID, cSearchRadius, 2);
    ModAttribute(playerId, MansabdarID, cMovementSpeed, 0.3);
    //  Wubao Upgrade
    ModAttribute(playerId, WubaoID, cHitpoints, 250);

    int playerCiv = xsGetPlayerCivilization(playerId);
    switch (playerCiv)
    {
        case cChinese:
        {
            ModResource(playerId, cAttributeResearchCostMod, -0.05);
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
            break;
        }
        case cMongols:
        {
            //  Mongols civ bonus, advanced Keshik
            //  ForceResearchTech(playerId, KnightTechID);
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
            break;
        }
        case cItalians:
        {
            ModResource(playerId, cAttributeGoldGeneration, 15);
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
        case cMalians:
        {
            //  Enable Donso
            ModArmor(playerId, DonsoID, cDamageClassPierce, 1);
            ModArmor(playerId, VeteranDonsoID, cDamageClassPierce, 1);
            ModArmor(playerId, EliteDonsoID, cDamageClassPierce, 1);
            break;
        }
        case cKhmer:
        {
            ForceResearchTech(playerId, ElephantArcherTechID);
            break;
        }
        case cBulgarians:
        {
            ModAttack(playerId, cCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cCavalryClass, cDamageClassCamelUnits, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCamelUnits, 1);
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
        case cPoles:
        {
            //  Poles civ bonus, advanced Light Cavalry
            ForceEnableTech(playerId, LightCavalryTechID);
            break;
        }
        case cDravidians:
        {
            ForceEnableTech(playerId, SquiresTechID);
            ForceEnableTech(playerId, GambesonsTechID);
            break;
        }
        case cBengalis:
        {
            xsEffectAmount(cUpgradeUnit, ScoutCavalryID, MansabdarID, 0, playerId);
            break;
        }
        case cRomans:
        {
            //  Romans civ bonus, Feudal Age Monastery and Monk
            EnableObject(playerId, MonasteryID);
            EnableObject(playerId, MonkID);
            break;
        }
        case cGeorgians:
        {
            ModAttribute(playerId, cCavalryClass, cRegenerationRate, 3);
            ModAttribute(playerId, cScoutCavalryClass, cRegenerationRate, 3);
            ModAttribute(playerId, cConquistadorClass, cRegenerationRate, 3);
            ModAttribute(playerId, cCavalryArcherClass, cRegenerationRate, 3);
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
        case cTeutons:
        {
            EnableObject(playerId, CrusaderKnightID);
            ModArmor(playerId, CrusaderKnightID, cDamageClassMelee, 1);
            break;
        }
        case cChinese:
        {
            ModResource(playerId, cAttributeResearchCostMod, -0.05);
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
        case cMongols:
        {
            //  Mongols civ bonus, advanced Elite Keshik
            //  ForceEnableTech(playerId, CavalierTechID);
            break;
        }
        case cSpanish:
        {
            ForceEnableTech(playerId, 599);
            xsEffectAmount(cUpgradeUnit, TradeBoatID, ManilaGalleonID, -1, playerId);
            break;
        }
        case cAztecs:
        {
            MulAttribute(playerId, ArcherID, cMovementSpeed, 1.05);
            MulAttribute(playerId, CrossbowmanID, cMovementSpeed, 1.05);
            MulAttribute(playerId, ArbalesterID, cMovementSpeed, 1.05);
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
            //  Enable Hospitaller Knight
            SetTechAuto(playerId, HospitallerKnightTechID);
            ModResource(playerId, cAttributeGoldGeneration, 15);
            break;
        }
        case cIncas:
        {
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cSlavs:
        {
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
            ModArmor(playerId, DonsoID, cDamageClassPierce, 1);
            ModArmor(playerId, VeteranDonsoID, cDamageClassPierce, 1);
            ModArmor(playerId, EliteDonsoID, cDamageClassPierce, 1);
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
        case cBulgarians:
        {
            ModAttack(playerId, cCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cCavalryClass, cDamageClassCamelUnits, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCamelUnits, 1);
            break;
        }
        case cTatars:
        {
            ModArmor(playerId, cCavalryArcherClass, cDamageClassPierce, 1);
            //  Enable Khan
            SetAttribute(playerId, KhanID, cDisabledFlag, 4);
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
            ModAttribute(playerId, cCavalryClass, cRegenerationRate, -1);
            ModAttribute(playerId, cScoutCavalryClass, cRegenerationRate, -1);
            ModAttribute(playerId, cConquistadorClass, cRegenerationRate, -1);
            ModAttribute(playerId, cCavalryArcherClass, cRegenerationRate, -1);
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
    //  Conscripted Army Upgrade
    ModAttribute(playerId, ConscriptedArmyID, cMovementSpeed, 0.1);
    ModAttribute(playerId, ExtraConscriptedArmyID, cMovementSpeed, 0.1);

    ModAttribute(playerId, MercenarySerjeantID, cHitpoints, 25);
    ModAttack(playerId, MercenarySerjeantID, cDamageClassMelee, 3);
    ModAttribute(playerId, MercenarySerjeantID, cShownAttack, 3);
    ModArmor(playerId, MercenarySerjeantID, cDamageClassMelee, 2);
    ModArmor(playerId, MercenarySerjeantID, cDamageClassPierce, 1);
    ModAttribute(playerId, MercenarySerjeantID, cShownMeleeArmor, 2);
    ModAttribute(playerId, MercenarySerjeantID, cShownPierceArmor, 1);
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
        case cTeutons:
        {
            ModArmor(playerId, CrusaderKnightID, cDamageClassMelee, 1);
            break;
        }
        case cChinese:
        {
            ModResource(playerId, cAttributeResearchCostMod, -0.05);
            break;
        }
        case cByzantines:
        {
            MulAttribute(playerId, cBuildingClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cWallClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cGateClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cFarmClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cTowerClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulResource(playerId, cAttributeOliveOilProductivity, 2);
            break;
        }
        case cAztecs:
        {
            MulAttribute(playerId, ArcherID, cMovementSpeed, 1.1 / 1.05);
            MulAttribute(playerId, CrossbowmanID, cMovementSpeed, 1.1 / 1.05);
            MulAttribute(playerId, ArbalesterID, cMovementSpeed, 1.1 / 1.05);
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cMayans:
        {
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cItalians:
        {
            ModResource(playerId, cAttributeGoldGeneration, 15);
            break;
        }
        case cIncas:
        {
            ModAttribute(playerId, ShrineID, cAvailableFlag, 1);
            break;
        }
        case cSlavs:
        {
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
        case cMalians:
        {
            ModArmor(playerId, DonsoID, cDamageClassPierce, 1);
            ModArmor(playerId, VeteranDonsoID, cDamageClassPierce, 1);
            ModArmor(playerId, EliteDonsoID, cDamageClassPierce, 1);
            break;
        }
        case cBerbers:
        {
            MulAttribute(playerId, cVillagerClass, cMovementSpeed, 1.2 / 1.15);
            break;
        }
        case cBulgarians:
        {
            ModAttack(playerId, cCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cCavalryClass, cDamageClassCamelUnits, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCamelUnits, 1);
            break;
        }   
        case cTatars:
        {
            ModArmor(playerId, cCavalryArcherClass, cDamageClassPierce, 1);
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
        case cGeorgians:
        {
            ModAttribute(playerId, cCavalryClass, cRegenerationRate, -1);
            ModAttribute(playerId, cScoutCavalryClass, cRegenerationRate, -1);
            ModAttribute(playerId, cConquistadorClass, cRegenerationRate, -1);
            ModAttribute(playerId, cCavalryArcherClass, cRegenerationRate, -1);
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
        case cMongols:
        {
            ForceResearchTech(playerId, CavalierTechID);
            break;
        }
        default:
            break;
    }
}


//  Post Imperial Age start effect
void EffectFunction10064(int playerId = -1)
{
}