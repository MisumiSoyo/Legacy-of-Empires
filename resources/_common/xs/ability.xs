//  ability.xs is to endow units with abilities
//  AbilityApplier() is the interface


include "units.xs";
include "armor-class.xs";


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
    xsEffectAmount(cModifyTech, TechID, cAttrMulTime, 6, playerId);
    xsEffectAmount(cModifyTech, TechID, cAttrMulAllCosts, 0, playerId);
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
    ApplyToAllMilitaryTargets(playerId, cPhalanxClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cPetardClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cCavalryArcherClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cHandCannoneerClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cScoutCavalryClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cPackedUnitClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cUnpackedSiegeUnitClass, cTaskTypeLoot);
    ApplyToAllMilitaryTargets(playerId, cScorpionClass, cTaskTypeLoot);
}


void GenerateGoldFromBuilding(int playerId = -1, int ClassTarget = -1, float Rate = 0.0)
{
    xsTaskAmount(cTaskAttrWorkValue1, Rate);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeCavalryLootBuildingGoldProductivity);

    xsTask(ClassTarget, cTaskTypeGenerateResources, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeGenerateResources, cTowerClass, playerId);
}


void PaxMongolicaApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, 2.0 * 60);
    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.0 - 2.0 * 60);
    xsTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
    LaunchStinger(playerId, ClassTarget);
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


void PoisoningApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTaskAmount(cTaskAttrSearchWaitTime, 5.000002);
    xsTaskAmount(cTaskAttrWorkValue1, -0.15);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);
    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.15);
    xsTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);

    LaunchStinger(playerId, ClassTarget);
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


void FlankingCavalryApplier(int playerId = -1, int ClassTarget = -1)
{
    ModAttribute(playerId, ClassTarget, cMaxCharge, 1);
    SetAttribute(playerId, ClassTarget, cChargeEvent, 0);
    SetAttribute(playerId, ClassTarget, cChargeType, 5);
}


//  10075 - Raja Kill Effect
void EffectFunction10075(int playerId = -1)
{
    float CalcedValue = xsPlayerAttribute(playerId, cAttributeRajaCalcedValue);
    float TotalValue = xsPlayerAttribute(playerId, cAttributeTotalValueOfKills) - xsPlayerAttribute(playerId, cAttributeTotalValueOfRazings);
    ModResource(playerId, cAttributeFood, (TotalValue - CalcedValue) * 0.1);
    ModResource(playerId, cAttributeGold, (TotalValue - CalcedValue) * 0.04);
    SetResource(playerId, cAttributeRajaCalcedValue, TotalValue);
}


//  10077 - C-Bonus, unique tech from other players
void EffectFunction10077(int playerId = -1)
{
    static int CastleTechIDArray = -1;

    if (CastleTechIDArray == -1)
    {
        CastleTechIDArray = xsArrayCreateInt(100, 0);
        ArrayMultipleSetInt(CastleTechIDArray, 1, 3, 83, 16, 489, 484, 462, 464, 488, 28, 491);
        ArrayMultipleSetInt(CastleTechIDArray, 11, 463, 487, 482, 492, 460, 485, 483, 486, 499, 506);
        ArrayMultipleSetInt(CastleTechIDArray, 21, 516, 514, 455, 1404, 574, 576, 578, 622, 624, 627);
        ArrayMultipleSetInt(CastleTechIDArray, 31, 628, 685, 687, 689, 691, 754, 756, 782, 784, 831);
        ArrayMultipleSetInt(CastleTechIDArray, 41, 833, 835, 883, 922, 923, 1111, 1120, 1130, 1070, 1080);
        ArrayMultipleSetInt(CastleTechIDArray, 51, 1061, 996, 1006, 1285, 1297, 1307, 1365, 1379, 1392, 0);
    }

    int i = 0;
    for (i = 1; <= xsGetNumPlayers())
        if (i != playerId)
        {
            int UniqueTechID = xsArrayGetInt(CastleTechIDArray, xsGetPlayerCivilization(i));
            if (xsGetTechState(playerId, UniqueTechID) < cTechStateNotReady)
            {
                xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetState, cAttributeForce, playerId);
                if (i <= 4)
                {
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 25, playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetHotkey, KeyToHotkeyID(i + 25), playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetLocation, UniversityID, playerId);
                }
                else
                {
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 26, playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetHotkey, KeyToHotkeyID(i + 26), playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetLocation, UniversityID, playerId);
                }
            }
        }
}


