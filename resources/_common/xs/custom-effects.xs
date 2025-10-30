//  全局量定义

//  资源定义
extern const int cAttributeVarangianLootProductivity = 384; //  瓦兰吉卫队黄金产率
extern const int cAttributeWubaoFoodWoodProductivity = 385; //  坞堡食物和木材产出速率
extern const int cAttributeFishTrapProductivity = 387;
extern const int cAttributeCavalryLootBuildingGoldProductivity = 389;   //  骑兵掠夺建筑黄金产率
extern const int cAttributeInfantryLootFarmFoodProductivity = 390;  //  步兵掠夺农田产出食物速率
extern const int cAttributeHunterFoodProductivity = 391;    //  猎人食物自动产率
extern const int cAttributeFarmFoodGenerateProductivity = 392;  //  农田食物产出速率
extern const int cAttributeWubaoGoldProductivity = 393; //  坞堡黄金产出速率
extern const int cAttributeRelicPurchaseLimit = 394;    //  圣物可购买数
extern const int cAttributeLoanLimit = 396; //  借贷可用数量
extern const int cAttributeGoldFishingProductivity = 397;   //  捕鱼黄金产出速率
extern const int cAttributeTaboriteWarriorProductivity = 398;   //  塔博尔战士资源产出速率
extern const int cAttributeHospitallerKnightCharge = 409;   //  医院骑士充能
extern const int cAttributeHospitallerKnightChargeRate = 410;   //  医院骑士充能效率
extern const int cAttributeShrineSpawnUnitID = 411; //  圣坛生产的单位ID
extern const int cAttributeMagyarRelicAttackBonus = 412;    //  马扎尔圣物加成的攻击力
extern const int cAttributeVikingRaiderKills = 413; //  维京掠夺者击杀数
extern const int cAttributeApostleProductivity = 414;   //  使徒黄金产出速率
extern const int cAttributePolesFoodObtained = 415; //  维利奇卡盐矿已经奖励的食物数
extern const int cAttributeSpanishExplorerGoldCalced = 416; //  西班牙探险家已经计算的黄金数
extern const int cAttributeWarShipFoodProductivity = 417; //  马来战船产生食物的速率
extern const int cAttributeRecruitMercenaryCost = 418;  //  招募佣兵所需积累的资源, 每过一段时间获得1次招募机会
extern const int cAttributeCurrentTime = 419;   //  当前时间 +1
extern const int cAttributeTechEffectTime = 420;    //  科技效果剩余的持续时间
extern const int cAttributeFrankLoan = 421; //  法兰克放贷数额
extern const int cAttributeAztecsKillCount = 422;   //  阿兹特克独特科技的击杀数统计
extern const int cAttributeHospitallerKnightAbilityTime = 423;  //  医院骑士技能剩余持续时间
extern const int cAttributeShrineSpawnCount = 424;  //  圣坛已生产单位的次数
extern const int cAttributeCondottieroMercenaryNum = 434;   //  意大利佣兵生成数量
extern const int cAttributeTeam = 435;   //  队伍编号
extern const int cAttributeRelicCount = 436;    //  圣物计数


//  单位ID定义
extern const int TotalObjects = 4060;
extern const int AssassinID = 4001;
extern const int StreltsyID = 4002;
extern const int KhevsuretiWarriorID = 4003;
extern const int YumiAshigaruID = 4006;
extern const int WoodenFortressID = 4009;
extern const int ManilaGalleoID = 4010;
extern const int VarangianID = 4011;
extern const int SipahiID = 4014;
extern const int WubaoID = 4016;
extern const int EarlyCavalryArcherID = 4017;
extern const int ParthianCavalryArcherID = 4020;
extern const int InvisiblePCAID = 4022;
extern const int InvisibleEPCAID = 4023;
extern const int ChanyuID = 4024;
extern const int ChariotArcherID = 4025;
extern const int RungScoutID = 4027;
extern const int SwissLancerID = 4031;
extern const int LembosID = 4032;
extern const int ConscriptedCavalryID = 4033;
extern const int CamelLancerID = 4034;
extern const int EliteCamelLancerID = 4035;
extern const int HobelarID = 4036;
extern const int EliteHobelarID = 4037;
extern const int HospitallerKnightID = 4038;
extern const int EliteHospitallerKnightID = 4039;
extern const int CrusaderKnightID = 4041;
extern const int SoheiID1 = 4042;
extern const int SoheiID2 = 4043;
extern const int VikingRaiderID = 4044;
extern const int SofaID = 4045;
extern const int EliteSofaID = 4046;
extern const int FlameThrowerID = 4047;
extern const int TaboriteWarriorID = 4048;
extern const int ShrineID = 4049;
extern const int InvisibleDeerSpawnerID = 4052;
extern const int ToungooWarriorID = 4055;
extern const int MansabdarID = 4058;
extern const int VeteranMansabdarID = 4059;
extern const int EliteMansabdarID = 4060;


