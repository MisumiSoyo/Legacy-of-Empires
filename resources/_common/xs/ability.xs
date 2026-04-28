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
    xsEffectAmount(cModifyTech, TechID, cAttrMulTime, 3, playerId);
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
void EffectFunction10008(int playerId = -1)
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
    ApplyToAllMilitaryTargets(playerId, cPhalanxClass, cTaskTypeLoot);
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
    xsTaskAmount(cTaskAttrWorkValue1, -0.08);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);
    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.08);
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


void EffectFunction10053(int playerId = -1)
{
    ModAttackBonus(playerId, cInfantryClass, 1);
}


void EffectFunction10054(int playerId = -1)
{
    ModAttackBonus(playerId, cInfantryClass, 1);
}


void EffectFunction10055(int playerId = -1)
{
    ModAttackBonus(playerId, cInfantryClass, 1);
}


void EffectFunction10056(int playerId = -1)
{
    ModAttackBonus(playerId, cArcherClass, 1);
    ModAttackBonus(playerId, cCavalryArcherClass, 1);
    ModAttackBonus(playerId, cHandCannoneerClass, 1);
}


void EffectFunction10057(int playerId = -1)
{
    ModAttackBonus(playerId, cArcherClass, 1);
    ModAttackBonus(playerId, cCavalryArcherClass, 1);
    ModAttackBonus(playerId, cHandCannoneerClass, 1);
}


void EffectFunction10058(int playerId = -1)
{
    ModAttackBonus(playerId, cArcherClass, 1);
    ModAttackBonus(playerId, cCavalryArcherClass, 1);
    ModAttackBonus(playerId, cHandCannoneerClass, 1);
}


//  10061 - Bengalis relic, monk hit points
void EffectFunction10061(int playerId = -1)
{
    SetResource(playerId, cAttributeBengalisRelicBonus, 1);
    DisableTech(playerId, BengalisMeleeAttackTechID);
    DisableTech(playerId, BengalisArcherArmorTechID);
    DisableTech(playerId, BengalisNavyBonusTechID);
}


//  10062 - Bengalis relic, melee attack bonus
void EffectFunction10062(int playerId = -1)
{
    SetResource(playerId, cAttributeBengalisRelicBonus, 2);
    DisableTech(playerId, BengalisMonkArmorTechID);
    DisableTech(playerId, BengalisArcherArmorTechID);
    DisableTech(playerId, BengalisNavyBonusTechID);
}


//  10063 - Bengalis relic, archer armor
void EffectFunction10063(int playerId = -1)
{
    SetResource(playerId, cAttributeBengalisRelicBonus, 3);
    DisableTech(playerId, BengalisMonkArmorTechID);
    DisableTech(playerId, BengalisMeleeAttackTechID);
    DisableTech(playerId, BengalisNavyBonusTechID);
}


//  10064 - Bengalis relic, navy bonus
void EffectFunction10064(int playerId = -1)
{
    SetResource(playerId, cAttributeBengalisRelicBonus, 4);
    DisableTech(playerId, BengalisMonkArmorTechID);
    DisableTech(playerId, BengalisMeleeAttackTechID);
    DisableTech(playerId, BengalisArcherArmorTechID);
}


void RelicMonkArmor(int playerId = -1, int RelicCount = 0, int RelicCounted = 0)
{
    ModAttribute(playerId, cMonkClass, cHitpoints, (RelicCount - RelicCounted) *  20);
    ModAttribute(playerId, cMonkWithRelicClass, cHitpoints, (RelicCount - RelicCounted) *  20);
}


void RelicInfCavAttack(int playerId = -1, int RelicCount = 0, int RelicCounted = 0)
{
    ModAttack(playerId, cInfantryClass, cDamageClassMelee, RelicCount - RelicCounted);
    ModAttack(playerId, cCavalryClass, cDamageClassMelee, RelicCount - RelicCounted);
    ModAttack(playerId, cScoutCavalryClass, cDamageClassMelee, RelicCount - RelicCounted);
    ModAttack(playerId, MountedTrebuchetID, cDamageClassMelee, RelicCounted - RelicCount);
}


