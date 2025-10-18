include "ability.xs";


// 10001 - 科技树调整(启用科技, 封建时代起生效)
void EffectFunction10001(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cJapanese:
        {
            //  启用手推炮
            xsEffectAmount(cModifyTech, 188, cAttrSetState, cAttributeEnable, playerId);
        }
        case cChinese:
        {
            xsEffectAmount(cModifyTech, 12, cAttrSetState, cAttributeEnable, playerId); //  启用轮作
            xsEffectAmount(cModifyTech, 37, cAttrSetState, cAttributeEnable, playerId); //  启用炮舰
            xsEffectAmount(cModifyTech, 85, cAttrSetState, cAttributeEnable, playerId); //  启用火枪手
            xsEffectAmount(cModifyTech, 188, cAttrSetState, cAttributeEnable, playerId);    //  启用手推炮
            xsEffectAmount(cModifyTech, 376, cAttrSetState, cAttributeEnable, playerId);    //  启用精锐炮舰
        }
        case cByzantines:
        {
            xsEffectAmount(cModifyTech, 50, cAttrSetState, cAttributeEnable, playerId); //启用石匠
            xsEffectAmount(cModifyTech, 51, cAttrSetState, cAttributeEnable, playerId); //启用建筑学
        }
        case cTurks:
        {
            //  启用草原枪兵
            xsEffectAmount(cModifyTech, 714, cAttrSetState, cAttributeEnable, playerId);
            xsEffectAmount(cModifyTech, 715, cAttrSetState, cAttributeEnable, playerId);
            //  精锐草原枪兵和重装骆驼兵 -33% 升级费用
            xsEffectAmount(cModifyTech, 715, cAttrMulAllCosts, 0.666666, playerId);
            xsEffectAmount(cModifyTech, 236, cAttrMulAllCosts, 0.666666, playerId);
        }
        case cHuns:
            xsEffectAmount(cModifyTech, 714, cAttrSetState, cAttributeEnable, playerId);    //启用草原枪兵
        case cMagyars:
        {
            //  启用草原枪兵
            xsEffectAmount(cModifyTech, 714, cAttrSetState, cAttributeEnable, playerId);
            xsEffectAmount(cModifyTech, 715, cAttrSetState, cAttributeEnable, playerId);
        }
        case cBurmese:
            xsEffectAmount(cModifyTech, 85, cAttrSetState, cAttributeEnable, playerId); //启用火枪手
        case cBulgarians:
            xsEffectAmount(cModifyTech, 264, cAttrSetState, cAttributeEnable, playerId);    //启用冠军剑士
        case cCumans:
            xsEffectAmount(cModifyTech, 39, cAttrSetState, cAttributeEnable, playerId); //  启用畜牧
        default:
        {
          break;
        }
    }
}