extern const int HospitallerKnightMaxCharge = 300; //   医院骑士技能充能
extern const float ShrineMaxCharge = 1200.0;    //  圣坛最大充能


//  全局数组
extern int KilledUnits = 0; //  已被击杀的单位

extern int KilledUnitsCount = 0;    //  已被记录的被击杀单位数量


//  引用文件
include "techtree.xs";



// Effect of Mongols Civ Bonus
void CavalryGenerateGoldFromBuilding(int ClassTarget = -1, int playerId = -1)
{
  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrResourceOut, 3);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeCavalryLootBuildingGoldProductivity);
  xsTaskAmount(cTaskAttrUnusedResource, 3);

  xsTask(ClassTarget, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(ClassTarget, cTaskTypeGenerateResources, cTowerClass, playerId);
}


// 10003 - C-Bonus, Cavalry generate gold by attacking buildings
void EffectFunction10003(int playerId = -1)
{
    xsResetTaskAmount();
    CavalryGenerateGoldFromBuilding(cScoutCavalryClass);
    CavalryGenerateGoldFromBuilding(cCavalryClass);
    xsResetTaskAmount();
    SetResource(playerId, cAttributeCavalryLootBuildingGoldProductivity, 10);
}


//Frozen Sea Dominance Aura Adder
void FrozenSeaDominanceAura(int ClassTarget = -1, int playerId = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, 0.047619);
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
    int LongBoatID = 250;
    int EliteLongBoatID = 533;
    xsEffectAmount(cAddAttribute, LongBoatID, cCombatAbility, 32, playerId);
    xsEffectAmount(cAddAttribute, EliteLongBoatID, cCombatAbility, 32, playerId);

    xsResetTaskAmount();
    FrozenSeaDominanceAura(LongBoatID, playerId);
    FrozenSeaDominanceAura(EliteLongBoatID, playerId);
    xsResetTaskAmount();
}


