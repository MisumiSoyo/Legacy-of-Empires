include "array.xs";
include "math.xs";
include "techtree.xs";


//  10002 - Forestry
void EffectFunction10002(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeForestryProductivity);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000009);
    xsTask(MaleLumberjackID, cTaskTypeGenerateResources, cTreeClass, playerId);
    xsTask(FemaleLumberjackID, cTaskTypeGenerateResources, cTreeClass, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeForestryProductivity, 1.5);
}


// 10003 - Castle Network
void EffectFunction10003(int playerId = -1)
{

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.13043478);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 39);

    CastleNetworkEffect(TownCenterID, playerId);
    CastleNetworkEffect(TownCenter2ID, playerId);
    CastleNetworkEffect(TownCenter3ID, playerId);
    CastleNetworkEffect(TownCenter4ID, playerId);

    xsResetTaskAmount();
}


// 10004 - Enclosure
void EffectFunction10004(int playerId = -1)
{
    xsEffectAmount(cMulResource, cAttributeFoodBonus, 0, 0.75, playerId);
    xsEffectAmount(cModResource, cAttributeGoldFarmingProductivity, 1, 10.6, playerId);
    xsEffectAmount(cAddAttribute, cVillagerClass, cHitpoints, -15, playerId);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeGoldFarmingProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();
}


//  10005 - Frank Loan (500 gold)
void EffectFunction10005(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 239);
    SetResource(playerId, cAttributeFrankLoan, 150);
}


//  10006 - Frank Loan (1000 gold)
void EffectFunction10006(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 359);
    SetResource(playerId, cAttributeFrankLoan, 300);
}


//  10007 - Frank Loan (2000 gold)
void EffectFunction10007(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 479);
    SetResource(playerId, cAttributeFrankLoan, 500);
}


//  10009 - Accolade
void EffectFunction10009(int playerId = -1)
{
    int i = 0;
    int j = 0;
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkFlag2, 5);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTaskAmount(cTaskAttrCarryCheck, 102);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000003);
    xsTaskAmount(cTaskAttrGatherType, 5);
    AccoladeApplier(playerId);
    xsTaskAmount(cTaskAttrCarryCheck, 103);
    xsTaskAmount(cTaskAttrSearchWaitTime, 9.000001);
    xsTaskAmount(cTaskAttrGatherType, 1);
    AccoladeApplier(playerId);
    xsResetTaskAmount();
}


//  10010 - Tang Dynasty
void EffectFunction10010(int playerId = -1)
{
    ModAttack(playerId, cInfantryClass, cDamageClassMelee, 3);
    ModAttack(playerId, cCavalryClass, cDamageClassMelee, 3);
    ModAttack(playerId, cScoutCavalryClass, cDamageClassMelee, 3);
    ModAttribute(playerId, cInfantryClass, cLineOfSight, 4);
    ModAttribute(playerId, cCavalryClass, cLineOfSight, 4);
    ModAttribute(playerId, cScoutCavalryClass, cLineOfSight, 4);
    ModResource(playerId, cAttributePopulationCap, 25);
    ModResource(playerId, cAttributeUnitLimit, 25);

    DisableTech(playerId, SongDynastyTechID);
    DisableTech(playerId, YuanDynastyTechID);
    DisableTech(playerId, MingDynastyTechID);
}


//  10011 - Song Dynasty
void EffectFunction10011(int playerId = -1)
{
    MulAttribute(playerId, cTradeBoatClass, cResourceCost, 0.65);
    MulAttribute(playerId, cVillagerClass, cResourceCost, 0.65);
    MulAttribute(playerId, cTradeCartClass, cResourceCost, 0.65);
    MulAttribute(playerId, cTradeBoatClass, cTrainTime, 0.5);
    MulAttribute(playerId, cTradeCartClass, cTrainTime, 0.5);
    ModResource(playerId, cAttributeResearchCostMod, -0.1);
    DisableTech(playerId, TangDynastyTechID);
    DisableTech(playerId, YuanDynastyTechID);
    DisableTech(playerId, MingDynastyTechID);
}


//  10012 - Yuan Dynasty
void EffectFunction10012(int playerId = -1)
{
    MulAttribute(playerId, cArcherClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cVillagerClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cInfantryClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cCavalryClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cMonkClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cSiegeWeaponClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cMonkClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cConquistadorClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cPetardClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cCavalryArcherClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cMonkWithRelicClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cHandCannoneerClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cScoutCavalryClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cPackedUnitClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cUnpackedSiegeUnitClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cScorpionClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cLivestockClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cKingClass, cMovementSpeed, 1.05);
    MulAttribute(playerId, cControlledAnimalClass, cMovementSpeed, 1.05);

    SetTechAuto(playerId, ManAtArmsTechID);
    SetTechAuto(playerId, LongSwordmanTechID);
    SetTechAuto(playerId, PikemanTechID);
    SetTechAuto(playerId, CrossbowmanTechID);
    SetTechAuto(playerId, EliteSkirmisherTechID);
    SetTechAuto(playerId, LightCavalryTechID);
    SetTechAuto(playerId, GalleonTechID);

    if (isResearched(playerId, ScaleBardingArmorTechID) == false)
        ForceResearchTech(playerId, ScaleBardingArmorTechID);
    if (isResearched(playerId, ChainBardingArmorTechID) == false)
        ForceResearchTech(playerId, ChainBardingArmorTechID);
    if (isResearched(playerId, PlateBardingArmorTechID) == false)
        ForceResearchTech(playerId, PlateBardingArmorTechID);

    DisableTech(playerId, TangDynastyTechID);
    DisableTech(playerId, SongDynastyTechID);
    DisableTech(playerId, MingDynastyTechID);
}


