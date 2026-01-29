include "array.xs";
include "math.xs";
include "techtree.xs";


//  Effect of Mongols Civ Bonus
void GenerateGoldFromBuilding(int ClassTarget = -1, int playerId = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrResourceOut, 3);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeCavalryLootBuildingGoldProductivity);
    xsTaskAmount(cTaskAttrUnusedResource, 3);

    xsTask(ClassTarget, cTaskTypeGenerateResources, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeGenerateResources, cTowerClass, playerId);
}


// 10003 - C-Bonus, Infantry and Cavalry generate gold by attacking buildings
void EffectFunction10003(int playerId = -1)
{
    xsResetTaskAmount();
    GenerateGoldFromBuilding(cScoutCavalryClass);
    GenerateGoldFromBuilding(cCavalryClass);
    GenerateGoldFromBuilding(cInfantryClass);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeCavalryLootBuildingGoldProductivity, 33);
}


//  Frozen Sea Dominance Aura Adder
void FrozenSeaDominanceAura(int ClassTarget = -1, int playerId = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, 1.0 - 1.0 / 1.1);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 10);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);

    xsTask(ClassTarget, cTaskTypeAura, cArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cPetardClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cScoutCavalryClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, 20);
    xsTaskAmount(cTaskAttrSearchWaitTime, 109);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);

    xsTask(ClassTarget, cTaskTypeAura, cArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cPetardClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cScoutCavalryClass, playerId);
}


// 10004 - Frozen Sea Dominance Aura Applier
void EffectFunction10004(int playerId = -1)
{
    xsEffectAmount(cAddAttribute, LongBoatID, cCombatAbility, 32, playerId);
    xsEffectAmount(cAddAttribute, EliteLongBoatID, cCombatAbility, 32, playerId);
    LaunchAura(playerId, cTransportShipClass);

    xsResetTaskAmount();
    FrozenSeaDominanceAura(LongBoatID, playerId);
    FrozenSeaDominanceAura(EliteLongBoatID, playerId);
    FrozenSeaDominanceAura(cTransportShipClass, playerId);
    xsResetTaskAmount();
}


// 10005 - Stockfish Trade
void EffectFunction10005(int playerId = -1)
{
    xsEffectAmount(cModResource, cAttributeFishingProductivity, 0, 0.5, playerId);
    xsEffectAmount(cModResource, cAttributeGoldFishingProductivity, 1, 1, playerId);

    //  Reset Fishing Ships' tasks
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeGoldFishingProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrOwnerType, 0);

    xsTaskAmount(cTaskAttrWorkValue1, 0.245);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.14);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.175);
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


// 10006 - Huns Atheism Adjustment, Tarkan Task Adder
void EffectFunction10006(int playerId = -1)
{
    int TarkanID1 = 755;
    int TarkanID2 = 886;
    int EliteTarkanID1 = 757;
    int EliteTarkanID2 = 887;

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, ChanyuID);
    xsTask(TarkanID1, cTaskTypePickupUnit, RelicID, playerId);
    xsTask(TarkanID2, cTaskTypePickupUnit, RelicID, playerId);
    xsTask(EliteTarkanID1, cTaskTypePickupUnit, RelicID, playerId);
    xsTask(EliteTarkanID2, cTaskTypePickupUnit, RelicID, playerId);
    xsResetTaskAmount();
}


// 10007 - Frontline Outpost
void EffectFunction10007(int playerId = -1)
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


// Cumans Civ Bonus Task Adder
void NoDropSiteHunters(int ClassTarget = -1, int playerId = -1)
{
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeHunterFoodProductivity);
    xsTaskAmount(cTaskAttrResourceOut, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrEnableTargeting, 1);
    xsTaskAmount(cTaskAttrOwnerType, 5);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTask(ClassTarget, cTaskTypeGenerateResources, cPreyAnimalClass, playerId);
    xsTask(ClassTarget, cTaskTypeGenerateResources, cPredatorAnimalClass, playerId);
    xsTask(ClassTarget, cTaskTypeGenerateResources, cBirdClass, playerId);
}


// 10008 - C-Bonus, hunters don't need to drop off food
void EffectFunction10008(int playerId = -1)
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


// 10009 - Strong Fortress
void EffectFunction10009(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1.05);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 8);
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


