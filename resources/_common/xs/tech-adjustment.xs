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
    xsEffectAmount(cModifyTech, BlockPrintingTechID, cAttrSetGoldCost, 0, playerId);
    xsEffectAmount(cModifyTech, BlockPrintingTechID, cAttrAddFoodCost, 250, playerId);
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
    AddAttackForm(playerId, VarangianID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, EliteVarangianID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, CataphractID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, EliteCataphractID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, KnightID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, CavalierID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, PaladinID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, SavarID, cDamageClassInfantry, 6);
    AddAttackForm(playerId, GuanNingCavalryID, cDamageClassInfantry, 6);
    ModAttribute(playerId, CataphractID, cAreaDamage, -2);
    ModAttribute(playerId, EliteCataphractID, cAreaDamage, -2);
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
    ModArmor(playerId, RattanSwordmanID, cDamageClassMelee, 1);
    ModArmor(playerId, EliteRattanSwordmanID, cDamageClassMelee, 1);

    ModArmor(playerId, RattanSwordmanID, cDamageClassPierce, 1);
    ModArmor(playerId, EliteRattanSwordmanID, cDamageClassPierce, 1);
}


//  10091 - Teutons Armor Bonus Adjustment
void EffectFunction10091(int playerId = -1)
{
    int i = 0;
    int TrainLocation = 0;
    for (i = NewObjectStartID; < TotalObjects)
    {
        TrainLocation = xsGetObjectAttribute(playerId, i, cTrainLocation);
        if ((TrainLocation == BarracksID) || (TrainLocation == StableID))
            ModArmor(playerId, i, cDamageClassMelee, 1);
    }
}


//  10092 - Malians Armor Bonus Adjustment
void EffectFunction10092(int playerId = -1)
{
    int i = 0;
    int TrainLocation = 0;
    for (i = NewObjectStartID; < TotalObjects)
    {
        TrainLocation = xsGetObjectAttribute(playerId, i, cTrainLocation);
        if (TrainLocation == BarracksID)
            ModArmor(playerId, i, cDamageClassPierce, 1);
    }
}


//  10101 - Hauberk Adjustment
void EffectFunction10101(int playerId = -1)
{
    ModAttribute(playerId, HospitallerKnightID, cDamageClassPierce, 2);
    ModAttribute(playerId, HospitallerKnightID, cDamageClassMelee, 1);
}


//  10102 - Ballistics Adjustment
void EffectFunction10102(int playerId = -1)
{
    SetAttribute(playerId, 363, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 364, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 477, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 478, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 366, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 365, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 466, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 375, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 475, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 476, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 377, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 376, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 507, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 519, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 506, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 537, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 510, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 522, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 504, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 517, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 505, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 518, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 511, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 523, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 514, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 54, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 525, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 328, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 503, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 516, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 513, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 526, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 372, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 470, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 540, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 541, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 373, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 471, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 512, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 524, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 518, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 747, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 746, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 187, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 538, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1057, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1058, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1169, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1170, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 786, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 787, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1779, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1780, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1781, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1782, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1830, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1867, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1868, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1930, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1931, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1971, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1972, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1983, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1982, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1964, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1957, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1936, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1937, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2057, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1879, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1913, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2572, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2573, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2574, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2575, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2608, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2609, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2631, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 2632, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1548, cEnableSmartProjectile, 3);

    SetAttribute(playerId, ProjectileDonsoID, cEnableSmartProjectile, 3);
    SetAttribute(playerId, ProjectileRattanSwordmanID, cEnableSmartProjectile, 3);
    SetAttribute(playerId, ProjectileRattanSwordmanFireID, cEnableSmartProjectile, 3);
}


//  10103 - Arquebus Adjustment
void EffectFunction10103(int playerId = -1)
{
    SetAttribute(playerId, 380, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 368, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 506, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 537, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 374, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1119, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1733, cEnableSmartProjectile, 3);
    SetAttribute(playerId, 1789, cEnableSmartProjectile, 3);
    SetAttribute(playerId, ProjectileGuanNingCavalryID, cEnableSmartProjectile, 3);

    ModAttribute(playerId, ProjectileGuanNingCavalryID, cMovementSpeed, 0.5);
}


