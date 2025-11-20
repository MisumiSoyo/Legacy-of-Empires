//======================================================================================
//
// This file contains functions which are called by technology effects.
// Included automatically.
//
//======================================================================================

// 1 - Inca team bonus: spawn a randomized llama
void EffectFunction1(int playerId = -1)
{
    int llamaId = 305;
    int randomNumber = xsGetRandomNumberLH(0, 2);
    if (randomNumber == 1)
    {
        llamaId = 1963;
    }
    xsEffectAmount(cSpawnUnit, llamaId, 619, 1, playerId);
}

// 2 - Dark Age effect: randomize graphics for Hunnic Horse
void EffectFunction2(int playerId = -1)
{
    int hunnicHorseId = 1869;
    int newAttackGraphicId = -1;
    int newStandingGraphicId = -1;
    int newDyingGraphicId = -1;
    int newUndeadGraphicId = -1;
    int newWalkingGraphicId = -1;

    int randomNumber = xsGetRandomNumberLH(0, 4);
    switch (randomNumber)
    {
        case 1:
        {
            newAttackGraphicId = 5600;
            newStandingGraphicId = 5602;
            newDyingGraphicId = 5601;
            newUndeadGraphicId = 5604;
            newWalkingGraphicId = 5605;
            break;
        }
        case 2:
        {
            newAttackGraphicId = 5606;
            newStandingGraphicId = 5608;
            newDyingGraphicId = 5607;
            newUndeadGraphicId = 5610;
            newWalkingGraphicId = 5611;
            break;
        }
        case 3:
        {
            newAttackGraphicId = 5612;
            newStandingGraphicId = 5614;
            newDyingGraphicId = 5613;
            newUndeadGraphicId = 5616;
            newWalkingGraphicId = 5617;
            break;
        }
        default:
        {
            return;
        }
    }

    xsEffectAmount(cSetAttribute, hunnicHorseId, cAttackGraphic, newAttackGraphicId, playerId);
    xsEffectAmount(cSetAttribute, hunnicHorseId, cStandingGraphic, newStandingGraphicId, playerId);
    xsEffectAmount(cSetAttribute, hunnicHorseId, cDyingGraphic, newDyingGraphicId, playerId);
    xsEffectAmount(cSetAttribute, hunnicHorseId, cUndeadGraphic, newUndeadGraphicId, playerId);
    xsEffectAmount(cSetAttribute, hunnicHorseId, cWalkingGraphic, newWalkingGraphicId, playerId);
}

// Effect of Ordo Cavalry UT for Khitans
void OrdoCavalry(int ClassTarget = -1, int playerId = -1)
{
  xsEffectAmount(cAddAttribute, ClassTarget, cCombatAbility, 128, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, 1.5);
  xsTaskAmount(cTaskAttrWorkValue2, 2);
  xsTaskAmount(cTaskAttrSearchWaitTime, 120);

  xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, -1.5);
  xsTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
  xsTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
  xsTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
  xsTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);
  xsTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);
}

// Remove Ordo Cavalry from undesirable units
void OrdoCavalryRemoval(int UnitTarget = -1, int playerId = -1)
{
  xsEffectAmount(cAddAttribute, UnitTarget, cCombatAbility, -128, playerId);
  xsRemoveTask(UnitTarget, cTaskTypeStinger, cBuildingClass, playerId);
  xsRemoveTask(UnitTarget, cTaskTypeStinger, cGateClass, playerId);
  xsRemoveTask(UnitTarget, cTaskTypeStinger, cFarmClass, playerId);
  xsRemoveTask(UnitTarget, cTaskTypeStinger, cTowerClass, playerId);
  xsRemoveTask(UnitTarget, cTaskTypeStinger, cWallClass, playerId);
}