// 10010 - C-Bonus, infantry generates gold from attacking farms
void EffectFunction10010(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeInfantryLootFarmFoodProductivity);
    xsTaskAmount(cTaskAttrResourceOut, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);

    xsTask(cInfantryClass, cTaskTypeGenerateResources, FarmID, playerId);
    xsTask(cInfantryClass, cTaskTypeGenerateResources, RiceFarmID, playerId);
    xsResetTaskAmount();
}


// 10011 - Anawrahta Canals
void EffectFunction10011(int playerId = -1)
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


// 10012 - C-Bonus, monk strengthens elephants
void EffectFunction10012(int playerId = -1)
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


// 10013 - Winged Charge
void EffectFunction10013(int playerId = -1)
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


//  10014 - Heavy Spear
void EffectFunction10014(int playerId = -1)
{
    HeavySpearApplier(SpearmanID, playerId);
    HeavySpearApplier(PikemanID, playerId);
    HeavySpearApplier(HalberdierID, playerId);
    HeavySpearApplier(cScoutCavalryClass, playerId);
    HeavySpearApplier(cCavalryClass, playerId);
}


//  10015 - Desert Guard
void EffectFunction10015(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, 397);
    xsTaskAmount(cTaskAttrResourceOut, 3);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);

    xsTask(cTradeCartClass, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
}


//  Castle Network Adder
void CastleNetworkEffect(int ClassTarget = -1, int playerId = -1)
{
    xsEffectAmount(cAddAttribute, ClassTarget, cCombatAbility, 32, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cPetardClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cScoutCavalryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cScorpionClass, playerId);
}

// 10016 - Castle Network
void EffectFunction10016(int playerId = -1)
{
    int TownCenterID1 = 109;
    int TownCenterID2 = 71;
    int TownCenterID3 = 141;
    int TownCenterID4 = 142;

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.0909090909);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 39);

    CastleNetworkEffect(cTowerClass, playerId);
    CastleNetworkEffect(TownCenterID1, playerId);
    CastleNetworkEffect(TownCenterID2, playerId);
    CastleNetworkEffect(TownCenterID3, playerId);
    CastleNetworkEffect(TownCenterID4, playerId);
    CastleNetworkEffect(CastleID, playerId);

    xsResetTaskAmount();
}


// 10017 - Enclosure
void EffectFunction10017(int playerId = -1)
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


// 10018 - Stockfish Trade + Gillnet
void EffectFunction10018(int playerId = -1)
{
    MulResource(playerId, cAttributeGoldFishingProductivity, 1.2);
}


//  10023 - Berbers Team Bonus
void EffectFunction10023(int playerId = -1)
{
    xsEffectAmount(cModifyTech, GenitourTechID, cAttrSetFoodCost, 0, playerId);
    xsEffectAmount(cModifyTech, GenitourTechID, cAttrSetTime, 0, playerId);
    xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrSetButton, 26, playerId);
    xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrSetHotkey, 18022, playerId);

    int playerCiv = xsGetPlayerCivilization(playerId);

    if ((playerCiv == cSpanish) || (playerCiv == cBerbers) || (playerCiv == cPortuguese))
    {
        xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrMulAllCosts, 0.5, playerId);
    }
}


//  10027 - Frank Loan (500 gold)
void EffectFunction10027(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 239);
    SetResource(playerId, cAttributeFrankLoan, 187.5);
}


//  10028 - Frank Loan (1000 gold)
void EffectFunction10028(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 359);
    SetResource(playerId, cAttributeFrankLoan, 300);
}


//  10029 - Frank Loan (2000 gold)
void EffectFunction10029(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 479);
    SetResource(playerId, cAttributeFrankLoan, 500);
}


//  10037 - Raide Horn
void EffectFunction10037(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeCavalryAttackGoldProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01 / 3);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000006);

    ApplyToAllPlayerTargets(playerId, cScoutCavalryClass, cTaskTypeGenerateResources);
    ApplyToAllPlayerTargets(playerId, cCavalryClass, cTaskTypeGenerateResources);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    ApplyToAllPlayerTargets(playerId, KeshikID, cTaskTypeGenerateResources);
    ApplyToAllPlayerTargets(playerId, EliteKeshikID, cTaskTypeGenerateResources);
    if ((xsGetPlayerCivilization(playerId) == cMongols) || (xsGetPlayerCivilization(playerId) == cTatars))
        ApplyToAllPlayerTargets(playerId, KnightID, cTaskTypeGenerateResources);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeCavalryAttackGoldProductivity, 75);
}