//  10013 - Ming Dynasty
void EffectFunction10013(int playerId = -1)
{
    EnableTech(playerId, GuanNingCavalryTechID);
    if (isResearched(playerId, ChemistryTechID) == false)
        ForceResearchTech(playerId, ChemistryTechID);

    MulAttribute(playerId, cArcherClass, cHitpoints, 1.10);
    MulAttribute(playerId, cInfantryClass, cHitpoints, 1.10);
    MulAttribute(playerId, cMonkClass, cHitpoints, 1.10);
    MulAttribute(playerId, cSiegeWeaponClass, cHitpoints, 1.10);
    MulAttribute(playerId, cMonkClass, cHitpoints, 1.10);
    MulAttribute(playerId, cWarshipClass, cHitpoints, 1.10);
    MulAttribute(playerId, cPetardClass, cHitpoints, 1.10);
    MulAttribute(playerId, cMonkWithRelicClass, cHitpoints, 1.10);
    MulAttribute(playerId, cHandCannoneerClass, cHitpoints, 1.10);
    MulAttribute(playerId, cPackedUnitClass, cHitpoints, 1.10);
    MulAttribute(playerId, cUnpackedSiegeUnitClass, cHitpoints, 1.10);
    MulAttribute(playerId, cScorpionClass, cHitpoints, 1.10);

    if (isResearched(playerId, BloodlinesTechID))
    {
        ModAttribute(playerId, cCavalryClass, cHitpoints, -20);
        ModAttribute(playerId, cConquistadorClass, cHitpoints, -20);
        ModAttribute(playerId, cCavalryArcherClass, cHitpoints, -20);
        ModAttribute(playerId, cScoutCavalryClass, cHitpoints, -20);
        ModAttribute(playerId, MissionaryID, cHitpoints, -20);
        ModAttribute(playerId, FlameCamelID, cHitpoints, -20);
        ModAttribute(playerId, JadwigaID, cHitpoints, -20);
        ModAttribute(playerId, TamarID, cHitpoints, -20);

        MulAttribute(playerId, cCavalryClass, cHitpoints, 1.10);
        MulAttribute(playerId, cConquistadorClass, cHitpoints, 1.10);
        MulAttribute(playerId, cCavalryArcherClass, cHitpoints, 1.10);
        MulAttribute(playerId, cScoutCavalryClass, cHitpoints, 1.10);
        MulAttribute(playerId, MissionaryID, cHitpoints, 1.10);
        MulAttribute(playerId, FlameCamelID, cHitpoints, 1.10);
        MulAttribute(playerId, JadwigaID, cHitpoints, 1.10);
        MulAttribute(playerId, TamarID, cHitpoints, 1.10);

        ModAttribute(playerId, cCavalryClass, cHitpoints, 20);
        ModAttribute(playerId, cConquistadorClass, cHitpoints, 20);
        ModAttribute(playerId, cCavalryArcherClass, cHitpoints, 20);
        ModAttribute(playerId, cScoutCavalryClass, cHitpoints, 20);
        ModAttribute(playerId, MissionaryID, cHitpoints, 20);
        ModAttribute(playerId, FlameCamelID, cHitpoints, 20);
        ModAttribute(playerId, JadwigaID, cHitpoints, 20);
        ModAttribute(playerId, TamarID, cHitpoints, 20);
    }
    else
    {
        MulAttribute(playerId, cCavalryClass, cHitpoints, 1.10);
        MulAttribute(playerId, cConquistadorClass, cHitpoints, 1.10);
        MulAttribute(playerId, cCavalryArcherClass, cHitpoints, 1.10);
        MulAttribute(playerId, cScoutCavalryClass, cHitpoints, 1.10);
    }

    DisableTech(playerId, TangDynastyTechID);
    DisableTech(playerId, SongDynastyTechID);
    DisableTech(playerId, YuanDynastyTechID);
}


//  10014 - Tributary System
void EffectFunction10014(int playerId = -1)
{
    TributarySystemApplier(playerId, EliteMangudaiID, 21, 16079);
    TributarySystemApplier(playerId, EliteRattanArcherID, 22, 16068);
    TributarySystemApplier(playerId, EliteTarkanID, 23, 16085);
    TributarySystemApplier(playerId, EliteWarWagonID, 26, 18022);
    TributarySystemApplier(playerId, EliteLiaoDaoID, 27, 18045);
    TributarySystemApplier(playerId, EliteIronPagodaID, 28, 18008);
    MulAttribute(playerId, EliteMangudaiID, cAttackReloadTime, 1.0 / 1.125);
    MulAttribute(playerId, EliteWarWagonID, cWoodCost, 0.75);
    ModAttribute(playerId, EliteLiaoDaoID, cDamageReflection, 0.125);
    MulAttribute(playerId, EliteIronPagodaID, cAttackReloadTime, 1.0 / 1.1);
}


//  10017 - Polutasvarf
void EffectFunction10017(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrWorkValue1, 30);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000007);
    ApplyAllMilitaryToTarget(playerId, cBuildingClass, cTaskTypeLoot);
    ApplyAllMilitaryToTarget(playerId, cTowerClass, cTaskTypeLoot);
    xsResetTaskAmount();
}


//  10019 - C-Bonus, extra food from trade units
void EffectFunction10019(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, FoodBuilding1ID);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000007);
    xsTask(cTradeBoatClass, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(cTradeCartClass, cTaskTypeExtraSpawn, -1, playerId);
    xsResetTaskAmount();
}


//  10020 - Satrap
void EffectFunction10020(int playerId = -1)
{
    
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.33);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, SatrapAuraRange);
    xsTaskAmount(cTaskAttrSearchWaitTime, 13.000001);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 5);
    xsTask(CastleID, cTaskTypeAura, 12, playerId);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTask(CastleID, cTaskTypeAura, cBuildingClass, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, CastleID);

    ModResource(playerId, 521, 1.5);
}


//  10021 - Sail on Land
void EffectFunction10021(int playerId = -1)
{
    SetAttribute(playerId, cWarshipClass, cTerrainTable, 0);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrTaskType, cTaskTypeAmphibious);
    xsTaskAmount(cTaskAttrTerrain, -32);
    xsTaskAmount(cTaskAttrWorkValue1, 0.5);
    xsModifyObjectTasks(cWarshipClass, playerId, 1000);
    xsResetTaskAmount();
}