// 3 - Apply Ordo Cavalry to Cavalry Classes
void EffectFunction3(int playerId = -1)
{
  int MountedTrebuchetId = 1923;
  int MamelukeId = 282;
  int EliteMameluketId = 556;
  int SaladinId = 1296;
  int JarlId = 1298;
  int LiuBiaoId = 2049;
  int BallistaElephantId = 1120;
  int EliteBallistaElephantId = 1122;
  int WarChariotFocusId = 1962;
  int WarChariotBarrageId = 1980;
  xsResetTaskAmount();

  OrdoCavalry(cCavalryClass, playerId);
  OrdoCavalry(cScoutCavalryClass, playerId);

  OrdoCavalryRemoval(MountedTrebuchetId, playerId);
  OrdoCavalryRemoval(MamelukeId, playerId);
  OrdoCavalryRemoval(EliteMameluketId, playerId);
  OrdoCavalryRemoval(SaladinId, playerId);
  OrdoCavalryRemoval(JarlId, playerId);
  OrdoCavalryRemoval(LiuBiaoId, playerId);
  OrdoCavalryRemoval(BallistaElephantId, playerId);
  OrdoCavalryRemoval(EliteBallistaElephantId, playerId);
  OrdoCavalryRemoval(WarChariotFocusId, playerId);
  OrdoCavalryRemoval(WarChariotBarrageId, playerId);

  xsResetTaskAmount();
}