// 10005 - Stockfish Trade
void EffectFunction10005(int playerId = -1)
{
    int FishermanMaleID = 56;
    int FishermanFemaleID = 57;
    int FishingShipID = 13;
    int FishTrapID = 199;

    xsEffectAmount(cModResource, cAttributeFishingProductivity, 0, 0.5, playerId);
    xsEffectAmount(cModResource, cAttributeFishTrapProductivity, 0, 0.5, playerId);
    xsEffectAmount(cModResource, cAttributeGoldFishingProductivity, 1, 1, playerId);

    //重写渔船采集养鱼场的任务
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceIn, cAttributeFish);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeFishTrapProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
    xsTaskAmount(cTaskAttrWorkValue1, 1.25);
    xsTaskAmount(cTaskAttrWorkValue2, 0);
    xsTaskAmount(cTaskAttrWorkRange, 0.11);
    xsTaskAmount(cTaskAttrProceedingGraphic, 1594);
    xsTaskAmount(cTaskAttrAutoSearch, 1);
    xsTaskAmount(cTaskAttrCarryCheck, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 3);
    xsTask(FishingShipID, cTaskTypeGatherRebuild, FishTrapID, playerId);


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
    xsTask(FishermanMaleID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(FishermanMaleID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTask(FishermanMaleID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsTask(FishermanFemaleID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(FishermanFemaleID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTask(FishermanFemaleID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsResetTaskAmount();
}


// 10006 - Huns Atheism Adjustment, Tarkan Task Adder
void EffectFunction10006(int playerId = -1)
{
    int RelicID = 285;
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


// 10007 - 前哨
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
    NoDropSiteHunters(HunterMaleID, playerId);
    NoDropSiteHunters(HunterFemaleID, playerId);
    xsResetTaskAmount();
}


// 10009 - 坚固防御
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
    int FarmId = 50;
    int RiceFarmId = 1187;

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeInfantryLootFarmFoodProductivity);
    xsTaskAmount(cTaskAttrResourceOut, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);

    xsTask(cInfantryClass, cTaskTypeGenerateResources, FarmId, playerId);
    xsTask(cInfantryClass, cTaskTypeGenerateResources, RiceFarmId, playerId);
    xsResetTaskAmount();
}


// 10011 - 阿奴律陀运河
void EffectFunction10011(int playerId = -1)
{
    int FarmId = 50;
    int RiceFarmId = 1187;

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeFarmFoodGenerateProductivity);
    xsTaskAmount(cTaskAttrResourceOut, 0);
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);

    xsTask(FarmId, cTaskTypeGenerateResources, -1, playerId);
    xsTask(RiceFarmId, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();
    xsEffectAmount(cModResource, cAttributeFarmFoodGenerateProductivity, 0, 8, playerId);
}


// 10012 - C-Bonus, monk strengthens elephants
void EffectFunction10012(int playerId = -1)
{
    int BattleElephantId = 1132;
    int EliteBattleElephantId = 1134;

    xsEffectAmount(cAddAttribute, BattleElephantId, cCombatAbility, 96, playerId);
    xsEffectAmount(cAddAttribute, EliteBattleElephantId, cCombatAbility, 96, playerId);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.130435);
    xsTaskAmount(cTaskAttrWorkValue2, 1);
    xsTaskAmount(cTaskAttrWorkRange, 8);
    xsTaskAmount(cTaskAttrAutoSearch, 0);
    xsTaskAmount(cTaskAttrOwnerType, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 10);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 3);

    xsTask(BattleElephantId, cTaskTypeAura, cMonkClass, playerId);
    xsTask(EliteBattleElephantId, cTaskTypeAura, cMonkClass, playerId);

    xsTaskAmount(cTaskAttrAutoSearch, 1);

    xsTask(BattleElephantId, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsTask(EliteBattleElephantId, cTaskTypeAura, cMonkWithRelicClass, playerId);
    xsResetTaskAmount();
}


// 10013 - 翼骑兵冲锋
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
    SetAttribute(playerId, cCavalryClass, cMaxCharge, 6);
    SetAttribute(playerId, cCavalryClass, cRechargeRate, 0.5);
    SetAttribute(playerId, cCavalryClass, cChargeEvent, 1);
    SetAttribute(playerId, cCavalryClass, cChargeType, 1);
    SetAttribute(playerId, cScoutCavalryClass, cSpecialAbility, 3);
    SetAttribute(playerId, cScoutCavalryClass, cMaxCharge, 6);
    SetAttribute(playerId, cScoutCavalryClass, cRechargeRate, 0.5);
    SetAttribute(playerId, cScoutCavalryClass, cChargeEvent, 1);
    SetAttribute(playerId, cScoutCavalryClass, cChargeType, 1);
}



//  重型长矛效果
void HeavySpear(int ClassTarget = -1, int playerId = -1)
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


// 10014 - 重型长矛
void EffectFunction10014(int playerId = -1)
{
    int SpearmanId = 93;
    int PikemanId = 358;
    int HalberdierId = 359;

    HeavySpear(SpearmanId, playerId);
    HeavySpear(PikemanId, playerId);
    HeavySpear(HalberdierId, playerId);
    HeavySpear(cScoutCavalryClass, playerId);
    HeavySpear(cCavalryClass, playerId);
}


// 10015 - Desert Guard
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


// Castle Network Adder
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