// 10022 - Piracy
void EffectFunction10022(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrTaskType, cTaskTypeLoot);
    xsTaskAmount(cTaskAttrObjectId, -1);
    xsTaskAmount(cTaskAttrObjectClass, 899);
    xsTaskAmount(cTaskAttrWorkValue1, 40);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    ApplyModifyAllTargets(playerId, cWarshipClass);
    ApplyModifyBuildingTargets(playerId, cWarshipClass, false);
    xsResetTaskAmount();
}


// 10023 - Stockfish Trade
void EffectFunction10023(int playerId = -1)
{
    xsEffectAmount(cModResource, cAttributeFishingProductivity, 0, 0.5, playerId);
    xsEffectAmount(cModResource, cAttributeGoldFishingProductivity, 1, 1, playerId);

    //  Reset Fishing Ships' tasks
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeGoldFishingProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrOwnerType, 0);

    xsTaskAmount(cTaskAttrWorkValue1, 0.21);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.12);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.174);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cFarmClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, 0.215);
    xsTask(MaleFishermanID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(MaleFishermanID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTask(MaleFishermanID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsTask(FemaleFishermanID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(FemaleFishermanID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTask(FemaleFishermanID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsResetTaskAmount();
}


// 10024 - C-Bonus, Infantry and Cavalry generate gold by attacking buildings
void EffectFunction10024(int playerId = -1)
{
    xsResetTaskAmount();
    GenerateGoldFromBuilding(cScoutCavalryClass);
    GenerateGoldFromBuilding(cCavalryClass);
    GenerateGoldFromBuilding(cInfantryClass);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeCavalryLootBuildingGoldProductivity, 33);
}


//  10025 - Pax Mongolica
void EffectFunction10025(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000007);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 0);

    PaxMongolicaApplier(playerId, MilitiaID);
    PaxMongolicaApplier(playerId, ManAtArmsID);
    PaxMongolicaApplier(playerId, LongSwordmanID);
    PaxMongolicaApplier(playerId, TwoHandedSwordmanID);
    PaxMongolicaApplier(playerId, ChampionID);
    PaxMongolicaApplier(playerId, SpearmanID);
    PaxMongolicaApplier(playerId, PikemanID);
    PaxMongolicaApplier(playerId, HalberdierID);
    PaxMongolicaApplier(playerId, ArcherID);
    PaxMongolicaApplier(playerId, CrossbowmanID);
    PaxMongolicaApplier(playerId, ArbalesterID);
    PaxMongolicaApplier(playerId, SkirmisherID);
    PaxMongolicaApplier(playerId, EliteSkirmisherID);
    PaxMongolicaApplier(playerId, ImperialSkirmisherID);
    PaxMongolicaApplier(playerId, EarlyCavalryArcherID);
    PaxMongolicaApplier(playerId, CavalryArcherID);
    PaxMongolicaApplier(playerId, HeavyCavalryArcherID);
    PaxMongolicaApplier(playerId, HandCannoneerID);
    PaxMongolicaApplier(playerId, GenitourID);
    PaxMongolicaApplier(playerId, EliteGenitourID);
    xsResetTaskAmount();

    SetAttribute(playerId, EliteKeshikID, cTrainLocation, StableID);
    SetAttribute(playerId, EliteKeshikID, cTrainButton, 2);
    SetAttribute(playerId, EliteKeshikID, cHotkeyId, WHotkeyID);
    EnableObject(playerId, EliteKeshikID);
}


//  10026 - C-Bonus, upgrade when killing enemies
void EffectFunction10026(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrUnusedResource, cAttributeAztecsSpearmanKillUpgradeEffect);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrProceedingGraphic, 12263);
    xsTaskAmount(cTaskAttrTaskType, cTaskTypeLoot);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000012);
    xsTaskAmount(cTaskAttrObjectId, -1);
    xsTaskAmount(cTaskAttrObjectClass, 899);
    xsModifyObjectTasks(SpearmanID, playerId, 1000);
    xsModifyObjectTasks(PikemanID, playerId, 1000);
    xsTaskAmount(cTaskAttrUnusedResource, cAttributeAztecsSkirmisherKillUpgradeEffect);
    xsModifyObjectTasks(SkirmisherID, playerId, 1000);
    xsTaskAmount(cTaskAttrUnusedResource, cAttributeAztecsEagleWarriorKillUpgradeEffect);
    xsModifyObjectTasks(EagleScoutID, playerId, 1000);
    xsModifyObjectTasks(EagleWarriorID, playerId, 1000);
    xsResetTaskAmount();

    SetResource(playerId, cAttributeAztecsSpearmanKillUpgradeEffect, AztecsSpearmanKillUpgradeEffectID);
    SetResource(playerId, cAttributeAztecsSkirmisherKillUpgradeEffect, AztecsSkirmisherKillUpgradeEffectID);
    SetResource(playerId, cAttributeAztecsEagleWarriorKillUpgradeEffect, AztecsEagleWarriorKillUpgradeEffectID);
}


//  10027 - Ixiptla
void EffectFunction10027(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceIn, 3157);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000001);
    int i = 0;
    int j = 0;
    for (i = 900; <= 964)
        if (isClassOperable(i))
            for (j = 900; <= 964)
                if (isLandMilitaryClass(j))
                    xsTask(i, cTaskTypeLoot, j, playerId);
    xsResetTaskAmount();
}


//  10028 - Cuauhocelotl
void EffectFunction10028(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProceedingGraphic, 12263);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCarryCheck, 2);
    xsTaskAmount(cTaskAttrGatherType, 2);
    xsTaskAmount(cTaskAttrSearchWaitTime, 9);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrWorkFlag2, 4);
    ApplyToAllMilitaryTargets(playerId, JaguarWarriorID, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, EliteJaguarWarriorID, cTaskTypeLoot);
    xsResetTaskAmount();

    xsTaskAmount(cTaskAttrProceedingGraphic, 12263);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCarryCheck, 104);
    xsTaskAmount(cTaskAttrSearchWaitTime, 9);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrWorkFlag2, 4);
    xsTaskAmount(cTaskAttrGatherType, 1);
    xsTaskAmount(cTaskAttrTaskType, cTaskTypeLoot);
    xsTaskAmount(cTaskAttrObjectId, -1);
    xsTaskAmount(cTaskAttrObjectClass, 899);
    xsModifyObjectTasks(EagleScoutID, playerId, 1000);
    xsModifyObjectTasks(EagleWarriorID, playerId, 1000);
    xsModifyObjectTasks(EliteEagleWarriorID, playerId, 1000);
    xsResetTaskAmount();
}


