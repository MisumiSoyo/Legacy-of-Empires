//  ability.xs用于设置单位的独特能力
//  AbilityApplier()是接口，完成单位能力的设置


include "units.xs";


void RecordKiller()
{
    //  为了避免频繁的resize导致卡顿, 先开好足够大小的数组
    KilledUnits = xsArrayCreateInt(10000, 0, "KilledUnits");
    KilledUnitsCount = 0;
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrResourceIn, 3084);
    int i = 0;
    int j = 0;
    for (i = 0; <= xsGetNumPlayers())
        for (j = 900; <= 964)
            if (isClassOperable(j))	//这一步是判断种属是否可操作。当然也可以获取所有种属的单位，但我不确定会不会产生意料之外的问题
                xsTask(j, cTaskTypeLoot, -1, i);
}


void AztecsKillEffect(int KillerPlayer = -1, int UnitID = -1, int TargetPlayer = -1, int TargetUnitID = -1)
{
    int CastleID = 82;
    int KillsRequired = 7;
    int JaguarWarriorID = 725;
    if (xsGetTechState(3094, KillerPlayer) != cTechStateDone)
        return;
    int CurrentKill = xsPlayerAttribute(KillerPlayer, cAttributeAztecsKillCount) + 1;
    if (CurrentKill == KillsRequired)
    {
        xsEffectAmount(cModResource, cAttributeSpawnCap, 0, 1, KillerPlayer);
        xsEffectAmount(cSpawnUnit, JaguarWarriorID, CastleID, 1, KillerPlayer);
        CurrentKill = 0;
    }
    SetResource(KillerPlayer, cAttributeAztecsKillCount, CurrentKill);
}


//  契丹金冠效果, 陆地军事单位可获取相当于击杀的敌方单位(除建筑) 12.5% 训练费用的资源
void KhitansKillEffect(int KillerPlayer = -1, int UnitID = -1, int TargetPlayer = -1, int TargetUnitID = -1)
{
    float LootPercent = 0.125;

    if (xsGetTechState(3093, KillerPlayer) != cTechStateDone)
        return;
    if ((isLandMilitaryUnit(UnitID) == false) || isBuildingUnit(TargetUnitID))
        return;

    int TargetObjectID = xsGetUnitObjectId(TargetUnitID);
    float TargetFoodCost = xsGetObjectAttribute(TargetPlayer, TargetObjectID, cFoodCost);
    float TargetWoodCost = xsGetObjectAttribute(TargetPlayer, TargetObjectID, cWoodCost);
    float TargetGoldCost = xsGetObjectAttribute(TargetPlayer, TargetObjectID, cGoldCost);
    float TargetStoneCost = xsGetObjectAttribute(TargetPlayer, TargetObjectID, cStoneCost);

    xsEffectAmount(cModResource, cAttributeFood, 1, TargetFoodCost * LootPercent, KillerPlayer);
    xsEffectAmount(cModResource, cAttributeWood, 1, TargetWoodCost * LootPercent, KillerPlayer);
    xsEffectAmount(cModResource, cAttributeGold, 1, TargetGoldCost * LootPercent, KillerPlayer);
    xsEffectAmount(cModResource, cAttributeStone, 1, TargetStoneCost * LootPercent, KillerPlayer);
}


//  击杀效果
void KillEffect(int KillerPlayer = -1, int UnitID = -1, int TargetPlayer = -1, int TargetUnitID = -1)
{
    //xsChatData("KillerPlayer = " + KillerPlayer + " UnitID = " + UnitID + " TargetPlayer = " + TargetPlayer + " TargetUnitID = " + TargetUnitID);
    int KillerCiv = xsGetPlayerCivilization(KillerPlayer);
    int TargetCiv = xsGetPlayerCivilization(TargetPlayer);
    switch (KillerCiv)
    {
        case cAztecs:
        {
            AztecsKillEffect(KillerPlayer, UnitID, TargetPlayer, TargetUnitID);
            break;
        }
        case cKhitans:
        {
            KhitansKillEffect(KillerPlayer, UnitID, TargetPlayer, TargetUnitID);
            break;
        }
        default:
            break;
    }
}


