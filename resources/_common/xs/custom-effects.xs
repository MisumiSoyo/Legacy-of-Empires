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
    if (isResearched(playerId, GrandTrunkRoadTechID))
        ModResource(playerId, cAttributeForestryProductivity, 2.2 * 1.1);
    else
        ModResource(playerId, cAttributeForestryProductivity, 2.2);
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
    MulResource(playerId, cAttributeFoodBonus, 0.8);
    ModResource(playerId, cAttributeEnclosureProductivity, 0.53 * 100 * 0.2);
    ModAttribute(playerId, cVillagerClass, cHitpoints, -15);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeEnclosureProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();
}


//  10005 - Frank Loan (500 gold)
void EffectFunction10005(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 180);
    SetResource(playerId, cAttributeFrankLoan, 250);
}


//  10006 - Frank Loan (1000 gold)
void EffectFunction10006(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 360);
    SetResource(playerId, cAttributeFrankLoan, 300);
}


//  10007 - Frank Loan (2000 gold)
void EffectFunction10007(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 480);
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
    xsEffectAmount(cModifyTech, TributarySystemTechID, cAttrMulAllCosts, 0.5, playerId);

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
    ModAttack(playerId, ProjectileFireLancerID, cDamageClassPierce, 2);
    ModAttribute(playerId, ProjectileFireLancerID, cShownAttack, 2);
    DisableTech(playerId, TangDynastyTechID);
    DisableTech(playerId, YuanDynastyTechID);
    DisableTech(playerId, MingDynastyTechID);
}


//  10012 - Yuan Dynasty
void EffectFunction10012(int playerId = -1)
{
    float MovementSpeedBonus = 1.10;
    MulAttribute(playerId, cArcherClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cBuildingClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cVillagerClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cInfantryClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cCavalryClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cSiegeWeaponClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cMonkClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cTradeCartClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cConquistadorClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cPhalanxClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cPetardClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cCavalryArcherClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cMonkWithRelicClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cHandCannoneerClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cScoutCavalryClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cPackedUnitClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cUnpackedSiegeUnitClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cScorpionClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cLivestockClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cKingClass, cMovementSpeed, MovementSpeedBonus);
    MulAttribute(playerId, cControlledAnimalClass, cMovementSpeed, MovementSpeedBonus);

    MulAttribute(playerId, cTradeCartClass, cWorkRate, MovementSpeedBonus);

    //SetTechAuto(playerId, ManAtArmsTechID);
    //SetTechAuto(playerId, LongSwordmanTechID);
    //SetTechAuto(playerId, PikemanTechID);
    //SetTechAuto(playerId, CrossbowmanTechID);
    //SetTechAuto(playerId, EliteSkirmisherTechID);
    //SetTechAuto(playerId, LightCavalryTechID);
    //SetTechAuto(playerId, MediumWarshipsTechID);

    if (isResearched(playerId, ScaleBardingArmorTechID) == false)
        ForceResearchTech(playerId, ScaleBardingArmorTechID, true);
    if (isResearched(playerId, ChainBardingArmorTechID) == false)
        ForceResearchTech(playerId, ChainBardingArmorTechID, true);
    if (isResearched(playerId, PlateBardingArmorTechID) == false)
        ForceResearchTech(playerId, PlateBardingArmorTechID, true);
    if (isResearched(playerId, ParthianTacticsTechID) == false)
        ForceResearchTech(playerId, ParthianTacticsTechID, true);

    EnableObject(playerId, YuanRaiderID);

    DisableTech(playerId, TangDynastyTechID);
    DisableTech(playerId, SongDynastyTechID);
    DisableTech(playerId, MingDynastyTechID);
}