//  10113 - Chatras Adjustment
void EffectFunction10113(int playerId = -1)
{
    ModAttribute(playerId, RaiderElephantID, cHitpoints, 100);
    ModAttribute(playerId, VeteranRaiderElephantID, cHitpoints, 100);
    ModAttribute(playerId, EliteRaiderElephantID, cHitpoints, 100);
    ModAttribute(playerId, EarlyElephantArcherID, cHitpoints, 100);
    ModAttribute(playerId, ElephantArcherID, cHitpoints, 100);
    ModAttribute(playerId, EliteElephantArcherID, cHitpoints, 100);
}


//  10114 - Forging Adjustment
void EffectFunction10114(int playerId = -1)
{
    ModAttack(playerId, ProjectileDonsoID, cDamageClassMelee, 1);
    ModAttack(playerId, ProjectileRattanSwordmanID, cDamageClassMelee, 1);
    ModAttack(playerId, ProjectileRattanSwordmanFireID, cDamageClassMelee, 1);
}


//  10115 - Iron Casting Adjustment
void EffectFunction10115(int playerId = -1)
{
    ModAttack(playerId, ProjectileDonsoID, cDamageClassMelee, 1);
    ModAttack(playerId, ProjectileRattanSwordmanID, cDamageClassMelee, 1);
    ModAttack(playerId, ProjectileRattanSwordmanFireID, cDamageClassMelee, 1);
}


//  10116 - Blast Furnace Adjustment
void EffectFunction10116(int playerId = -1)
{
    ModAttack(playerId, ProjectileDonsoID, cDamageClassMelee, 2);
    ModAttack(playerId, ProjectileRattanSwordmanID, cDamageClassMelee, 2);
    ModAttack(playerId, ProjectileRattanSwordmanFireID, cDamageClassMelee, 2);
}


//  10098 - Chemistry Adjustment
void EffectFunction10098(int playerId = -1)
{
    ModAttack(playerId, ManilaGalleonID, cDamageClassPierce, 1);
    if (isResearched(playerId, ManilaGalleonTechID))
        UpgradeUnit(playerId, TradeCogID, ManilaGalleonID);
    ModAttack(playerId, FlameThrowerID, cDamageClassMelee, 1);

    ModAttack(playerId, ProjectileDonsoID, cDamageClassMelee, 1);
    ModAttack(playerId, ProjectileRattanSwordmanID, cDamageClassMelee, 1);
    ModAttack(playerId, ProjectileRattanSwordmanFireID, cDamageClassMelee, 1);

    UpgradeUnit(playerId, ProjectileRattanSwordmanID, ProjectileRattanSwordmanFireID);
}


//  10119 - Medical Corps Adjustment
void EffectFunction10119(int playerId = -1)
{
    ModAttribute(playerId, RaiderElephantID, cRegenerationRate, 30);
    ModAttribute(playerId, VeteranRaiderElephantID, cRegenerationRate, 30);
    ModAttribute(playerId, EliteRaiderElephantID, cRegenerationRate, 30);
    ModAttribute(playerId, EarlyElephantArcherID, cRegenerationRate, 30);
}


//  10121 - Grand Trunk Road Adjustment
void EffectFunction10121(int playerId = -1)
{
    MulResource(playerId, cAttributeGoldFarmingProductivity, 1.1);
    MulResource(playerId, cAttributeForestryProductivity, 1.1);
    MulResource(playerId, cAttributeCashCropProductivity, 1.1);
}