// 4 - Effect of Tuntian for Wei
void EffectFunction4(int playerId = -1)
{
  int WarriorPriestWithRelicID = 1831;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeMilitaryFoodTrickle);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 3);
  xsTaskAmount(cTaskAttrSearchWaitTime, 1);
  xsTaskAmount(cTaskAttrAutoSearch, 3);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);

  xsTask(cArcherClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(cInfantryClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(cCavalryClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(cConquistadorClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(cPetardClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(cCavalryArcherClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(cHandCannoneerClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(cScoutCavalryClass, cTaskTypeGenerateResources, -1, playerId);
  xsTask(WarriorPriestWithRelicID, cTaskTypeGenerateResources, -1, playerId);

  xsResetTaskAmount();
}

// 5 - Effect of Chieftains for Vikings
void EffectFunction5(int playerId = -1)
{
  int WarriorPriestWithRelicID = 1831;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 20);
  xsTaskAmount(cTaskAttrProductivityResource, 274);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
  xsTask(cInfantryClass, cTaskTypeLoot, cTradeBoatClass, playerId);
  xsTask(cInfantryClass, cTaskTypeLoot, cMonkWithRelicClass, playerId);
  xsTask(cInfantryClass, cTaskTypeLoot, cMonkClass, playerId);
  xsTask(cInfantryClass, cTaskTypeLoot, cMonkWithRelicClass, playerId);
  xsTask(cInfantryClass, cTaskTypeLoot, WarriorPriestWithRelicID, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, 5);
  xsTask(cInfantryClass, cTaskTypeLoot, cVillagerClass, playerId);

  xsResetTaskAmount();
}

// Effect of Coiled Serpent Array for Shu
void CoiledSerpentArray(int ClassTarget = -1, int playerId = -1)
{
  int SpearmanID = 93;
  int PikemanID = 358;
  int HalberdierID = 359;
  int SpearmanDonjonID = 1786;
  int PikemanDonjonID = 1787;
  int HalberdierDonjonID = 1788;
  int WhiteFeatherGuardID = 1959;
  int EliteWhiteFeatherGuardID = 1961;
  xsEffectAmount(cAddAttribute, ClassTarget, cCombatAbility, 96, playerId);
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.15);
  xsTaskAmount(cTaskAttrWorkValue2, 30);
  xsTaskAmount(cTaskAttrWorkRange, 15);
  xsTaskAmount(cTaskAttrGatheringSoundInt32, 13406);
  xsTaskAmount(cTaskAttrDepositSoundInt32, 13406);
  xsTaskAmount(cTaskAttrOwnerType, 1);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 3);
  xsTaskAmount(cTaskAttrSearchWaitTime, 0);
  xsTaskAmount(cTaskAttrAutoSearch, 0);
  xsTask(ClassTarget, cTaskTypeAura, SpearmanID, playerId);

  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTask(ClassTarget, cTaskTypeAura, PikemanID, playerId);
  xsTask(ClassTarget, cTaskTypeAura, HalberdierID, playerId);
  xsTask(ClassTarget, cTaskTypeAura, SpearmanDonjonID, playerId);
  xsTask(ClassTarget, cTaskTypeAura, PikemanDonjonID, playerId);
  xsTask(ClassTarget, cTaskTypeAura, HalberdierDonjonID, playerId);
  xsTask(ClassTarget, cTaskTypeAura, WhiteFeatherGuardID, playerId);
  xsTask(ClassTarget, cTaskTypeAura, EliteWhiteFeatherGuardID, playerId);

  xsResetTaskAmount();
}

// 6 - Apply Coiled Serpent Array to desired units for Shu
void EffectFunction6(int playerId = -1)
{
  int SpearmanID = 93;
  int PikemanID = 358;
  int HalberdierID = 359;
  int SpearmanDonjonID = 1786;
  int PikemanDonjonID = 1787;
  int HalberdierDonjonID = 1788;
  int WhiteFeatherGuardID = 1959;
  int EliteWhiteFeatherGuardID = 1961;
  xsResetTaskAmount();

  CoiledSerpentArray(SpearmanID, playerId);
  CoiledSerpentArray(PikemanID, playerId);
  CoiledSerpentArray(HalberdierID, playerId);
  CoiledSerpentArray(SpearmanDonjonID, playerId);
  CoiledSerpentArray(PikemanDonjonID, playerId);
  CoiledSerpentArray(HalberdierDonjonID, playerId);
  CoiledSerpentArray(WhiteFeatherGuardID, playerId);
  CoiledSerpentArray(EliteWhiteFeatherGuardID, playerId);

  xsResetTaskAmount();
}

// 7 - Effect of Bimaristan for Saracens
void EffectFunction7(int playerId = -1)
{
  int WarriorPriestWithRelicID = 1831;
  xsResetTaskAmount();

  xsEffectAmount(cAddAttribute, cMonkClass, cCombatAbility, 32, playerId);
  xsEffectAmount(cAddAttribute, cMonkWithRelicClass, cCombatAbility, 32, playerId);
  xsEffectAmount(cAddAttribute, WarriorPriestWithRelicID, cCombatAbility, -32, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, 75);
  xsTaskAmount(cTaskAttrWorkValue2, 1);
  xsTaskAmount(cTaskAttrWorkRange, 5);
  xsTaskAmount(cTaskAttrGatheringSoundInt32, 13404);
  xsTaskAmount(cTaskAttrDepositSoundInt32, 13404);
  xsTaskAmount(cTaskAttrOwnerType, 4);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 2);
  xsTaskAmount(cTaskAttrSearchWaitTime, 109);
  xsTaskAmount(cTaskAttrGatherType, 21);

  xsTask(cMonkClass, cTaskTypeAura, cArcherClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cVillagerClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cInfantryClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cCavalryClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cMonkClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cTradeCartClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cConquistadorClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cPetardClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cCavalryArcherClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cMonkWithRelicClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cHandCannoneerClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cScoutCavalryClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cFarmClass, playerId);
  xsTask(cMonkClass, cTaskTypeAura, cKingClass, playerId);

  xsTask(cMonkWithRelicClass, cTaskTypeAura, cArcherClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cVillagerClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cInfantryClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cCavalryClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cMonkClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cTradeCartClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cConquistadorClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cPetardClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cCavalryArcherClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cMonkWithRelicClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cHandCannoneerClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cScoutCavalryClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cFarmClass, playerId);
  xsTask(cMonkWithRelicClass, cTaskTypeAura, cKingClass, playerId);

  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cArcherClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cVillagerClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cInfantryClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cCavalryClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cMonkClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cTradeCartClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cConquistadorClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cPetardClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cCavalryArcherClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cMonkWithRelicClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cHandCannoneerClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cScoutCavalryClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cFarmClass, playerId);
  xsRemoveTask(WarriorPriestWithRelicID, cTaskTypeAura, cKingClass, playerId);

  xsResetTaskAmount();
}

// 8 - Effect of Stronghold for Celts
void EffectFunction8(int playerId = -1)
{
  int WarriorPriestWithRelicID = 1831;
  int CastleID = 82;
  xsResetTaskAmount();

  xsEffectAmount(cAddAttribute, CastleID, cCombatAbility, 32, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, 30);
  xsTaskAmount(cTaskAttrWorkValue2, 1);
  xsTaskAmount(cTaskAttrWorkRange, 7);
  xsTaskAmount(cTaskAttrGatheringSoundInt32, 13405);
  xsTaskAmount(cTaskAttrDepositSoundInt32, 13405);
  xsTaskAmount(cTaskAttrOwnerType, 4);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 4);
  xsTaskAmount(cTaskAttrSearchWaitTime, 109);
  xsTaskAmount(cTaskAttrGatherType, 21);
  xsTask(CastleID, cTaskTypeAura, cInfantryClass, playerId);
  xsTask(CastleID, cTaskTypeAura, WarriorPriestWithRelicID, playerId);

  xsResetTaskAmount();
}