//  10013 - Ming Dynasty
void EffectFunction10013(int playerId = -1)
{
    EnableTech(playerId, GuanNingCavalryTechID);
    if (isResearched(playerId, ChemistryTechID) == false)
        ForceResearchTech(playerId, ChemistryTechID, true);

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


//  10018 - C-Bonus, hunters generate gold
void EffectFunction10018(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeHunterGoldGenerationProductivity);
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTaskAmount(cTaskAttrEnableTargeting, 1);
    xsTaskAmount(cTaskAttrOwnerType, 5);
    xsTaskAmount(cTaskAttrGatherType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGoldGeneration);
    xsTaskAmount(cTaskAttrWorkValue1, xsGetObjectAttribute(playerId, MaleHunterID, cWorkRate) * 0.01);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000019);
    xsTask(MaleHunterID, cTaskTypeGenerateResources, cPreyAnimalClass, playerId);
    xsTask(MaleHunterID, cTaskTypeGenerateResources, cPredatorAnimalClass, playerId);
    xsTask(FemaleHunterID, cTaskTypeGenerateResources, cPreyAnimalClass, playerId);
    xsTask(FemaleHunterID, cTaskTypeGenerateResources, cPredatorAnimalClass, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeHunterGoldGenerationProductivity, 4.0 * 1.04);  //  multply 1.04 to adjust actual output
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
    xsTask(CastleID, cTaskTypeAura, cBuildingClass, playerId);
    xsTask(TownCenterID, cTaskTypeAura, cBuildingClass, playerId);
    xsTask(TownCenter2ID, cTaskTypeAura, cBuildingClass, playerId);
    xsTask(TownCenter3ID, cTaskTypeAura, cBuildingClass, playerId);
    xsTask(TownCenter4ID, cTaskTypeAura, cBuildingClass, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, CastleID);
    LaunchAura(playerId, TownCenterID);
    LaunchAura(playerId, TownCenter2ID);
    LaunchAura(playerId, TownCenter3ID);
    LaunchAura(playerId, TownCenter4ID);

    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000012);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeSatrapGoldProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTask(CastleID, cTaskTypeGenerateResources, -1, playerId);
    xsTask(TownCenterID, cTaskTypeGenerateResources, -1, playerId);
    xsTask(TownCenter2ID, cTaskTypeGenerateResources, -1, playerId);
    xsTask(TownCenter3ID, cTaskTypeGenerateResources, -1, playerId);
    xsTask(TownCenter4ID, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
    ModResource(playerId, cAttributeSatrapGoldProductivity, 50);
}