// 10002 - 科技树调整(启用/禁用单位, 禁用/修改科技, 黑暗时代起生效)
void EffectFunction10002(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cGoths:
            xsEffectAmount(cDisableTech, 127, 0, 0, playerId);  //禁用瞭望箭塔
        case cJapanese:
        {
            xsEffectAmount(cDisableTech, 85, 0, 0, playerId);   //禁用火枪手
            xsEffectAmount(cDisableTech, 100, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 151, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 237, 0, 0, playerId);
        }
        case cChinese:
        {
            //  中国文明加成, 贸易单位 +50% 训练速度
            xsEffectAmount(cMulAttribute, cTradeBoatClass, cTrainTime, 0.66666666, playerId);
            xsEffectAmount(cMulAttribute, cTradeCartClass, cTrainTime, 0.66666666, playerId);
            //  中国文明加成, 科技折扣
            xsEffectAmount(cModResource, cAttributeResearchCostMod, 0, 0.05, playerId);
        }
        case cByzantines:
        {
            //  拜占庭文明加成, 异教免费升级
            xsEffectAmount(cModifyTech, 439, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 439, cAttrSetTime, 0, playerId);
        }
        case cPersians:
        {
            xsEffectAmount(cDisableTech, 192, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 218, 0, 0, playerId);
            //  波斯文明加成, 市场科技免费升级
            SetTechAuto(playerId, 48);
            SetTechAuto(playerId, 23);
            SetTechAuto(playerId, 17);
            SetTechAuto(playerId, 15);
        }
        case cSaracens:
        {
            xsEffectAmount(cDisableTech, 235, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 236, 0, 0, playerId);
            //  萨拉森文明加成 + 骆驼长矛骑兵
            xsEffectAmount(cMulAttribute, CamelLancerID, cHitpoints, 1.25, playerId);
            xsEffectAmount(cMulAttribute, EliteCamelLancerID, cHitpoints, 1.25, playerId);
        }
        case cTurks:
        {
            xsEffectAmount(cDisableTech, 166, 0, 0, playerId);
            //  土耳其文明加成, 炮舰可在陆地上移动
            xsEffectAmount(cSetAttribute, 420, cTerrainTable, 0, playerId);
            xsEffectAmount(cSetAttribute, 691, cTerrainTable, 0, playerId);
            break;
        }
        case cVikings:
        {
            xsEffectAmount(cDisableTech, 127, 0, 0, playerId);
        }
        case cMongols:
        {
            //  蒙古文明加成, 骑兵攻击建筑产生黄金
            SetResource(playerId, cAttributeMaintenance, 10003);
        }
        case cCelts:
        {
            //  凯尔特文明加成, 步兵和骑兵更难被转化
            xsEffectAmount(cAddAttribute, cInfantryClass, cMaxConversionTimeMod, 1, playerId);
            xsEffectAmount(cAddAttribute, cInfantryClass, cMinConversionTimeMod, 1, playerId);
            xsEffectAmount(cAddAttribute, cCavalryClass, cMaxConversionTimeMod, 1, playerId);
            xsEffectAmount(cAddAttribute, cCavalryClass, cMinConversionTimeMod, 1, playerId);
        }
        case cSpanish:
        {
            //  启用标枪骑兵
            SetTechAuto(playerId, 601);
            xsEffectAmount(cModifyTech, 599, cAttrSetButton, 26, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrSetHotkey, 18022, playerId);
            //  西班牙文明加成, 标枪骑兵升级食物费用 -50%
            xsEffectAmount(cModifyTech, 599, cAttrMulFoodCost, 0.5, playerId);
        }
        case cAztecs:
        {
            xsEffectAmount(cDisableTech, 240, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 35, 0, 0, playerId);
            //  小艇
            xsEffectAmount(cEnableObject, LembosID, 1, 0, playerId);
        }
        case cMayans:
        {
            xsEffectAmount(cDisableTech, 12, 0, 0, playerId);   //禁用轮作
            xsEffectAmount(cDisableTech, 13, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 14, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 240, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 35, 0, 0, playerId);
            //  玛雅文明加成, 石匠免费升级
            xsEffectAmount(cModifyTech, 50, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 50, cAttrSetTime, 0, playerId);
            //  玛雅文明加成, 每研究一个科技, 可持续获取额外食物
            xsEffectAmount(cModResource, cAttributeTechnologyRewardEffect, 0, 1599, playerId);
            //  玛雅文明加成, 农田费用 -60%, 产量 -50%
            xsEffectAmount(cModResource, cAttributeFarmFood, 1, -87.5, playerId);
            xsEffectAmount(cMulAttribute, 50, cWoodCost, 0.4, playerId);
            //  小艇
            xsEffectAmount(cEnableObject, LembosID, 1, 0, playerId);
        }
        case cHuns:
            xsEffectAmount(cDisableTech, 127, 0, 0, playerId);
        case cIndians:
        {
            //  印度斯坦文明加成, 大学科技免费, 但研究速度 -50%
            xsEffectAmount(cModifyTech, 50, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 51, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 54, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 380, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 93, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 47, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 64, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 377, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 322, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 194, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 140, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 63, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 608, cAttrMulAllCosts, 0, playerId);
            xsEffectAmount(cModifyTech, 50, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 51, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 54, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 380, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 93, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 47, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 64, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 377, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 322, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 194, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 140, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 63, cAttrMulTime, 2, playerId);
            xsEffectAmount(cModifyTech, 608, cAttrMulTime, 2, playerId);
        }
        case cIncas:
        {
            xsEffectAmount(cDisableTech, 240, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 35, 0, 0, playerId);
            //  印加文明加成, 可蓄养动物视野 +2
            xsEffectAmount(cAddAttribute, cLivestockClass, cLineOfSight, 2, playerId);
            //  印加文明加成, 兵营, 靶场, 马厩, 攻城武器厂 +100% 建造速度
            xsEffectAmount(cMulAttribute, 12, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 20, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 132, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 498, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 10, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 14, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 87, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 86, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 101, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 153, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 49, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, 150, cTrainTime, 0.5, playerId);
            //  小艇
            xsEffectAmount(cEnableObject, LembosID, 1, 0, playerId);
        }
        case cMagyars:
        {
            //  马扎尔文明加成, 可在城堡以 +75% 速度训练单位
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
        case cPortuguese:
        {
            //  启用标枪骑兵
            SetTechAuto(playerId, 601);
            xsEffectAmount(cModifyTech, 599, cAttrSetButton, 26, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrSetHotkey, 18022, playerId);
            //  葡萄牙文明加成, 标枪骑兵 +2 射手护甲
            xsEffectAmount(cAddAttribute, 1010, cArmor, 15 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 1012, cArmor, 15 * 256 + 2, playerId);
        }
        case cEthiopians:
        {
            //  埃塞俄比亚文明加成, 长矛兵和弯刀勇士破甲
            SetAttribute(playerId, cAttributeMaintenance, 10014);
        }
        case cMalians:
        {
            //  马里文明加成, 火枪手 +66% 训练速度
            xsEffectAmount(cMulAttribute, cHandCannoneerClass, cTrainTime, 0.6, playerId);
        }
        case cKhmer:
        {
            //  高棉文明加成, 僧侣加成象兵
            SetResource(playerId, cAttributeMaintenance, 10012);
        }
        case cBurmese:
        {
            //  缅甸启用火枪手
            EnableTech(playerId, 85);
        }
        case cVietnamese:
        {
            xsEffectAmount(cDisableTech, 218, 0, 0, playerId);  //  禁用重装骑射手
            //  越南文明加成 + 园艺学, 施肥, 育种, 经济作物
            xsEffectAmount(cModifyTech, 3054, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3054, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, 3055, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3055, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, 3056, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3056, cAttrSetWoodCost, 0, playerId);
            xsEffectAmount(cModifyTech, 3057, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 3057, cAttrSetWoodCost, 0, playerId);
        }
        case cBulgarians:
        {
            //  保加利亚文明加成 + 军事训练
            xsEffectAmount(cModifyTech, 1810, cAttrMulFoodCost, 0.5, playerId);
        }
        case cCumans:
        {
            //  禁用原有的库曼城堡时代和帝王时代移动速度科技
            xsEffectAmount(cDisableTech, 727, 0, 0, playerId);
            xsEffectAmount(cDisableTech, 728, 0, 0, playerId);
            //  库曼文明加成, 骑兵相关科技 +200% 研究速度
            xsEffectAmount(cModifyTech, 80, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 81, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 82, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 67, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 68, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 75, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 39, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 435, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 254, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 428, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 209, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 265, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 526, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 218, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 236, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 521, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 715, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 786, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 1033, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 1589, cAttrMulTime, 0.333333, playerId);
            xsEffectAmount(cModifyTech, 1628, cAttrMulTime, 0.333333, playerId);
            //  库曼文明加成, 猎人不需要提交食物
            xsEffectAmount(cModResource, cAttributeHunterFoodProductivity, 0, 41, playerId);
            xsEffectAmount(cMulResource, cAttributeHuntingProductivity, 0, 0.0000000000000001, playerId);
            xsEffectAmount(cModResource, cAttributeMaintenance, 0, 10008, playerId);
        }
        case cLithuanians:
        {
            //  立陶宛文明加成, 掷矛手和标枪骑兵 -50% 升级费用, +100% 升级速度
            xsEffectAmount(cModifyTech, 98, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 655, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrMulTime, 0.5, playerId);
            xsEffectAmount(cModifyTech, 98, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, 655, cAttrMulAllCosts, 0.5, playerId);
            xsEffectAmount(cModifyTech, 599, cAttrMulAllCosts, 0.5, playerId);
        }
        case cBurgundians:
        {
            //xsEffectAmount(cDisableTech, 316, 0, 0, playerId);
            //xsEffectAmount(cDisableTech, 319, 0, 0, playerId);
            //xsEffectAmount(cDisableTech, 233, 0, 0, playerId);
            //xsEffectAmount(cDisableTech, 230, 0, 0, playerId);
            //  勃艮第文明加成 + 园艺学, 施肥, 育种, 经济作物
            xsEffectAmount(cModifyTech, 3054, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, 3055, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, 3056, cAttrMulFoodCost, 0.66666667, playerId);
            xsEffectAmount(cModifyTech, 3057, cAttrMulFoodCost, 0.66666667, playerId);
        }
        case cGurjaras:
        {
            //  瞿折罗文明加成, 修道院提供人口空间
            xsEffectAmount(cAddAttribute, 30, cAmountFirstStorage, 10, playerId);
            xsEffectAmount(cAddAttribute, 31, cAmountFirstStorage, 10, playerId);
            xsEffectAmount(cAddAttribute, 32, cAmountFirstStorage, 10, playerId);
            xsEffectAmount(cAddAttribute, 104, cAmountFirstStorage, 10, playerId);
        }
        case cRomans:
        {
            //  罗马文明加成, 城墙和城门 +100% 建造速度
            xsEffectAmount(cMulAttribute, cWallClass, cTrainTime, 0.5, playerId);
            xsEffectAmount(cMulAttribute, cGateClass, cTrainTime, 0.5, playerId);
        }
        case cGeorgians:
        {
            //  格鲁吉亚文明加成, 村民 +100% 修理速度
            xsEffectAmount(cMulAttribute, 156, cWorkRate, 2, playerId);
            xsEffectAmount(cMulAttribute, 222, cWorkRate, 2, playerId);
        }
        case cShu:
        {
            //  启用坞堡
            SetTechAuto(playerId, 3016);
            //  蜀文明加成, 步兵从农田掠夺食物
            xsEffectAmount(cModResource, cAttributeInfantryLootFarmFoodProductivity, 0, 25, playerId);
            xsEffectAmount(cModResource, cAttributeMaintenance, 0, 10010, playerId);
        }
        case cWu:
        {
            //  启用坞堡
            SetTechAuto(playerId, 3016);
        }
        case cWei:
        {
            //  启用坞堡
            SetTechAuto(playerId, 3016);
        }
        case cJurchens:
        {
            //  女真文明加成, TC产鹿
            SetAttribute(playerId, 890, cDeadUnitId, InvisibleDeerSpawnerID);
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, -0.3333333);
        }
        case cKhitans:
        {
            xsEffectAmount(cModifyTech, 3054, cAttrSetState, cAttributeDisable, playerId);  //禁用园艺学
            xsEffectAmount(cModifyTech, 3055, cAttrSetState, cAttributeDisable, playerId);  //禁用施肥
            xsEffectAmount(cModifyTech, 3056, cAttrSetState, cAttributeDisable, playerId);  //禁用育种
            xsEffectAmount(cDisableTech, 3057, 0, 0, playerId); //禁用经济作物
        }
        default:
            break;
    }

    //  标枪骑兵
    xsEffectAmount(cSetAttribute, 1010, cTrainButton, 21);
    xsEffectAmount(cSetAttribute, 1010, cHotkeyId, 16079);
    xsEffectAmount(cSetAttribute, 1012, cTrainButton, 21);
    xsEffectAmount(cSetAttribute, 1012, cHotkeyId, 16079);
    //  传教士
    xsEffectAmount(cSetAttribute, 775, cTrainButton, 22);
    xsEffectAmount(cSetAttribute, 775, cHotkeyId, 16078);
    //  圣物产出黄金 30 → 45 / 分钟
    xsEffectAmount(cMulResource, cAttributeRelicRate, 0, 1.5, playerId);
    //  瓦兰吉卫队黄金产率设置
    xsEffectAmount(cModResource, cAttributeVarangianLootProductivity, 0, 1, playerId);
    //  祭司战士
    xsEffectAmount(cSetAttribute, 1811, cTrainButton, 21, playerId);
    xsEffectAmount(cSetAttribute, 1811, cHotkeyId, 16079, playerId);
    //  坞堡食物和木材产出速率
    xsEffectAmount(cModResource, cAttributeWubaoFoodWoodProductivity, 0, 1, playerId);
    //  为所有攻城武器设置攻城武器攻击力 -10
    xsEffectAmount(cSetAttribute, cSiegeWeaponClass, cAttack, 0 - 104 * 256 - 10, playerId);
    xsEffectAmount(cSetAttribute, cPackedUnitClass, cAttack, 0 - 104 * 256 - 10, playerId);
    xsEffectAmount(cSetAttribute, cUnpackedSiegeUnitClass, cAttack, 0 - 104 * 256 - 10, playerId);
    xsEffectAmount(cSetAttribute, cScorpionClass, cAttack, 0 - 104 * 256 - 10, playerId);
    //  意大利佣兵训练位置调整, 设置为21号
    xsEffectAmount(cSetAttribute, 882, cTrainButton, 21, playerId);
    xsEffectAmount(cSetAttribute, 882, cHotkeyId, 16079, playerId);
    //  塔博尔战士资源产出速率设置
    xsEffectAmount(cModResource, cAttributeTaboriteWarriorProductivity, 0, 1, playerId);
    //  三国和中国楼船训练位置调整
    SetAttribute(playerId, 1948, cTrainButton, 24);
    SetAttribute(playerId, 1948, cHotkeyId, 16106);
    //  罗马军升级时间调整
    xsEffectAmount(cModifyTech, 885, cAttrSetTime, 80, playerId);
    //  大商站人口占用 20 → 15
    SetAttribute(playerId, 1021, cAmountFirstStorage, -15);
    SetAttribute(playerId, 1021, cAmountSecondStorage, 15);
    SetAttribute(playerId, 1021, cAmountThirdStorage, 15);
    //  部分文明什一税科技说明改动
    if ((playerCiv == cChinese) || (playerCiv == cJapanese) || (playerCiv == cKoreans) || (playerCiv == cVietnamese) || (playerCiv == cBurmese))
    {
        xsEffectAmount(cModifyTech, 3059, cAttrSetName, 500078, playerId);
        xsEffectAmount(cModifyTech, 3059, cAttrSetDescription, 521078, playerId);
    }
}


