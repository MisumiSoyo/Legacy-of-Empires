include "ability.xs";


// 10001 - Tech Tree Adjustment (takes effect from dark age)
void EffectFunction10001(int playerId = -1)
{
    AbilityApplier(playerId);
    int playerCiv = xsGetPlayerCivilization(playerId);

    //  Some civs' Tithe descriptions adjustment
    if ((playerCiv == cChinese) || (playerCiv == cJapanese) || (playerCiv == cKoreans) || (playerCiv == cVietnamese) || (playerCiv == cBurmese)
        || (playerCiv == cKhitans) || (playerCiv == cJurchens))
    {
        xsEffectAmount(cModifyTech, TitheTechID, cAttrSetName, 500078, playerId);
        xsEffectAmount(cModifyTech, TitheTechID, cAttrSetDescription, 521078, playerId);
    }

    //  Pasture
    if ((playerCiv == cMongols) || (playerCiv == cHuns) || (playerCiv == cMagyars) || (playerCiv == cCumans) || (playerCiv == cTatars) || (playerCiv == cKhitans))
    {
        DisableTech(playerId, FarmTechID);
        DisableTech(playerId, HorseCollarTechID);
        DisableTech(playerId, HeavyPlowTechID);
        DisableTech(playerId, CropRotationTechID);
    }
    else
    {
        DisableTech(playerId, PastureTechID);
        DisableTech(playerId, DomesticationTechID);
        DisableTech(playerId, PastoralismTechID);
        DisableTech(playerId, TranshumanceTechID);
    }

    //  Shrine
    if ((playerCiv != cAztecs) && (playerCiv != cMayans) && (playerCiv != cIncas) && (playerCiv != cMuisca) && (playerCiv != cMapuche) && (playerCiv != cTupi))
    {
        DisableTech(playerId, ShrineTechID);
    }

    switch (playerCiv)
    {
        case cFranks:
        {
            EnableTech(playerId, BracerTechID);
            break;
        }
        case cGoths:
        {
            EnableTech(playerId, PlateBardingArmorTechID);
            EnableTech(playerId, GoldShaftMiningTechID);
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, ArsonTechID);
            DisableTech(playerId, WatchTowerTechID);
            DisableTech(playerId, HandCannoneerTechID);
            DisableTech(playerId, BombardCannonTechID);
            break;
        }
        case cTeutons:
        {
            EnableTech(playerId, LightCavalryTechID);
            EnableTech(playerId, ArbalesterTechID);
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, GoldShaftMiningTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, TreadmillCraneTechID);
            break;
        }
        case cJapanese:
        {
            EnableTech(playerId, BombardCannonTechID);
            DisableTech(playerId, SkirmisherTechID);
            DisableTech(playerId, EliteSkirmisherTechID);
            break;
        }
        case cChinese:
        {
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, CannonGalleonTechID);
            EnableTech(playerId, EliteCannonGalleonTechID);
            EnableTech(playerId, HandCannoneerTechID);
            EnableTech(playerId, BombardCannonTechID);
            EnableTech(playerId, HussarTechID);
            EnableTech(playerId, ParthianTacticsTechID);
            EnableTech(playerId, GambesonsTechID);
            EnableTech(playerId, HeiKuangCavalryTechID);
            EnableTech(playerId, HeavyHeiKuangCavalryTechID);
            EnableTech(playerId, TreadmillCraneTechID);
            SetResource(playerId, cAttributeResearchCostMod, 0.95);
            DisableTech(playerId, KnightTechID);
            DisableTech(playerId, CavalierTechID);
            DisableTech(playerId, 350);
            DisableTech(playerId, 351);
            DisableTech(playerId, 352);
            break;
        }
        case cByzantines:
        {
            EnableTech(playerId, MasonryTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, BlastFurnaceTechID);
            EnableTech(playerId, HerbalMedicineTechID);
            break;
        }
        case cPersians:
        {
            EnableTech(playerId, ArbalesterTechID);
            EnableTech(playerId, BracerTechID);
            EnableTech(playerId, SiegeEngineersTechID);
            break;
        }
        case cSaracens:
        {
            break;
        }
        case cTurks:
        {
            EnableTech(playerId, SteppeLancerTechID);
            EnableTech(playerId, EliteSteppeLancerTechID);
            break;
        }
        case cVikings:
        {
            DisableTech(playerId, WatchTowerTechID);
            break;
        }
        case cMongols:
        {
            break;
        }
        case cCelts:
        {
            EnableTech(playerId, BracerTechID);
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, ArbalesterTechID);
            break;
        }
        case cSpanish:
        {
            break;
        }
        case cAztecs:
        {
            EnableTech(playerId, RingArcherArmorTechID);
            DisableTech(playerId, GoldShaftMiningTechID);
            DisableTech(playerId, StoneShaftMiningTechID);
            DisableTech(playerId, 3105);
            break;
        }
        case cMayans:
        {
            DisableTech(playerId, StoneShaftMiningTechID);
            DisableTech(playerId, CropRotationTechID);
            DisableTech(playerId, 3105);
            break;
        }
        case cHuns:
        {
            EnableTech(playerId, SteppeLancerTechID);
            EnableTech(playerId, EliteSteppeLancerTechID);
            DisableTech(playerId, WatchTowerTechID);
            DisableTech(playerId, KnightTechID);
            DisableTech(playerId, CavalierTechID);
            DisableTech(playerId, PaladinTechID);
            break;
        }
        case cKoreans:
        {
            EnableTech(playerId, BlastFurnaceTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, HoardingsTechID);
            break;
        }
        case cItalians:
        {
            EnableTech(playerId, HalberdierTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, GoldShaftMiningTechID);
            EnableTech(playerId, BombardTowerTechID);
            EnableTech(playerId, SiegeEngineersTechID);
            break;
        }
        case cIncas:
        {
            DisableTech(playerId, GoldShaftMiningTechID);
            DisableTech(playerId, StoneShaftMiningTechID);
            break;
        }
        case cMagyars:
        {
            EnableTech(playerId, SteppeLancerTechID);
            EnableTech(playerId, EliteSteppeLancerTechID);
            EnableTech(playerId, HandCannoneerTechID);
            break;
        }
        case cSlavs:
        {
            EnableTech(playerId, HandCannoneerTechID);
            break;
        }
        case cPortuguese:
        {
            break;
        }
        case cEthiopians:
        {
            EnableTech(playerId, BattleElephantTechID);
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, PlateBardingArmorTechID);
            EnableTech(playerId, BombardTowerTechID);
            EnableTech(playerId, HoardingsTechID);
            break;
        }
        case cMalians:
        {
            EnableTech(playerId, BlastFurnaceTechID);
            EnableTech(playerId, HalberdierTechID);
            break;
        }
        case cBerbers:
        {
            EnableTech(playerId, HalberdierTechID);
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, SappersTechID);
            break;
        }
        case cKhmer:
        {
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, ElephantArcherTechID);
            EnableTech(playerId, EliteElephantArcherTechID);
            DisableTech(playerId, CavalryArcherTechID);
            DisableTech(playerId, HeavyCavalryArcherTechID);
            break;
        }
        case cMalay:
        {
            EnableTech(playerId, ElephantArcherTechID);
            EnableTech(playerId, EliteElephantArcherTechID);
            DisableTech(playerId, CavalryArcherTechID);
            break;
        }
        case cBurmese:
        {
            EnableTech(playerId, HandCannoneerTechID);
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, HoardingsTechID);
            EnableTech(playerId, ArrowslitsTechID);
            DisableTech(playerId, DryDockTechID);
            break;
        }
        case cVietnamese:
        {
            EnableTech(playerId, ElephantArcherTechID);
            EnableTech(playerId, EliteElephantArcherTechID);
            DisableTech(playerId, CavalryArcherTechID);
            DisableTech(playerId, HeavyCavalryArcherTechID);
            break;
        }
        case cBulgarians:
        {
            break;
        }
        case cTatars:
        {
            break;
        }
        case cCumans:
        {
            EnableTech(playerId, HusbandryTechID);
            DisableTech(playerId, 711);
            DisableTech(playerId, 727);
            DisableTech(playerId, 728);
            break;
        }
        case cLithuanians:
        {
            EnableTech(playerId, PlateMailArmorTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, GoldShaftMiningTechID);
            break;
        }
        case cBurgundians:
        {
            EnableTech(playerId, RingArcherArmorTechID);
            EnableTech(playerId, SiegeEngineersTechID);
            EnableTech(playerId, BloodlinesTechID);
            break;
        }
        case cSicilians:
        {
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, SappersTechID);
            break;
        }
        case cPoles:
        {
            EnableTech(playerId, HalberdierTechID);
            EnableTech(playerId, RingArcherArmorTechID);
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, GoldShaftMiningTechID);
            EnableTech(playerId, HandCannoneerTechID);
            break;
        }
        case cBohemians:
        {
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, HeatedShotTechID);
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, HoardingsTechID);
            break;
        }
        case cDravidians:
        {
            break;
        }
        case cBengalis:
        {
            EnableTech(playerId, HussarTechID);
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, StoneShaftMiningTechID);
            EnableTech(playerId, HoardingsTechID);
            EnableTech(playerId, SappersTechID);
            break;
        }
        case cGurjaras:
        {
            //  Gurjaras civ bonus, Monastries +10 population headroom
            ModAttribute(playerId, MonasteryID, cAmountFirstStorage, 10);
            ModAttribute(playerId, Monastery2ID, cAmountFirstStorage, 10);
            ModAttribute(playerId, Monastery3ID, cAmountFirstStorage, 10);
            ModAttribute(playerId, Monastery4ID, cAmountFirstStorage, 10);
            break;
        }
        case cRomans:
        {
            EnableTech(playerId, HussarTechID);
            EnableTech(playerId, BracerTechID);
            EnableTech(playerId, ArbalesterTechID);
            break;
        }
        case cArmenians:
        {
            break;
        }
        case cGeorgians:
        {
            EnableTech(playerId, RingArcherArmorTechID);
            //  Georgians civ bonus, Repairers +100% work rate
            MulAttribute(playerId, MaleRepairerID, cWorkRate, 2);
            MulAttribute(playerId, FemaleRepairerID, cWorkRate, 2);
            break;
        }
        case cShu:
        {

            //  Shu civ bonus, infantries generate food from attacking farms
            SetResource(playerId, cAttributeInfantryLootFarmFoodProductivity, 25);
            SetResource(playerId, cAttributeEffectFunctionNumber, 10010);
            break;
        }
        case cWu:
        {
            EnableTech(playerId, GambesonsTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, HoardingsTechID);
            EnableTech(playerId, ThumbRingTechID);
            EnableTech(playerId, RingArcherArmorTechID);
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, ArrowslitsTechID);
            EnableTech(playerId, FortifiedWallTechID);
            break;
        }
        case cWei:
        {
            break;
        }
        case cJurchens:
        {
            break;
        }
        case cKhitans:
        {
            EnableTech(playerId, GoldShaftMiningTechID);
            EnableTech(playerId, TreadmillCraneTechID);
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, HerbalMedicineTechID);
            break;
        }
        case cMuisca:
        {
            break;
        }
        case cMapuche:
        {
            break;
        }
        case cTupi:
        {
            break;
        }
        default:
            break;
    }
}