//  10021 - C-Bonus, Sail on Land
void EffectFunction10021(int playerId = -1)
{
    SetAttribute(playerId, cWarshipClass, cTerrainTable, 0);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrTaskType, cTaskTypeAmphibious);
    xsTaskAmount(cTaskAttrTerrain, -32);
    xsTaskAmount(cTaskAttrWorkValue1, 0.33);
    xsTaskAmount(cTaskAttrWorkValue2, 1.0);
    xsModifyObjectTasks(cWarshipClass, playerId, 1000);
    xsResetTaskAmount();

    AddTrainLocation(playerId, GalleyID, true, SiegeWorkshopID, NullInt, QKeyID + 20, QHotkeyID);
    AddTrainLocation(playerId, WarGalleyID, true, SiegeWorkshopID, NullInt, QKeyID + 20, QHotkeyID);
    AddTrainLocation(playerId, GalleonID, true, SiegeWorkshopID, NullInt, QKeyID + 20, QHotkeyID);
    AddTrainLocation(playerId, FireGalleyID, true, SiegeWorkshopID, NullInt, WKeyID + 20, WHotkeyID);
    AddTrainLocation(playerId, FireShipID, true, SiegeWorkshopID, NullInt, WKeyID + 20, WHotkeyID);
    AddTrainLocation(playerId, FastFireShipID, true, SiegeWorkshopID, NullInt, WKeyID + 20, WHotkeyID);
    AddTrainLocation(playerId, HulkID, true, SiegeWorkshopID, NullInt, EKeyID + 20, EHotkeyID);
    AddTrainLocation(playerId, WarHulkID, true, SiegeWorkshopID, NullInt, EKeyID + 20, EHotkeyID);
    AddTrainLocation(playerId, CarrackID, true, SiegeWorkshopID, NullInt, EKeyID + 20, EHotkeyID);
    AddTrainLocation(playerId, CannonGalleonID, true, SiegeWorkshopID, NullInt, RKeyID + 20, RHotkeyID);
    AddTrainLocation(playerId, EliteCannonGalleonID, true, SiegeWorkshopID, NullInt, RKeyID + 20, RHotkeyID);
    AddTrainLocation(playerId, DemolitionRaftID, true, SiegeWorkshopID, NullInt, AKeyID + 20, AHotkeyID);
    AddTrainLocation(playerId, DemolitionShipID, true, SiegeWorkshopID, NullInt, AKeyID + 20, AHotkeyID);
    AddTrainLocation(playerId, HeavyDemolitionShipID, true, SiegeWorkshopID, NullInt, AKeyID + 20, AHotkeyID);

    xsEffectAmount(cModifyTech, MediumWarshipsTechID, cAttrSetLocation, SiegeWorkshopID);
    xsEffectAmount(cModifyTech, HeavyWarshipsTechID, cAttrSetLocation, SiegeWorkshopID);
    xsEffectAmount(cModifyTech, DemolitionShipTechID, cAttrSetLocation, SiegeWorkshopID);
    xsEffectAmount(cModifyTech, HeavyDemolitionShipTechID, cAttrSetLocation, SiegeWorkshopID);
    xsEffectAmount(cModifyTech, EliteCannonGalleonTechID, cAttrSetLocation, SiegeWorkshopID);
    xsEffectAmount(cModifyTech, MediumWarshipsTechID, cAttrSetButton, XKeyID + 20);
    xsEffectAmount(cModifyTech, HeavyWarshipsTechID, cAttrSetButton, XKeyID + 20);
    xsEffectAmount(cModifyTech, DemolitionShipTechID, cAttrSetButton, CKeyID + 20);
    xsEffectAmount(cModifyTech, HeavyDemolitionShipTechID, cAttrSetButton, CKeyID + 20);
    xsEffectAmount(cModifyTech, EliteCannonGalleonTechID, cAttrSetButton, VKeyID + 20);
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
    xsTaskAmount(cTaskAttrProductivityResource, cAttributePiracyProductivity);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    ApplyModifyAllTargets(playerId, cWarshipClass);
    ApplyModifyBuildingTargets(playerId, cWarshipClass, false);
    xsResetTaskAmount();

    SetResource(playerId, cAttributePiracyProductivity, 1);
}


// 10023 - Stockfish Trade
void EffectFunction10023(int playerId = -1)
{
    xsEffectAmount(cModResource, cAttributeFishingProductivity, 0, 0.5, playerId);
    xsEffectAmount(cModResource, cAttributeGoldFishingProductivity, 1, 1, playerId);
    MulResource(playerId, cAttributeFishingProductivity, VikingsDeathBonusRate(xsPlayerAttribute(playerId, cAttributeVikingsCountedDeath)));
    MulResource(playerId, cAttributeGoldFishingProductivity, VikingsDeathBonusRate(xsPlayerAttribute(playerId, cAttributeVikingsCountedDeath)));

    //  Reset Fishing Ships' tasks
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeGoldFishingProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrOwnerType, 0);

    xsTaskAmount(cTaskAttrWorkValue1, 0.24 * 0.5 * 1.75);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.24 * 0.5);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.24 * 0.5 * 1.45);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cFarmClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, 0.43 * 0.5 * 1);
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
    GenerateGoldFromBuilding(playerId, cScoutCavalryClass, 0.33);
    GenerateGoldFromBuilding(playerId, cCavalryClass, 0.33);
    GenerateGoldFromBuilding(playerId, cInfantryClass, 0.45);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeCavalryLootBuildingGoldProductivity, 1);
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

    EnableObject(playerId, EliteKeshikID);
}