//  阿萨辛, 冲锋技能, 攻击 1 次即死亡
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
    xsTaskAmount(cTaskAttrWorkValue1, -15);
    xsTaskAmount(cTaskAttrSearchWaitTime, 120.00002);
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTask(AssassinID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 15);
    xsTask(AssassinID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(AssassinID, cTaskTypeStinger, cTowerClass, playerId);
    xsResetTaskAmount();
    LaunchStinger(playerId, AssassinID);

    //  当前游戏bug, 如果本次攻击击杀了目标, 则157效果不触发, 因此使用154做特殊处理
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


//  维京狂战士, 攻击回复 8 生命值, -10% 基础攻击间隔
void BerserkInit(int playerId = -1)
{
    int BerserkID = 692;
    int EliteBerserkID = 694;

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 0);
    xsTaskAmount(cTaskAttrSearchWaitTime, 109);
    xsTaskAmount(cTaskAttrWorkValue1, 360);
    xsTask(BerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -360);
    xsTask(BerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 480);
    xsTask(EliteBerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -480);
    xsTask(EliteBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cTowerClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, -0.1);
    xsTaskAmount(cTaskAttrWorkValue2, 6);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
    xsTask(BerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.1);
    xsTask(BerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(BerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, -0.1);
    xsTask(EliteBerserkID, cTaskTypeStinger, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.1);
    xsTask(EliteBerserkID, cTaskTypeStinger, cBuildingClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cWallClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cGateClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cFarmClass, playerId);
    xsTask(EliteBerserkID, cTaskTypeStinger, cTowerClass, playerId);
    xsResetTaskAmount();

    LaunchStinger(playerId, BerserkID);
    LaunchStinger(playerId, EliteBerserkID);
}



//  维京掠夺者, 每 30 总击杀提供 10% 攻击速度加成, 最多 50%
//  给予task 154, 当击杀时触发效果
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


// 10019 - 维京掠夺者击杀奖励效果
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


//  医院骑士, 攻击充能, 使用 151 产生资源效果
void HospitallerKnightInit(int playerId = -1)
{
    int HospitallerKnightAbilityBuildingID = 4040;

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 1);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeHospitallerKnightCharge);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeHospitallerKnightChargeRate);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cArcherClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cTradeBoatClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cVillagerClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cInfantryClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cCavalryClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cSiegeWeaponClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cMonkClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cTradeCartClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cTransportShipClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cFishingBoatClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cWarshipClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cConquistadorClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cPetardClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cCavalryArcherClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cMonkWithRelicClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cHandCannoneerClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cScoutCavalryClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cPackedUnitClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cUnpackedSiegeUnitClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cScorpionClass, playerId);

    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cArcherClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cTradeBoatClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cVillagerClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cInfantryClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cCavalryClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cSiegeWeaponClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cMonkClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cTradeCartClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cTransportShipClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cFishingBoatClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cWarshipClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cConquistadorClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cPetardClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cCavalryArcherClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cMonkWithRelicClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cHandCannoneerClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cScoutCavalryClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cPackedUnitClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cUnpackedSiegeUnitClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cScorpionClass, playerId);

    //对建筑充能效率为 1/3, 对墙, 门和农田充能效率为 1/5
    xsTaskAmount(cTaskAttrWorkValue1, 0.333333);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cBuildingClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cTowerClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cBuildingClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cTowerClass, playerId);

    xsTaskAmount(cTaskAttrWorkValue1, 0.2);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cWallClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cGateClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cWallClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cGateClass, playerId);
    xsTask(EliteHospitallerKnightID, cTaskTypeGenerateResources, cFarmClass, playerId);

    xsResetTaskAmount();

    //设置充能, 事件 -5 建造隐藏建筑
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cMaxCharge, HospitallerKnightMaxCharge, playerId);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cChargeType, -5, playerId);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cTraitPiece, HospitallerKnightAbilityBuildingID, playerId);
    xsEffectAmount(cModResource, cAttributeHospitallerKnightChargeRate, 0, 1, playerId);
    xsEffectAmount(cSetAttribute, EliteHospitallerKnightID, cMaxCharge, HospitallerKnightMaxCharge, playerId);
    xsEffectAmount(cSetAttribute, EliteHospitallerKnightID, cChargeType, -5, playerId);
    xsEffectAmount(cSetAttribute, EliteHospitallerKnightID, cTraitPiece, HospitallerKnightAbilityBuildingID, playerId);
}