//  10024 - 封建时代效果
void EffectFunction10024(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cGoths:
        {
            xsEffectAmount(cEnableObject, WoodenFortressID, 1, 0, playerId);    //木制要塞
            //  哥特文明加成, 封建和城堡时代也增加人口上限和人口空间
            xsEffectAmount(cModResource, cAttributePopulationCap, 1, 10, playerId);
            xsEffectAmount(cModResource, cAttributeUnitLimit, 1, 10, playerId);
        }
        case cTeutons:
        {
            //  条顿文明加成, 掷矛手射程增加
            xsEffectAmount(cAddAttribute, 7, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cSearchRadius, 1, playerId);
        }
        case cJapanese:
        {
            //  启用弓足轻
            xsEffectAmount(cEnableObject, YumiAshigaruID, 1, 0, playerId);
        }
        case cChinese:
        {
            //  中国文明加成, 科技折扣
            xsEffectAmount(cModResource, cAttributeResearchCostMod, 0, 0.9, playerId);
        }
        case cByzantines:
        {
            //  拜占庭建筑生命值加成调整
            MulAttribute(playerId, cBuildingClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cWallClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cGateClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cFarmClass, cHitpoints, 1.15 / 1.19999);
            MulAttribute(playerId, cTowerClass, cHitpoints, 1.15 / 1.19999);
        }
        case cPersians:
        {
            //  启用安息骑射手
            xsEffectAmount(cEnableObject, ParthianCavalryArcherID, 1, 0, playerId);
            xsEffectAmount(cSetAttribute, InvisiblePCAID, cRegenerationHpPercent, -30, playerId);
            xsEffectAmount(cSetAttribute, InvisibleEPCAID, cRegenerationHpPercent, -30, playerId);
        }
        case cVikings:
            xsEffectAmount(cEnableObject, WoodenFortressID, 1, 0, playerId);    //木制要塞
        case cSpanish:
        {
            //  西班牙文明加成, 标枪骑兵和精锐标枪骑兵提前一个时代
            ForceResearchTech(playerId, 601);
        }
        case cAztecs:
        {
            //  启用圣坛
            xsEffectAmount(cSetAttribute, ShrineID, cAvailableFlag, 1, playerId);
            xsEffectAmount(cSetAttribute, ShrineID, cDisabledFlag, 4, playerId);
        }
        case cMayans:
        {
            //  启用圣坛
            xsEffectAmount(cSetAttribute, ShrineID, cAvailableFlag, 1, playerId);
            xsEffectAmount(cSetAttribute, ShrineID, cDisabledFlag, 4, playerId);
        }
        case cHuns:
        {
            xsEffectAmount(cEnableObject, EarlyCavalryArcherID, 1, 0, playerId);    //  早期骑射手
            xsEffectAmount(cEnableObject, WoodenFortressID, 1, 0, playerId);    //木制要塞
        }
        case cIncas:
        {
            //  启用圣坛
            xsEffectAmount(cSetAttribute, ShrineID, cAvailableFlag, 1, playerId);
            xsEffectAmount(cSetAttribute, ShrineID, cDisabledFlag, 4, playerId);
        }
        case cBurgundians:
            xsEffectAmount(cEnableObject, 38, 1, 0, playerId);  //  启用骑士
        case cPoles:
        {
            //  波兰文明加成, 轻骑兵可提前一个时代升级
            ForceEnableTech(playerId, 254);
        }
        case cRomans:
        {
            //  罗马文明加成, 封建修道院和僧侣
            xsEffectAmount(cEnableObject, 104, 1, 0, playerId);
            xsEffectAmount(cEnableObject, 125, 1, 0, playerId);
        }
        case cWu:
        {
            //  吴文明加成, 坞堡产出黄金
            xsEffectAmount(cModResource, cAttributeWubaoGoldProductivity, 0, 10, playerId);
        }
        case cWei:
        {
            //  魏文明加成, 坞堡建造上限增加
            xsEffectAmount(cAddAttribute, WubaoID, cAvailableFlag, 1, playerId);
        }
        case cJurchens:
        {
            //  启用签军骑兵
            xsEffectAmount(cEnableObject, ConscriptedCavalryID, 1, 0, playerId);
            //  女真文明加成, TC产鹿
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, -0.4);
        }
        default:
            break;
    }

    //  骑士属性
    xsEffectAmount(cAddAttribute, 38, cHitpoints, -20, playerId);
    xsEffectAmount(cAddAttribute, 38, cAttack, 0 - 4 * 256 - 2, playerId);
    xsEffectAmount(cMulAttribute, 38, cTrainTime, 1.3333333, playerId);
}


