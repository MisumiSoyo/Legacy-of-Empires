// 10032 - Huns Atheism Adjustment, Tarkan Task Adder
void EffectFunction10032(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, ChanyuID);
    xsTask(TarkanID, cTaskTypePickupUnit, RelicID, playerId);
    xsTask(Tarkan2ID, cTaskTypePickupUnit, RelicID, playerId);
    xsTask(EliteTarkanID, cTaskTypePickupUnit, RelicID, playerId);
    xsTask(EliteTarkan2ID, cTaskTypePickupUnit, RelicID, playerId);
    xsResetTaskAmount();

    ModAttribute(playerId, TarkanID, cHeroStatus, 2);
    ModAttribute(playerId, Tarkan2ID, cHeroStatus, 2);
    ModAttribute(playerId, EliteTarkanID, cHeroStatus, 2);
    ModAttribute(playerId, EliteTarkan2ID, cHeroStatus, 2);
    AddAttackForm(playerId, ChanyuID, cDamageClassMonastery, 200);
}


//  10076 - Hussite Reforms Adjustment
void EffectFunction10076(int playerId = -1)
{
    int MonkCount = xsGetObjectCount(playerId, cMonkClass) + xsGetObjectCount(playerId, cMonkWithRelicClass);
    ModResource(playerId, cAttributeGold, 50 * MonkCount);
    xsEffectAmount(cModifyTech, TitheTechID, cAttrSetGoldCost, 0, playerId);
    xsEffectAmount(cModifyTech, TitheTechID, cAttrAddFoodCost, 125, playerId);
}


//  10082 - Town Patrol Adjustment
void EffectFunction10082(int playerId = -1)
{
    ModAttribute(playerId, TownCenterID, cTotalProjectiles, 2);
    ModAttribute(playerId, TownCenter2ID, cTotalProjectiles, 2);
    ModAttribute(playerId, TownCenter3ID, cTotalProjectiles, 2);
    ModAttribute(playerId, TownCenter4ID, cTotalProjectiles, 2);

    ModAttribute(playerId, TownCenterID, cMaxTotalProjectiles, 2);
    ModAttribute(playerId, TownCenter2ID, cMaxTotalProjectiles, 2);
    ModAttribute(playerId, TownCenter3ID, cMaxTotalProjectiles, 2);
    ModAttribute(playerId, TownCenter4ID, cMaxTotalProjectiles, 2);
}


//  10083 - Logistica Adjustment
void EffectFunction10083(int playerId = -1)
{
    ModAttribute(playerId, VarangianID, cBlastWidth, 0.5);
    ModAttribute(playerId, EliteVarangianID, cBlastWidth, 0.5);
    ModAttribute(playerId, KnightID, cBlastWidth, 0.5);
    ModAttribute(playerId, CavalierID, cBlastWidth, 0.5);
    ModAttribute(playerId, PaladinID, cBlastWidth, 0.5);
    ModAttribute(playerId, SavarID, cBlastWidth, 0.5);
    ModAttribute(playerId, GuanNingCavalryID, cBlastWidth, 0.5);

    SetAttribute(playerId, VarangianID, cAreaDamage, -5);
    SetAttribute(playerId, EliteVarangianID, cAreaDamage, -5);
    SetAttribute(playerId, KnightID, cAreaDamage, -5);
    SetAttribute(playerId, CavalierID, cAreaDamage, -5);
    SetAttribute(playerId, PaladinID, cAreaDamage, -5);
    SetAttribute(playerId, SavarID, cAreaDamage, -5);
    SetAttribute(playerId, GuanNingCavalryID, cAreaDamage, -5);
}


//  10090 - Gambesons Adjustment
void EffectFunction10090(int playerId = -1)
{
    ModArmor(playerId, MilitiaID, cDamageClassMelee, 1);
    ModArmor(playerId, ManAtArmsID, cDamageClassMelee, 1);
    ModArmor(playerId, LongSwordmanID, cDamageClassMelee, 1);
    ModArmor(playerId, TwoHandedSwordmanID, cDamageClassMelee, 1);
    ModArmor(playerId, ChampionID, cDamageClassMelee, 1);
    ModArmor(playerId, LegionaryID, cDamageClassMelee, 1);
    ModArmor(playerId, FireLancerID, cDamageClassMelee, 1);
    ModArmor(playerId, EliteFireLancerID, cDamageClassMelee, 1);
}


//  10091 - Teutons Armor Bonus Adjustment
void EffectFunction10091(int playerId = -1)
{
    int i = 0;
    int TrainLocation = 0;
    for (i = NewObjectStartID; <= TotalObjects)
    {
        TrainLocation = xsGetObjectAttribute(playerId, i, cTrainLocation);
        if ((TrainLocation == BarracksID) || (TrainLocation == StableID))
            ModArmor(playerId, i, cDamageClassMelee, 1);
    }

    ModArmor(playerId, KeshikID, cDamageClassMelee, 1);
    ModArmor(playerId, EliteKeshikID, cDamageClassMelee, 1);
}


//  10092 - Malians Armor Bonus Adjustment
void EffectFunction10092(int playerId = -1)
{
    int i = 0;
    int TrainLocation = 0;
    for (i = NewObjectStartID; <= TotalObjects)
    {
        TrainLocation = xsGetObjectAttribute(playerId, i, cTrainLocation);
        if (TrainLocation == BarracksID)
            ModArmor(playerId, i, cDamageClassPierce, 1);
    }
}