// 10016 - Castle Network 城堡网络
void EffectFunction10016(int playerId = -1)
{
    int CastleID = 82;
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


// 10017 - Enclosure 圈地
void EffectFunction10017(int playerId = -1)
{
    int MaleFarmerId = 214;
    int FemaleFarmerId = 259;

    xsEffectAmount(cMulResource, cAttributeFoodBonus, 0, 0.75, playerId);
    xsEffectAmount(cModResource, cAttributeGoldFarmingProductivity, 1, 10.6, playerId);
    xsEffectAmount(cAddAttribute, cVillagerClass, cHitpoints, -15, playerId);

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 0.01);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeGoldFarmingProductivity);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 1);

    xsTask(MaleFarmerId, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsTask(FemaleFarmerId, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();
}


// 10018 - Stockfish Trade + Gillnet
void EffectFunction10018(int playerId = -1)
{
    int FishingShipID = 13;

    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrProductivityResource, 397);
    xsTaskAmount(cTaskAttrResourceOut, 3);
    xsTaskAmount(cTaskAttrWorkValue1, 0.294);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cSeaFishClass, playerId);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cDeepSeaFishClass, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.168);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cShoreFish, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 0.21);
    xsTask(FishingShipID, cTaskTypeGenerateResources, cFarmClass, playerId);
    xsResetTaskAmount();
}


//  10020 - 医院骑士技能开启
void EffectFunction10020(int playerId = -1)
{
    //  检测, 由于定时器有时间间隔, 防止延迟导致重复施放技能
    if (xsPlayerAttribute(playerId, cAttributeHospitallerKnightCharge) == 0.0)
        return;

    //  技能条不满，无法施放
    if (xsPlayerAttribute(playerId, cAttributeHospitallerKnightCharge) < HospitallerKnightMaxCharge - 1)
        return;
    //  清空技能条
    xsEffectAmount(cModResource, cAttributeHospitallerKnightCharge, 0, 0.0, playerId);
    SetObjectCharge(playerId, HospitallerKnightID, 0.0);

    HospitallerKnightAbility(playerId);
}


//  10021 - 精锐医院骑士
void EffectFunction10021(int playerId = -1)
{
    xsEffectAmount(cAddAttribute, HospitallerKnightID, cHitpoints, 30, playerId);
    xsEffectAmount(cAddAttribute, HospitallerKnightID, cArmor, 3*256 + 1, playerId);
    xsEffectAmount(cAddAttribute, HospitallerKnightID, cArmor, 4*256 + 1, playerId);
    xsEffectAmount(cAddAttribute, HospitallerKnightID, cAttack, 4*256 + 3, playerId);
    xsEffectAmount(cAddAttribute, HospitallerKnightID, cShownAttack, 3, playerId);
    xsEffectAmount(cAddAttribute, HospitallerKnightID, cShownMeleeArmor, 1, playerId);
    xsEffectAmount(cAddAttribute, HospitallerKnightID, cShownPierceArmor, 1, playerId);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cNameId, 700030, playerId);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cDescriptionId, 701030, playerId);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cShortTooltipId, 600005, playerId);
    xsEffectAmount(cSetAttribute, HospitallerKnightID, cExtendedTooltipId, 600005, playerId);
}


//  10022 - 单位击杀触发的效果
void EffectFunction10022(int playerId = -1)
{
    int playerUnits = 0;
    int i = 0;
    int j = 0;
    for (j = 900; <= 964)
        if (isClassOperable(j))
        {
            playerUnits = xsGetPlayerUnitIds(playerId, j);
            for (i = 0; < xsArrayGetSize(playerUnits))
            {
                int UnitID = xsArrayGetInt(playerUnits, i);
                int TargetUnitID = xsGetUnitTargetUnitId(UnitID);
                if (TargetUnitID == -1)
                    continue;
                if (xsDoesUnitExist(TargetUnitID) && (xsGetUnitHitpoints(TargetUnitID) > 0))    //  目标存活
                    continue;
                if (ArrayFindInt(KilledUnits, TargetUnitID, 0, KilledUnitsCount) != -1)
                    continue;
                int KillerPlayer = playerId;
        
                int TargetPlayer = xsGetUnitOwner(TargetUnitID);
                KillEffect(KillerPlayer, UnitID, TargetPlayer, TargetUnitID);
                xsArraySetInt(KilledUnits, KilledUnitsCount, TargetUnitID);
                KilledUnitsCount ++;
                //xsChatData("Killed Unit" + TargetUnitID);
                break;
            }
        }
}