//  医院骑士团技能效果, 治疗周围友方单位, 并且暂时不会阵亡
void HospitallerKnightAbility(int playerId = -1)
{ 
    int AbilityDuration = 25;
    int AbilityRange = 6;
    int HealRate = 240;

    if (xsGetTechState(3039, playerId) == cTechStateDone)
        HealRate = 300;
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, HealRate);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, AbilityRange);
    xsTaskAmount(cTaskAttrOwnerType, 4);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTaskAmount(cTaskAttrSearchWaitTime, 109.00001);

    xsTask(HospitallerKnightID, cTaskTypeAura, cArcherClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cVillagerClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cInfantryClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cCavalryClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cMonkClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cTradeCartClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cConquistadorClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cPetardClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cCavalryArcherClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cHandCannoneerClass, playerId);
    xsTask(HospitallerKnightID, cTaskTypeAura, cScoutCavalryClass, playerId);

    xsResetTaskAmount();
    LaunchAura(playerId, HospitallerKnightID);
    SetResource(playerId, cAttributeHospitallerKnightAbilityTime, AbilityDuration);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cInvulnerabilityLevel, -1, playerId);
    xsSetPlayerAttribute(playerId, cAttributeHospitallerKnightChargeRate, 0.000000000001);  //  技能期间不能充能; 忘记为0时会不会按1计算了, 先置为极小值
}


//  医院骑士技能结束处理
void HospitallerKnightAbilityEnd(int playerId = -1)
{
    RemoveAura(playerId, HospitallerKnightID);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cInvulnerabilityLevel, 0, playerId);
    xsSetPlayerAttribute(playerId, cAttributeHospitallerKnightChargeRate, 1);
}


//  医院骑士充能, 开启技能期间可治疗周围友军, 并且免于阵亡
void HospitallerKnight(int Time = 0, int playerId = -1)
{
    //  医院骑士充能, 技能所需充能为 HospitallerKnightMaxCharge 指定的值
    float CurrentCharge = xsPlayerAttribute(playerId, cAttributeHospitallerKnightCharge);   //  当前充能
    int RemainingTime = xsPlayerAttribute(playerId, cAttributeHospitallerKnightAbilityTime);  //  技能剩余持续时间

    if (CurrentCharge > HospitallerKnightMaxCharge)
    {
        CurrentCharge = HospitallerKnightMaxCharge;
        xsEffectAmount(cModResource, cAttributeHospitallerKnightCharge, 0, HospitallerKnightMaxCharge, playerId);
    }

    SetObjectCharge(playerId, HospitallerKnightID, CurrentCharge);

    if (RemainingTime > 0)
    {
        RemainingTime --;
        if (RemainingTime == 0)
            HospitallerKnightAbilityEnd(playerId);
        SetResource(playerId, cAttributeHospitallerKnightAbilityTime, RemainingTime);
    }
}


//  圣坛, 自动产出单位, 充能值到达 ShrineMaxCharge 时即产出单位。所有圣坛共享充能
void Shrine(int Time = 0, int playerId = 0)
{
    int i = 0;
    static int ShrineArray = 0;
    if (ShrineArray == 0)
        ShrineArray = xsGetPlayerUnitIds(playerId, ShrineID);
    else
        ShrineArray = xsGetPlayerUnitIds(playerId, ShrineID, ShrineArray);
    if (xsArrayGetSize(ShrineArray) == 0)
        return;

    int SpawnProgress = xsGetUnitCharge(xsArrayGetInt(ShrineArray, 0));
    int SpawnUnitID = xsPlayerAttribute(playerId, cAttributeShrineSpawnUnitID);
    int SpawnCount = xsPlayerAttribute(playerId, cAttributeShrineSpawnCount);

    if (SpawnProgress >= xsGetObjectAttribute(playerId, ShrineID, cMaxCharge))
    {
        SpawnCount ++;
        //  初始拥有 50% 充能
        if (SpawnCount > 1)
        {
            SpawnUnit(playerId, SpawnUnitID, ShrineID, 2, 1000);
            SpawnProgress = SpawnProgress - xsGetObjectAttribute(playerId, ShrineID, cMaxCharge);
        }
        else
            SpawnProgress = SpawnProgress - xsGetObjectAttribute(playerId, ShrineID, cMaxCharge) / 2;
        SetResource(playerId, cAttributeShrineSpawnCount, SpawnCount);
    }
    SetObjectCharge(playerId, ShrineID, SpawnProgress);
}


void EffectFunction10030(int playerId = -1)  //  切换到训练民兵系
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 74, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 90, playerId);
}

void EffectFunction10031(int playerId = -1)  //  切换到训练长矛兵系
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 93, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 72, playerId);
}

void EffectFunction10032(int playerId = -1)  //  切换到训练鹰斥候系
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 751, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 100, playerId);
}

void EffectFunction10033(int playerId = -1)  //  切换到训练步弓手系
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 4, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 100, playerId);
}