void RelicArcherArmor(int playerId = -1, int RelicCount = 0, int RelicCounted = 0)
{
    ModArmor(playerId, cArcherClass, cDamageClassPierce, RelicCount - RelicCounted);
    ModArmor(playerId, cConquistadorClass, cDamageClassPierce, RelicCount - RelicCounted);
    ModArmor(playerId, cCavalryArcherClass, cDamageClassPierce, RelicCount - RelicCounted);
    ModArmor(playerId, cHandCannoneerClass, cDamageClassPierce, RelicCount - RelicCounted);
    ModArmor(playerId, cArcherClass, cDamageClassMelee, RelicCount - RelicCounted);
    ModArmor(playerId, cConquistadorClass, cDamageClassMelee, RelicCount - RelicCounted);
    ModArmor(playerId, cCavalryArcherClass, cDamageClassMelee, RelicCount - RelicCounted);
    ModArmor(playerId, cHandCannoneerClass, cDamageClassMelee, RelicCount - RelicCounted);
}


void RelicNavyAttack(int playerId = -1, int RelicCount = 0, int RelicCounted = 0)
{
    ModAttack(playerId, cWarshipClass, cDamageClassPierce, RelicCount - RelicCounted);
    ModAttack(playerId, cWarshipClass, cDamageClassMelee, RelicCount - RelicCounted);
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


//  10077 - C-Bonus, unique tech from allies
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
        if ((i != playerId) && (isAlly(i, playerId)))
        {
            int UniqueTechID = xsArrayGetInt(CastleTechIDArray, xsGetPlayerCivilization(i));
            if (xsGetTechState(playerId, UniqueTechID) < cTechStateNotReady)
            {
                xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetState, cAttributeForce, playerId);
                if (i <= 4)
                {
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 25, playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetHotkey, KeyToHotkeyID(i), playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetLocation, UniversityID, playerId);
                }
                else
                {
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 26, playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetHotkey, KeyToHotkeyID(i + 1), playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetLocation, UniversityID, playerId);
                }
            }
        }
}


//  10078 - C-Bonus, unique tech from allies
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
        if ((i != playerId) && (isAlly(i, playerId)))
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


void FeitoriaAdjustment(int playerId = -1)
{
    SetAttribute(playerId, FeitoriaID, cAmountFirstStorage, -15);
    SetAttribute(playerId, FeitoriaID, cAmountSecondStorage, 15);
    SetAttribute(playerId, FeitoriaID, cAmountThirdStorage, 15);
}


void GenitourAdjustment(int playerId = -1)
{
    SetAttribute(playerId, GenitourID, cTrainButton, 21);
    SetAttribute(playerId, GenitourID, cHotkeyId, QHotkeyID);
    SetAttribute(playerId, EliteGenitourID, cTrainButton, 21);
    SetAttribute(playerId, EliteGenitourID, cHotkeyId, QHotkeyID);
}