//  10029 - C-Bonus, farms produce all resources
void EffectFunction10029(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeMayansFarmGoldProductivity);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000006);
    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeMayansFarmWoodProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeWood);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000009);
    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeMayansFarmStoneProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeStone);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000010);
    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();

    SetResource(playerId, cAttributeMayansFarmWoodProductivity, 53.0 * 0.81 * 1.15 * 0.40);
    SetResource(playerId, cAttributeMayansFarmStoneProductivity, 53.0 * 0.81 * 1.15 * 0.10);
    SetResource(playerId, cAttributeMayansFarmGoldProductivity, 53.0 * 0.81 * 1.15 * 0.20);
}


//  10030 - Yum Kaax's Blessing
void EffectFunction10030(int playerId = -1)
{
    MulAttribute(playerId, 214, cWorkRate, 1000);
    MulAttribute(playerId, 214, cCarryCapacity, 100);
    MulAttribute(playerId, 259, cWorkRate, 1000);
    MulAttribute(playerId, 259, cCarryCapacity, 100);
    MulAttribute(playerId, 50, cWorkRate, 10000);
    SetAttribute(playerId, YumKaaxsBlessingBuildingID, cRegenerationHpPercent, -6);
    SetAttribute(playerId, YumKaaxsBlessingBuildingID, cDeadUnitId, YumKaaxsBlessingEndBuildingID);
    vector pos = xsVectorSet(0.0, 0.0, 0.0);
    xsCreateUnit(YumKaaxsBlessingBuildingID, playerId, pos, false, false, false);

    MulResource(playerId, cAttributeMayansFarmWoodProductivity, 1000);
    MulResource(playerId, cAttributeMayansFarmStoneProductivity, 1000);
    MulResource(playerId, cAttributeMayansFarmGoldProductivity, 1000);
}


//  10031 - Yum Kaax's Blessing End Effect
void EffectFunction10031(int playerId = -1)
{
    MulAttribute(playerId, 214, cWorkRate, 1.0 / 1000);
    MulAttribute(playerId, 214, cCarryCapacity, 1.0 / 100);
    MulAttribute(playerId, 259, cWorkRate, 1.0 / 1000);
    MulAttribute(playerId, 259, cCarryCapacity, 1.0 / 100);
    MulAttribute(playerId, 50, cWorkRate, 1.0 / 10000);
    MulResource(playerId, cAttributeMayansFarmWoodProductivity, 1.0 / 1000);
    MulResource(playerId, cAttributeMayansFarmStoneProductivity, 1.0 / 1000);
    MulResource(playerId, cAttributeMayansFarmGoldProductivity, 1.0 / 1000);
}


// 10033 - Frontline Outpost
void EffectFunction10033(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1.1);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 9);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 5);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 7);

    xsTask(WoodenFortressID, cTaskTypeAura, cArcherClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cPetardClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cScoutCavalryClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, 30);
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000006);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(WoodenFortressID, cTaskTypeAura, cArcherClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cPetardClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(WoodenFortressID, cTaskTypeAura, cScoutCavalryClass, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, WoodenFortressID);
}


//  10034 - Maritime Stronghold
void EffectFunction10034(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0.1);
    xsTaskAmount(cTaskAttrBuildingPick, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 3);
    xsTaskAmount(cTaskAttrOwnerType, 4);
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTask(cWarshipClass, cTaskTypeBuild, SeaTower2ID, playerId);
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 12.5);
    xsTaskAmount(cTaskAttrWorkRange, 0.1);
    xsTaskAmount(cTaskAttrBuildingPick, 1);
    xsTaskAmount(cTaskAttrOwnerType, 4);
    xsTaskAmount(cTaskAttrSearchWaitTime, 3);
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTask(cWarshipClass, cTaskTypeRepair, SeaTower2ID, playerId);
    xsResetTaskAmount();

    SetAttribute(playerId, cWarshipClass, cTraits, 4);
    SetAttribute(playerId, cWarshipClass, cTraitPiece, SeaTower2ID);
    EnableObject(playerId, SeaTower2ID);
}


//  10035 - Mercenary Contract
void EffectFunction10035(int playerId = -1)
{
    SpawnUnit(playerId, CondottieroID, TownCenterID, 5, 1);
    SetResource(playerId, cAttributeCondottieroMercenaryNum, 5);
    SetAttribute(playerId, MercenaryContractBuildingID, cDeadUnitId, MercenaryContractBuildingID);
    SetAttribute(playerId, MercenaryContractBuildingID, cBloodUnitId, MercenaryContractEffectBuildingID);
    SetAttribute(playerId, MercenaryContractBuildingID, cRegenerationHpPercent, -0.5);
    SpawnUnit(playerId, MercenaryContractBuildingID, TownCenterID, 1, 1);
}


//  10036 - Italians, Mercenary Contract spawn Condottieros
void EffectFunction10036(int playerId = -1)
{
    if (xsPlayerAttribute(playerId, cAttributePopulationCap) > 0)
    {
        SetAttribute(playerId, MercenaryContractBuildingID, cRegenerationHpPercent, -0.5);
        SpawnUnit(playerId, CondottieroID, TownCenterID, xsPlayerAttribute(playerId, cAttributeCondottieroMercenaryNum), 1);
    }
    else
        SetAttribute(playerId, MercenaryContractBuildingID, cRegenerationHpPercent, -30);
}


//  10038 - Sultans
void EffectFunction10038(int playerId = -1)
{
    AddAttackForm(playerId, cInfantryClass, cDamageClassElephantUnits, 10);
    AddAttackForm(playerId, cCavalryClass, cDamageClassElephantUnits, 10);
    AddAttackForm(playerId, cScoutCavalryClass,cDamageClassElephantUnits, 10);
    AddAttackForm(playerId, cArcherClass, cDamageClassElephantUnits, 6);
    AddAttackForm(playerId, cCavalryArcherClass, cDamageClassElephantUnits, 6);
    AddAttackForm(playerId, cConquistadorClass, cDamageClassElephantUnits, 6);
    AddAttackForm(playerId, cHandCannoneerClass, cDamageClassElephantUnits, 6);
}


