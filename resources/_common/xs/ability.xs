//  ability.xs is to endow units with abilities
//  AbilityApplier() is the interface


include "units.xs";


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


void EffectFunction10030(int playerId = -1)  //  Switch to training Champi Warrior
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, ChampiScoutID, playerId);
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
    SetResource(playerId, cAttributeShrineSpawnTime, 40);
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


void EffectFunction10106(int playerId = -1)  //  Switch to training Guecha Warrior
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, GuechaWarriorID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 70);
}


void EffectFunction10107(int playerId = -1)  //  Switch to training Temple Guard
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, TempleGuardID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 80);
}


void EffectFunction10108(int playerId = -1)  //  Switch to training Kona
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, KonaID, playerId);
    SetResource(playerId, cAttributeShrineSpawnTime, 75);
}


void EffectFunction10109(int playerId = -1)  //  Switch to training Bolas Rider
{
    SetResource(playerId, cAttributeShrineSpawnUnitID, BolasRiderID);
    SetResource(playerId, cAttributeShrineSpawnTime, 60);
}


void EffectFunction10110(int playerId = -1)  //  Switch to training Blackwood Archer
{
    SetResource(playerId, cAttributeShrineSpawnUnitID, BlackwoodArcherID);
    SetResource(playerId, cAttributeShrineSpawnTime, 60);
}


void EffectFunction10111(int playerId = -1)  //  Switch to training Ibirapema Warrior
{
    SetResource(playerId, cAttributeShrineSpawnUnitID, IbirapemaWarriorID);
    SetResource(playerId, cAttributeShrineSpawnTime, 65);
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
    SetInfinityStacking(playerId, 3100);
    SetInfinityStacking(playerId, 3101);
    SetInfinityStacking(playerId, 3103);
    SetInfinityStacking(playerId, 3104);
    SetInfinityStacking(playerId, 3105);
    SetInfinityStacking(playerId, 3106);
    SetInfinityStacking(playerId, 3118);
    SetInfinityStacking(playerId, 3119);
    SetInfinityStacking(playerId, 3127);
    SetInfinityStacking(playerId, 3482);
    SetInfinityStacking(playerId, 3483);
    SetInfinityStacking(playerId, 3484);
    SetInfinityStacking(playerId, 3485);
    SetInfinityStacking(playerId, 3486);
    SetInfinityStacking(playerId, 3487);
    SetResource(playerId, cAttributeShrineSpawnUnitID, ChampiScoutID);
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


//  Malay civ bonus, ships generate food
void EffectFunction10091(int playerId = -1)
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


//  10093 - C-Bonus, Cavalry +50% base attack vs skirmishers
void EffectFunction10093(int playerId = -1)
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
    AddAttackForm(playerId, cSiegeWeaponClass, cDamageClassSiegeWeaponAttack, -10);
    AddAttackForm(playerId, cPackedUnitClass, cDamageClassSiegeWeaponAttack, -10);
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


//  10090 - Marauders Adjustment
void EffectFunction10090(int playerId = -1)
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
    xsTaskAmount(cTaskAttrResourceIn, FoederatiArmyKillEffectID);
    xsTaskAmount(cTaskAttrSearchWaitTime, 1.000008);
    ApplyToAllPlayerTargets(playerId, FoederatiSwordmanID, cTaskTypeLoot);
    ApplyToAllPlayerTargets(playerId, FoederatiCavalryArcherID, cTaskTypeLoot);
    ApplyToAllPlayerTargets(playerId, FoederatiKnightID, cTaskTypeLoot);
    xsResetTaskAmount();
}


//  10084 - Foederati Army Kill Effect
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


//  10098 - Malay TC aura display
void EffectFunction10098(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, MalayTCAuraRange);
    xsTaskAmount(cTaskAttrSearchWaitTime, 3.000001);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 4);
    xsTask(TownCenterID, cTaskTypeAura, cBuildingClass, playerId);
    xsTask(TownCenter2ID, cTaskTypeAura, cBuildingClass, playerId);
    xsTask(TownCenter3ID, cTaskTypeAura, cBuildingClass, playerId);
    xsTask(TownCenter4ID, cTaskTypeAura, cBuildingClass, playerId);
    xsResetTaskAmount();
    LaunchAura(playerId, TownCenterID);
    LaunchAura(playerId, TownCenter2ID);
    LaunchAura(playerId, TownCenter3ID);
    LaunchAura(playerId, TownCenter4ID);
}


//  10117 - C-Bonus, unique tech from allies
void EffectFunction10117(int playerId = -1)
{
    static int TechIDArray = -1;

    if (TechIDArray == -1)
    {
        TechIDArray = xsArrayCreateInt(100, 0);
        ArrayMultipleSetInt(TechIDArray, 1, 461, 493, 457, 11, 59, 52, 61, 7, 454, 10);
        ArrayMultipleSetInt(TechIDArray, 11, 49, 6, 5, 440, 24, 4, 21, 445, 902, 507);
        ArrayMultipleSetInt(TechIDArray, 21, 517, 515, 513, 573, 575, 577, 579, 623, 625, 626);
        ArrayMultipleSetInt(TechIDArray, 31, 629, 686, 688, 690, 692, 755, 757, 783, 785, 832);
        ArrayMultipleSetInt(TechIDArray, 41, 834, 836, 884, 921, 924, 1113, 1123, 1133, 1069, 1081);
        ArrayMultipleSetInt(TechIDArray, 51, 1062, 997, 1007, 1285, 1298, 1309, 1366, 1380, 1393, 0);
    }

    int i = 0;
    for (i = 1; <= xsGetNumPlayers())
        if ((i != playerId) && (isAlly(i, playerId)))
        {
            int UniqueTechID = xsArrayGetInt(TechIDArray, xsGetPlayerCivilization(i));
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


//  Interface
void AbilityApplier(int playerId = -1)
{
    SetNewAttackForms(playerId);
    SetNewArmorForms(playerId);
    AssassinInit(playerId);
    VikingRaiderInit(playerId);
    TCSpawnedDeerInit(playerId);
    ShrineInit(playerId);
    KhanInit(playerId);
    FoederatiArmyInit(playerId);
}