//  10023 - 柏柏尔团队加成
void EffectFunction10023(int playerId = -1)
{
    xsEffectAmount(cModifyTech, 601, cAttrSetFoodCost, 0, playerId);
    xsEffectAmount(cModifyTech, 601, cAttrSetTime, 0, playerId);
    xsEffectAmount(cModifyTech, 599, cAttrSetButton, 26, playerId);
    xsEffectAmount(cModifyTech, 599, cAttrSetHotkey, 18022, playerId);

    int playerCiv = xsGetPlayerCivilization(playerId);

    if ((playerCiv == cSpanish) || (playerCiv == cBerbers) || (playerCiv == cPortuguese))
    {
        xsEffectAmount(cModifyTech, 599, cAttrMulAllCosts, 0.5, playerId);
    }
}


//  10027 - 法兰克放贷 (500黄金)
void EffectFunction10027(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 239);
    SetResource(playerId, cAttributeFrankLoan, 187.5);
}


//  10028 - 法兰克放贷 (1000黄金)
void EffectFunction10028(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 359);
    SetResource(playerId, cAttributeFrankLoan, 300);
}


//  10029 - 法兰克放贷 (2000黄金)
void EffectFunction10029(int playerId = -1)
{
    SetResource(playerId, cAttributeTechEffectTime, 479);
    SetResource(playerId, cAttributeFrankLoan, 500);
}


//  10037 - 掠夺号角
void EffectFunction10037(int playerId = -1)
{
    ModAttack(playerId, cCavalryClass, 4, 1);
    ModAttack(playerId, cScoutCavalryClass, 4, 1);
    ModArmor(playerId, cCavalryClass, 3, 1);
    ModArmor(playerId, cScoutCavalryClass, 3, 1);
    ModAttack(playerId, cCavalryClass, 21, 4);
    ModAttack(playerId, cScoutCavalryClass, 21, 4);
    MulResource(playerId, 213, 4);
    SetResource(playerId, cAttributeTechEffectTime, 179);
}


//  10038 - 浮动园地
void EffectFunction10038(int playerId = -1)
{
    MulAttribute(playerId, cTradeBoatClass, cWorkRate, 1.2);
    MulAttribute(playerId, cBuildingClass, cWorkRate, 1.2);
    MulAttribute(playerId, cVillagerClass, cWorkRate, 1.2);
    MulAttribute(playerId, cTradeCartClass, cWorkRate, 1.2);
    MulAttribute(playerId, cFishingBoatClass, cWorkRate, 1.2);
    MulAttribute(playerId, cFarmClass, cWorkRate, 1.2);
    MulAttribute(playerId, ShrineID, cMaxCharge, 1.0 / 1.2);
    SetResource(playerId, cAttributeTechEffectTime, 179);
}


//  10039 - 玉米神祝福
void EffectFunction10039(int playerId = -1)
{
    MulAttribute(playerId, 214, cWorkRate, 1000);
    MulAttribute(playerId, 214, cCarryCapacity, 100);
    MulAttribute(playerId, 259, cWorkRate, 1000);
    MulAttribute(playerId, 259, cCarryCapacity, 100);
    MulAttribute(playerId, 50, cWorkRate, 10000);
    SetResource(playerId, cAttributeTechEffectTime, 8);
}


//  10040 - 意大利佣兵合同
void EffectFunction10040(int playerId = -1)
{
    SetResource(playerId, cAttributeCondottieroMercenaryNum, 5);
    SetResource(playerId, cAttributeTechEffectTime, 1);
}


//  10041 - 意大利高级佣兵合同
void EffectFunction10041(int playerId = -1)
{
    ModResource(playerId, cAttributeCondottieroMercenaryNum, 5);
}