//  10097 - Manila Galleon + Blacksmith techs
void EffectFunction10097(int playerId = -1)
{
    ModAttack(playerId, ManilaGalleonID, cDamageClassPierce, 1);
    ModAttribute(playerId, ManilaGalleonID, cLineOfSight, 1);
    ModAttribute(playerId, ManilaGalleonID, cMaxRange, 1);

    if (isResearched(playerId, ManilaGalleonTechID))
        UpgradeUnit(playerId, TradeCogID, ManilaGalleonID);
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



int UniqueUnitIDArray = -1;
int EliteUniqueUnitIDArray = -1;
int UniqueUnitTechIDArray = -1;
int EliteUniqueUnitTechIDArray = -1;
int FlagArray = -1;


void UniqueUnitInit()
{
    if (UniqueUnitIDArray == -1)
    {
        UniqueUnitIDArray = xsArrayCreateInt(100, 0);
        ArrayMultipleSetInt(UniqueUnitIDArray, 1, 8, 281, 41, 25, 291, 73, 40, 239, 282, 46);
        ArrayMultipleSetInt(UniqueUnitIDArray, 11, 692, 11, 232, 771, 725, 763, 755, 827, 866, 1747);
        ArrayMultipleSetInt(UniqueUnitIDArray, 21, 879, 869, 876, 1001, 1016, 1013, 1007, 1120, 1123, 1126);
        ArrayMultipleSetInt(UniqueUnitIDArray, 31, 1129, 1225, 1228, 1231, 1234, 1655, 1658, 1701, 1704, 1735);
        ArrayMultipleSetInt(UniqueUnitIDArray, 41, 1759, 1741, 1790, 1800, 1803, 2101, 2104, 2107, 1959, 1968);
        ArrayMultipleSetInt(UniqueUnitIDArray, 51, 1949, 1908, 1920, 2382, 2386, 2388, 2562, 2566, 2579, 0);

        EliteUniqueUnitIDArray = xsArrayCreateInt(100, 0);
        ArrayMultipleSetInt(EliteUniqueUnitIDArray, 1, 530, 531, 555, 554, 560, 559, 553, 558, 556, 557);
        ArrayMultipleSetInt(EliteUniqueUnitIDArray, 11, 694, 561, 534, 773, 726, 765, 757, 829, 868, 1749);
        ArrayMultipleSetInt(EliteUniqueUnitIDArray, 21, 881, 871, 878, 1003, 1018, 1015, 1009, 1122, 1125, 1128);
        ArrayMultipleSetInt(EliteUniqueUnitIDArray, 31, 1131, 1227, 1230, 1233, 1236, 1657, 1659, 1703, 1706, 1737);
        ArrayMultipleSetInt(EliteUniqueUnitIDArray, 41, 1761, 1743, 1792, 1802, 1805, 2102, 2105, 2108, 1961, 1970);
        ArrayMultipleSetInt(EliteUniqueUnitIDArray, 51, 1951, 1910, 1922, 2383, 2387, 2389, 2564, 2568, 2581, 0);

        UniqueUnitTechIDArray = xsArrayCreateInt(100, 0);
        ArrayMultipleSetInt(UniqueUnitTechIDArray, 1, 263, 275, 446, 276, 262, 268, 267, 274, 269, 271);
        ArrayMultipleSetInt(UniqueUnitTechIDArray, 11, 399, 273, 277, 58, 431, 26, 1, 449, 467, 839);
        ArrayMultipleSetInt(UniqueUnitTechIDArray, 21, 508, 471, 503, 562, 568, 566, 564, 614, 616, 618);
        ArrayMultipleSetInt(UniqueUnitTechIDArray, 31, 620, 677, 679, 681, 683, 750, 752, 778, 780, 825);
        ArrayMultipleSetInt(UniqueUnitTechIDArray, 41, 827, 829, 881, 917, 919, 1114, 1124, 1134, 1063, 1073);
        ArrayMultipleSetInt(UniqueUnitTechIDArray, 51, 1035, 990, 1001, 1288, 1300, 1325, 1363, 1375, 1388, 0);

        EliteUniqueUnitTechIDArray = xsArrayCreateInt(100, 0);
        ArrayMultipleSetInt(EliteUniqueUnitTechIDArray, 1, 360, 363, 365, 364, 366, 362, 361, 367, 368, 369);
        ArrayMultipleSetInt(EliteUniqueUnitTechIDArray, 11, 398, 371, 370, 60, 432, 27, 2, 450, 468, 840);
        ArrayMultipleSetInt(EliteUniqueUnitTechIDArray, 21, 509, 472, 504, 563, 569, 567, 565, 615, 617, 619);
        ArrayMultipleSetInt(EliteUniqueUnitTechIDArray, 31, 621, 678, 680, 682, 684, 751, 753, 779, 781, 826);
        ArrayMultipleSetInt(EliteUniqueUnitTechIDArray, 41, 828, 830, 882, 918, 920, 1115, 1125, 1135, 1064, 1074);
        ArrayMultipleSetInt(EliteUniqueUnitTechIDArray, 51, 1036, 991, 1002, 1289, 1301, 1326, 1364, 1376, 1389, 0);
    }
}


//  10015 - C-Bonus, random mercenaries
void EffectFunction10015(int playerId = -1)
{
    UniqueUnitInit();
    if (FlagArray == -1)
        FlagArray = xsArrayCreateInt(100, 0);

    int i = 0;
    int tmp = 0;
    int TargetUniqueUnitID = 0;
    int TargetEliteUniqueUnitID = 0;
    int TargetUniqueUnitTechID = 0;
    for (i = 1; <= CivCount)
        if ((i != cByzantines) && (isChroniclesCiv(i) == false))
            xsArraySetInt(FlagArray, i, 0);
        else
            xsArraySetInt(FlagArray, i, 1);
    for (i = 1; <= 4)
    {
        while (true)
        {
            tmp = xsGetRandomNumberMax(CivCount) + 1;
            if (xsArrayGetInt(FlagArray, tmp) == 0)
                break;
        }
        xsArraySetInt(FlagArray, tmp, 1);
        TargetUniqueUnitID = xsArrayGetInt(UniqueUnitIDArray, tmp);
        TargetEliteUniqueUnitID = xsArrayGetInt(EliteUniqueUnitIDArray, tmp);
        TargetUniqueUnitTechID = xsArrayGetInt(UniqueUnitTechIDArray, tmp);
        ForceResearchTech(playerId, TargetUniqueUnitTechID);
        SetAttribute(playerId, TargetUniqueUnitID, cTrainButton, 20 + i);
        SetAttribute(playerId, TargetEliteUniqueUnitID, cTrainButton, 20 + i);
        SetAttribute(playerId, TargetUniqueUnitID, cHotkeyId, KeyToHotkeyID(20 + i));
        SetAttribute(playerId, TargetUniqueUnitID, cHotkeyId, KeyToHotkeyID(20 + i));
        SetAttribute(playerId, TargetEliteUniqueUnitID, cHotkeyId, KeyToHotkeyID(20 + i));
        SetAttribute(playerId, TargetEliteUniqueUnitID, cHotkeyId, KeyToHotkeyID(20 + i));
        SetResource(playerId, cAttributeByzantinesMercenaryIDStart + i - 1, tmp);
    }
}


//  10111 - C-Bonus, random mercenaries age 4
void EffectFunction10111(int playerId = -1)
{
    int i = 0;
    int TargetEliteUniqueUnitTechID = 0;

    UniqueUnitInit();
    for (i = 1; <= 4)
    {
        int TargetCivID = xsPlayerAttribute(playerId, cAttributeByzantinesMercenaryIDStart + i - 1);
        TargetEliteUniqueUnitTechID = xsArrayGetInt(EliteUniqueUnitTechIDArray, TargetCivID);
        xsEffectAmount(cModifyTech, TargetEliteUniqueUnitTechID, cAttrSetButton, 25 + i);
        xsEffectAmount(cModifyTech, TargetEliteUniqueUnitTechID, cAttrSetHotkey, KeyToHotkeyID(25 + i));
        ForceEnableTech(playerId, TargetEliteUniqueUnitTechID);
    }
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


//  10112 - Ixiptla kill effect
void EffectFunction10112(int playerId = -1)
{
    int KillCount = xsPlayerAttribute(playerId, cAttributeIxipltaKillCount) + 1;
    if (KillCount % 7 == 0)
        SpawnUnit(playerId, JaguarWarriorID, CastleID, 1, 1);
    SetResource(playerId, cAttributeIxipltaKillCount, KillCount);
}


//  Interface
void AbilityApplier(int playerId = -1)
{
    SetNewArmorForms(playerId);
    FoederatiArmyInit(playerId);
    AssassinInit(playerId);
    KhanInit(playerId);
    MangonelAdjustment(playerId);
    SetCustomResources(playerId);
    FeitoriaAdjustment(playerId);
    GenitourAdjustment(playerId);
}