//  10002 - Tech Tree ID set
void EffectFunction10002(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);
    int TechTreeAdjustmentTechID = 3001;
    int TechTreeTechID = 3488;

    static int TechTreeEffectIDs = -1;
    if (TechTreeEffectIDs == -1)
    {
        TechTreeEffectIDs = xsArrayCreateInt(100, 348);
        ArrayMultipleSetInt(TechTreeEffectIDs, 1, 254, 258, 259, 262, 255, 257, 256, 260, 261, 263);
        ArrayMultipleSetInt(TechTreeEffectIDs, 11, 276, 277, 275, 446, 447, 449, 448, 504, 10, 1);
        ArrayMultipleSetInt(TechTreeEffectIDs, 21, 3, 5, 7, 31, 48, 42, 37, 646, 648, 650);
        ArrayMultipleSetInt(TechTreeEffectIDs, 31, 652, 706, 708, 710, 712, 782, 784, 801, 803, 838);
        ArrayMultipleSetInt(TechTreeEffectIDs, 41, 840, 842, 890, 925, 927, 1101, 1117, 1129, 1028, 1030);
        ArrayMultipleSetInt(TechTreeEffectIDs, 51, 1026, 986, 988, 1218, 1246, 1256, 1360, 1361, 1362);
    }
    SetTechEffectID(playerId, TechTreeTechID, xsArrayGetInt(TechTreeEffectIDs, playerCiv));
    ForceResearchTech(playerId, TechTreeTechID);
    ForceResearchTech(playerId, TechTreeAdjustmentTechID);
}