//  10077 - Raide Horn End Effect
void EffectFunction10077(int playerId = -1)
{
}


//  10038 - Floating Garden
void EffectFunction10038(int playerId = -1)
{
    MulAttribute(playerId, cTradeBoatClass, cWorkRate, 1.2);
    MulAttribute(playerId, cBuildingClass, cWorkRate, 1.2);
    MulAttribute(playerId, cVillagerClass, cWorkRate, 1.2);
    MulAttribute(playerId, cTradeCartClass, cWorkRate, 1.2);
    MulAttribute(playerId, cFishingBoatClass, cWorkRate, 1.2);
    MulAttribute(playerId, cFarmClass, cWorkRate, 1.2);
    SetAttribute(playerId, FloatingGardenBuildingID, cRegenerationHpPercent, 0.0 - 1.0 / 3);
    SetAttribute(playerId, FloatingGardenBuildingID, cDeadUnitId, FloatingGardenEndBuildingID);
    SpawnUnit(playerId, FloatingGardenBuildingID, UniversityID, 1, 1);
}


//  10021 - Floating Garden End Effect
void EffectFunction10021(int playerId = -1)
{
    MulAttribute(playerId, cTradeBoatClass, cWorkRate, 1.0 / 1.2);
    MulAttribute(playerId, cBuildingClass, cWorkRate, 1.0 / 1.2);
    MulAttribute(playerId, cVillagerClass, cWorkRate, 1.0 / 1.2);
    MulAttribute(playerId, cTradeCartClass, cWorkRate, 1.0 / 1.2);
    MulAttribute(playerId, cFishingBoatClass, cWorkRate, 1.0 / 1.2);
    MulAttribute(playerId, cFarmClass, cWorkRate, 1.0 / 1.2);
    MulAttribute(playerId, ShrineID, cMaxCharge, 1.2);
}


//  10039 - Yum Kaax's Blessing
void EffectFunction10039(int playerId = -1)
{
    MulAttribute(playerId, 214, cWorkRate, 1000);
    MulAttribute(playerId, 214, cCarryCapacity, 100);
    MulAttribute(playerId, 259, cWorkRate, 1000);
    MulAttribute(playerId, 259, cCarryCapacity, 100);
    MulAttribute(playerId, 50, cWorkRate, 10000);
    SetAttribute(playerId, YumKaaxsBlessingBuildingID, cRegenerationHpPercent, -6);
    SetAttribute(playerId, YumKaaxsBlessingBuildingID, cDeadUnitId, YumKaaxsBlessingEndBuildingID);
    SpawnUnit(playerId, YumKaaxsBlessingBuildingID, UniversityID, 1, 1);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeYumKaaxGoldProductivity);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000006);
    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeYumKaaxWoodProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeWood);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000007);
    xsTask(MaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();

    MulResource(playerId, cAttributeFoodBonus, 0.15);
    SetResource(playerId, cAttributeYumKaaxGoldProductivity, 53.0 * 0.15 * 1000);
    SetResource(playerId, cAttributeYumKaaxWoodProductivity, 53.0 * 0.15 * 1000);
}


//  10020 - Yum Kaax's Blessing End Effect
void EffectFunction10020(int playerId = -1)
{
    MulAttribute(playerId, 214, cWorkRate, 1.0 / 1000);
    MulAttribute(playerId, 214, cCarryCapacity, 1.0 / 100);
    MulAttribute(playerId, 259, cWorkRate, 1.0 / 1000);
    MulAttribute(playerId, 259, cCarryCapacity, 1.0 / 100);
    MulAttribute(playerId, 50, cWorkRate, 1.0 / 10000);
    MulResource(playerId, cAttributeFoodBonus, 1.0 / 0.15);
    SetResource(playerId, cAttributeYumKaaxGoldProductivity, 0.0);
    SetResource(playerId, cAttributeYumKaaxWoodProductivity, 0.0);
}