// 9 - Effect of Fortified Church Bonus for Georgians
void ChurchAura(int BuildingID = -1, int playerId = -1)
{
  int FarmerMaleID = 214;
  int FarmerFemaleID = 259;
  int VillagerMaleID = 83;
  int VillagerFemaleID = 293;
  int FishermanMaleID = 56;
  int FishermanFemaleID = 57;
  int BuilderMaleID = 118;
  int ForagerMaleID = 120;
  int HunterMaleID = 122;
  int LumberjackMaleID = 123;
  int StoneMinerMaleID = 124;
  int RepairerMaleID = 156;
  int BuilderFemaleID = 212;
  int HunterFemaleID = 216;
  int LumberjackFemaleID = 218;
  int StoneMinerFemaleID = 220;
  int RepairerFemaleID = 222;
  int ForagerFemaleID = 354;
  int GoldMinerMaleID = 579;
  int GoldMinerFemaleID = 581;
  int ShepherMaleID = 590;
  int ShepherFemaleID = 592;
  int VillagerMale2ID= 1810;
  int HerderMaleID = 1891;
  int HerderFemaleID = 1892;
  int OystererMaleID = 2333;
  int OystererFemaleID = 2334;

  xsEffectAmount(cAddAttribute, BuildingID, cCombatAbility, 32, playerId);
  xsTaskAmount(cTaskAttrWorkValue1, 0.1);
  xsTaskAmount(cTaskAttrWorkValue2, 1);
  xsTaskAmount(cTaskAttrWorkRange, 8);
  xsTaskAmount(cTaskAttrGatheringSoundInt32, 13402);
  xsTaskAmount(cTaskAttrDepositSoundInt32, 13402);
  xsTaskAmount(cTaskAttrOwnerType, 1);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 5);
  xsTaskAmount(cTaskAttrSearchWaitTime, 13);

  xsTask(BuildingID, cTaskTypeAura, VillagerMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, VillagerFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, FishermanMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, FishermanFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, BuilderMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, ForagerMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, HunterMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, LumberjackMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, StoneMinerMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, RepairerMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, BuilderFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, HunterFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, LumberjackFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, StoneMinerFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, RepairerFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, ForagerFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, GoldMinerMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, GoldMinerFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, ShepherMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, ShepherFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, VillagerMale2ID, playerId);
  xsTask(BuildingID, cTaskTypeAura, HerderMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, HerderFemaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, OystererMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, OystererFemaleID, playerId);

  xsTask(BuildingID, cTaskTypeAura, cFarmClass, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, 0.18);
  xsTask(BuildingID, cTaskTypeAura, FarmerMaleID, playerId);
  xsTask(BuildingID, cTaskTypeAura, FarmerFemaleID, playerId);
}

// 9 - Apply Fortified Church Bonus for Georgians
void EffectFunction9(int playerId = -1)
{
  int Monastery1ID = 104;
  int Monastery2ID = 30;
  int Monastery3ID = 31;
  int Monastery4ID = 32;
  int FortifiedChurchID = 1806;
  xsResetTaskAmount();

  ChurchAura(Monastery1ID, playerId);
  ChurchAura(Monastery2ID, playerId);
  ChurchAura(Monastery3ID, playerId);
  ChurchAura(Monastery4ID, playerId);
  ChurchAura(FortifiedChurchID, playerId);

  xsResetTaskAmount();
}

// 10 - Effect of Red Cliff Tactics for Wu
void EffectFunction10(int playerId = -1)
{
  int DemoShipID = 527;
  int HeavyDemoShipID = 528;
  int DemoRaftID = 1104;
  xsResetTaskAmount();

  xsEffectAmount(cAddAttribute, DemoShipID, cCombatAbility, 128, playerId);
  xsEffectAmount(cAddAttribute, HeavyDemoShipID, cCombatAbility, 128, playerId);
  xsEffectAmount(cAddAttribute, DemoRaftID, cCombatAbility, 128, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, -300);
  xsTaskAmount(cTaskAttrWorkValue2, 5);
  xsTaskAmount(cTaskAttrWorkRange, 5);
  xsTaskAmount(cTaskAttrSearchWaitTime, 109);
  xsTask(DemoShipID, cTaskTypeStinger, cBuildingClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cWallClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cGateClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cFarmClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cTowerClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cBuildingClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cWallClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cGateClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cFarmClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cTowerClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cBuildingClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cWallClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cGateClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cFarmClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cTowerClass, playerId);

  xsTaskAmount(cTaskAttrProceedingGraphic, 13066);
  xsTask(DemoShipID, cTaskTypeStinger, cTradeBoatClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cTransportShipClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cFishingBoatClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cWarshipClass, playerId);
  xsTask(DemoShipID, cTaskTypeStinger, cBoardingShipClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cTradeBoatClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cTransportShipClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cFishingBoatClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cWarshipClass, playerId);
  xsTask(HeavyDemoShipID, cTaskTypeStinger, cBoardingShipClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cTradeBoatClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cTransportShipClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cFishingBoatClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cWarshipClass, playerId);
  xsTask(DemoRaftID, cTaskTypeStinger, cBoardingShipClass, playerId);

  xsResetTaskAmount();
}