//  10046 - 使徒
void EffectFunction10046(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
    xsTaskAmount(cTaskAttrProductivityResource, cAttributeApostleProductivity);
    xsTaskAmount(cTaskAttrWorkValue1, 60.0 / 60);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
    xsTaskAmount(cTaskAttrSearchWaitTime, 0.000004);
    xsTask(cMonkClass, cTaskTypeGenerateResources, -1, playerId);
    xsTask(cMonkWithRelicClass, cTaskTypeGenerateResources, -1, playerId);
    xsTaskAmount(cTaskAttrWorkValue1, 45.0 / 60);
    xsTask(1811, cTaskTypeGenerateResources, -1, playerId);
    xsTask(1831, cTaskTypeGenerateResources, -1, playerId);
    xsResetTaskAmount();

    SetResource(playerId, cAttributeApostleProductivity, 1);
}


//  10047 - 维利奇卡盐矿
void EffectFunction10047(int playerId = -1)
{
    float StoneTotal = xsPlayerAttribute(playerId, cAttributeStoneTotal);
    ModResource(playerId, cAttributeFood, 0.8 * StoneTotal);
    SetResource(playerId, cAttributePolesFoodObtained, 0.8 * StoneTotal);
}


//  法兰克, 计算借贷返利
void Franks(int Time = 0, int playerId = -1)
{
    int FrankLoanTime = xsPlayerAttribute(playerId, cAttributeTechEffectTime);
    if (FrankLoanTime > 0)
    {
        if (FrankLoanTime % 60 == 0)
            xsEffectAmount(cModResource, cAttributeGold, 1, xsPlayerAttribute(playerId, cAttributeFrankLoan), playerId);
        FrankLoanTime --;
        if (FrankLoanTime == 0)
            xsEffectAmount(cModResource, cAttributeLoanLimit, 1, 1, playerId);
        SetResource(playerId, cAttributeTechEffectTime, FrankLoanTime);
    }
}


//  拜占庭, 招募雇佣兵
void Byzantines(int Time = 0, int playerId = -1)
{
    if (xsPlayerAttribute(playerId, cAttributeCurrentAge) >= 1)
    {
        float ProgressInc = 1.0;
        if (isResearched(playerId, 3140))
            ProgressInc = ProgressInc * 1.25;
        ModResource(playerId, cAttributeRecruitMercenaryCost, ProgressInc);
    }
}


//  波斯文明加成, 城堡从周围建筑收取黄金
void Persians(int Time = 0, int playerId = -1)
{
    int CastleID = 82;
    int AuraRange = 10;

    float TotalGold = 0.0;
    int BuildingArray = NewArrayInt();
    BuildingArray = xsGetPlayerUnitIds(playerId, cBuildingClass, BuildingArray);
    int CastleArray = NewArrayInt();
    CastleArray = xsGetPlayerUnitIds(playerId, CastleID, CastleArray);
    int i = 0;
    int BuildingArraySize = xsArrayGetSize(BuildingArray);
    for (i = 0; < BuildingArraySize)
    {
        //判断是否在城堡覆盖范围内
        int BuildingID = xsArrayGetInt(BuildingArray, i);
        if (BuildingID == -1)
            break;
        vector BuildingPosition = xsGetUnitPosition(BuildingID);
        int j = 0;
        bool flag = false;
        for (j = 0; <xsArrayGetSize(CastleArray))
        {
            vector CastlePosition = xsGetUnitPosition(xsArrayGetInt(CastleArray, j));
            if ((DistanceX(BuildingPosition, CastlePosition) <= AuraRange) && (DistanceY(BuildingPosition, CastlePosition) <= AuraRange))
            {
                flag = true;
                break;
            }
        }
        if (flag)
            TotalGold = TotalGold + 1.0 * PersianBuildingGold(playerId, BuildingID) / 60;
    }
    xsEffectAmount(cModResource, cAttributeGold, 1, TotalGold, playerId);
    //xsChatData("Persians TotalGold =" + TotalGold + "BuildingArraySize = " + xsArrayGetSize(BuildingArray));
    RecycleArrayInt(BuildingArray);
    RecycleArrayInt(CastleArray);

    //为城堡添加范围指示器
    if (Time == 0)
    {
        xsResetTaskAmount();
        xsTaskAmount(cTaskAttrWorkValue1, 0);
        xsTaskAmount(cTaskAttrWorkValue2, 1);
        xsTaskAmount(cTaskAttrWorkRange, AuraRange - 2);    //城堡碰撞半径为2
        xsTaskAmount(cTaskAttrSearchWaitTime, 1);
        xsTaskAmount(cTaskAttrCombatLevelFlag, 4);
        xsTask(CastleID, cTaskTypeAura, cBuildingClass, playerId);
        xsResetTaskAmount();
        LaunchAura(playerId, CastleID);
    }
}