//  10024 - Feudal Age Effect
void EffectFunction10024(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);
    switch (playerCiv)
    {
        default:
            break;
    }
}


//  10025 - Castle Age effect
void EffectFunction10025(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cSlavs:
        {
            xsEffectAmount(cMulAttribute, SiegeWorkshopID, cWorkRate, 1.25, playerId);
            xsEffectAmount(cMulAttribute, SiegeWorkshop4ID, cWorkRate, 1.25, playerId);
            break;
        }
        default:
            break;
    }
}


//  10026 - Imperial Age effect
void EffectFunction10026(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cSlavs:
        {
            xsEffectAmount(cMulAttribute, SiegeWorkshopID, cWorkRate, 1.2, playerId);
            xsEffectAmount(cMulAttribute, SiegeWorkshop4ID, cWorkRate, 1.2, playerId);
            break;
        }
        default:
            break;
    }
}


//  Feudal Age start effect
void EffectFunction10061(int playerId = -1)
{
}


//  Castle Age start effect
void EffectFunction10062(int playerId = -1)
{
}


//  Imperial Age start effect
void EffectFunction10063(int playerId = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cMongols:
        {
            ForceResearchTech(playerId, CavalierTechID);
            break;
        }
        default:
            break;
    }
}


//  Post Imperial Age start effect
void EffectFunction10064(int playerId = -1)
{
}