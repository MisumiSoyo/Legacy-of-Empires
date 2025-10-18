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
extern const int cAttributeMagyarsSteppeLancerAttackBonus = 412;    //  马扎尔圣物加成的攻击力
extern const int cAttributeVikingRaiderKills = 413; //  维京掠夺者击杀数
extern const int cAttributeApostleProductivity = 414;   //  使徒黄金产出速率
extern const int cAttributePolesFoodObtained = 415; //  维利奇卡盐矿已经奖励的食物数


//  单位ID定义
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


extern const int HospitallerKnightMaxCharge = 300; //   医院骑士技能充能
extern const float ShrineMaxCharge = 1200.0;    //  圣坛最大充能


//  全局数组
extern int HospitallerKnightAbilityTime = 0;    //医院骑士技能计时
extern int KilledUnits = 0; //  已被击杀的单位
extern int AztecsKillCount = 0; //  阿兹特克独特科技的击杀数统计
extern int FrankLoan = 0;  //  法兰克借贷每分钟返还的黄金数
extern int FrankLoanTime = 0;   //  法兰克借贷剩余时长
extern int RaideHornTime = 0;   //  掠夺号角剩余时长
extern int FloatingGardenTime = 0;  //  浮动园地剩余时长
extern int YumKaaxBlessingTime = 0; //  玉米神祝福剩余时长
extern int MercenaryContractNum = 0;   //  意大利雇佣兵合同招募数
extern int ShrineSpawnCount = 0;    //  圣坛生产次数


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
    xsTaskAmount(cTaskAttrProductivityResource, 397);
    xsTaskAmount(cTaskAttrResourceOut, 3);
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


// Ethiopians Civ Bonus Adder
void EthiopiansCivBonus(int ClassTarget = -1, int playerId = -1)
{
    xsTaskAmount(cTaskAttrWorkValue1, -1);
    xsTaskAmount(cTaskAttrWorkValue2, 3);
    xsTaskAmount(cTaskAttrWorkRange, 1);
    xsTaskAmount(cTaskAttrSearchWaitTime, 116);
    xsTaskAmount(cTaskAttrCombatLevelFlag, 2);

    xsTask(ClassTarget, cTaskTypeStinger, -1, playerId);
    xsRemoveTask(ClassTarget, cTaskTypeStinger, cBuildingClass, playerId);
    xsRemoveTask(ClassTarget, cTaskTypeStinger, cGateClass, playerId);
    xsRemoveTask(ClassTarget, cTaskTypeStinger, cFarmClass, playerId);
    xsRemoveTask(ClassTarget, cTaskTypeStinger, cTowerClass, playerId);
    xsRemoveTask(ClassTarget, cTaskTypeStinger, cWallClass, playerId);
}