//  10078 - C-Bonus, unique tech from other players
void EffectFunction10078(int playerId = -1)
{
    static int ImperialTechIDArray = -1;

    if (ImperialTechIDArray == -1)
    {
        ImperialTechIDArray = xsArrayCreateInt(100, 0);
        ArrayMultipleSetInt(ImperialTechIDArray, 1, 461, 493, 457, 11, 59, 52, 61, 7, 454, 10);
        ArrayMultipleSetInt(ImperialTechIDArray, 11, 49, 6, 5, 440, 24, 4, 21, 445, 902, 507);
        ArrayMultipleSetInt(ImperialTechIDArray, 21, 517, 515, 513, 573, 575, 577, 579, 623, 625, 626);
        ArrayMultipleSetInt(ImperialTechIDArray, 31, 629, 686, 688, 690, 692, 755, 757, 783, 785, 832);
        ArrayMultipleSetInt(ImperialTechIDArray, 41, 834, 836, 884, 921, 924, 1113, 1123, 1133, 1069, 1081);
        ArrayMultipleSetInt(ImperialTechIDArray, 51, 1062, 997, 1007, 1287, 1298, 1309, 1366, 1380, 1393, 0);
    }

    int i = 0;
    for (i = 1; <= xsGetNumPlayers())
        if (i != playerId)
        {
            int UniqueTechID = xsArrayGetInt(ImperialTechIDArray, xsGetPlayerCivilization(i));
            if (xsGetTechState(playerId, UniqueTechID) < cTechStateNotReady)
            {
                xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetState, cAttributeForce, playerId);
                if (i <= 4)
                {
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 20, playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetHotkey, KeyToHotkeyID(i), playerId);
                }
                else
                {
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 21, playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetHotkey, KeyToHotkeyID(i + 1), playerId);
                }
            }
        }
}


void KhanInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkFlag2, 30);
    xsTaskAmount(cTaskAttrCarryCheck, 101);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000001);
    xsTaskAmount(cTaskAttrGatherType, 5);

    ApplyToAllPlayerTargets(playerId, KhanID, cTaskTypeLoot);
    xsResetTaskAmount();

    xsTaskAmount(cTaskAttrSearchWaitTime, 10.000002);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrWorkValue1, 1.0 - 1.0 / 1.25);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 47);

    ApplyToAllMilitaryTargets(playerId, KhanID, cTaskTypeAura);

    xsTaskAmount(cTaskAttrSearchWaitTime, 5.000001);
    xsTaskAmount(cTaskAttrWorkValue1, 1.15);
    ApplyToAllMilitaryTargets(playerId, KhanID, cTaskTypeAura);
    xsResetTaskAmount();
    SetAttribute(playerId, KhanID, cMaxCharge, 1);
    SetAttribute(playerId, KhanID, cRechargeRate, 1.0 / 120);
    SetAttribute(playerId, KhanID, cChargeEvent, 15);
    SetAttribute(playerId, KhanID, cChargeType, -3);
}


void MangonelAdjustment(int playerId = -1)
{
    AddAttackForm(playerId, MangonelID, cDamageClassTrees, -109);
    SetAttribute(playerId, MangonelID, cBlastAttackLevel, 1);
    AddAttackForm(playerId, RocketCartID, cDamageClassTrees, -21);
    SetAttribute(playerId, RocketCartID, cBlastAttackLevel, 1);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTaskAmount(cTaskAttrEnableTargeting, 1);
    xsTaskAmount(cTaskAttrOwnerType, 3);
    xsTaskAmount(cTaskAttrGatherType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 3);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTask(MangonelID, cTaskTypeCombat, cTreeClass, playerId);
    xsTask(RocketCartID, cTaskTypeCombat, cTreeClass, playerId);
    xsResetTaskAmount();
}


void SetCustomResources(int playerId = -1)
{
    SetResource(playerId, cAttributeWubaoFoodWoodProductivity, 1);
    SetResource(playerId, cAttributeTaboriteWarriorProductivity, 1);
    SetResource(playerId, cAttributeLastRuleTime, -1);
}


