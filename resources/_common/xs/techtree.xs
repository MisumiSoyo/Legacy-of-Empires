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

    switch (playerCiv)
    {
        case cKoreans:
        {
            //  Koreans civ bonus, Treadmill Crane, Murder Holes and Arrowslits -50% cost
            xsEffectAmount(cModifyTech, TreadmillCraneTechID, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, MurderHolesTechID, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, ArrowslitsTechID, cAttrMulAllCosts, 0.5, playerId);
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
            //  Shu civ bonus, Wubao -20% cost
            MulAttribute(playerId, WubaoID, cResourceCost, 0.8);
            //  Shu civ bonus, infantries generate food from attacking farms
            SetResource(playerId, cAttributeInfantryLootFarmFoodProductivity, 25);
            SetResource(playerId, cAttributeMaintenance, 10010);
            break;
        }
        case cWu:
        {
            //  Wu civ bonus, Wubao technologies -33% cost
            xsEffectAmount(cModifyTech, GentryTechID, cAttrMulAllCosts, 0.67, playerId);
            xsEffectAmount(cModifyTech, MercenaryTechID, cAttrMulAllCosts, 0.67, playerId);
            xsEffectAmount(cModifyTech, StrongFortressTechID, cAttrMulAllCosts, 0.67, playerId);
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
    int playerCiv = xsGetPlayerCivilization(playerId);
    switch (playerCiv)
    {
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
        case cBulgarians:
        {
            ModAttack(playerId, cCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCavalry, 1);
            ModAttack(playerId, cCavalryClass, cDamageClassCamelUnits, 1);
            ModAttack(playerId, cScoutCavalryClass, cDamageClassCamelUnits, 1);
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
        case cAztecs:
        {
            MulAttribute(playerId, ArcherID, cMovementSpeed, 1.05);
            MulAttribute(playerId, CrossbowmanID, cMovementSpeed, 1.05);
            MulAttribute(playerId, ArbalesterID, cMovementSpeed, 1.05);
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
            break;
        }
        case cSicilians:
        {
            //  Enable Hospitaller Knight
            SetTechAuto(playerId, 3038);
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
}


//  10026 - Imperial Age effect
void EffectFunction10026(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cAztecs:
        {
            MulAttribute(playerId, ArcherID, cMovementSpeed, 1.1 / 1.05);
            MulAttribute(playerId, CrossbowmanID, cMovementSpeed, 1.1 / 1.05);
            MulAttribute(playerId, ArbalesterID, cMovementSpeed, 1.1 / 1.05);
            break;
        }
        case cItalians:
        {
            ModResource(playerId, cAttributeGoldGeneration, 15);
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