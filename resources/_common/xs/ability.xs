//  ability.xs is to endow units with abilities
//  AbilityApplier() is the interface


include "units.xs";


//  Assasins' Ability
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

    xsTaskAmount(cTaskAttrWorkValue1, -60);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 120.00001);
    xsTask(AssassinID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 60);
    xsTask(AssassinID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cTowerClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -20);
    xsTaskAmount(cTaskAttrSearchWaitTime, 120.00002);
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
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.00003);
    xsTaskAmount(cTaskAttrGatherType, -100);
    xsTask(AssassinID, cTaskTypeLoot, -1, playerId);
    xsTaskAmount(cTaskAttrGatherType, 100);
    xsTask(AssassinID, cTaskTypeLoot, cBuildingClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cWallClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cGateClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cFarmClass, playerId);
    xsTask(AssassinID, cTaskTypeLoot, cTowerClass, playerId);
    xsResetTaskAmount();
}


//  Berserks regenerate HP and increase attack speed when attacking
void BerserkInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 109);
    xsTaskAmount(cTaskAttrWorkValue1, 360);
    xsTask(BerserkID, cTaskTypeStinger, -1, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -360);
    xsTask(BerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 480);
    xsTask(EliteBerserkID, cTaskTypeStinger, -1, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -480);
    xsTask(EliteBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cTowerClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, -0.1);
    xsTaskAmount(cTaskAttrWorkValue2, 6);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10.000001);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTask(BerserkID, cTaskTypeStinger, -1, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.1);
    xsTask(BerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(MercenaryBerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -0.1);
    xsTask(EliteBerserkID, cTaskTypeStinger, -1, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.1);
    xsTask(EliteBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(MercenaryEliteBerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsResetTaskAmount();

    LaunchStinger(playerId, BerserkID);
    LaunchStinger(playerId, EliteBerserkID);
    LaunchStinger(playerId, MercenaryBerserkID);
    LaunchStinger(playerId, MercenaryEliteBerserkID);
}



//  Viking Raider Task
void VikingRaiderInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceIn, 3085);

    xsTask(VikingRaiderID, cTaskTypeLoot, cArcherClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cTradeBoatClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cVillagerClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cInfantryClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cCavalryClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cSiegeWeaponClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cMonkClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cTradeCartClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cFishingBoatClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cWarshipClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cConquistadorClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cPetardClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cCavalryArcherClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cMonkWithRelicClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cHandCannoneerClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cScoutCavalryClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cPackedUnitClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cUnpackedSiegeUnitClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cScorpionClass, playerId);
    xsTask(VikingRaiderID, cTaskTypeLoot, cKingClass, playerId);
    xsResetTaskAmount();
}


// 10019 - Viking Raider Kill Effect
void EffectFunction10019(int playerId = -1)
{
    int VikingRaiderKillCount = xsPlayerAttribute(playerId, cAttributeVikingRaiderKills);
    float AttackSpeedBonus = minFloat(0.1 * (VikingRaiderKillCount / 20), 0.5);
    VikingRaiderKillCount = VikingRaiderKillCount + 1;
    float CurrentAttackSpeedBonus = minFloat(0.1 * (VikingRaiderKillCount / 20), 0.5);
    if (AttackSpeedBonus < CurrentAttackSpeedBonus)
        MulAttribute(playerId, VikingRaiderID, cAttackReloadTime, (AttackSpeedBonus + 1.0) / (CurrentAttackSpeedBonus + 1.0));
    SetResource(playerId, cAttributeVikingRaiderKills, VikingRaiderKillCount);
}


void EffectFunction10030(int playerId = -1)  //  Switch to training Militia
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, MilitiaID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 45);
}

void EffectFunction10031(int playerId = -1)  //  Switch to training Spearman
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, SpearmanID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 36);
}

void EffectFunction10032(int playerId = -1)  //  Switch to training Eagle Scout
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, EagleScoutID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 50);
}

void EffectFunction10033(int playerId = -1)  //  Switch to training Archer
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, ArcherID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 50);
}

void EffectFunction10034(int playerId = -1)  //  Switch to training Skirmisher
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, SkirmisherID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 36);
}


void EffectFunction10035(int playerId = -1)  //  Switch to training Slinger
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, SlingerID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 55);
}


void EffectFunction10036(int playerId = -1)  //  Switch to training Kamayuk
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, KamayukID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 60);
}


void EffectFunction10043(int playerId = -1)  //  Switch to training Jaguar Warrior
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, JaguarWarriorID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 60);
}


void EffectFunction10044(int playerId = -1)  //  Switch to training Plumed Archer
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, PlumedArcherID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 60);
}


void EffectFunction10045(int playerId = -1)  //  Switch to training Xolotl
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, XolotlWarriorID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 45);
}


void TCSpawnedDeerInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 120.0000005);
    xsTaskAmount(cTaskAttrWorkRange, 2);
    xsTaskAmount(cTaskAttrWorkValue1, -4);  //  die in 15 seconds
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTask(4054, cTaskTypeAura, 109, playerId);
    xsTask(4054, cTaskTypeAura, 71, playerId);
    xsTask(4054, cTaskTypeAura, 141, playerId);
    xsTask(4054, cTaskTypeAura, 142, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, 4054, true);
}