//  10040 - Mercenary Contract
void EffectFunction10040(int playerId = -1)
{
    SpawnUnit(playerId, CondottieroID, TownCenterID, 5, 1);
    SetResource(playerId, cAttributeCondottieroMercenaryNum, 5);
    SetAttribute(playerId, MercenaryContractBuildingID, cDeadUnitId, MercenaryContractBuildingID);
    SetAttribute(playerId, MercenaryContractBuildingID, cBloodUnitId, MercenaryContractEffectBuildingID);
    SetAttribute(playerId, MercenaryContractBuildingID, cRegenerationHpPercent, -0.5);
    SpawnUnit(playerId, MercenaryContractBuildingID, UniversityID, 1, 1);
}


//  10041 - Italians, Mercenary Contract spawn Condottieros
void EffectFunction10041(int playerId = -1)
{
    if (xsPlayerAttribute(playerId, cAttributePopulationCap) > 0)
    {
        SetAttribute(playerId, MercenaryContractBuildingID, cRegenerationHpPercent, -0.5);
        SpawnUnit(playerId, CondottieroID, TownCenterID, xsPlayerAttribute(playerId, cAttributeCondottieroMercenaryNum), 1);
    }
    else
        SetAttribute(playerId, MercenaryContractBuildingID, cRegenerationHpPercent, -30);
}


//  10042 - Satrap
void EffectFunction10042(int playerId = -1)
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


//  10046 - Apostle
void EffectFunction10046(int playerId = -1)
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


//  10047 - Kopalnia Soli Wieliczka
void EffectFunction10047(int playerId = -1)
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


//  10065 - Sultans
void EffectFunction10065(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000009);
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 0);
    SultansApplier(playerId, 239);
    SultansApplier(playerId, 558);
    SultansApplier(playerId, 873);
    SultansApplier(playerId, 875);
    SultansApplier(playerId, 1071);
    SultansApplier(playerId, 1120);
    SultansApplier(playerId, 1122);
    SultansApplier(playerId, 1132);
    SultansApplier(playerId, 1134);
    SultansApplier(playerId, 1744);
    SultansApplier(playerId, 1746);
    xsResetTaskAmount();

    LaunchStinger(playerId, cInfantryClass);
    LaunchStinger(playerId, cCavalryClass);
    LaunchStinger(playerId, cScoutCavalryClass);
    LaunchStinger(playerId, cArcherClass);
    LaunchStinger(playerId, cCavalryArcherClass);
    LaunchStinger(playerId, cConquistadorClass);
    LaunchStinger(playerId, cHandCannoneerClass);
    ModAttribute(playerId, LiaoDaoID, cCombatAbility, -128);
    ModAttribute(playerId, EliteLiaoDaoID, cCombatAbility, -128);
    ModAttribute(playerId, WhiteFeatherGuardID, cCombatAbility, -128);
    ModAttribute(playerId, EliteWhiteFeatherGuardID, cCombatAbility, -128);
}


//  10066 - Ixiptla
void EffectFunction10066(int playerId = -1)
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


//  10067 - Ixiptla Kill Effect
void EffectFunction10067(int playerId = -1)
{
    int KillCount = xsPlayerAttribute(playerId, cAttributeIxipltaKillCount) + 1;
    int SpawnJaguarNum = KillCount / 7;
    if (SpawnJaguarNum > 0)
        SpawnUnit(playerId, 725, 82, SpawnJaguarNum, 1);
    SetResource(playerId, cAttributeIxipltaKillCount, KillCount - SpawnJaguarNum * 7);
}


//  10068 - Dacaogu
void EffectFunction10068(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceIn, 3158);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000002);
    int i = 0;
    int j = 0;
    for (i = 900; <= 964)
        if (isLandMilitaryClass(i))
            for (j = 900; <= 964)
                if (isClassOperable(j))
                    xsTask(i, cTaskTypeLoot, j, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeDacaoguCalcedValue, xsPlayerAttribute(playerId, cAttributeTotalValueOfKills) - xsPlayerAttribute(playerId, cAttributeTotalValueOfRazings));
}


//  10069 - Dacaogu Kill Effect
void EffectFunction10069(int playerId = -1)
{
    float CalcedValue = xsPlayerAttribute(playerId, cAttributeDacaoguCalcedValue);
    float TotalValue = xsPlayerAttribute(playerId, cAttributeTotalValueOfKills) - xsPlayerAttribute(playerId, cAttributeTotalValueOfRazings);
    ModResource(playerId, cAttributeFood, (TotalValue - CalcedValue) * 0.1);
    ModResource(playerId, cAttributeGold, (TotalValue - CalcedValue) * 0.04);
    SetResource(playerId, cAttributeDacaoguCalcedValue, TotalValue);
}