//  10039 - C-Bonus, Faster Castle Units
void EffectFunction10039(int playerId = -1)
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
}


//  Heavy Spear Applier
void HeavySpearApplier(int ClassTarget = -1, int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, -1);
    xsTaskAmount(cTaskAttrWorkValue2, 3);
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 116.000001);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);

    xsTaskAmount(cTaskAttrSearchWaitTime, 117.000001);
    xsTaskAmount(cTaskAttrWorkValue1, -1);
    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);
    xsResetTaskAmount();
    LaunchStinger(playerId, ClassTarget);
}


//  10040 - Heavy Spear
void EffectFunction10040(int playerId = -1)
{
    HeavySpearApplier(SpearmanID, playerId);
    HeavySpearApplier(PikemanID, playerId);
    HeavySpearApplier(HalberdierID, playerId);
    HeavySpearApplier(cScoutCavalryClass, playerId);
    HeavySpearApplier(cCavalryClass, playerId);
}


//  10041 - Poisoning
void EffectFunction10041(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrWorkValue2, 2);
    xsTaskAmount(cTaskAttrOwnerType, 0);

    PoisoningApplier(playerId, cArcherClass);
    PoisoningApplier(playerId, cConquistadorClass);
    PoisoningApplier(playerId, cCavalryArcherClass);
    PoisoningApplier(playerId, cHandCannoneerClass);
    PoisoningApplier(playerId, ProjectileDonsoID);
    xsResetTaskAmount();
}


//  10042 - C-Bonus, extra resource from army
void EffectFunction10042(int playerId = -1)
{
    int ArmyCount = xsPlayerAttribute(playerId, cAttributeMilitaryPopulation);
    ModResource(playerId, cAttributeFood, ArmyCount * 7);
    ModResource(playerId, cAttributeWood, ArmyCount * 7);
    ModResource(playerId, cAttributeGold, ArmyCount * 5);
}


// 10043 - C-Bonus, monk strengthens elephants
void EffectFunction10043(int playerId = -1)
{
    xsEffectAmount(cAddAttribute, BattleElephantID, cCombatAbility, 96, playerId);
    xsEffectAmount(cAddAttribute, EliteBattleElephantID, cCombatAbility, 96, playerId);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.130435);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrAutoSearch, 0);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);

    xsTask(BattleElephantID, cTaskTypeAura, cMonkClass, playerId);
    xsTask(EliteBattleElephantID, cTaskTypeAura, cMonkClass, playerId);

    xsTaskAmount(cTaskAttrAutoSearch, 1);

    xsTask(BattleElephantID, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsTask(EliteBattleElephantID, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsResetTaskAmount();
}


//  10044 - Silat Melayu
void EffectFunction10044(int playerId = -1)
{
    AddAttackForm(playerId, KarambitWarriorID, cDamageClassVillager, 5);
    AddAttackForm(playerId, KarambitWarriorID, cDamageClassTradeUnit, 5);
    AddAttackForm(playerId, EliteKarambitWarriorID, cDamageClassVillager, 5);
    AddAttackForm(playerId, EliteKarambitWarriorID, cDamageClassTradeUnit, 5);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, -10);
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000017);
    xsTask(KarambitWarriorID, cTaskTypeRefund, -1, playerId);
    xsTask(EliteKarambitWarriorID, cTaskTypeRefund, -1, playerId);
    xsResetTaskAmount();
}


// 10045 - Anawrahta Canals
void EffectFunction10045(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeFarmFoodGenerateProductivity);
    xsTaskAmount(cTaskAttrResourceOut, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);

    xsTask(FarmID, cTaskTypeGenerateResources, -1, playerId);
    xsTask(RiceFarmID, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
    xsEffectAmount(cModResource, cAttributeFarmFoodGenerateProductivity, 0, 8, playerId);
}


//  10046 - C-Bonus, economic units refund when killed
void EffectFunction10046(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000013);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTask(cTradeBoatClass, cTaskTypeRefund, -1, playerId);
    xsTask(cVillagerClass, cTaskTypeRefund, -1, playerId);
    xsTask(cTradeCartClass, cTaskTypeRefund, -1, playerId);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000014);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeWood);
    xsTask(cTradeBoatClass, cTaskTypeRefund, -1, playerId);
    xsTask(cVillagerClass, cTaskTypeRefund, -1, playerId);
    xsTask(cTradeCartClass, cTaskTypeRefund, -1, playerId);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000015);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeStone);
    xsTask(cTradeBoatClass, cTaskTypeRefund, -1, playerId);
    xsTask(cVillagerClass, cTaskTypeRefund, -1, playerId);
    xsTask(cTradeCartClass, cTaskTypeRefund, -1, playerId);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000016);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTask(cTradeBoatClass, cTaskTypeRefund, -1, playerId);
    xsTask(cVillagerClass, cTaskTypeRefund, -1, playerId);
    xsTask(cTradeCartClass, cTaskTypeRefund, -1, playerId);
    xsResetTaskAmount();
}


//  10047 - Fervor of Battle
void EffectFunction10047(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrUnusedResource, cAttributeFervorofBattleKillEffect);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000010);
    xsTaskAmount(cTaskAttrProceedingGraphic, 12263);
    xsTask(MilitiaID, cTaskTypeLoot, -1, playerId);
    xsTask(ManAtArmsID, cTaskTypeLoot, -1, playerId);
    xsTask(LongSwordmanID, cTaskTypeLoot,, -1, playerId);
    xsTask(TwoHandedSwordmanID, cTaskTypeLoot, -1, playerId);
    xsResetTaskAmount();

    xsTaskAmount(cTaskAttrResourceIn, FervorofBattleKillEffect5ID);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000011);
    xsTask(FootKonnikID, cTaskTypeLoot, -1, playerId);
    xsTask(EliteFootKonnikID, cTaskTypeLoot, -1, playerId);
    xsTask(FootKonnik2ID, cTaskTypeLoot, -1, playerId);
    xsTask(EliteFootKonnik2ID, cTaskTypeLoot, -1, playerId);
    xsResetTaskAmount();

    SetResource(playerId, cAttributeFervorofBattleKillEffect, FervorofBattleKillEffect1ID);
}