//  10025 - 城堡时代效果
void EffectFunction10025(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cBritons:
        {
            //  启用骑马步兵
            xsEffectAmount(cEnableObject, HobelarID, 1, 0, playerId);
        }
        case cGoths:
        {
            //  哥特文明加成, 封建和城堡时代也增加人口上限和人口空间
            xsEffectAmount(cModResource, cAttributePopulationCap, 1, 5, playerId);
            xsEffectAmount(cModResource, cAttributeUnitLimit, 1, 5, playerId);
        }
        case cTeutons:
        {
            //  条顿文明加成, 掷矛手射程增加
            xsEffectAmount(cAddAttribute, 7, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cSearchRadius, 1, playerId);
            //  启用十字军骑士
            xsEffectAmount(cEnableObject, CrusaderKnightID, 1, 0, playerId);
            //  条顿文明加成 + 十字军骑士
            xsEffectAmount(cAddAttribute, CrusaderKnightID, cArmor, 4 * 256 + 1, playerId);
        }
        case cJapanese:
        {
            //  启用僧兵
            xsEffectAmount(cEnableObject, SoheiID1, 1, 0, playerId);
        }
        case cChinese:
        {
            //  中国文明加成, 科技折扣
            xsEffectAmount(cModResource, cAttributeResearchCostMod, 0, 0.85, playerId);
            //  启用猛火油柜
            xsEffectAmount(cEnableObject, FlameThrowerID, 1, 0, playerId);
        }
        case cByzantines:
        {
            //  启用瓦兰吉卫队
            xsEffectAmount(cEnableObject, VarangianID, 1, 0, playerId);
            //  拜占庭建筑生命值加成调整
            MulAttribute(playerId, cBuildingClass, cHitpoints, 1.2 / 1.15 / 1.0833);
            MulAttribute(playerId, cWallClass, cHitpoints, 1.2 / 1.15 / 1.0833);
            MulAttribute(playerId, cGateClass, cHitpoints, 1.2 / 1.15 / 1.0833);
            MulAttribute(playerId, cFarmClass, cHitpoints, 1.2 / 1.15 / 1.0833);
            MulAttribute(playerId, cTowerClass, cHitpoints, 1.2 / 1.15 / 1.0833);
        }
        case cPersians:
            xsEffectAmount(cEnableObject, AssassinID, 1, 0, playerId);  //  启用阿萨辛刺客
        case cSaracens:
        {
            xsEffectAmount(cEnableObject, AssassinID, 1, 0, playerId);  //  启用阿萨辛刺客
            //  启用骆驼长矛骑兵
            xsEffectAmount(cEnableObject, CamelLancerID, 1, 0, playerId);
        }
        case cTurks:
        {
            //  启用西帕希骑兵
            xsEffectAmount(cEnableObject, SipahiID, 1, 0, playerId);
        }
        case cSpanish:
        {
            //  西班牙文明加成, 标枪骑兵和精锐标枪骑兵提前一个时代
            ForceEnableTech(playerId, 599);
            //  西班牙文明加成, 马尼拉大帆船
            xsEffectAmount(cUpgradeUnit, 17, ManilaGalleoID, -1, playerId);
        }
        case cAztecs:
        {
            //  阿兹特克文明加成, 步弓手移动速度增加
            xsEffectAmount(cMulAttribute, 4, cMovementSpeed, 1.05, playerId);
            xsEffectAmount(cMulAttribute, 24, cMovementSpeed, 1.05, playerId);
            xsEffectAmount(cMulAttribute, 492, cMovementSpeed, 1.05, playerId);
            //  圣坛可建造数 +1
            xsEffectAmount(cAddAttribute, ShrineID, cAvailableFlag, 1, playerId);
        }
        case cMayans:
        {
            //  圣坛可建造数 +1
            xsEffectAmount(cAddAttribute, ShrineID, cAvailableFlag, 1, playerId);
        }
        case cHuns:
            xsEffectAmount(cUpgradeUnit, EarlyCavalryArcherID, 39, -1, playerId);   //  升级为骑射手
        case cItalians:
        {
            //  意大利文明加成, 可以购买圣物
            xsEffectAmount(cModifyTech, 3099, cAttrSetStacking, 1, playerId);
            xsEffectAmount(cModifyTech, 3099, cAttrSetStackingResearchCap, 4, playerId);
            xsEffectAmount(cModResource, cAttributeRelicPurchaseLimit, 0, 2, playerId);
            //  启用医院骑士
            SetTechAuto(playerId, 3038);
        }
        case cIncas:
        {
            //  圣坛可建造数 +1
            xsEffectAmount(cAddAttribute, ShrineID, cAvailableFlag, 1, playerId);
        }
        case cSlavs:
        {
            //  斯拉夫文明加成, 骑士系和贵族铁骑在城堡/帝王时代对建筑 +2/4 攻击力
            xsEffectAmount(cAddAttribute, 38, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 283, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 569, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 876, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 878, cAttack, 21 * 256 + 2, playerId);
            //  斯拉夫文明加成, 攻城武器厂在城堡/帝王时代 +25/50% 工作效率
            xsEffectAmount(cMulAttribute, 49, cWorkRate, 1.25, playerId);
            xsEffectAmount(cMulAttribute, 150, cWorkRate, 1.25, playerId);
        }
        case cEthiopians:
        {
            //  埃塞俄比亚文明加成的食物和黄金提升
            xsEffectAmount(cModResource, cAttributeFood, 1, 100, playerId);
            xsEffectAmount(cModResource, cAttributeGold, 1, 100, playerId);
        }
        case cMalians:
        {
            //  启用索法骑手
            xsEffectAmount(cEnableObject, SofaID, 1, 0, playerId);
        }
        case cBerbers:
        {
            //  柏柏尔村民在城堡/帝王时代移动速度加成提高
            xsEffectAmount(cMulAttribute, cVillagerClass, cMovementSpeed, 1.045454545, playerId);
        }
        case cVietnamese:
        {
            //  启用丛林斥候
            xsEffectAmount(cEnableObject, RungScoutID, 1, 0, playerId);
        }
        case cTatars:
        {
            //  鞑靼文明加成, 骑射手远程护甲增加
            xsEffectAmount(cAddAttribute, cCavalryArcherClass, cArmor, 3 * 256 + 1, playerId);
        }
        case cCumans:
        {
            //  库曼移动速度加成调整
            xsEffectAmount(cMulAttribute, cScoutCavalryClass, cMovementSpeed, 1.01904762, playerId);
            xsEffectAmount(cMulAttribute, cCavalryClass, cMovementSpeed, 1.01904762, playerId);
            xsEffectAmount(cMulAttribute, cCavalryArcherClass, cMovementSpeed, 1.01904762, playerId);
            xsEffectAmount(cMulAttribute, cConquistadorClass, cMovementSpeed, 1.01904762, playerId);
        }
        case cSicilians:
        {
            //  启用医院骑士
            SetTechAuto(playerId, 3038);
        }
        case cBohemians:
        {
            //  启用战车弓兵
            xsEffectAmount(cEnableObject, ChariotArcherID, 1, 0, playerId);
        }
        case cDravidians:
        {
            //  达罗毗荼文明加成的木材提升
            xsEffectAmount(cModResource, cAttributeWood, 1, 150, playerId);
            //  达罗毗荼文明加成, 僧侣转化范围增加
            xsEffectAmount(cAddAttribute, cMonkClass, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, cMonkClass, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, cMonkClass, cSearchRadius, 1, playerId);
        }
        case cGeorgians:
        {
            //  启用赫雷苏维季战士
            xsEffectAmount(cEnableObject, KhevsuretiWarriorID, 1, 0, playerId);
        }
        case cWu:
        {
            //  吴文明加成, 坞堡产出黄金
            xsEffectAmount(cModResource, cAttributeWubaoGoldProductivity, 0, 15, playerId);
        }
        case cWei:
        {
            //  魏文明加成, 坞堡建造上限增加
            xsEffectAmount(cAddAttribute, WubaoID, cAvailableFlag, 1, playerId);
        }
        case cJurchens:
        {
            //  女真文明加成, TC产鹿
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, -0.5);
        }
        default:
            break;
    }

    //  木制要塞升级
    xsEffectAmount(cMulAttribute, WoodenFortressID, cHitpoints, 1.333333, playerId);
    xsEffectAmount(cAddAttribute, WoodenFortressID, cAttack, 3 * 256 + 1, playerId);

    //  坞堡升级
    xsEffectAmount(cAddAttribute, WubaoID, cHitpoints, 500, playerId);

    //  小艇升级
    xsEffectAmount(cAddAttribute, LembosID, cHitpoints, 15, playerId);
    xsEffectAmount(cAddAttribute, LembosID, cAttack, 3 * 256 + 1, playerId);
    xsEffectAmount(cAddAttribute, LembosID, cAttack, 16 * 256 + 1, playerId);
    xsEffectAmount(cAddAttribute, LembosID, cAttack, 34 * 256 + 1, playerId);

    //  签军骑兵升级
    xsEffectAmount(cAddAttribute, ConscriptedCavalryID, cHitpoints, 15, playerId);
    xsEffectAmount(cAddAttribute, ConscriptedCavalryID, cAttack, 4 * 256 + 2, playerId);

    //  骑士属性
    xsEffectAmount(cAddAttribute, 38, cHitpoints, 20, playerId);
    xsEffectAmount(cAddAttribute, 38, cAttack, 4 * 256 + 2, playerId);
    xsEffectAmount(cMulAttribute, 38, cTrainTime, 0.75, playerId);
}