//  10070 - Property Tax
void EffectFunction10070(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, ExtraConscriptedArmyID);
    xsTaskAmount(cTaskAttrWorkValue2, 3);
    xsTask(ConscriptedArmyID, cTaskTypeExtraSpawn, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000003);
    xsTask(1908, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(1910, cTaskTypeExtraSpawn, -1, playerId);
    xsResetTaskAmount();   
}


//  10071 - Gendarmes d'ordonnance
void EffectFunction10071(int playerId = -1)
{
    int i = 0;
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000002);
    xsTaskAmount(cTaskAttrWorkRange, 7);
    xsTaskAmount(cTaskAttrWorkValue2, 30);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTaskAmount(cTaskAttrWorkValue1, 30);
    xsTaskAmount(cTaskAttrAutoSearch, 0);
    for (i = 900; <= 964)
        if (isMilitaryClass(i))
        {
            xsTask(cCavalryClass, cTaskTypeAura, i, playerId);
            xsTask(cScoutCavalryClass, cTaskTypeAura, i, playerId);
            if  (i == 900)
                xsTaskAmount(cTaskAttrAutoSearch, 1);
        }
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000001);
    xsTaskAmount(cTaskAttrWorkValue1, 30);
    xsTaskAmount(cTaskAttrAutoSearch, 0);
    for (i = 900; <= 964)
        if (isMilitaryClass(i))
        {
            xsTask(cCavalryClass, cTaskTypeAura, i, playerId);
            xsTask(cScoutCavalryClass, cTaskTypeAura, i, playerId);
            if  (i == 900)
                xsTaskAmount(cTaskAttrAutoSearch, 1);
        }
    xsResetTaskAmount();
    LaunchAura(playerId, cCavalryClass, true);
    LaunchAura(playerId, cScoutCavalryClass, true);
    ModAttribute(playerId, MonaspaID, cCombatAbility, -96);
    ModAttribute(playerId, EliteMonaspaID, cCombatAbility, -96);
}


//  10072 - Accolade
void EffectFunction10072(int playerId = -1)
{
    int i = 0;
    int j = 0;
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkFlag2, 5);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTaskAmount(cTaskAttrCarryCheck, 5);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000003);
    xsTaskAmount(cTaskAttrGatherType, 5);
    AccoladeApplier(playerId);
    xsTaskAmount(cTaskAttrCarryCheck, 2);
    xsTaskAmount(cTaskAttrSearchWaitTime, 9.000001);
    xsTaskAmount(cTaskAttrGatherType, 1);
    AccoladeApplier(playerId);
    xsResetTaskAmount();
}


//  10073 - Pax Mongolica
void EffectFunction10073(int playerId = -1)
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
    PaxMongolicaApplier(playerId, KeshikID);
    PaxMongolicaApplier(playerId, EliteKeshikID);
    if ((xsGetPlayerCivilization(playerId) == cMongols) || (xsGetPlayerCivilization(playerId) == cTatars))
        if (isResearched(playerId, CavalierTechID))
            UpgradeUnit(playerId, KnightID, EliteKeshikID);
        else
            UpgradeUnit(playerId, KnightID, KeshikID);
    
    xsResetTaskAmount();
}


//  Spanish, Explorer
void EffectFunction10078(int playerId = -1)
{
    float ExplorerGoldRate = 0.015;
    int i = 0;
    float CalcedGold = xsPlayerAttribute(playerId, cAttributeSpanishExplorerGoldCalced);
    float CurrentGold = 0;
    for (i = 1; <= xsGetNumPlayers())
        if (i != playerId)
            CurrentGold = CurrentGold + xsPlayerAttribute(i, cAttributeGoldTotal);
    ModResource(playerId, cAttributeGold, (CurrentGold - CalcedGold) * ExplorerGoldRate);
    SetResource(playerId, cAttributeSpanishExplorerGoldCalced, CurrentGold);
}