void ShrineInit(int playerId = -1)
{
    int i = 0;
    for (i = 3100; <= 3127)
        if ((3100 <= i) && (i <= 3106) || (i == 3118) || (i == 3119) || (i == 3127))
        {
            xsEffectAmount(cModifyTech, i, cAttrSetStacking, 1, playerId);
            xsEffectAmount(cModifyTech, i, cAttrSetStackingResearchCap, 32767, playerId);
        }
    SetResource(playerId, cAttributeShrineSpawnUnitID, MilitiaID);
    SetResource(playerId, cAttributeShrineSpawnTime, 45);
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


void MalayShipInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrWorkValue1, 8.0 / 60);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeWarShipFoodProductivity);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(cWarshipClass, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeWarShipFoodProductivity, 1);
}


void BengalisCavalryVSSkirmisher(int playerId = -1)
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


void EffectFunction10049(int playerId = -1)
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


void EffectFunction10050(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModAttack(playerId, MansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, VeteranMansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, EliteMansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, ScoutCavalryID, cDamageClassMelee, 2);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


void EffectFunction10051(int playerId = -1)
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


void EffectFunction10052(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModAllyResource(playerId, cAttributeTradeFoodPercent, 10);
    ModAllyResource(playerId, cAttributeTradeWoodPercent, 10);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


void EffectFunction10053(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    MulAttribute(playerId, cInfantryClass, cAttackReloadTime, 1.0 / 1.15);
    ModArmor(playerId, cInfantryClass, cDamageClassMelee, 1);
    ModArmor(playerId, cInfantryClass, cDamageClassPierce, 1);
}


void EffectFunction10054(int playerId = -1)
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


void EffectFunction10055(int playerId = -1)
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


void EffectFunction10056(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    ModAttack(playerId, 873, cDamageClassPierce, 1);
    ModAttack(playerId, 875, cDamageClassPierce, 1);
    ModAttack(playerId, 873, cDamageClassSpearmen, 4);
    ModAttack(playerId, 875, cDamageClassSpearmen, 4);
}


void KeshikStinger(int playerId = -1, float Rate = 0.0)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000008);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 3.0 * 60 * Rate);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrOwnerType, 0);

    xsTask(KeshikID, cTaskTypeStinger, -1, playerId);
    xsTask(MercenaryKeshikID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 4.0 * 60 * Rate);
    xsTask(EliteKeshikID, cTaskTypeStinger, -1, playerId);
    xsTask(MercenaryEliteKeshikID, cTaskTypeStinger, -1, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, 0.0 - 3.0 * 60 * Rate);
    xsTask(KeshikID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(KeshikID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(KeshikID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(KeshikID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(KeshikID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(MercenaryKeshikID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(MercenaryKeshikID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(MercenaryKeshikID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(MercenaryKeshikID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(MercenaryKeshikID, cTaskTypeStinger, cFarmClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.0 - 4.0 * 60 * Rate);
    xsTask(EliteKeshikID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(EliteKeshikID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(EliteKeshikID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(EliteKeshikID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(EliteKeshikID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(MercenaryEliteKeshikID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(MercenaryEliteKeshikID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(MercenaryEliteKeshikID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(MercenaryEliteKeshikID, cTaskTypeStinger, cTowerClass, playerId);
    xsTask(MercenaryEliteKeshikID, cTaskTypeStinger, cFarmClass, playerId);
    xsResetTaskAmount();
    LaunchStinger(playerId, KeshikID);
    LaunchStinger(playerId, EliteKeshikID);
    LaunchStinger(playerId, MercenaryKeshikID);
    LaunchStinger(playerId, MercenaryEliteKeshikID);
    if ((xsGetPlayerCivilization(playerId) == cMongols) || (xsGetPlayerCivilization(playerId) == cTatars))
        if (isResearched(playerId, CavalierTechID))
            UpgradeUnit(playerId, KnightID, EliteKeshikID);
        else
            UpgradeUnit(playerId, KnightID, KeshikID);
    SetResource(playerId, 213, 0);
}


void EffectFunction10058(int playerId = -1)
{
    ModAttackBonus(playerId, cInfantryClass, 1);
}


void EffectFunction10059(int playerId = -1)
{
    ModAttackBonus(playerId, cInfantryClass, 1);
}


void EffectFunction10060(int playerId = -1)
{
    ModAttackBonus(playerId, cInfantryClass, 1);
}


void EffectFunction10074(int playerId = -1)
{
    ModAttackBonus(playerId, cArcherClass, 1);
    ModAttackBonus(playerId, cCavalryArcherClass, 1);
    ModAttackBonus(playerId, cHandCannoneerClass, 1);
}


void EffectFunction10075(int playerId = -1)
{
    ModAttackBonus(playerId, cArcherClass, 1);
    ModAttackBonus(playerId, cCavalryArcherClass, 1);
    ModAttackBonus(playerId, cHandCannoneerClass, 1);
}


void EffectFunction10076(int playerId = -1)
{
    ModAttackBonus(playerId, cArcherClass, 1);
    ModAttackBonus(playerId, cCavalryArcherClass, 1);
    ModAttackBonus(playerId, cHandCannoneerClass, 1);
}


void SetNewAttackForms(int playerId = -1)
{
    SetAttack(playerId, cSiegeWeaponClass, cDamageClassSiegeWeaponAttack, -10);
    SetAttack(playerId, cPackedUnitClass, cDamageClassSiegeWeaponAttack, -10);
    SetAttack(playerId, cUnpackedSiegeUnitClass, cDamageClassSiegeWeaponAttack, -10);
    SetAttack(playerId, cScorpionClass, cDamageClassSiegeWeaponAttack, -10);
}


void KhanInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrWorkFlag2, 30);
    xsTaskAmount(cTaskAttrCarryCheck, 1);
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


void SultansApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, 0.0 - 9.0 * 60);
    xsTask(cInfantryClass, cTaskTypeStinger, ClassTarget, playerId);
    xsTask(cCavalryClass, cTaskTypeStinger, ClassTarget, playerId);
    xsTask(cScoutCavalryClass, cTaskTypeStinger, ClassTarget, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.0 - 6.0 * 60);
    xsTask(cArcherClass, cTaskTypeStinger, ClassTarget, playerId);
    xsTask(cCavalryArcherClass, cTaskTypeStinger, ClassTarget, playerId);
    xsTask(cConquistadorClass, cTaskTypeStinger, ClassTarget, playerId);
    xsTask(cHandCannoneerClass, cTaskTypeStinger, ClassTarget, playerId);
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



//  10022 - Tributary System
void EffectFunction10022(int playerId = -1)
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


void PoisoningApplier(int playerId = -1, int ClassTarget = -1)
{
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.000003);
    xsTaskAmount(cTaskAttrWorkValue1, -90);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 90);
    xsTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);

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


void AnarchyTarkanAdjustment(int playerId = -1)
{
    SetAttribute(playerId, Tarkan2ID, cTrainLocationsEntryMod, 1);
    SetAttribute(playerId, Tarkan2ID, cTrainButton, 3);
    SetAttribute(playerId, Tarkan2ID, cHotkeyId, 16085);
    SetAttribute(playerId, Tarkan2ID, cTrainLocationsEntryMod, 0);
    SetAttribute(playerId, EliteTarkan2ID, cTrainLocationsEntryMod, 1);
    SetAttribute(playerId, EliteTarkan2ID, cTrainButton, 3);
    SetAttribute(playerId, EliteTarkan2ID, cHotkeyId, 16085);
    SetAttribute(playerId, EliteTarkan2ID, cTrainLocationsEntryMod, 0);
}


void FoederatiArmyInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsResetTaskAmount();
}


void TangDynastyEffect(int playerId = -1)
{
    ModAttack(playerId, cInfantryClass, cDamageClassMelee, 2);
    ModAttack(playerId, cCavalryClass, cDamageClassMelee, 2);
    ModAttribute(playerId, cInfantryClass, cLineOfSight, 4);
    ModAttribute(playerId, cCavalryClass, cLineOfSight, 4);
}


void TangDynastyReset(int playerId = -1)
{
    ModAttack(playerId, cInfantryClass, cDamageClassMelee, -2);
    ModAttack(playerId, cCavalryClass, cDamageClassMelee, -2);
    ModAttribute(playerId, cInfantryClass, cLineOfSight, -4);
    ModAttribute(playerId, cCavalryClass, cLineOfSight, -4);
}


void SongDynastyEffect(int playerId = -1)
{
    ModAttribute(playerId, cTradeCartClass, cWoodCost, 0.8);
    ModAttribute(playerId, cTradeCartClass, cGoldCost, 0.8);
    ModAttribute(playerId, cTradeBoatClass, cWoodCost, 0.8);
    ModAttribute(playerId, cTradeBoatClass, cGoldCost, 0.8);
    ModResource(playerId, cAttributeResearchCostMod, -0.05);
    ModResource(playerId, cAttributeResearchTimeMod, -0.2);
}


void SongDynastyReset(int playerId = -1)
{
    ModAttribute(playerId, cTradeCartClass, cWoodCost, 1.25);
    ModAttribute(playerId, cTradeCartClass, cGoldCost, 1.25);
    ModAttribute(playerId, cTradeBoatClass, cWoodCost, 1.25);
    ModAttribute(playerId, cTradeBoatClass, cGoldCost, 1.25);
    ModResource(playerId, cAttributeResearchCostMod, 0.05);
    ModResource(playerId, cAttributeResearchTimeMod, 0.2);
}


//  Interface
void AbilityApplier(int playerId = -1)
{
    SetNewAttackForms(playerId);
    AssassinInit(playerId);
    BerserkInit(playerId);
    VikingRaiderInit(playerId);
    TCSpawnedDeerInit(playerId);
    ShrineInit(playerId);
    KeshikStinger(playerId, 0.5);
    KhanInit(playerId);
}