// 11 - Effect of Shepherd/Herder bonus for Khitans
void EffectFunction11(int playerId = -1)
{
  int ShepherMaleID = 590;
  int ShepherFemaleID = 592;
  int HerderMaleID = 1891;
  int HerderFemaleID = 1892;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeShepherdingFoodProductivity);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
  xsTaskAmount(cTaskAttrSearchWaitTime, 3);
  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);

  xsTask(ShepherMaleID, cTaskTypeGenerateResources, cLivestockClass, playerId);
  xsTask(ShepherFemaleID, cTaskTypeGenerateResources, cLivestockClass, playerId);

  xsTaskAmount(cTaskAttrProductivityResource, cAttributeHerdingFoodProductivity);
  xsTask(HerderMaleID, cTaskTypeGenerateResources, cFarmClass, playerId);
  xsTask(HerderFemaleID, cTaskTypeGenerateResources, cFarmClass, playerId);

  xsResetTaskAmount();
}

// 12 - Effect of Forager bonus for Portuguese
void EffectFunction12(int playerId = -1)
{
  int ForagerMaleID = 120;
  int ForagerFemaleID = 354;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeForagingWoodProductivity);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeWood);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
  xsTaskAmount(cTaskAttrSearchWaitTime, 3);
  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);

  xsTask(ForagerMaleID, cTaskTypeGenerateResources, cForageBushClass, playerId);
  xsTask(ForagerFemaleID, cTaskTypeGenerateResources, cForageBushClass, playerId);

  xsResetTaskAmount();
}

// 13 - Effect of Stone Miner bonus for Poles
void EffectFunction13(int playerId = -1)
{
  int StoneMinerMaleID = 124;
  int StoneMinerFemaleID = 220;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeStoneGoldMiningProductivity);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
  xsTaskAmount(cTaskAttrSearchWaitTime, 3);
  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);

  xsTask(StoneMinerMaleID, cTaskTypeGenerateResources, cStoneMineClass, playerId);
  xsTask(StoneMinerFemaleID, cTaskTypeGenerateResources, cStoneMineClass, playerId);

  xsResetTaskAmount();
}

// 14 - Effect of Burgundian Vineyards for Burgundians
void EffectFunction14(int playerId = -1)
{
  int FarmerMaleID = 214;
  int FarmerFemaleID = 259;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeGoldFarmingProductivity);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
  xsTaskAmount(cTaskAttrSearchWaitTime, 3);
  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);

  xsTask(FarmerMaleID, cTaskTypeGenerateResources, cFarmClass, playerId);
  xsTask(FarmerFemaleID, cTaskTypeGenerateResources, cFarmClass, playerId);

  xsResetTaskAmount();
}

// 15 - Effect of Paper Money for Vietnamese
void EffectFunction15(int playerId = -1)
{
  int LumberjackMaleID = 123;
  int LumberjackFemaleID = 218;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeChoppingGoldProductivity);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
  xsTaskAmount(cTaskAttrSearchWaitTime, 3);
  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);

  xsTask(LumberjackMaleID, cTaskTypeGenerateResources, cTreeClass, playerId);
  xsTask(LumberjackFemaleID, cTaskTypeGenerateResources, cTreeClass, playerId);

  xsResetTaskAmount();
}