//  10026 - 帝王时代效果
void EffectFunction10026(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cFranks:
        {
            //  启用瑞士枪兵
            xsEffectAmount(cEnableObject, SwissLancerID, 1, 0, playerId);
        }
        case cGoths:
        {
            //  哥特文明加成, 封建和城堡时代也增加人口上限和人口空间
            xsEffectAmount(cModResource, cAttributePopulationCap, 1, 5, playerId);
            xsEffectAmount(cModResource, cAttributeUnitLimit, 1, -5, playerId);
        }
        case cTeutons:
        {
            //  条顿文明加成, 掷矛手射程增加
            xsEffectAmount(cAddAttribute, 7, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 7, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 6, cSearchRadius, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, 1155, cSearchRadius, 1, playerId);
            //  条顿文明加成 + 十字军骑士
            xsEffectAmount(cAddAttribute, CrusaderKnightID, cArmor, 4 * 256 + 1, playerId);
        }
        case cChinese:
        {
            //  中国文明加成, 科技折扣
            xsEffectAmount(cModResource, cAttributeResearchCostMod, 0, 0.8, playerId);
        }
        case cByzantines:
        {
            //  拜占庭建筑生命值加成调整
            MulAttribute(playerId, cBuildingClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cWallClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cGateClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cFarmClass, cHitpoints, 1.25 / 1.2 / 1.0769);
            MulAttribute(playerId, cTowerClass, cHitpoints, 1.25 / 1.2 / 1.0769);
        }
        case cSpanish:
        {
            //  马尼拉大帆船属性升级
            xsEffectAmount(cAddAttribute, 17, cHitpoints, 20, playerId);
            xsEffectAmount(cAddAttribute, 17, cAttack, 3 * 256 + 1, playerId);
            xsEffectAmount(cAddAttribute, 17, cAttack, 16 * 256 + 1, playerId);
            xsEffectAmount(cAddAttribute, 17, cArmor, 16 * 256 + 1, playerId);
        }
        case cAztecs:
        {
            //  阿兹特克文明加成, 步弓手移动速度增加
            xsEffectAmount(cMulAttribute, 4, cMovementSpeed, 1.04761905, playerId);
            xsEffectAmount(cMulAttribute, 24, cMovementSpeed, 1.04761905, playerId);
            xsEffectAmount(cMulAttribute, 492, cMovementSpeed, 1.04761905, playerId);
            //  圣坛可建造数 +1
            xsEffectAmount(cAddAttribute, ShrineID, cAvailableFlag, 1, playerId);
        }
        case cMayans:
        {
            //  圣坛可建造数 +1
            xsEffectAmount(cAddAttribute, ShrineID, cAvailableFlag, 1, playerId);
        }
        case cItalians:
        {
            //  意大利文明加成, 可以购买圣物
            xsEffectAmount(cModResource, cAttributeRelicPurchaseLimit, 1, 2, playerId);
        }
        case cIncas:
        {
            //  圣坛可建造数 +1
            xsEffectAmount(cAddAttribute, ShrineID, cAvailableFlag, 1, playerId);
        }
        case cSlavs:
        {
            //  斯拉夫文明加成, 骑士系和贵族铁骑在城堡/帝王时代对建筑 +2/4 攻击力
            xsEffectAmount(cAddAttribute, 38, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 283, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 569, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 876, cAttack, 21 * 256 + 2, playerId);
            xsEffectAmount(cAddAttribute, 878, cAttack, 21 * 256 + 2, playerId);
            //  斯拉夫文明加成, 攻城武器厂在城堡/帝王时代 +25/50% 工作效率
            xsEffectAmount(cMulAttribute, 49, cWorkRate, 1.2, playerId);
            xsEffectAmount(cMulAttribute, 150, cWorkRate, 1.2, playerId);
        }
        case cEthiopians:
        {
            //  埃塞俄比亚文明加成的食物和黄金提升
            xsEffectAmount(cModResource, cAttributeFood, 1, 200, playerId);
            xsEffectAmount(cModResource, cAttributeGold, 1, 200, playerId);
        }
        case cBerbers:
        {
            //  柏柏尔村民在城堡/帝王时代移动速度加成提高
            xsEffectAmount(cMulAttribute, cVillagerClass, cMovementSpeed, 1.0434783, playerId);
        }
        case cTatars:
        {
            //  鞑靼文明加成, 骑射手远程护甲增加
            xsEffectAmount(cAddAttribute, cCavalryArcherClass, cArmor, 3 * 256 + 1, playerId);
        }
        case cCumans:
        {
            //  库曼移动速度加成调整
            xsEffectAmount(cMulAttribute, cScoutCavalryClass, cMovementSpeed, 1.01869159, playerId);
            xsEffectAmount(cMulAttribute, cCavalryClass, cMovementSpeed, 1.01869159, playerId);
            xsEffectAmount(cMulAttribute, cCavalryArcherClass, cMovementSpeed, 1.01869159, playerId);
            xsEffectAmount(cMulAttribute, cConquistadorClass, cMovementSpeed, 1.01869159, playerId);
        }
        case cDravidians:
        {
            //  达罗毗荼文明加成的木材提升
            xsEffectAmount(cModResource, cAttributeWood, 1, 300, playerId);
            //  达罗毗荼文明加成, 僧侣转化范围增加
            xsEffectAmount(cAddAttribute, cMonkClass, cMaxRange, 1, playerId);
            xsEffectAmount(cAddAttribute, cMonkClass, cLineOfSight, 1, playerId);
            xsEffectAmount(cAddAttribute, cMonkClass, cSearchRadius, 1, playerId);
        }
        case cWu:
        {
            //  吴文明加成, 坞堡产出黄金
            xsEffectAmount(cModResource, cAttributeWubaoGoldProductivity, 0, 20, playerId);
        }
        case cWei:
        {
            //  魏文明加成, 坞堡建造上限增加
            xsEffectAmount(cAddAttribute, WubaoID, cAvailableFlag, 1, playerId);
        }
        case cJurchens:
        {
            //  女真文明加成, TC产鹿
            SetAttribute(playerId, InvisibleDeerSpawnerID, cRegenerationHpPercent, -0.66666666667);
        }
        default:
            break;
    }

    //  阿萨辛刺客升级
    //xsEffectAmount(cAddAttribute, AssassinID, cHitpoints, 15, playerId);
    //xsEffectAmount(cAddAttribute, AssassinID, cAttack, 4 * 256 + 15, playerId);
    //xsEffectAmount(cAddAttribute, AssassinID, cShownAttack, 15, playerId);
    //  木制要塞升级
    xsEffectAmount(cMulAttribute, WoodenFortressID, cHitpoints, 1.25, playerId);
    xsEffectAmount(cAddAttribute, WoodenFortressID, cAttack, 3 * 256 + 1, playerId);
    //  坞堡升级
    xsEffectAmount(cAddAttribute, WubaoID, cHitpoints, 500, playerId);
    //  马尼拉大帆船升级
    xsEffectAmount(cAddAttribute, ManilaGalleoID, cHitpoints, 20, playerId);
    xsEffectAmount(cAddAttribute, ManilaGalleoID, cAttack, 3 * 256 + 1, playerId);
    xsEffectAmount(cAddAttribute, ManilaGalleoID, cAttack, 16 * 256 + 1, playerId);
    xsEffectAmount(cAddAttribute, ManilaGalleoID, cArmor, 16 * 256 + 1, playerId);
    //  小艇升级
    xsEffectAmount(cAddAttribute, LembosID, cHitpoints, 15, playerId);
    xsEffectAmount(cAddAttribute, LembosID, cAttack, 3 * 256 + 1, playerId);
    xsEffectAmount(cAddAttribute, LembosID, cAttack, 16 * 256 + 1, playerId);
    xsEffectAmount(cAddAttribute, LembosID, cAttack, 34 * 256 + 1, playerId);
    //  签军骑兵升级
    xsEffectAmount(cAddAttribute, ConscriptedCavalryID, cHitpoints, 15, playerId);
    xsEffectAmount(cAddAttribute, ConscriptedCavalryID, cAttack, 4 * 256 + 2, playerId);
    //  战车弓兵升级
    LaunchAura(playerId, ChariotArcherID);
}