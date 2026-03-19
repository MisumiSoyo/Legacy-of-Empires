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
    xsTaskAmount(cTaskAttrWorkValue1, 0.0909090909);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 39);

    CastleNetworkEffect(cTowerClass, playerId);
    CastleNetworkEffect(TownCenterID, playerId);
    CastleNetworkEffect(TownCenter2ID, playerId);
    CastleNetworkEffect(TownCenter3ID, playerId);
    CastleNetworkEffect(TownCenter4ID, playerId);
    CastleNetworkEffect(CastleID, playerId);

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
    SetResource(playerId, cAttributeFrankLoan, 187.5);
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
    ModResource(playerId, cAttributeResearchCostMod, -0.05);
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


//  10015 - C-Bonus, Olive Oil
void EffectFunction10015(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeOliveOilProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeOliveOil);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000005);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cForageBushClass, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cPreyAnimalClass, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cPredatorAnimalClass, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cTreeClass, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(cVillagerClass, cTaskTypeGenerateResources, cLivestockClass, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeOliveOilProductivity, 9);
}


//  10016 - Elite Mercenary
void EffectFunction10016(int playerId = -1)
{
    int i = 0;
    for (i = 4022; <= 4072)
        if (i % 2 == 0)
            UpgradeUnit(playerId, i, i+1);  
}


//  10017 - Polutasvarf
void EffectFunction10017(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceOut, cAttributeOliveOil);
    xsTaskAmount(cTaskAttrWorkValue1, 120);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000007);
    PolutasvarfApplier(playerId, cArcherClass);
    PolutasvarfApplier(playerId, cInfantryClass);
    PolutasvarfApplier(playerId, cCavalryClass);
    PolutasvarfApplier(playerId, cSiegeWeaponClass);
    PolutasvarfApplier(playerId, cWarshipClass);
    PolutasvarfApplier(playerId, cConquistadorClass);
    PolutasvarfApplier(playerId, cPetardClass);
    PolutasvarfApplier(playerId, cCavalryArcherClass);
    PolutasvarfApplier(playerId, cHandCannoneerClass);
    PolutasvarfApplier(playerId, cScoutCavalryClass);
    PolutasvarfApplier(playerId, cPackedUnitClass);
    PolutasvarfApplier(playerId, cUnpackedSiegeUnitClass);
    PolutasvarfApplier(playerId, cScorpionClass);
    PolutasvarfApplier(playerId, cLandMineClass);
    xsResetTaskAmount();

    MulResource(playerId, cAttributeVarangianLootProductivity, 1.33);
}


//  10018 - Persians Team Bonus
void EffectFunction10018(int playerId = -1)
{
    AddAttackForm(playerId, KnightID, cDamageClassArchers, 2);
    AddAttackForm(playerId, CavalierID, cDamageClassArchers, 2);
    AddAttackForm(playerId, PaladinID, cDamageClassArchers, 2);
    AddAttackForm(playerId, SavarID, cDamageClassArchers, 2);
    AddAttackForm(playerId, HeiGuangCavalryID, cDamageClassArchers, 2);
    AddAttackForm(playerId, HeavyHeiGuangCavalryID, cDamageClassArchers, 2);
    //AddAttackForm(playerId, SipahiID, cDamageClassArchers, 2);
    //AddAttackForm(playerId, EliteSipahiID, cDamageClassArchers, 2);
    AddAttackForm(playerId, GuanNingCavalryID, cDamageClassArchers, 2);
    AddAttackForm(playerId, MountedSamuraiID, cDamageClassArchers, 2);
    AddAttackForm(playerId, EliteMountedSamuraiID, cDamageClassArchers, 2);
    //AddAttackForm(playerId, GoguryeoHeavyCavalryID, cDamageClassArchers, 2);
    //AddAttackForm(playerId, EliteGoguryeoHeavyCavalryID, cDamageClassArchers, 2);
    //AddAttackForm(playerId, KeshikID, cDamageClassArchers, 2);
    //AddAttackForm(playerId, EliteKeshikID, cDamageClassArchers, 2);
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


include "timer.xs";


void main()
{
    xsChatData("Mod: Legacy of Empires");
    xsChatData("Build: 183  2026.03.19");
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