//  10026 - Ixiptla
void EffectFunction10026(int playerId = -1)
{
    int UnitKills = xsPlayerAttribute(playerId, cAttributeKills);
    SpawnUnit(playerId, EliteJaguarWarriorID, TownCenterID, (UnitKills / 30) * 7, 1);
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceIn, FreeJaguarKillEffectID);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000001);
    ApplyAllToTarget(playerId, -1, cTaskTypeLoot, true, true, true, true);
    xsResetTaskAmount();
}


//  10027 - Cash Crop
void EffectFunction10027(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeCashCropProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000013);
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTaskAmount(cTaskAttrEnableTargeting, 1);
    xsTaskAmount(cTaskAttrOwnerType, 5);
    xsTaskAmount(cTaskAttrGatherType, 1);
    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();

    if (isResearched(playerId, GrandTrunkRoadTechID))
        ModResource(playerId, cAttributeCashCropProductivity, 2.0 * 1.1);
    else
        ModResource(playerId, cAttributeCashCropProductivity, 2.0);
}


//  10028 - Cuauhocelotl
void EffectFunction10028(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProceedingGraphic, 12263);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCarryCheck, 11);
    xsTaskAmount(cTaskAttrSearchWaitTime, 9.000005);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrWorkFlag2, 4);
    xsTaskAmount(cTaskAttrGatherType, 2);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    ApplyToAllMilitaryTargets(playerId, cInfantryClass, cTaskTypeLoot);

    xsTaskAmount(cTaskAttrCombatLevelFlag, 0);
    xsTaskAmount(cTaskAttrWorkFlag2, 0);
    ApplyToAllMilitaryTargets(playerId, JaguarWarriorID, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, EliteJaguarWarriorID, cTaskTypeLoot);
    xsTaskAmount(cTaskAttrCarryCheck, 2);
    xsTaskAmount(cTaskAttrSearchWaitTime, 9);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrWorkFlag2, 4);
    xsTaskAmount(cTaskAttrGatherType, 3);
    ApplyToAllMilitaryTargets(playerId, JaguarWarriorID, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, EliteJaguarWarriorID, cTaskTypeLoot);
    xsResetTaskAmount();
    PrintObjectTasks(playerId, JaguarWarriorID);
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


//  10030 - Steppe Legacy
void EffectFunction10030(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000021);
    xsTaskAmount(cTaskAttrWorkValue1, 0.5);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTask(SteppeLancerID, cTaskTypeRefund, -1, playerId);
    xsTask(EliteSteppeLancerID, cTaskTypeRefund, -1, playerId);
    xsResetTaskAmount();
}


//  10031 - Greuthungi Cavalry
void EffectFunction10031(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000024);
    xsTaskAmount(cTaskAttrWorkValue1, 0.6);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTask(KnightID, cTaskTypeRefund, -1, playerId);
    xsTask(CavalierID, cTaskTypeRefund, -1, playerId);
    xsTask(PaladinID, cTaskTypeRefund, -1, playerId);
    xsTask(SavarID, cTaskTypeRefund, -1, playerId);
    xsTask(CrusaderKnightID, cTaskTypeRefund, -1, playerId);
    xsResetTaskAmount();
}


//  10033 - Frontline Outpost
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
}


//  10016 - Advanced Mercenary Contract
void EffectFunction10016(int playerId = -1)
{
    ModResource(playerId, cAttributeCondottieroMercenaryNum, 5);
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
    FasterCastleUnits(playerId, BlackArmyInfantryID, 23, EHotkeyID);
    FasterCastleUnits(playerId, CondottieroID, 24, RHotkeyID);
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
    FasterCastleUnits(playerId, BlackArmyArquebusierID, FKeyID + 20, FHotkeyID);
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
    ModResource(playerId, cAttributeFood, ArmyCount * 5);
    ModResource(playerId, cAttributeWood, ArmyCount * 5);
    ModResource(playerId, cAttributeGold, ArmyCount * 5);
}