void EffectFunction10034(int playerId = -1)  //  切换到训练掷矛手系
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 7, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 72, playerId);
}


void EffectFunction10035(int playerId = -1)  //  切换到训练投石手
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 185, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 110, playerId);
}


void EffectFunction10036(int playerId = -1)  //  切换到训练印加枪兵长
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 879, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 120, playerId);
}


void EffectFunction10043(int playerId = -1)  //  切换到训练豹勇士
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 725, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 120, playerId);
}


void EffectFunction10044(int playerId = -1)  //  切换到训练羽箭手
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 763, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 120, playerId);
}


void EffectFunction10045(int playerId = -1)  //  切换到训练索洛托勇士
{
    xsEffectAmount(cModResource, cAttributeShrineSpawnUnitID, 0, 1570, playerId);
    xsEffectAmount(cSetAttribute, ShrineID, cRechargeRate, ShrineMaxCharge / 90, playerId);
}


//  女真TC产的鹿, 在城镇中心下会流血死亡, 防止重复体积导致无法移动
void TCSpawnedDeerInit(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrSearchWaitTime, 120.0000005);
    xsTaskAmount(cTaskAttrWorkRange, 2);
    xsTaskAmount(cTaskAttrWorkValue1, -4);  //  15秒内死亡
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
    SetResource(playerId, cAttributeShrineSpawnUnitID, 74);
    SetAttribute(playerId, ShrineID, cRechargeRate, ShrineMaxCharge / 90);
    SetAttribute(playerId, ShrineID, cMaxCharge, ShrineMaxCharge);
    //  阿兹特克文明加成, 圣坛 +15% 生产速度
    if (xsGetPlayerCivilization(playerId) == cAztecs)
    {
        MulAttribute(playerId, ShrineID, cMaxCharge, 1.0 / 1.15);
    }
}


//  马扎尔文明加成, 可在城堡以 +75% 速度训练单位
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


//  波斯文明加成每分钟建筑产生的黄金
float PersianBuildingGold(int playerId = -1, int UnitID = -1)
{
    int ObjectID = xsGetUnitObjectId(UnitID);

    if (isCastle(ObjectID))
        return (0);
    //  处理城镇中心，排除附加建筑
    if (xsGetObjectAttribute(playerId, ObjectID, cNameId) == 5164)
        if (isTownCenter(ObjectID) == false)
            return (0);
    
    //  每分钟产生黄金数 = 建筑木材费用/20+建筑黄金费用/10+建筑石料费用/5
    return (xsGetObjectAttribute(playerId, ObjectID, cWoodCost) / 20 + xsGetObjectAttribute(playerId, ObjectID, cGoldCost) / 10
            + xsGetObjectAttribute(playerId, ObjectID, cStoneCost) / 5);
}


//  马来战船可以产生食物
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


int RecruitUnit(int index = 0)
{
    switch (index)
    {
        case 0:
            return (1225);  //  龙骑兵
        case 1:
            return (1655);  //  马上轻装兵
        case 2:
            return (755);  //   答剌罕骑兵
        case 3:
            return (41);  //    近卫军
        case 4:
            return (1231);  //  钦察
        case 5:
            return (1007);  //  骆驼射手
        case 6:
            return (1803);  //  莫纳斯帕
        case 7:
            return (281);  //   掷斧兵
        case 8:
            return (239);  //   战象
        case 9:
            return (771);  //   西班牙征服者
        case 10:
            return (1658);  //  萨金特卫兵
        case 11:
            return (1228);  //  怯薛
    }
    return (-1);
}


int RecruitEliteUnit(int index = 0)
{
    switch (index)
    {
        case 0:
            return (1227);  //  龙骑兵
        case 1:
            return (1657);  //  马上轻装兵
        case 2:
            return (757);  //   答剌罕骑兵
        case 3:
            return (555);  //    近卫军
        case 4:
            return (1233);  //  钦察
        case 5:
            return (1009);  //  骆驼射手
        case 6:
            return (1805);  //  莫纳斯帕
        case 7:
            return (531);  //   掷斧兵
        case 8:
            return (558);  //   战象
        case 9:
            return (773);  //   西班牙征服者
        case 10:
            return (1659);  //  萨金特卫兵
        case 11:
            return (1230);  //  怯薛
    }
    return (-1);
}