void MulFishingWorkValue(int playerId = -1, int ObjectID = -1)
{
    int TaskID = FindTask(playerId, ObjectID, cTaskTypeGatherRebuild, cSeaFishClass, -1);
    xsObjectTaskAmount(ObjectID, playerId, TaskID);
    float tmp = xsGetTaskAmount(cTaskAttrWorkValue1) * 1.33;
    xsTaskAmount(cTaskAttrWorkValue1, tmp);
    xsTask(ObjectID, cTaskTypeGatherRebuild, cSeaFishClass, playerId);
    TaskID = FindTask(playerId, ObjectID, cTaskTypeGatherRebuild, cDeepSeaFishClass, -1);
    xsObjectTaskAmount(ObjectID, playerId, TaskID);
    tmp = xsGetTaskAmount(cTaskAttrWorkValue1) * 1.33;
    xsTaskAmount(cTaskAttrWorkValue1, tmp);
    xsTask(ObjectID, cTaskTypeGatherRebuild, cSeaFishClass, playerId);
    xsResetTaskAmount();
}


void GendarmesdOrdonnanceApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTaskAmount(cTaskAttrAutoSearch, 0);
    xsTask(ClassTarget, cTaskTypeAura, KnightID, playerId);
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTask(ClassTarget, cTaskTypeAura, CavalierID, playerId);
    xsTask(ClassTarget, cTaskTypeAura, PaladinID, playerId);
    xsTask(ClassTarget, cTaskTypeAura, SavarID, playerId);
}


void KadalPaarvaiApplier(int playerId = -1, int ObjectID = -1)
{
    int TaskID = FindTask(playerId, ObjectID, cTaskTypeGatherRebuild, 899, FishTrapID);
    xsObjectTaskAmount(ObjectID, playerId, TaskID);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeFishTrapProductivity);
    float tmp = xsGetTaskAmount(cTaskAttrWorkValue1);
    xsTaskAmount(cTaskAttrWorkValue1, tmp * 5);
    xsTask(ObjectID, cTaskTypeGatherRebuild, FishTrapID, playerId);
    xsResetTaskAmount();
    MulAttribute(playerId, ObjectID, cWorkRate, 0.2);
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


void PospoliteRuszenieApplier(int playerId = -1, int ClassTarget = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTaskAmount(cTaskAttrEnableTargeting, 1);
    xsTaskAmount(cTaskAttrOwnerType, 5);
    xsTaskAmount(cTaskAttrGatherType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 3);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTask(ClassTarget, cTaskTypeCombat, -1, playerId);
    xsResetTaskAmount();

    SetAttribute(playerId, ClassTarget, cGarrisonCapacity, 8);
    SetAttribute(playerId, ClassTarget, cProjectileUnit, ProjectileFolwarkID);
    SetAttribute(playerId, ClassTarget, cSecondaryProjectileUnit, ProjectileFolwarkID);
    ModAttribute(playerId, ClassTarget, cMaxTotalProjectiles, 6);
    ModAttribute(playerId, ClassTarget, cTotalProjectiles, 1);
    SetAttribute(playerId, ClassTarget, cShownRange, 5.5);
    SetAttribute(playerId, ClassTarget, cMaxRange, 5.5);
    SetAttribute(playerId, ClassTarget, cShownAttack, 5);
    SetAttribute(playerId, ClassTarget, cAttackReloadTime, 2);
    SetAttribute(playerId, ClassTarget, cAccuracyPercent, 100);
    SetAttribute(playerId, ClassTarget, cGarrisonHealRate, 0.2);
    SetAttribute(playerId, ClassTarget, cGarrisonType, 1);
    SetAttribute(playerId, ClassTarget, cProjectileSpawningAreaWidth, 1);
    SetAttribute(playerId, ClassTarget, cProjectileSpawningAreaLength, 0.5);
    SetAttribute(playerId, ClassTarget, cProjectileSpawningAreaRandomness, 2);
    SetAttribute(playerId, ClassTarget, cProjectileGraphicDisplacementX, 0);
    SetAttribute(playerId, ClassTarget, cProjectileGraphicDisplacementY, 1);
    SetAttribute(playerId, ClassTarget, cProjectileGraphicDisplacementZ, 1);
    SetAttribute(playerId, ClassTarget, cSearchRadius, 5.5);
    if (isResearched(playerId, HerbalMedicineTechID))
        MulAttribute(playerId, ClassTarget, cGarrisonHealRate, 6);
    AddAttackForm(playerId, ClassTarget, cDamageClassPierce, xsGetObjectAttribute(playerId, ProjectileFolwarkID, cAttack, cDamageClassPierce));
    SetAttribute(playerId, ClassTarget, cGarrisonGraphic, 4682);
}