// 10043 - Devaraja
void EffectFunction10043(int playerId = -1)
{
    xsResetTaskAmount();
    int TaskID = FindTask(playerId, MonkID, cTaskTypeHeal);
    xsObjectTaskAmount(MonkID, playerId, TaskID);
    float tmp = xsGetTaskAmount(cTaskAttrWorkValue1);
    xsTaskAmount(cTaskAttrWorkValue1, tmp / 12);
    xsTask(MonkID, cTaskTypeHeal, cBuildingClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, tmp);
    xsTask(MonkID, cTaskTypeHeal, cSiegeWeaponClass, playerId);
    xsTask(MonkID, cTaskTypeHeal, cPackedUnitClass, playerId);
    xsTask(MonkID, cTaskTypeHeal, cUnpackedSiegeUnitClass, playerId);
    xsTask(MonkID, cTaskTypeHeal, cScorpionClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, tmp * 3);
    xsTask(MonkID, cTaskTypeHeal, BattleElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, EliteBattleElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, RaiderElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, VeteranRaiderElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, EliteRaiderElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, WarElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, EliteWarElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, EarlyElephantArcherID, playerId);
    xsTask(MonkID, cTaskTypeHeal, ElephantArcherID, playerId);
    xsTask(MonkID, cTaskTypeHeal, EliteElephantArcherID, playerId);
    xsTask(MonkID, cTaskTypeHeal, BallistaElephantID, playerId);
    xsTask(MonkID, cTaskTypeHeal, EliteBallistaElephantID, playerId);
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


// 10045 - C-Bonus, farm produces food
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
    xsEffectAmount(cModResource, cAttributeFarmFoodGenerateProductivity, 0, 20.0 / 6, playerId);
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
    xsTaskAmount(cTaskAttrSearchWaitTime, 5.000004);
    xsTaskAmount(cTaskAttrWorkRange, 4);
    xsTaskAmount(cTaskAttrWorkValue1, 1.15);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);
    xsTask(cCavalryClass, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(cConquistadorClass, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(cCavalryArcherClass, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(cScoutCavalryClass, cTaskTypeAura, cInfantryClass, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, cCavalryClass);
    LaunchAura(playerId, cConquistadorClass);
    LaunchAura(playerId, cCavalryArcherClass);
    LaunchAura(playerId, cScoutCavalryClass);
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
    ApplyToAllPlayerTargets(playerId, KnightID, cTaskTypeStinger);
    ApplyToAllPlayerTargets(playerId, CavalierID, cTaskTypeStinger);
    ApplyToAllPlayerTargets(playerId, PaladinID, cTaskTypeStinger);
    xsResetTaskAmount();
    LaunchStinger(playerId, KeshikID);
    LaunchStinger(playerId, EliteKeshikID);
    LaunchStinger(playerId, KnightID);
    LaunchStinger(playerId, CavalierID);
    LaunchStinger(playerId, PaladinID);
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


// 10052 - Pospolite Ruszenie
void EffectFunction10052(int playerId = -1)
{
    PospoliteRuszenieApplier(playerId, MillID);
    PospoliteRuszenieApplier(playerId, FolwarkID);
    PospoliteRuszenieApplier(playerId, Folwark2ID);
    PospoliteRuszenieApplier(playerId, Folwark3ID);

    AddTrainLocation(playerId, ScoutCavalryID, true, MillID, NullInt, AKeyID, AHotkeyID);
    AddTrainLocation(playerId, LightCavalryID, true, MillID, NullInt, AKeyID, AHotkeyID);
    AddTrainLocation(playerId, HussarID, true, MillID, NullInt, AKeyID, AHotkeyID);
    AddTrainLocation(playerId, WingedHussarID, true, MillID, NullInt, AKeyID, AHotkeyID);
}


//  10053 - C-Bonus, Free Cavalier for Killing Cavalry
void EffectFunction10053(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFreeCavalier);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000023);
    ApplyAllToTarget(playerId, cCavalryClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cScoutCavalryClass, cTaskTypeLoot, true, true, true, true);
    xsResetTaskAmount();
    EnableObject(playerId, FreeCavalierBuildingID);
}


//  10069 - Caravan Guard
void EffectFunction10069(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeTradeCartGoldProductivity);
    xsTaskAmount(cTaskAttrResourceOut, 3);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(cTradeCartClass, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
    ModResource(playerId, cAttributeTradeCartGoldProductivity, 10);
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
    xsTaskAmount(cTaskAttrWorkValue1, ConscriptedArmy2ID);
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
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000020);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeInfantryLootFarmFoodProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);

    xsTask(cInfantryClass, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeInfantryLootFarmFoodProductivity, 100);
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
    xsTaskAmount(cTaskAttrWorkRange, 8);
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

    ModArmor(playerId, cMonkWithRelicClass, cDamageClassPierce, 8);
    ModArmor(playerId, cMonkWithRelicClass, cDamageClassMelee, 8);
    ModAttribute(playerId, cMonkWithRelicClass, cRegenerationRate, 90);
    MulAttribute(playerId, cMonkWithRelicClass, cMovementSpeed, 1.2);

    xsTaskAmount(cTaskAttrWorkValue1, 1.0 / 60);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000014);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeRelicRate);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(cMonkWithRelicClass, cTaskTypeGenerateResources, -1, playerId);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000015);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeRelicFoodRate);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTask(cMonkWithRelicClass, cTaskTypeGenerateResources, -1, playerId);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000016);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeRelicWoodRate);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeWood);
    xsTask(cMonkWithRelicClass, cTaskTypeGenerateResources, -1, playerId);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000017);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeRelicStoneRate);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeStone);
    xsTask(cMonkWithRelicClass, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
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
    xsTaskAmount(cTaskAttrSearchWaitTime, 9.000003);
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
    xsTaskAmount(cTaskAttrWorkValue1, 1.0);
    xsTaskAmount(cTaskAttrWorkValue2, 40);
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
    MulAttribute(playerId, cVillagerClass, cTrainTime, 1.0 / 1.5);
    MulAttribute(playerId, cVillagerClass, cTrainLocationsEntryMod, 32767);
    SetAttribute(playerId, cVillagerClass, cTrainLocation, WatchTowerID);
    SetAttribute(playerId, cVillagerClass, cTrainButton, 1);
    SetAttribute(playerId, cVillagerClass, cHotkeyId, QHotkeyID);
    MulAttribute(playerId, cVillagerClass, cTrainTime, 3);
    SetAttribute(playerId, cVillagerClass, cTrainLocationsEntryMod, 0);
}