// 10014 - Ethiopians Civ Bonus Applier
void EffectFunction10014(int playerId = -1)
{
    int SpearmanId = 93;
    int PikemanId = 358;
    int HalberdierId = 359;
    int ShotelWarriorId = 1016;
    int EliteShotelWarriorId = 1018;

    xsResetTaskAmount();
    EthiopiansCivBonus(SpearmanId, playerId);
    EthiopiansCivBonus(PikemanId, playerId);
    EthiopiansCivBonus(HalberdierId, playerId);
    EthiopiansCivBonus(ShotelWarriorId, playerId);
    EthiopiansCivBonus(EliteShotelWarriorId, playerId);
    xsResetTaskAmount();
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
    //检测, 由于定时器有时间间隔, 防止延迟导致重复施放技能
    if (xsPlayerAttribute(playerId, cAttributeHospitallerKnightCharge) == 0.0)
        return;

    //技能条不满，无法施放
    if (xsPlayerAttribute(playerId, cAttributeHospitallerKnightCharge) < HospitallerKnightMaxCharge - 1)
        return;
    //清空技能条
    xsEffectAmount(cModResource, cAttributeHospitallerKnightCharge, 0, 0.0, playerId);
    int HospitallerKnightArray = NewArrayInt();
    HospitallerKnightArray = xsGetPlayerUnitIds(playerId, HospitallerKnightID, HospitallerKnightArray);
    int i = 0;
    for (i = 0; < xsArrayGetSize(HospitallerKnightArray))
        xsSetUnitCharge(xsArrayGetInt(HospitallerKnightArray, i), 0.0);
    RecycleArrayInt(HospitallerKnightArray);

    int EliteHospitallerKnightArray = NewArrayInt();
    EliteHospitallerKnightArray = xsGetPlayerUnitIds(playerId, EliteHospitallerKnightID, EliteHospitallerKnightArray);
    for (i = 0; < xsArrayGetSize(EliteHospitallerKnightArray))
        xsSetUnitCharge(xsArrayGetInt(EliteHospitallerKnightArray, i), 0.0);
    RecycleArrayInt(EliteHospitallerKnightArray);

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
    int playerUnits = PlayerAllUnits(playerId, true);

    int i = 0;
    for (i = 0; < xsArrayGetSize(playerUnits))
    {
        int UnitID = xsArrayGetInt(playerUnits, i);
        int TargetUnitID = xsGetUnitTargetUnitId(UnitID);
        if (xsDoesUnitExist(TargetUnitID) && (xsGetUnitHitpoints(TargetUnitID) > 0))    //  目标存活
            continue;
        if (ArrayFindInt(KilledUnits, TargetUnitID) != -1)
            continue;
        int KillerPlayer = playerId;
        
        int TargetPlayer = xsGetUnitOwner(TargetUnitID);
        KillEffect(KillerPlayer, UnitID, TargetPlayer, TargetUnitID);
        ArrayAppendInt(KilledUnits, TargetUnitID);
        break;
    }
    RecycleArrayInt(playerUnits);
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
    xsArraySetInt(FrankLoanTime, playerId, 239);
    xsArraySetInt(FrankLoan, playerId, 187.5);
}


//  10028 - 法兰克放贷 (1000黄金)
void EffectFunction10028(int playerId = -1)
{
    xsArraySetInt(FrankLoanTime, playerId, 359);
    xsArraySetInt(FrankLoan, playerId, 300);
}


//  10029 - 法兰克放贷 (2000黄金)
void EffectFunction10029(int playerId = -1)
{
    xsArraySetInt(FrankLoanTime, playerId, 479);
    xsArraySetInt(FrankLoan, playerId, 500);
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
    xsArraySetInt(RaideHornTime, playerId, 179);
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
    xsArraySetInt(FloatingGardenTime, playerId, 179);
}


//  10039 - 玉米神祝福
void EffectFunction10039(int playerId = -1)
{
    MulAttribute(playerId, 214, cWorkRate, 1000);
    MulAttribute(playerId, 214, cCarryCapacity, 100);
    MulAttribute(playerId, 259, cWorkRate, 1000);
    MulAttribute(playerId, 259, cCarryCapacity, 100);
    MulAttribute(playerId, 50, cWorkRate, 10000);
    xsArraySetInt(YumKaaxBlessingTime, playerId, 8);
}


//  10040 - 意大利佣兵合同
void EffectFunction10040(int playerId = -1)
{
    xsArraySetInt(MercenaryContractNum, playerId, 5);
    SpawnUnit(playerId, 4050, 209, 1);
    SetResource(playerId, cAttributeMaintenance, 1042);
}


//  10041 - 意大利高级佣兵合同
void EffectFunction10041(int playerId = -1)
{
    xsArraySetInt(MercenaryContractNum, playerId, 10);
}


//  10042 - 意大利佣兵合同生成单位
void EffectFunction10042(int playerId = -1)
{
    SpawnUnit(playerId, 882, 109, xsArrayGetInt(MercenaryContractNum, playerId));
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
    ModResource(playerId, cAttributeFood, 0.75 * StoneTotal);
    SetResource(playerId, cAttributePolesFoodObtained, 0.75 * StoneTotal);
}