// 16 - Effect of Lumberjack Bonus for Shu/Athenians
void EffectFunction16(int playerId = -1)
{
  int LumberjackMaleID = 123;
  int LumberjackFemaleID = 218;
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.01);
  xsTaskAmount(cTaskAttrProductivityResource, cAttributeChoppingFoodProductivity);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
  xsTaskAmount(cTaskAttrSearchWaitTime, 3);
  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);

  xsTask(LumberjackMaleID, cTaskTypeGenerateResources, cTreeClass, playerId);
  xsTask(LumberjackFemaleID, cTaskTypeGenerateResources, cTreeClass, playerId);

  xsResetTaskAmount();
}

void OdomantianRaiderHighValueTargets(int taskObject = -1, int playerId = -1)
{
  xsTask(taskObject, cTaskTypeLoot, cTradeBoatClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cVillagerClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cTradeCartClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cMonkWithRelicClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cMonkClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cMonkWithRelicClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cKingClass, playerId);
}

void OdomantianRaiderLowValueTargets(int taskObject = -1, int playerId = -1)
{
  xsTask(taskObject, cTaskTypeLoot, cArcherClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cInfantryClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cCavalryClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cSiegeWeaponClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cArcherClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cTransportShipClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cWarshipClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cConquistadorClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cPetardClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cCavalryArcherClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cHandCannoneerClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cScoutCavalryClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cPackedUnitClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cUnpackedSiegeUnitClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cScorpionClass, playerId);
}

// 1000 - Effect of Odomantian Raiders for Thracians
void EffectFunction1000(int playerId = -1)
{
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 5);
  xsTaskAmount(cTaskAttrProductivityResource, 510);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);

  OdomantianRaiderHighValueTargets(cInfantryClass, playerId);
  OdomantianRaiderHighValueTargets(cCavalryClass, playerId);
  
  xsTaskAmount(cTaskAttrWorkValue1, 3);

  OdomantianRaiderLowValueTargets(cInfantryClass, playerId);
  OdomantianRaiderLowValueTargets(cCavalryClass, playerId);

  xsResetTaskAmount();
}

void AthenianMilitaryPolicy(int taskObject = -1, int playerId = -1)
{
  xsTask(taskObject, cTaskTypeLoot, cTradeBoatClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cVillagerClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cTradeCartClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cMonkWithRelicClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cMonkClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cMonkWithRelicClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cKingClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cArcherClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cInfantryClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cCavalryClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cSiegeWeaponClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cArcherClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cTransportShipClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cWarshipClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cConquistadorClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cPetardClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cCavalryArcherClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cHandCannoneerClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cScoutCavalryClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cPackedUnitClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cUnpackedSiegeUnitClass, playerId);
  xsTask(taskObject, cTaskTypeLoot, cScorpionClass, playerId);
}

// 1001 - Effect of Military Policy for Athenians
void EffectFunction1001(int playerId = -1)
{
  int MonoremeID = 2127;
  int BiremeID = 2128;
  int TriremeID = 2129;

  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 3);
  xsTaskAmount(cTaskAttrProductivityResource, 551);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);

  AthenianMilitaryPolicy(cInfantryClass, playerId);
  AthenianMilitaryPolicy(cCavalryClass, playerId);
  AthenianMilitaryPolicy(cScoutCavalryClass, playerId);
  AthenianMilitaryPolicy(MonoremeID, playerId);
  AthenianMilitaryPolicy(BiremeID, playerId);
  AthenianMilitaryPolicy(TriremeID, playerId);

  xsResetTaskAmount();
}

void ApplyPuruRegenAbility(int targetObject = -1, int playerId = -1)
{
  xsEffectAmount(cAddAttribute, targetObject, cCombatAbility, 96, playerId);
  xsEffectAmount(cAddAttribute, targetObject, cRegenerationRate, 25, playerId);

  xsTaskAmount(cTaskAttrAutoSearch, 0);

  xsTask(targetObject, cTaskTypeAura, cTradeBoatClass, playerId);

  xsTaskAmount(cTaskAttrAutoSearch, 1);

  xsTask(targetObject, cTaskTypeAura, cVillagerClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cTradeCartClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cMonkWithRelicClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cMonkClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cMonkWithRelicClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cKingClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cArcherClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cInfantryClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cCavalryClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cSiegeWeaponClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cArcherClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cTransportShipClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cWarshipClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cConquistadorClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cPetardClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cCavalryArcherClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cHandCannoneerClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cScoutCavalryClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cPackedUnitClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cUnpackedSiegeUnitClass, playerId);
  xsTask(targetObject, cTaskTypeAura, cScorpionClass, playerId);
}