//  10104 - Order of the Golden Fleece
void EffectFunction10104(int playerId = -1)
{
    int Time = xsGetGameTime();
    SpawnUnit(playerId, KnightID, TownCenterID, Time / 120, 1);
}


//  10106 - Druid
void EffectFunction10106(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 13.000002);
    xsTaskAmount(cTaskAttrWorkValue1, 0.12);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 9);
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
    MulAttribute(playerId, SpearmanID, cTrainTime, 0.6);
    MulAttribute(playerId, PikemanID, cTrainTime, 0.6);
    MulAttribute(playerId, HalberdierID, cTrainTime, 0.6);

    MulAttribute(playerId, SpearmanID, cResourceCost, 0.6);
    MulAttribute(playerId, PikemanID, cResourceCost, 0.6);
    MulAttribute(playerId, HalberdierID, cResourceCost, 0.6);

    MulAttackBonus(playerId, SpearmanID, 0.5);
    MulAttackBonus(playerId, PikemanID, 0.5);
    MulAttackBonus(playerId, HalberdierID, 0.5);

    ModAttack(playerId, SpearmanID, cDamageClassMelee, 2);
    ModAttack(playerId, PikemanID, cDamageClassMelee, 2);
    ModAttack(playerId, HalberdierID, cDamageClassMelee, 2);
}