//  10048 - Raide Horn
void EffectFunction10048(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000002);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 180);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 2);
    ApplyToAllPlayerTargets(playerId, KeshikID, cTaskTypeStinger);
    ApplyToAllPlayerTargets(playerId, EliteKeshikID, cTaskTypeStinger);
    xsResetTaskAmount();
    LaunchStinger(playerId, KeshikID);
    LaunchStinger(playerId, EliteKeshikID);
    MulResource(playerId, 213, 2);
}


// 10049 - C-Bonus, hunters don't need to drop off food
void EffectFunction10049(int playerId = -1)
{
    int HunterMaleID = 122;
    int HunterFemaleID = 216;

    xsResetTaskAmount();
    NoDropSiteHunters(MaleHunterID, playerId);
    NoDropSiteHunters(FemaleHunterID, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeHunterFoodProductivity, 41);
    MulResource(playerId, cAttributeHuntingProductivity, 0.0000000000000001);
}


//  10050 - C-Bonus, extra gold from spearmen and skirmishers
void EffectFunction10050(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, GoldBuilding1ID);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000008);
    xsTask(SpearmanID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(PikemanID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(HalberdierID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(DonsoID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(VeteranDonsoID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(EliteDonsoID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(SkirmisherID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(EliteSkirmisherID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(ImperialSkirmisherID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(GenitourID, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(EliteGenitourID, cTaskTypeExtraSpawn, -1, playerId);
    xsResetTaskAmount();
}


//  10051 - Kopalnia Soli Wieliczka
void EffectFunction10051(int playerId = -1)
{
    float StoneTotal = xsPlayerAttribute(playerId, cAttributeStoneTotal);
    ModResource(playerId, cAttributeFood, 0.8 * StoneTotal);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeStoneMinerFoodProductivity);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000004);
    xsTask(MaleStoneMinerID, cTaskTypeGenerateResources, cStoneMineClass, playerId);
    xsTask(FemaleStoneMinerID, cTaskTypeGenerateResources, cStoneMineClass, playerId);
    xsResetTaskAmount();

    SetResource(playerId, cAttributeStoneMinerFoodProductivity, 28.8);
}


// 10052 - Winged Charge
void EffectFunction10052(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 2);
    xsTaskAmount(cTaskAttrWorkValue2, 7);
    xsTaskAmount(cTaskAttrWorkRange, 1.25);
    xsTaskAmount(cTaskAttrWorkFlag2, 2001);
    xsTask(cCavalryClass, cTaskTypeChargeAttack, -1, playerId);
    xsTask(cScoutCavalryClass, cTaskTypeChargeAttack, -1, playerId);
    xsResetTaskAmount();

    SetAttribute(playerId, cCavalryClass, cSpecialAbility, 3);
    SetAttribute(playerId, cCavalryClass, cMaxCharge, 2);
    SetAttribute(playerId, cCavalryClass, cRechargeRate, 2.0 / 12);
    SetAttribute(playerId, cCavalryClass, cChargeEvent, 1);
    SetAttribute(playerId, cCavalryClass, cChargeType, 1);
    SetAttribute(playerId, cScoutCavalryClass, cSpecialAbility, 3);
    SetAttribute(playerId, cScoutCavalryClass, cMaxCharge, 2);
    SetAttribute(playerId, cScoutCavalryClass, cRechargeRate, 2.0 / 12);
    SetAttribute(playerId, cScoutCavalryClass, cChargeEvent, 1);
    SetAttribute(playerId, cScoutCavalryClass, cChargeType, 1);
}


//  10059 - C-Bonus, Barrack and Archery Range units + attack bonus
void EffectFunction10059(int playerId = -1)
{
    MulAttackBonus(playerId, cInfantryClass, 1.25);
    MulAttackBonus(playerId, cArcherClass, 1.25);
    MulAttackBonus(playerId, cCavalryArcherClass, 1.25);
    MulAttackBonus(playerId, cHandCannoneerClass, 1.25);
    MulAttackBonus(playerId, SpearmanID, 0.8);
    MulAttackBonus(playerId, PikemanID, 0.8);
    MulAttackBonus(playerId, HalberdierID, 0.8);
}


//  10060 - C-Bonus, Cavalry +50% base attack vs skirmishers
void EffectFunction10060(int playerId = -1)
{
    int i = 0;
    for (i = 0; < TotalObjects)
        if ((i < 900) || (i > 964))
        {
            int ClassID = xsGetObjectClass(playerId, i);
            if ((ClassID == cScoutCavalryClass) || (ClassID == cCavalryClass))
                ModAttack(playerId, i, cDamageClassSkirmishers, xsGetObjectAttribute(playerId, i, cAttack, cDamageClassMelee) / 2);
        }
}


//  10069 - Caravan Guard
void EffectFunction10069(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, 397);
    xsTaskAmount(cTaskAttrResourceOut, 3);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);

    xsTask(cTradeCartClass, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
}


//  10070 - Apostle
void EffectFunction10070(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeApostleProductivity);
    xsTaskAmount(cTaskAttrWorkValue1, 3.0 / 60);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000004);
    
    int i = 0;
    for (i = 900; <= 964)
        if (isMilitaryClass(i) && (i != cMonkClass) && (i != cMonkWithRelicClass))
            xsTask(i, cTaskTypeGenerateResources, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 6.0 / 60);
    xsTask(cMonkClass, cTaskTypeGenerateResources, -1, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();

    SetResource(playerId, cAttributeApostleProductivity, 1);
}


// 10071 - Strong Fortress
void EffectFunction10071(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1.05);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 7);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 5);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);

    xsTask(WubaoID, cTaskTypeAura, cArcherClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cVillagerClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cSiegeWeaponClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cMonkClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cTradeCartClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cPetardClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cScoutCavalryClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cPackedUnitClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cUnpackedSiegeUnitClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cScorpionClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 117);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(WubaoID, cTaskTypeAura, cArcherClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cVillagerClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cSiegeWeaponClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cMonkClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cTradeCartClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cPetardClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cScoutCavalryClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cPackedUnitClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cUnpackedSiegeUnitClass, playerId);
    xsTask(WubaoID, cTaskTypeAura, cScorpionClass, playerId);
    xsResetTaskAmount();
}