//  西班牙独特科技, 探险家
void Spanish(int Time = 0, int playerId = -1)
{
    static float ExplorerGoldRate = 0.015;
    int i = 0;
    float CalcedGold = xsPlayerAttribute(playerId, cAttributeSpanishExplorerGoldCalced);
    float CurrentGold = 0;
    for (i = 0; <= xsGetNumPlayers())
        if (i != playerId)
            CurrentGold = CurrentGold + xsPlayerAttribute(i, cAttributeGoldTotal);
    if (isResearched(playerId, 3135))
        ModResource(playerId, cAttributeGold, (CurrentGold - CalcedGold) * ExplorerGoldRate);
    SetResource(playerId, cAttributeSpanishExplorerGoldCalced, CurrentGold);
}


//  阿兹特克独特科技, 浮动园地
void Aztecs(int Time = 0, int playerId = -1)
{
    int FloatingGardenTime = xsPlayerAttribute(playerId, cAttributeTechEffectTime);
    if (FloatingGardenTime == 0)
        return;
    FloatingGardenTime --;
    if (FloatingGardenTime == 0)
    {
        MulAttribute(playerId, cTradeBoatClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cBuildingClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cVillagerClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cTradeCartClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cFishingBoatClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cFarmClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, ShrineID, cMaxCharge, 1.2);
    }
    SetResource(playerId, cAttributeTechEffectTime, FloatingGardenTime);
}


//  玛雅独特科技, 玉米神祝福
void Mayans(int Time = 0, int playerId = -1)
{
    int YumKaaxBlessingTime = xsPlayerAttribute(playerId, cAttributeTechEffectTime);
    if (YumKaaxBlessingTime == 0)
        return;
    YumKaaxBlessingTime --;
    if (YumKaaxBlessingTime == 0)
    {
        MulAttribute(playerId, 214, cWorkRate, 1.0 / 1000);
        MulAttribute(playerId, 214, cCarryCapacity, 1.0 / 100);
        MulAttribute(playerId, 259, cWorkRate, 1.0 / 1000);
        MulAttribute(playerId, 259, cCarryCapacity, 1.0 / 100);
        MulAttribute(playerId, 50, cWorkRate, 1.0 / 10000);
    }
    SetResource(playerId, cAttributeTechEffectTime, YumKaaxBlessingTime);
}


//  意大利, 佣兵合同
void Italians(int Time = 0, int playerId = -1)
{
    if (isResearched(playerId, 3114) == false)
        return;
    int MercenaryContractTime = xsPlayerAttribute(playerId, cAttributeTechEffectTime);
    MercenaryContractTime --;
    if (MercenaryContractTime == 0)
    {
        SpawnUnit(playerId, 882, 109, xsPlayerAttribute(playerId, cAttributeCondottieroMercenaryNum), 1);
        MercenaryContractTime = 120;
    }
    SetResource(playerId, cAttributeTechEffectTime, MercenaryContractTime);
}


//  马扎尔文明加成, 圣物加成草原枪兵攻击力
void Magyars(int Time = 0, int playerId = -1)
{
    int SteppeLancerID = 1370;
    int EliteSteppeLancerID = 1372;
    int AttackBonus = xsPlayerAttribute(playerId, cAttributeMagyarRelicAttackBonus);
    //草原枪兵攻击加成
    int RelicCaptured = xsPlayerAttribute(playerId, cAttributeRelics);
    int CurrentAttackBonus = minInt(RelicCaptured / 2, 2);

    ModAttack(playerId, SteppeLancerID, cDamageClassMelee, CurrentAttackBonus - AttackBonus);
    ModAttack(playerId, EliteSteppeLancerID, cDamageClassMelee, CurrentAttackBonus - AttackBonus);
    SetResource(playerId, cAttributeMagyarRelicAttackBonus, CurrentAttackBonus);
}