// 1002 - Apply regeneration with no enemies nearby for Puru
void EffectFunction1002(int playerId = -1)
{
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, -25);
  xsTaskAmount(cTaskAttrWorkValue2, 1);
  xsTaskAmount(cTaskAttrWorkRange, 10);
  xsTaskAmount(cTaskAttrOwnerType, 1);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 130);
  xsTaskAmount(cTaskAttrSearchWaitTime, 109);
  xsTaskAmount(cTaskAttrOwnerType, 5);

  xsTask(cCavalryClass, cTaskTypeAura, cTradeBoatClass, playerId);

  xsTaskAmount(cTaskAttrAutoSearch, 1);

  ApplyPuruRegenAbility(cCavalryClass, playerId);
  ApplyPuruRegenAbility(cScoutCavalryClass, playerId);

  xsResetTaskAmount();
}

// 1003 - Effect of Dii Plunderers for Thracians
void EffectFunction1003(int playerId = -1)
{
  int MilitiaID = 74;
  int ManAtArmsID = 75;
  int LongSwordsmanID = 77;
  int ChampionID = 567;
  int SpearmanID = 93;
  int PikemanID = 358;
  int HalberdierID = 359;
  int HopliteID = 2110;
  int EliteHopliteID = 2111;
  int RhomphaiaWarriorID = 2386;
  int EliteRhomphaiaWarriorID = 2387;
  
  xsResetTaskAmount();

  xsTaskAmount(cTaskAttrWorkValue1, 0.15);
  xsTaskAmount(cTaskAttrProductivityResource, 511);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeWood);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 1);
  xsTaskAmount(cTaskAttrSearchWaitTime, 3);
  xsTaskAmount(cTaskAttrAutoSearch, 1);
  xsTaskAmount(cTaskAttrEnableTargeting, 1);
  xsTaskAmount(cTaskAttrOwnerType, 5);
  xsTaskAmount(cTaskAttrGatherType, 1);
  
  xsTask(SpearmanID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(PikemanID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(HalberdierID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  
  xsTaskAmount(cTaskAttrResourceOut, cAttributeFood);
  
  xsTask(MilitiaID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(ManAtArmsID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(LongSwordsmanID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(ChampionID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(HopliteID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(EliteHopliteID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  
  xsTaskAmount(cTaskAttrWorkValue1, 0.1);
  xsTaskAmount(cTaskAttrResourceOut, cAttributeGold);
  
  xsTask(RhomphaiaWarriorID, cTaskTypeGenerateResources, cBuildingClass, playerId);
  xsTask(EliteRhomphaiaWarriorID, cTaskTypeGenerateResources, cBuildingClass, playerId);

  xsResetTaskAmount();
}

// 1004 - Apply Thracians Tower Workrate Bonus
void EffectFunction1004(int playerId = -1)
{
  int LumberjackMaleID = 123;
  int StoneMinerMaleID = 124;
  int LumberjackFemaleID = 218;
  int StoneMinerFemaleID = 220;
  int GoldMinerMaleID = 579;
  int GoldMinerFemaleID = 581;

  xsResetTaskAmount();

  xsEffectAmount(cAddAttribute, cTowerClass, cCombatAbility, 32, playerId);

  xsTaskAmount(cTaskAttrWorkValue1, 0.15);
  xsTaskAmount(cTaskAttrWorkValue2, 1);
  xsTaskAmount(cTaskAttrWorkRange, 8);
  xsTaskAmount(cTaskAttrOwnerType, 1);
  xsTaskAmount(cTaskAttrCombatLevelFlag, 5);
  xsTaskAmount(cTaskAttrSearchWaitTime, 13);

  xsTask(cTowerClass, cTaskTypeAura, LumberjackMaleID, playerId);
  xsTask(cTowerClass, cTaskTypeAura, StoneMinerMaleID, playerId);
  xsTask(cTowerClass, cTaskTypeAura, LumberjackFemaleID, playerId);
  xsTask(cTowerClass, cTaskTypeAura, StoneMinerFemaleID, playerId);
  xsTask(cTowerClass, cTaskTypeAura, GoldMinerMaleID, playerId);
  xsTask(cTowerClass, cTaskTypeAura, GoldMinerFemaleID, playerId);
  
  xsResetTaskAmount();
}


include "custom-constants.xs";
include "custom-effects.xs";