//  10072 - Meng'an Mouke
void EffectFunction10072(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, ConscriptedArmyID);
    xsTaskAmount(cTaskAttrWorkValue2, 3);
    xsTask(ConscriptedArmyID, cTaskTypeExtraSpawn, -1, playerId);
    xsResetTaskAmount();
}


//  10073 - Flanking Cavalry
void EffectFunction10073(int playerId = -1)
{
    FlankingCavalryApplier(playerId, cScoutCavalryClass);
    FlankingCavalryApplier(playerId, cCavalryClass);
    FlankingCavalryApplier(playerId, cCavalryArcherClass);
    FlankingCavalryApplier(playerId, cConquistadorClass);
}


//  10074 - Raja
void EffectFunction10074(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceIn, RajaKillEffectID);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000002);
    int i = 0;
    int j = 0;
    for (i = 900; <= 964)
        if (isLandMilitaryClass(i))
            for (j = 900; <= 964)
                if (isClassOperable(j))
                    xsTask(i, cTaskTypeLoot, j, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeRajaCalcedValue, xsPlayerAttribute(playerId, cAttributeTotalValueOfKills) - xsPlayerAttribute(playerId, cAttributeTotalValueOfRazings));
}


//  10081 - C-Bonus, infantry generates food from attacking farms
void EffectFunction10081(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeInfantryLootFarmFoodProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrUnusedResource, 3);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);

    xsTask(cInfantryClass, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeInfantryLootFarmFoodProductivity, 25);
}


//  10093 - Sacred Ritual
void EffectFunction10093(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000008);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 120);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 0);
    ApplyToAllPlayerTargets(playerId, cInfantryClass, cTaskTypeStinger);
    xsTaskAmount(cTaskAttrWorkValue1, 60);
    ApplyToAllPlayerTargets(playerId, IbirapemaWarriorID, cTaskTypeStinger);
    ApplyToAllPlayerTargets(playerId, EliteIbirapemaWarriorID, cTaskTypeStinger);
    xsResetTaskAmount();
    LaunchStinger(playerId, cInfantryClass);
}


//  10094 - El Dorado
void EffectFunction10094(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 9.000002);
    xsTaskAmount(cTaskAttrWorkRange, 5);
    xsTaskAmount(cTaskAttrWorkValue1, 100);
    xsTaskAmount(cTaskAttrWorkValue2, 100);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(cInfantryClass, cTaskTypeAura, cMonkWithRelicClass, playerId);

    xsTaskAmount(cTaskAttrSearchWaitTime, 116.000002);
    xsTask(cArcherClass, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsTask(cInfantryClass, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsTaskAmount(cTaskAttrSearchWaitTime, 117.000002);
    xsTask(cArcherClass, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsTask(cInfantryClass, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, cInfantryClass, true);
    LaunchAura(playerId, cArcherClass, true);

    ModArmor(playerId, cMonkWithRelicClass, cDamageClassPierce, 5);
    ModArmor(playerId, cMonkWithRelicClass, cDamageClassMelee, 5);
    ModAttribute(playerId, cMonkWithRelicClass, cRegenerationRate, 60);
}


//  10095 - Khazar Lancers
void EffectFunction10095(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrWorkValue2, 3);
    xsTaskAmount(cTaskAttrOwnerType, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000005);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTaskAmount(cTaskAttrWorkValue1, -60);
    ApplyToAllPlayerTargets(playerId, SteppeLancerID, cTaskTypeStinger);
    ApplyToAllPlayerTargets(playerId, EliteSteppeLancerID, cTaskTypeStinger);
    xsTaskAmount(cTaskAttrWorkValue1, -1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTaskAmount(cTaskAttrSearchWaitTime, 9.000002);
    ApplyToAllPlayerTargets(playerId, SteppeLancerID, cTaskTypeStinger);
    ApplyToAllPlayerTargets(playerId, EliteSteppeLancerID, cTaskTypeStinger);
    xsTaskAmount(cTaskAttrWorkValue1, -0.15);
    xsTaskAmount(cTaskAttrSearchWaitTime, 5.000003);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);
    ApplyToAllPlayerTargets(playerId, SteppeLancerID, cTaskTypeStinger);
    ApplyToAllPlayerTargets(playerId, EliteSteppeLancerID, cTaskTypeStinger);
    xsResetTaskAmount();
    LaunchStinger(playerId, SteppeLancerID);
    LaunchStinger(playerId, EliteSteppeLancerID);
}


//  10096 - Gendarmes d'ordonnance
void EffectFunction10096(int playerId = -1)
{
    int i = 0;
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000002);
    xsTaskAmount(cTaskAttrWorkRange, 7);
    xsTaskAmount(cTaskAttrWorkValue1, 0.5);
    xsTaskAmount(cTaskAttrWorkValue2, 30);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);

    GendarmesdOrdonnanceApplier(playerId, ScoutCavalryID);
    GendarmesdOrdonnanceApplier(playerId, LightCavalryID);
    GendarmesdOrdonnanceApplier(playerId, HussarID);
    xsResetTaskAmount();

    LaunchAura(playerId, ScoutCavalryID, true);
    LaunchAura(playerId, LightCavalryID, true);
    LaunchAura(playerId, HussarID, true);
}


//  10099 - Exempted Tenant System
void EffectFunction10099(int playerId = -1)
{
    MulAttribute(playerId, cVillagerClass, cTrainLocationsEntryMod, 32767);
    SetAttribute(playerId, cVillagerClass, cTrainLocation, CastleID);
    SetAttribute(playerId, cVillagerClass, cTrainButton, 21);
    SetAttribute(playerId, cVillagerClass, cHotkeyId, QHotkeyID);
    MulAttribute(playerId, cVillagerClass, cTrainTime, 0.8);
    MulAttribute(playerId, cVillagerClass, cTrainLocationsEntryMod, 32767);
    SetAttribute(playerId, cVillagerClass, cTrainLocation, WatchTowerID);
    SetAttribute(playerId, cVillagerClass, cTrainButton, 1);
    SetAttribute(playerId, cVillagerClass, cHotkeyId, QHotkeyID);
    MulAttribute(playerId, cVillagerClass, cTrainTime, 2.5);
    SetAttribute(playerId, cVillagerClass, cTrainLocationsEntryMod, 0);
}


