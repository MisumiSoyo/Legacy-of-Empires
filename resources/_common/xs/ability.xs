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


void EffectFunction10061(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModArmor(playerId, cMonkClass, cDamageClassMelee, 2);
    ModArmor(playerId, cMonkClass, cDamageClassPierce, 3);
    ModArmor(playerId, cMonkWithRelicClass, cDamageClassMelee, 2);
    ModArmor(playerId, cMonkWithRelicClass, cDamageClassPierce, 3);
    ModAttribute(playerId, cMonkClass, cHitpoints, 15);
    ModAttribute(playerId, cMonkWithRelicClass, cHitpoints, 15);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


void EffectFunction10062(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModAttack(playerId, MansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, VeteranMansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, EliteMansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, ScoutCavalryID, cDamageClassMelee, 2);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


void EffectFunction10063(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModArmor(playerId, 1738, cDamageClassPierce, 1);
    SetArmor(playerId, 1738, cDamageClassArchers, 254);
    ModArmor(playerId, 1740, cDamageClassPierce, 1);
    SetArmor(playerId, 1740, cDamageClassArchers, 254);
    ModArmor(playerId, 1759, cDamageClassPierce, 1);
    SetArmor(playerId, 1759, cDamageClassArchers, 254);
    ModArmor(playerId, 1761, cDamageClassPierce, 1);
    SetArmor(playerId, 1761, cDamageClassArchers, 254);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


void EffectFunction10064(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModAllyResource(playerId, cAttributeTradeFoodPercent, 10);
    ModAllyResource(playerId, cAttributeTradeWoodPercent, 10);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


void EffectFunction10065(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    MulAttribute(playerId, cInfantryClass, cAttackReloadTime, 1.0 / 1.15);
    ModArmor(playerId, cInfantryClass, cDamageClassMelee, 1);
    ModArmor(playerId, cInfantryClass, cDamageClassPierce, 1);
}


void EffectFunction10066(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    ModAttribute(playerId, cTradeBoatClass, cRegenerationRate, 15);
    ModAttribute(playerId, cFishingBoatClass, cRegenerationRate, 15);
    ModAttribute(playerId, cWarshipClass, cRegenerationRate, 15);
    ModAttribute(playerId, cBoardingShipClass, cRegenerationRate, 15);
    ModAttribute(playerId, cTransportShipClass, cRegenerationRate, 15);
}


void EffectFunction10067(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    SpawnUnit(playerId, 1738, 109, 1, 32767);
    SpawnUnit(playerId, 1738, 104, 1, 32767);
    SpawnUnit(playerId, 1738, 82, 1, 32767);
    ModAttribute(playerId, 1738, cWoodCost, -15);
    ModAttribute(playerId, 1740, cWoodCost, -15);
    ModAttribute(playerId, 1759, cWoodCost, -15);
    ModAttribute(playerId, 1761, cWoodCost, -15);
}


void EffectFunction10068(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    ModAttack(playerId, 873, cDamageClassPierce, 1);
    ModAttack(playerId, 875, cDamageClassPierce, 1);
    ModAttack(playerId, 873, cDamageClassSpearmen, 4);
    ModAttack(playerId, 875, cDamageClassSpearmen, 4);
}


void FlankingCavalryApplier(int playerId = -1, int ClassTarget = -1)
{
    ModAttribute(playerId, ClassTarget, cMaxCharge, 1);
    SetAttribute(playerId, ClassTarget, cChargeEvent, 0);
    SetAttribute(playerId, ClassTarget, cChargeType, 5);
}


//  10075 - Dacaogu Kill Effect
void EffectFunction10075(int playerId = -1)
{
    float CalcedValue = xsPlayerAttribute(playerId, cAttributeDacaoguCalcedValue);
    float TotalValue = xsPlayerAttribute(playerId, cAttributeTotalValueOfKills) - xsPlayerAttribute(playerId, cAttributeTotalValueOfRazings);
    ModResource(playerId, cAttributeFood, (TotalValue - CalcedValue) * 0.1);
    ModResource(playerId, cAttributeGold, (TotalValue - CalcedValue) * 0.04);
    SetResource(playerId, cAttributeDacaoguCalcedValue, TotalValue);
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
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 20, playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetHotkey, KeyToHotkeyID(i), playerId);
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetLocation, UniversityID, playerId);
                }
                else
                {
                    xsEffectAmount(cModifyTech, UniqueTechID, cAttrSetButton, i + 21, playerId);
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


void SetNewAttackForms(int playerId = -1)
{
    AddAttackForm(playerId, cSiegeWeaponClass, cDamageClassSiegeWeaponAttack, -10);
    AddAttackForm(playerId, cUnpackedSiegeUnitClass, cDamageClassSiegeWeaponAttack, -10);
    AddAttackForm(playerId, cScorpionClass, cDamageClassSiegeWeaponAttack, -10);

    AddAttackForm(playerId, cHandCannoneerClass, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, ConquistadorID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, EliteConquistadorID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, MercenaryConquistadorID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, MercenaryEliteConquistadorID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, BombardCannonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, HoufniceID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, HussiteWagonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, EliteHussiteWagonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, MercenaryHussiteWagonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, MercenaryEliteHussiteWagonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, PetardID, cDamageClassGunpowderAttack);
}


void SetNewArmorForms(int playerId = -1)
{
    AddArmorForm(playerId, cArcherClass, cDamageClassRoyalHeirs, -3);
    AddArmorForm(playerId, cHandCannoneerClass, cDamageClassRoyalHeirs, -3);

    AddArmorForm(playerId, MonasteryID, cDamageClassMonastery);
    AddArmorForm(playerId, Monastery2ID, cDamageClassMonastery);
    AddArmorForm(playerId, Monastery3ID, cDamageClassMonastery);
    AddArmorForm(playerId, Monastery4ID, cDamageClassMonastery);

    AddArmorForm(playerId, cVillagerClass, cDamageClassVillager);

    AddArmorForm(playerId, ScoutCavalryID, cDamageClassLightCavalry);
    AddArmorForm(playerId, LightCavalryID, cDamageClassLightCavalry);
    AddArmorForm(playerId, HussarID, cDamageClassLightCavalry);
    AddArmorForm(playerId, MagyarHuszarID, cDamageClassLightCavalry);
    AddArmorForm(playerId, EliteMagyarHuszarID, cDamageClassLightCavalry);
    AddArmorForm(playerId, MercenaryMagyarHuszarID, cDamageClassLightCavalry);
    AddArmorForm(playerId, MercenaryEliteMagyarHuszarID, cDamageClassLightCavalry);

    AddArmorForm(playerId, cTradeBoatClass, cDamageClassTradeUnit);
    AddArmorForm(playerId, cTradeCartClass, cDamageClassTradeUnit);
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

    int i = 0;
    for (i = 900; <= 964)
        if (isClassOperable(i) && (isBuildingClass(i) == false))
            xsTask(KhanID, cTaskTypeLoot, i, playerId);
    xsResetTaskAmount();

    xsTaskAmount(cTaskAttrSearchWaitTime, 10.000002);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrWorkValue1, 1.0 - 1.0 / 1.25);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 47);

    for (i = 900; <= 964)
        if (isMilitaryClass(i))
            xsTask(KhanID, cTaskTypeAura, i, playerId);

    xsTaskAmount(cTaskAttrSearchWaitTime, 5.000001);
    xsTaskAmount(cTaskAttrWorkValue1, 1.15);
    for (i = 900; <= 964)
        if (isMilitaryClass(i))
            xsTask(KhanID, cTaskTypeAura, i, playerId);
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


//  Interface
void AbilityApplier(int playerId = -1)
{
    SetNewAttackForms(playerId);
    SetNewArmorForms(playerId);
    FoederatiArmyInit(playerId);
    AssassinInit(playerId);
    KhanInit(playerId);
    MangonelAdjustment(playerId);
}