//  10048 - 招募佣兵
void EffectFunction10048(int playerId = -1)
{    
    int AgeID = xsPlayerAttribute(playerId, cAttributeCurrentAge);

    int temp = xsGetRandomNumberLH(0, 100);
    float RecruitValue = 350.0;
    if (temp >= 30)
        RecruitValue = 400.0;
    if (temp >= 60)
        RecruitValue = 450.0;
    if (temp >= 80)
        RecruitValue = 550.0;
    if (temp >= 92)
        RecruitValue = 650.0;
    if (AgeID == 2)
        RecruitValue = RecruitValue * 475.0 / 400;
    if (AgeID == 3)
        RecruitValue = RecruitValue * 550.0 / 400;

    temp = xsGetRandomNumberLH(0, 12);
    int RecruitUnitID = RecruitUnit(temp);
    if (AgeID == 3)
        RecruitUnitID = RecruitEliteUnit(temp);
    int SpawnNum = RecruitValue / (xsGetObjectAttribute(playerId, RecruitUnitID, cFoodCost) + xsGetObjectAttribute(playerId, RecruitUnitID, cWoodCost)
                                   + xsGetObjectAttribute(playerId, RecruitUnitID, cGoldCost));
    SpawnUnit(playerId, RecruitUnitID, 109, SpawnNum, 1);
    xsChatData("RecruitUnitID = " + RecruitUnitID + ", SpawnNum = " + SpawnNum);
}


void BengalisCavalryVSSkirmisher(int playerId = -1)
{
    int i = 0;
    for (i = 0; <= TotalObjects)
        if ((i < 900) || (i > 964))
        {
            int ClassID = xsGetObjectClass(playerId, i);
            if ((ClassID == cScoutCavalryClass) || (ClassID == cCavalryClass))
                ModAttack(playerId, i, cDamageClassSkirmishers, xsGetObjectAttribute(playerId, i, cAttack, cDamageClassMelee) / 2);
        }
}


//  孟加拉, 消耗圣物获取加成, 僧侣 +2 近战护甲/3 远程护甲
void EffectFunction10049(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModArmor(playerId, cMonkClass, cDamageClassMelee, 2);
    ModArmor(playerId, cMonkClass, cDamageClassPierce, 3);
    ModArmor(playerId, cMonkWithRelicClass, cDamageClassMelee, 2);
    ModArmor(playerId, cMonkWithRelicClass, cDamageClassPierce, 3);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


//  由于目前是通过将斥候骑兵升级为曼沙布达尔骑兵来替代, 所以对曼沙布达尔骑兵加成时要同时适用于斥候骑兵
//  孟加拉, 消耗圣物获取加成, 曼沙布达尔骑兵 +2 攻击力
void EffectFunction10050(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModAttack(playerId, MansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, VeteranMansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, EliteMansabdarID, cDamageClassMelee, 2);
    ModAttack(playerId, 448, cDamageClassMelee, 2);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


//  孟加拉, 消耗圣物获取加成, 战车 +1 远程护甲, 并且免疫对射手加成
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


//  孟加拉, 消耗圣物获取加成, 团队贸易 +10% 额外木材和食物产出
void EffectFunction10052(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    ModAllyResource(playerId, cAttributeTradeFoodPercent, 10);
    ModAllyResource(playerId, cAttributeTradeWoodPercent, 10);
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
}


//  孟加拉, 消耗圣物获取加成, 步兵 +15% 攻击速度, +1 近战护甲/远程护甲
void EffectFunction10053(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    MulAttribute(playerId, cInfantryClass, cAttackReloadTime, 1.0 / 1.15);
    ModArmor(playerId, cInfantryClass, cDamageClassMelee, 1);
    ModArmor(playerId, cInfantryClass, cDamageClassPierce, 1);
}


//  孟加拉, 消耗圣物获取加成, 舰船每分钟回复的生命值 +15
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


//  孟加拉, 消耗圣物获取加成, 当前每个城镇中心和修道院立即产生 1 个战车, 战车木材费用 -10
void EffectFunction10055(int playerId = -1)
{
    if (ConsumeRelic(playerId) == false)
        return;
    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    SpawnUnit(playerId, 1738, 109, 1, 32767);
    SpawnUnit(playerId, 1738, 104, 1, 32767);
    ModAttribute(playerId, 1738, cWoodCost, -10);
    ModAttribute(playerId, 1740, cWoodCost, -10);
    ModAttribute(playerId, 1759, cWoodCost, -10);
    ModAttribute(playerId, 1761, cWoodCost, -10);
}


//  接口, 赋予单位独特能力
void AbilityApplier()
{
    RecordKiller();

    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
    {
        AssassinInit(i);
        BerserkInit(i);
        VikingRaiderInit(i);
        HospitallerKnightInit(i);
        TCSpawnedDeerInit(i);
        ShrineInit(i);
    }
}
