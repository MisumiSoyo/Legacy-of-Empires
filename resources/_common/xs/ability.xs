//  ability.xs is to endow units with abilities
//  AbilityApplier() is the interface


include "units.xs";


//  Castle Network Adder
void CastleNetworkEffect(int ClassTarget = -1, int playerId = -1)
{
    xsTask(ClassTarget, cTaskTypeAura, cArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cPetardClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cScoutCavalryClass, playerId);
    xsTask(ClassTarget, cTaskTypeAura, cScorpionClass, playerId);
    LaunchAura(playerId, ClassTarget);
}


void FreeTech(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrMulTime, 2.5, playerId);
    xsEffectAmount(cModifyTech, TechID, cAttrMulAllCosts, 0, playerId);
}


void FoederatiArmyInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceIn, FoederatiArmyKillEffectID);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000008);
    ApplyToAllPlayerTargets(playerId, FoederatiSwordmanID, cTaskTypeLoot);
    ApplyToAllPlayerTargets(playerId, FoederatiCavalryArcherID, cTaskTypeLoot);
    ApplyToAllPlayerTargets(playerId, FoederatiKnightID, cTaskTypeLoot);
    xsResetTaskAmount();
}


//  10008 - Foederati Army Kill Effect
void EffectFunction10084(int playerId = -1)
{
    int i = 0;
    int n = xsGetNumPlayers();
    int cnt = 0;
    for (i = 0; <= n)
        if (isAlly(i, playerId))
            if (isResearched(i, FoederatiArmyTechID))
                cnt ++;
    for (i = 0; <= n)
        if (isAlly(i, playerId))
            if (isResearched(i, FoederatiArmyTechID))
            {
                ModResource(i, cAttributeFood, 7.0 / cnt);
                ModResource(i, cAttributeGold, 7.0 / cnt);
            }
}


void AccoladeApplier(int playerId = -1)
{
    ApplyToAllMilitaryTargets(playerId, cArcherClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cInfantryClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cCavalryClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cSiegeWeaponClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cMonkClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cTransportShipClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cWarshipClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cConquistadorClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cPetardClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cCavalryArcherClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cHandCannoneerClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cScoutCavalryClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cPackedUnitClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cUnpackedSiegeUnitClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cScorpionClass, cTaskTypeLoot);
}


void TributarySystemApplier(int playerId = -1, int ObjectTarget = -1, int TrainButtonID = -1, int HotKeyID = -1)
{
    EnableObject(playerId, ObjectTarget);
    SetAttribute(playerId, ObjectTarget, cTrainButton, TrainButtonID);
    SetAttribute(playerId, ObjectTarget, cHotkeyId, HotKeyID);
}



void PolutasvarfApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTask(ClassTarget, cTaskTypeLoot, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeLoot, cTowerClass, playerId);
}


//  Assassins' Ability
void AssassinInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 2);
    xsTaskAmount(cTaskAttrWorkValue2, 8);
    xsTaskAmount(cTaskAttrWorkRange, 1.5);
    xsTaskAmount(cTaskAttrWorkFlag2, 2001);
    xsTask(AssassinID, cTaskTypeChargeAttack, -1, playerId);
    xsResetTaskAmount();
    xsEffectAmount(cSetAttribute, AssassinID, cSpecialAbility, 3, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, -120);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 120.000010);
    xsTask(AssassinID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -20);
    xsTaskAmount(cTaskAttrSearchWaitTime, 120.000020);
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTask(AssassinID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 20);
    xsTask(AssassinID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cTowerClass, playerId);
    xsResetTaskAmount();
    LaunchStinger(playerId, AssassinID);

    //  since current bugs existing in game, units would never trigger task 157 when their attacks kill target enemies
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000030);
    xsTaskAmount(cTaskAttrGatherType, -100);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTask(AssassinID, cTaskTypeLoot, -1, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cBuildingClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cWallClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cGateClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cFarmClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cTowerClass, playerId);
    xsResetTaskAmount();
}


void GenerateGoldFromBuilding(int ClassTarget = -1, int playerId = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrResourceOut, 3);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeCavalryLootBuildingGoldProductivity);
    xsTaskAmount(cTaskAttrUnusedResource, 3);

    xsTask(ClassTarget, cTaskTypeGenerateResources, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeGenerateResources, cTowerClass, playerId);
}


void PaxMongolicaApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, 2.0 * 60);
    if ((ClassTarget == KeshikID) || (ClassTarget == EliteKeshikID))
        xsTaskAmount(cTaskAttrWorkValue1, 1.0 * 60);
    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.0 - 2.0 * 60);
    if ((ClassTarget == KeshikID) || (ClassTarget == EliteKeshikID))
        xsTaskAmount(cTaskAttrWorkValue1, 0.0 - 1.0 * 60);
    xsTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
    LaunchStinger(playerId, ClassTarget);
}


// 10032 - Huns Atheism Adjustment, Tarkan Task Adder
void EffectFunction10032(int playerId = -1)
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


//  Magyars civ bonus
void FasterCastleUnits(int playerId = -1, int ObjectID = -1, int TrainButtonID = -1, int HotKeyID = -1)
{
    SetAttribute(playerId, ObjectID, cTrainLocationsTotalNum, 2);
    SetAttribute(playerId, ObjectID, cTrainLocationsEntryMod, 3);
    SetAttribute(playerId, ObjectID, cTrainLocation, 82);
    SetAttribute(playerId, ObjectID, cTrainButton, TrainButtonID);
    MulAttribute(playerId, ObjectID, cTrainTime, 1.0 / 1.75);
    SetAttribute(playerId, ObjectID, cHotkeyId, HotKeyID);
    SetAttribute(playerId, ObjectID, cTrainLocationsEntryMod, 0);
}


//  Interface
void AbilityApplier(int playerId = -1)
{
    FoederatiArmyInit(playerId);
    AssassinInit(playerId);
}