void MulAllResourceOut(int playerId = -1, float value = -1.0)
{
    MulResource(playerId, cAttributeFoodBonus, value);
    MulResource(playerId, cAttributeForagingProductivity, value);
    MulResource(playerId, cAttributeFishingProductivity, value);
    MulResource(playerId, cAttributeFishTrapProductivity, value);
    MulResource(playerId, cAttributeWoodBonus, value);
    MulResource(playerId, cAttributeGoldBonus, value);
    MulResource(playerId, cAttributeRelicRate, value);
    MulResource(playerId, cAttributeGoldFishingProductivity, value);
    MulResource(playerId, cAttributeStoneBonus, value);
    MulAttribute(playerId, cTradeBoatClass, cWorkRate, value);
    MulAttribute(playerId, cTradeCartClass, cWorkRate, value);
}


float VikingsDeathBonusRate(int DeathCount = -1)
{
    if (DeathCount < 30)
        return (1.0);
    else
        if (DeathCount < 75)
            return (1.05);
        else
            if (DeathCount < 135)
                return (1.1);
            else
                if (DeathCount < 210)
                    return (1.15);
                else
                    if (DeathCount < 300)
                        return (1.2);
                    else
                        return (1.25);
    return (1.25);
}


//  10128 - Kill cavalry count
void EffectFunction10128(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000022);
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeKillCavalryCount);
    xsTaskAmount(cTaskAttrWorkRange, 0);

    ApplyAllToTarget(playerId, cCavalryClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cConquistadorClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cCavalryArcherClass, cTaskTypeLoot, true, true, true, true);
    ApplyAllToTarget(playerId, cScoutCavalryClass, cTaskTypeLoot, true, true, true, true);
    xsResetTaskAmount();
}


void DataCountInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000027);
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceOut, LoeAttrMilitaryDeath);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 0);
    ApplyAllMilitaryToTarget(playerId, -1, cTaskTypeRefund);
    xsResetTaskAmount();
}


void WuGoldDiscount(int playerId = -1)
{
    ModAttribute(playerId, cArcherClass, cGoldCost, -1);
    ModAttribute(playerId, cInfantryClass, cGoldCost, -1);
    ModAttribute(playerId, cCavalryClass, cGoldCost, -1);
    ModAttribute(playerId, cSiegeWeaponClass, cGoldCost, -1);
    ModAttribute(playerId, cMonkClass, cGoldCost, -1);
    ModAttribute(playerId, cConquistadorClass, cGoldCost, -1);
    ModAttribute(playerId, cPetardClass, cGoldCost, -1);
    ModAttribute(playerId, cCavalryArcherClass, cGoldCost, -1);
    ModAttribute(playerId, cMonkWithRelicClass, cGoldCost, -1);
    ModAttribute(playerId, cHandCannoneerClass, cGoldCost, -1);
    ModAttribute(playerId, cScoutCavalryClass, cGoldCost, -1);
    ModAttribute(playerId, cPackedUnitClass, cGoldCost, -1);
    ModAttribute(playerId, cUnpackedSiegeUnitClass, cGoldCost, -1);
    ModAttribute(playerId, cScorpionClass, cGoldCost, -1);
    ModAttribute(playerId, cPhalanxClass, cGoldCost, -1);
    ModAttribute(playerId, cTransportShipClass, cGoldCost, -1);
    ModAttribute(playerId, cWarshipClass, cGoldCost, -1);
    ModAttribute(playerId, cVillagerClass, cGoldCost, -1);
    ModAttribute(playerId, cTradeCartClass, cGoldCost, -1);
    ModAttribute(playerId, cTradeBoatClass, cGoldCost, -1);
    ModAttribute(playerId, cFishingBoatClass, cGoldCost, -1);
    ModAttribute(playerId, cBuildingClass, cGoldCost, -1);
    ModAttribute(playerId, cWallClass, cGoldCost, -1);
    ModAttribute(playerId, cGateClass, cGoldCost, -1);
    ModAttribute(playerId, cTowerClass, cGoldCost, -1);
    ModAttribute(playerId, cFarmClass, cGoldCost, -1);
}


//  Castle built effect
void EffectFunction10134(int playerId = -1)
{
    ModResource(playerId, cAttributeFood, 10000);
}


//  Interface
void AbilityApplier(int playerId = -1)
{
    SetNewArmorForms(playerId);
    KhanInit(playerId);
    MangonelAdjustment(playerId);
    SetCustomResources(playerId);
    UniqueUnitInit();
    DataCountInit(playerId);
}