//  鞑靼独特科技, 掠夺号角
void Tatars(int Time = 0, int playerId = -1)
{
    int RaideHornTime = xsPlayerAttribute(playerId, cAttributeTechEffectTime);
    if (RaideHornTime == 0)
        return;
    RaideHornTime --;
    if (RaideHornTime == 0)
    {
        ModAttack(playerId, cCavalryClass, 4, -1);
        ModAttack(playerId, cScoutCavalryClass, 4, -1);
        ModArmor(playerId, cCavalryClass, 3, -1);
        ModArmor(playerId, cScoutCavalryClass, 3, -1);
        ModAttack(playerId, cCavalryClass, 21, -4);
        ModAttack(playerId, cScoutCavalryClass, 21, -4);
        MulResource(playerId, 213, 0.25);
    }
    SetResource(playerId, cAttributeTechEffectTime, RaideHornTime);
}


//  波兰独特科技, 维利奇卡盐矿
void Poles(int Time = -1, int playerId = -1)
{
    if (isResearched(playerId, 3133) == false)
        return;
    float FoodObtained = xsPlayerAttribute(playerId, cAttributePolesFoodObtained);
    float CurrentFoodBonus = xsPlayerAttribute(playerId, cAttributeStoneTotal) * 0.8;
    ModResource(playerId, cAttributeFood, CurrentFoodBonus - FoodObtained);
    SetResource(playerId, cAttributePolesFoodObtained, CurrentFoodBonus);
}


void Bengalis(int Time = -1, int playerId = -1)
{
}


//  初始化
void Init()
{
    //  获取玩家阵营
    int TeamNum = 0;
    int i = 0;
    int j = 0;
    for (i = 0; <= xsGetNumPlayers())
        if (xsPlayerAttribute(i, cAttributeTeam) == 0)
        {
            TeamNum ++;
            xsResearchTechnology(3149, true, false, i);
            for (j = 0; <= xsGetNumPlayers())
                if (xsPlayerAttribute(j, cAttributeTeam) == 10)
                    SetResource(j, cAttributeTeam, TeamNum);
        }
}


// Timer Event 定时器事件
void TimerEvent(int Time = 0, int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));

    switch (playerCiv)
    {
        case cFranks:
        {
            Franks(Time, playerId);
            break;
        }
        case cByzantines:
        {
            Byzantines(Time, playerId);
            break;
        }
        case cPersians:
        {
            Persians(Time, playerId);
            break;
        }
        case cSpanish:
        {
            Spanish(Time, playerId);
            break;
        }
        case cAztecs:
        {
            Aztecs(Time, playerId);
            break;
        }
        case cMayans:
        {
            Mayans(Time, playerId);
            break;
        }
        case cItalians:
        {
            Italians(Time, playerId);
            break;
        }
        case cMagyars:
        {
            Magyars(Time, playerId);
            break;
        }
        case cTatars:
        {
            Tatars(Time, playerId);
            break;
        }
        case cPoles:
        {
            Poles(Time, playerId);
            break;
        }
        case cBengalis:
        {
            Bengalis(Time, playerId);
            break;
        }
        default:
        {
            break;
        }
    }

    HospitallerKnight(Time, playerId);
    Shrine(Time, playerId);
}


void Test(int Time = 0)
{
}


// 定时器
rule Timer
    active
    highFrequency
{
    int LastUpdateTime = xsPlayerAttribute(0, cAttributeCurrentTime) ;
    int CurrentTime = xsGetGameTime();

    while (LastUpdateTime <= CurrentTime)
    {
        if (LastUpdateTime == 0)
        {
            ArrayRecycleInit();
            Init();
            AbilityApplier();
        }
        int i = 0;
        for (i = 0; <= xsGetNumPlayers())
            TimerEvent(LastUpdateTime, i);
        LastUpdateTime = LastUpdateTime + 1;
        ModResource(0, cAttributeCurrentTime, 1);
    }
}