//  10117 - Ph'kak
void EffectFunction10117(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 9.000004);
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrWorkValue1, -0.2);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 5);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);
    xsTask(cInfantryClass, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(cInfantryClass, cTaskTypeAura, cScoutCavalryClass, playerId);
    xsResetTaskAmount();

    LaunchAura(playerId, cInfantryClass);
}


//  10118 - Kadal Paarvai
void EffectFunction10118(int playerId = -1)
{
    KadalPaarvaiApplier(playerId, FishingShipID);
    KadalPaarvaiApplier(playerId, FishingShip2ID);
    KadalPaarvaiApplier(playerId, AntiquityModeFishingShipID);
    MulResource(playerId, cAttributeFishingProductivity, 5);
    SetResource(playerId, cAttributeFishTrapProductivity, 1);
}


//  10120 - C-Bonus, relics produce food instead of gold
void EffectFunction10120(int playerId = -1)
{
    float RelicGoldRate = xsPlayerAttribute(playerId, cAttributeRelicRate);
    if (AllyCiv(playerId, cAztecs))
        RelicGoldRate = RelicGoldRate * 1.33;
    ModResource(playerId, cAttributeRelicFoodRate, RelicGoldRate);
    SetResource(playerId, cAttributeRelicRate, 0);
}


//  10122 - Kipchak Reinforcements
void EffectFunction10122(int playerId = -1)
{
    if (isResearched(playerId, HeavyCavalryArcherTechID))
        UpgradeUnit(playerId, CavalryArcherID, EliteKipchakID);
    else
        UpgradeUnit(playerId, CavalryArcherID, KipchakID);
    UpgradeUnit(playerId, HeavyCavalryArcherID, EliteKipchakID);
    SetAttribute(playerId, CavalryArcherID, cTrainLocation, ArcheryRangeID);
    SetAttribute(playerId, CavalryArcherID, cTrainButton, 3);
    SetAttribute(playerId, CavalryArcherID, cHotkeyId, EHotkeyID);
    SetAttribute(playerId, HeavyCavalryArcherID, cTrainLocation, ArcheryRangeID);
    SetAttribute(playerId, HeavyCavalryArcherID, cTrainButton, 3);
    SetAttribute(playerId, HeavyCavalryArcherID, cHotkeyId, EHotkeyID);

    xsEffectAmount(cModifyTech, HeavyCavalryArcherTechID, cAttrSetIcon, 105, playerId);
    SpawnUnit(playerId, CavalryArcherID, ArcheryRangeID, 1);
}


//  10123 - C-Bonus, free deers
void EffectFunction10123(int playerId = -1)
{
    int AgeID = xsPlayerAttribute(playerId, cAttributeCurrentAge);
    SpawnUnit(playerId, DeerID, TownCenterSpawnerID, AgeID + 1);
}


//  10126 - C-Bonus, resource from killing economic units
void EffectFunction10126(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000018);
    xsTaskAmount(cTaskAttrWorkValue1, 15);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    ApplyAllToTarget(playerId, cTradeBoatClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cVillagerClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cTradeCartClass, cTaskTypeLoot, true, true, true, true);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000019);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    ApplyAllToTarget(playerId, cTradeBoatClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cVillagerClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cTradeCartClass, cTaskTypeLoot, true, true, true, true);
    xsResetTaskAmount();
}


//  10127 - Remove wonder victory
void EffectFunction10127(int playerId = -1)
{
    xsRemoveTask(WonderID, cTaskTypeGenerateWonderVictory, -1, playerId);
}


include "timer.xs";


void main()
{
    xsChatData("Mod: Legacy of Empires");
    xsChatData("Patch: 369  2026.08.28");
    xsChatData("Author: Misumi Soyo");
    xsChatData("Please ensure that the [Graphics] Legacy of Empires mod is enabled.");

    vector pos = xsVectorSet(0.0, 0.0, 0.0);
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        SetAttribute(i, TimerBuildingID, cRegenerationHpPercent, -267);
    if (xsGetObjectCount(1, TimerBuildingID) <= 0)
        xsCreateUnit(TimerBuildingID, 1, pos, false, false);
}