//  法兰克, 计算借贷返利
void Franks(int Time = 0, int playerId = -1)
{
    if (xsArrayGetInt(FrankLoanTime, playerId) >= 0)
    {
        if (xsArrayGetInt(FrankLoanTime, playerId) % 60 == 0)
            xsEffectAmount(cModResource, cAttributeGold, 1, xsArrayGetInt(FrankLoan, playerId), playerId);
        xsArraySetInt(FrankLoanTime, playerId, xsArrayGetInt(FrankLoanTime, playerId) - 1);
        if (xsArrayGetInt(FrankLoanTime, playerId) < 0)
            xsEffectAmount(cModResource, cAttributeLoanLimit, 1, 1, playerId);
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
    for (i = 0; <xsArrayGetSize(BuildingArray))
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


//  阿兹特克独特科技, 浮动园地
void Aztecs(int Time = 0, int playerId = -1)
{
    if (xsArrayGetInt(FloatingGardenTime, playerId) < 0)
        return;
    ArrayIncInt(FloatingGardenTime, playerId, -1);
    if (xsArrayGetInt(FloatingGardenTime, playerId) == -1)
    {
        MulAttribute(playerId, cTradeBoatClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cBuildingClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cVillagerClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cTradeCartClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cFishingBoatClass, cWorkRate, 1.0 / 1.2);
        MulAttribute(playerId, cFarmClass, cWorkRate, 1.0 / 1.2);
    }
}


//  玛雅独特科技, 玉米神祝福
void Mayans(int Time = 0, int playerId = -1)
{
    if (xsArrayGetInt(YumKaaxBlessingTime, playerId) < 0)
        return;
    ArrayIncInt(YumKaaxBlessingTime, playerId, -1);
    if (xsArrayGetInt(YumKaaxBlessingTime, playerId) == -1)
    {
        MulAttribute(playerId, 214, cWorkRate, 1.0 / 1000);
        MulAttribute(playerId, 214, cCarryCapacity, 1.0 / 100);
        MulAttribute(playerId, 259, cWorkRate, 1.0 / 1000);
        MulAttribute(playerId, 259, cCarryCapacity, 1.0 / 100);
        MulAttribute(playerId, 50, cWorkRate, 1.0 / 10000);
    }
}


//  马扎尔文明加成, 圣物加成草原枪兵攻击力
void Magyars(int Time = 0, int playerId = -1)
{
    int SteppeLancerID = 1370;
    int EliteSteppeLancerID = 1372;
    int AttackBonus = xsPlayerAttribute(playerId, cAttributeMagyarsSteppeLancerAttackBonus);
    //草原枪兵攻击加成
    int RelicCaptured = xsPlayerAttribute(playerId, cAttributeRelics);
    int CurrentAttackBonus = minInt(RelicCaptured / 2, 2);

    xsEffectAmount(cAddAttribute, SteppeLancerID, cAttack, -4*256-AttackBonus, playerId);
    xsEffectAmount(cAddAttribute, EliteSteppeLancerID, cAttack, -4*256-AttackBonus, playerId);
    xsEffectAmount(cAddAttribute, SteppeLancerID, cAttack, 4*256+CurrentAttackBonus, playerId);
    xsEffectAmount(cAddAttribute, EliteSteppeLancerID, cAttack, 4*256+CurrentAttackBonus, playerId);
    SetResource(playerId, cAttributeMagyarsSteppeLancerAttackBonus, CurrentAttackBonus);
}


//  鞑靼独特科技, 掠夺号角
void Tatars(int Time = 0, int playerId = -1)
{
    if (xsArrayGetInt(RaideHornTime, playerId) < 0)
        return;
    ArrayIncInt(RaideHornTime, playerId, -1);
    if (xsArrayGetInt(RaideHornTime, playerId) == -1)
    {
        ModAttack(playerId, cCavalryClass, 4, -1);
        ModAttack(playerId, cScoutCavalryClass, 4, -1);
        ModArmor(playerId, cCavalryClass, 3, -1);
        ModArmor(playerId, cScoutCavalryClass, 3, -1);
        ModAttack(playerId, cCavalryClass, 21, -4);
        ModAttack(playerId, cScoutCavalryClass, 21, -4);
        MulResource(playerId, 213, 0.25);
    }
}


//  波兰独特科技, 维利奇卡盐矿
void Poles(int Time = -1, int playerId = -1)
{
    if (isResearched(playerId, 3133) == false)
        return;
    float FoodObtained = xsPlayerAttribute(playerId, cAttributePolesFoodObtained);
    float CurrentFoodBonus = xsPlayerAttribute(playerId, cAttributeStoneTotal) * 0.75;
    ModResource(playerId, cAttributeFood, CurrentFoodBonus - FoodObtained);
    SetResource(playerId, cAttributePolesFoodObtained, CurrentFoodBonus);
}


//  初始化
void Init()
{
    AztecsKillCount = NewArrayInt(9, 0);
    HospitallerKnightAbilityTime = NewArrayInt(xsGetNumPlayers() + 1, 0);
    FrankLoan = NewArrayInt(xsGetNumPlayers() + 1, 0);
    FrankLoanTime = NewArrayInt(xsGetNumPlayers() + 1, -1);
    RaideHornTime = NewArrayInt(xsGetNumPlayers() + 1, -1);
    FloatingGardenTime = NewArrayInt(xsGetNumPlayers() + 1, -1);
    YumKaaxBlessingTime = NewArrayInt(xsGetNumPlayers() + 1, -1);
    MercenaryContractNum = NewArrayInt(xsGetNumPlayers() + 1, 0);
    ShrineSpawnCount = NewArrayInt(xsGetNumPlayers() + 1, 0);
}


// Timer Event 定时器事件
void TimerEvent(int Time = 0, int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cFranks:
            Franks(Time, playerId);
        case cPersians:
            Persians(Time, playerId);
        case cAztecs:
            Aztecs(Time, playerId);
        case cMayans:
            Mayans(Time, playerId);
        case cMagyars:
            Magyars(Time, playerId);
        case cTatars:
            Tatars(Time, playerId);
        case cPoles:
            Poles(Time, playerId);
        default:
        {
            break;
        }
    }

    HospitallerKnight(Time, playerId);
    Shrine(Time, playerId);
    SetAttribute(playerId, 4050, cRegenerationHpPercent, -0.5);
}


void Test(int Time = 0)
{
    int UnitIDs = 0;
    int i = 0;
    int j = 0;
    int TempArray = 0;
    for (i = 0; <= xsGetNumPlayers())
    {
        UnitIDs = PlayerAllUnits(i, true, -1, true);
        for (j = 0; < xsArrayGetSize(UnitIDs))
        {
            TempArray = NewArrayInt();
            int UnitID = xsArrayGetInt(UnitIDs, j);
            int AttrsHeld = xsGetUnitAttributeTypesHeld(UnitID);
            bool flag = false;
            for (k = 0; < xsArrayGetSize(AttrsHeld))
            {
                int temp = xsGetUnitAttributeHeld(UnitID, xsArrayGetInt(AttrsHeld, k));
                if (temp >= 1)
                    flag = true;
                ArrayAppendInt(TempArray, temp);
            }
            if (flag)
                xsChatData("Time = " + Time + " UnitID = " + UnitID + " " + xsGetUnitName(UnitID) + " AttrHeld: " + ArrayToStringInt(AttrsHeld) + ", " + ArrayToStringInt(TempArray));
            RecycleArrayInt(TempArray);
            RecycleArrayInt(AttrsHeld);
        }
    }
}


// 定时器
rule Timer
    active
    highFrequency
{
    static int LastUpdateTime = -1;
    int CurrentTime = xsGetGameTime();

    while (LastUpdateTime < CurrentTime)
    {
        LastUpdateTime = LastUpdateTime +1;
        if (LastUpdateTime == 0)
        {
            ArrayRecycleInit();
            Init();
            AbilityApplier();
        }
        int i = 0;
        for (i = 0; <= xsGetNumPlayers())
            TimerEvent(LastUpdateTime, i);
        //Test(LastUpdateTime);
    }
}