//  10100 - C-Bonus, relic bonus techs
void EffectFunction10100(int playerId = -1)
{
    SetInfinityStacking(playerId, BengalisMonkArmorTechID);
    SetInfinityStacking(playerId, BengalisMeleeAttackTechID);
    SetInfinityStacking(playerId, BengalisArcherArmorTechID);
    SetInfinityStacking(playerId, BengalisNavyBonusTechID);
}


//  10104 - Firearm Casting
void EffectFunction10104(int playerId = -1)
{
    ForceResearchTech(playerId, 769);
    MulAttack(playerId, GuanNingCavalryID, -1, 1.25);
    MulAttack(playerId, ProjectileGuanNingCavalryID, -1, 1.25);
    MulAttack(playerId, HandcannonAshigaruID, -1, 1.25);
    MulAttack(playerId, StreltsyID, -1, 1.25);
    MulAttack(playerId, MercenaryConquistadorID, -1, 1.25);
    MulAttack(playerId, MercenaryEliteConquistadorID, -1, 1.25);
    MulAttack(playerId, MercenaryOrganGunID, -1, 1.25);
    MulAttack(playerId, MercenaryEliteOrganGunID, -1, 1.25);
    MulAttack(playerId, MercenaryHussiteWagonID, -1, 1.25);
    MulAttack(playerId, MercenaryEliteHussiteWagonID, -1, 1.25);
}


//  10105 - Black Army
void EffectFunction10105(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000018);
    xsTaskAmount(cTaskAttrWorkValue1, 30);
    xsTaskAmount(cTaskAttrWorkValue2, 30);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTaskAmount(cTaskAttrAutoSearch, 0);
    xsTask(cHandCannoneerClass, cTaskTypeAura, cCavalryClass, playerId);
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTask(cHandCannoneerClass, cTaskTypeAura, cScoutCavalryClass, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, cHandCannoneerClass, true);
}


//  10106 - Druid
void EffectFunction10106(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 13.000002);
    xsTaskAmount(cTaskAttrWorkValue1, 0.12);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 7);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 39);
    xsTask(cMonkClass, cTaskTypeAura, MaleLumberjackID, playerId);
    xsTask(cMonkClass, cTaskTypeAura, FemaleLumberjackID, playerId);
    xsTask(cMonkClass, cTaskTypeAura, MaleGoldMinerID, playerId);
    xsTask(cMonkClass, cTaskTypeAura, FemaleGoldMinerID, playerId);
    xsTask(cMonkClass, cTaskTypeAura, MaleStoneMinerID, playerId);
    xsTask(cMonkClass, cTaskTypeAura, FemaleStoneMinerID, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeAura, MaleLumberjackID, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeAura, FemaleLumberjackID, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeAura, MaleGoldMinerID, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeAura, FemaleGoldMinerID, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeAura, MaleStoneMinerID, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeAura, FemaleStoneMinerID, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, cMonkClass);
    LaunchAura(playerId, cMonkWithRelicClass);
}


//  10107 - Monsoon Navigation
void EffectFunction10107(int playerId = -1)
{
    MulAttribute(playerId, cFishingBoatClass, cMovementSpeed, 1.6);
    MulAttribute(playerId, cFishingBoatClass, cMovementSpeed, 1.6);

    MulFishingWorkValue(playerId, FishingShipID);
    MulFishingWorkValue(playerId, FishingShip2ID);
    MulFishingWorkValue(playerId, AntiquityModeFishingShipID);
}


//  10108 - C-Bonus, mounted units +50% attack bonus
void EffectFunction10108(int playerId = -1)
{
    MulAttackBonus(playerId, cCavalryClass, 1.5);
    MulAttackBonus(playerId, cConquistadorClass, 1.5);
    MulAttackBonus(playerId, cCavalryArcherClass, 1.5);
    MulAttackBonus(playerId, cScoutCavalryClass, 1.5);
}


//  10109 - C-Bonus, team free vills for monastery techs
void EffectFunction10109(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);
    if (playerCiv == cDravidians)
        AllySpawnUnit(playerId, MaleVillagerID, TownCenterID, 1, 1);
}


//  10110 - Dha
void EffectFunction10110(int playerId = -1)
{
    MulAttribute(playerId, SpearmanID, cTrainTime, 0.5);
    MulAttribute(playerId, PikemanID, cTrainTime, 0.5);
    MulAttribute(playerId, HalberdierID, cTrainTime, 0.5);

    MulAttribute(playerId, SpearmanID, cResourceCost, 0.5);
    MulAttribute(playerId, PikemanID, cResourceCost, 0.5);
    MulAttribute(playerId, HalberdierID, cResourceCost, 0.5);

    MulAttackBonus(playerId, SpearmanID, 0.5);
    MulAttackBonus(playerId, PikemanID, 0.5);
    MulAttackBonus(playerId, HalberdierID, 0.5);

    ModAttack(playerId, SpearmanID, cDamageClassMelee, 2);
    ModAttack(playerId, PikemanID, cDamageClassMelee, 2);
    ModAttack(playerId, HalberdierID, cDamageClassMelee, 2);
}


include "timer.xs";


void main()
{
    xsChatData("Mod: Legacy of Empires");
    xsChatData("Patch: 248  2026.04.21");
    xsChatData("Author: Misumi Soyo");
    xsChatData("Please ensure that the [Graphics] Legacy of Empires mod is enabled.");

    int playerId = 0;
    vector pos = xsVectorSet(0.0, 0.0, 0.0);
    for (playerId = 0; <= xsGetNumPlayers())
    {
        SetAttribute(playerId, TimerBuildingID, cRegenerationHpPercent, -134);
        xsCreateUnit(TimerBuildingID, playerId, pos, false, false);
    }
}