//  Explorer Init
void EffectFunction10081(int playerId = -1)
{
    float ExplorerGoldRate = 0.015;
    int i = 0;
    float CurrentGold = 0.0;
    for (i = 1; <= xsGetNumPlayers())
        if (i != playerId)
            CurrentGold = CurrentGold + xsPlayerAttribute(i, cAttributeGoldTotal);
    SetResource(playerId, cAttributeSpanishExplorerGoldCalced, CurrentGold);
}


//  10080 - Poisoning
void EffectFunction10080(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrWorkValue2, 3);
    xsTaskAmount(cTaskAttrOwnerType, 0);

    PoisoningApplier(playerId, cArcherClass);
    PoisoningApplier(playerId, cConquistadorClass);
    PoisoningApplier(playerId, cCavalryArcherClass);
    PoisoningApplier(playerId, cHandCannoneerClass);
    PoisoningApplier(playerId, ProjectileDonsoID);
    xsResetTaskAmount();
}


//  10085 - Tang Dynasty
void EffectFunction10085(int playerId = -1)
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


//  10086 - Song Dynasty
void EffectFunction10086(int playerId = -1)
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


//  10087 - Yuan Dynasty
void EffectFunction10087(int playerId = -1)
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


//  10088 - Ming Dynasty
void EffectFunction10088(int playerId = -1)
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


//  10079 - TC Spawn Timer Event
void EffectFunction10079(int playerId = -1)
{
    if (xsPlayerAttribute(playerId, cAttributeTimerFlag) > 0)
        return;
    SetAttribute(playerId, TimerBuildingID, cRegenerationHpPercent, -134);
    SpawnUnit(playerId, TimerBuildingID, 619, 1, 1);
}


//  10082 - Olive Grove
void EffectFunction10082(int playerId = -1)
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
    SetResource(playerId, cAttributeOliveOilProductivity, 10);
    SetResource(playerId, cAttributeRecruitMercenaryCost, 1);
}


void PolutasvarfApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTask(ClassTarget, cTaskTypeLoot, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeLoot, cTowerClass, playerId);
}


//  10083 - Polutasvarf
void EffectFunction10083(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceOut, cAttributeOliveOil);
    xsTaskAmount(cTaskAttrWorkValue1, 150);
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


//  10089 - Khazar Lancers
void EffectFunction10089(int playerId = -1)
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


//  10092 - C-Bonus, Faster Castle Units
void EffectFunction10092(int playerId = -1)
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


//  10094 - C-Bonus, Barrack and Archery Range units + attack bonus
void EffectFunction10094(int playerId = -1)
{
    MulAttackBonus(playerId, cInfantryClass, 1.25);
    MulAttackBonus(playerId, cArcherClass, 1.25);
    MulAttackBonus(playerId, cCavalryArcherClass, 1.25);
    MulAttackBonus(playerId, cHandCannoneerClass, 1.25);
    MulAttackBonus(playerId, SpearmanID, 0.8);
    MulAttackBonus(playerId, PikemanID, 0.8);
    MulAttackBonus(playerId, HalberdierID, 0.8);
}


//  10095 - C-Bonus, extra food from trade units
void EffectFunction10095(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, FoodBuilding1ID);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000007);
    xsTask(cTradeBoatClass, cTaskTypeExtraSpawn, -1, playerId);
    xsTask(cTradeCartClass, cTaskTypeExtraSpawn, -1, playerId);
    xsResetTaskAmount();
}


//  10096 - C-Bonus, warships building
void EffectFunction10096(int playerId = -1)
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
}


//  10097 - C-Bonus, extra gold from spearmen and skirmishers
void EffectFunction10097(int playerId = -1)
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


//  10098 - C-Bonus, extra resource from army
void EffectFunction10099(int playerId = -1)
{
    int ArmyCount = xsPlayerAttribute(playerId, cAttributeMilitaryPopulation);
    ModResource(playerId, cAttributeFood, ArmyCount * 6);
    ModResource(playerId, cAttributeWood, ArmyCount * 6);
    ModResource(playerId, cAttributeGold, ArmyCount * 3);
}


include "timer.xs";


void main()
{
    xsChatData("Mod: Legacy of Empires");
    xsChatData("Build: 112  2026.01.29");
    xsChatData("Author: Misumi Soyo");
    xsChatData("Please ensure that the [Graphics] Legacy of Empires mod is enabled.");
}