void ButalmapuCivCustomChanges(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    if ((playerCiv == cVikings) || (isResearched(playerId, RattanSwordmanTechID)) || (isResearched(playerId, LegionaryTechID)))
    {
        MulAttribute(playerId, MilitiaID, cResourceCost, 0.85);
        MulAttribute(playerId, ManAtArmsID, cResourceCost, 0.85);
        MulAttribute(playerId, LongSwordmanID, cResourceCost, 0.85);
        MulAttribute(playerId, TwoHandedSwordmanID, cResourceCost, 0.85);
        MulAttribute(playerId, ChampionID, cResourceCost, 0.85);
    }

    if ((playerCiv == cMalians))
    {
        MulAttribute(playerId, SpearmanID, cResourceCost, 0.85);
        MulAttribute(playerId, PikemanID, cResourceCost, 0.85);
        MulAttribute(playerId, HalberdierID, cResourceCost, 0.85);
    }

    if ((playerCiv == cFranks) || (playerCiv == cJapanese) || (playerCiv == cCelts))
    {
        MulAttribute(playerId, ArcherID, cResourceCost, 0.85);
        MulAttribute(playerId, CrossbowmanID, cResourceCost, 0.85);
        MulAttribute(playerId, ArbalesterID, cResourceCost, 0.85);
    }

    if ((playerCiv == cPoles))
    {
        MulAttribute(playerId, CavalryArcherID, cResourceCost, 0.85);
        MulAttribute(playerId, HeavyCavalryArcherID, cResourceCost, 0.85);
    }

    if ((playerCiv == cJapanese) || (playerCiv == cSlavs))
    {
        MulAttribute(playerId, HandCannoneerID, cResourceCost, 0.85);
    }

    if ((playerCiv == cIndians) || (playerCiv == cBengalis) || (playerCiv == cRomans) || (isResearched(playerId, WingedHussarTechID)))
    {
        MulAttribute(playerId, ScoutCavalryID, cResourceCost, 0.85);
        MulAttribute(playerId, LightCavalryID, cResourceCost, 0.85);
        MulAttribute(playerId, HussarID, cResourceCost, 0.85);
    }

    if ((playerCiv == cJapanese) || (playerCiv == cTurks) || (playerCiv == cKoreans) || (playerCiv == cEthiopians) || (playerCiv == cVietnamese)
        || (isResearched(playerId, CrusaderKnightTechID)) || (isResearched(playerId, HospitallerKnightTechID)))
    {
        MulAttribute(playerId, KnightID, cResourceCost, 0.85);
        MulAttribute(playerId, CavalierID, cResourceCost, 0.85);
        MulAttribute(playerId, PaladinID, cResourceCost, 0.85);
    }

    if ((isResearched(playerId, GuanNingCavalryTechID)))
    {
        MulAttribute(playerId, HeiGuangCavalryID, cResourceCost, 0.85);
        MulAttribute(playerId, HeavyHeiGuangCavalryID, cResourceCost, 0.85);
    }

    if ((playerCiv == cDravidians))
    {
        MulAttribute(playerId, BattleElephantID, cResourceCost, 0.85);
        MulAttribute(playerId, EliteBattleElephantID, cResourceCost, 0.85);
    }

    if ((playerCiv == cPersians)  || (playerCiv == cSaracens))
    {
        MulAttribute(playerId, PetardID, cResourceCost, 0.85);
    }

    if ((isResearched(playerId, DragonShipTechID)))
    {
        MulAttribute(playerId, FireGalleyID, cResourceCost, 0.85);
        MulAttribute(playerId, FireShipID, cResourceCost, 0.85);
        MulAttribute(playerId, FastFireShipID, cResourceCost, 0.85);
    }

    if ((isResearched(playerId, ManilaGalleonTechID)))
    {
        MulAttribute(playerId, TradeCogID, cResourceCost, 0.85);
    }

    if ((isResearched(playerId, HoufniceTechID)))
    {
        MulAttribute(playerId, BombardCannonID, cResourceCost, 0.85);
    }
}


//  10124 - Butalmapu Adjustment
void EffectFunction10124(int playerId = -1)
{
    int i = 0;
    int j = 0;
    int PlayerObjectCount = xsGetPlayerNumberOfObjects(playerId);
    int UniqueUnitArmor = 0;

    for (i = NewObjectStartID; < PlayerObjectCount)
        if (isClassID(i) == false)
        {
            UniqueUnitArmor = xsGetObjectAttribute(playerId, i, cArmor, cDamageClassUniqueUnits);
            if (UniqueUnitArmor != -1)
                MulAllyAttribute(playerId, i, cResourceCost, 0.85);
        }
    for (i = 1; <= xsGetNumPlayers())
        ButalmapuCivCustomChanges(i);

    MulAllyAttribute(playerId, DragonShipID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, GuanNingCavalryID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, LongBoatID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, EliteLongBoatID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, ManilaGalleonID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, TurtleShipID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, EliteTurtleShipID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, CondottieroID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, CaravelID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, EliteCaravelID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, FlemishPikemanID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, WingedHussarID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, HoufniceID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, ThirisadaiID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, LegionaryID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, WarriorPriestID, cResourceCost, 0.85);
    MulAllyAttribute(playerId, WarriorPriestWithRelicID, cResourceCost, 0.85);
}


//  10125 - Cavalry kill adjustment for Mapuche
void EffectFunction10125(int playerId = -1)
{
    xsResetTaskAmount();
    xsTaskAmount(cTaskAttrWorkValue1, 6);
    xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);

    CavalryKillReward(cCavalryClass, playerId);
    CavalryKillReward(cScoutCavalryClass, playerId);
    CavalryKillReward(cConquistadorClass, playerId);
    CavalryKillReward(cCavalryArcherClass, playerId);
  
  xsResetTaskAmount();
}