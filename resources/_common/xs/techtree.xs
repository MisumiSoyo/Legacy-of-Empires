include "ability.xs";
include "tech-adjustment.xs";


// 10001 - Tech Tree Adjustment
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

    if ((playerCiv != cShu) && (playerCiv != cWu) && (playerCiv != cWei))
    {
        DisableTech(playerId, WubaoTechID);
        DisableTech(playerId, GentryTechID);
        DisableTech(playerId, MercenaryTechID);
        DisableTech(playerId, StrongFortressTechID);
    }

    switch (playerCiv)
    {
        case cBritons:
        {
            EnableTech(playerId, BombardCannonTechID);
            EnableTech(playerId, BombardTowerTechID);
            EnableTech(playerId, HeresyTechID);
            EnableTech(playerId, StoneShaftMiningTechID);
            break;
        }
        case cFranks:
        {
            EnableTech(playerId, BracerTechID);
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, ArbalesterTechID);
            EnableTech(playerId, HeatedShotTechID);
            EnableTech(playerId, BombardTowerTechID);
            EnableTech(playerId, GuildsTechID);
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, StoneShaftMiningTechID);
            EnableTech(playerId, TreadmillCraneTechID);
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
            EnableTech(playerId, GuildsTechID);
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
            EnableTech(playerId, HeiGuangCavalryTechID);
            EnableTech(playerId, HeavyHeiGuangCavalryTechID);
            EnableTech(playerId, TreadmillCraneTechID);
            EnableTech(playerId, CarvelHullTechID);
            EnableTech(playerId, ClinkerConstructionTechID);
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
            EnableTech(playerId, FortifiedWallTechID);
            EnableTech(playerId, KeepTechID);
            EnableTech(playerId, ArrowslitsTechID);
            EnableTech(playerId, BombardTowerTechID);
            break;
        }
        case cSaracens:
        {
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, BombardTowerTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, HeavyScorpionTechID);
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, HeatedShotTechID);
            break;
        }
        case cTurks:
        {
            EnableTech(playerId, SteppeLancerTechID);
            EnableTech(playerId, EliteSteppeLancerTechID);
            EnableTech(playerId, CropRotationTechID);
            break;
        }
        case cVikings:
        {
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, HalberdierTechID);
            DisableTech(playerId, WatchTowerTechID);
            DisableTech(playerId, ArrowslitsTechID);
            DisableTech(playerId, GambesonsTechID);
            DisableTech(playerId, ChampionTechID);
            DisableTech(playerId, CropRotationTechID);
            DisableTech(playerId, 416);
            break;
        }
        case cMongols:
        {
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, BombardCannonTechID);
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
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, CrossbowmanTechID);
            EnableTech(playerId, ArbalesterTechID);
            EnableTech(playerId, SiegeEngineersTechID);
            EnableTech(playerId, HeavyScorpionTechID);
            EnableTech(playerId, TreadmillCraneTechID);
            DisableTech(playerId, StoneShaftMiningTechID);
            break;
        }
        case cAztecs:
        {
            EnableTech(playerId, RingArcherArmorTechID);
            DisableTech(playerId, GoldShaftMiningTechID);
            DisableTech(playerId, StoneShaftMiningTechID);
            DisableTech(playerId, CropRotationTechID);
            DisableTech(playerId, WheelBarrowTechID);
            DisableTech(playerId, HandCartTechID);
            DisableTech(playerId, TreadmillCraneTechID);
            break;
        }
        case cMayans:
        {
            DisableTech(playerId, StoneShaftMiningTechID);
            DisableTech(playerId, CropRotationTechID);
            DisableTech(playerId, TreadmillCraneTechID);
            DisableTech(playerId, HeavyPlowTechID);
            DisableTech(playerId, WheelBarrowTechID);
            DisableTech(playerId, HandCartTechID);
            DisableTech(playerId, HorseCollarTechID);
            DisableTech(playerId, BankingTechID);
            DisableTech(playerId, CashCropTechID);
            DisableTech(playerId, ForestryTechID);
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
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, SiegeRamTechID);
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
            EnableTech(playerId, BombardCannonTechID);
            EnableTech(playerId, SquiresTechID);
            EnableTech(playerId, PlateMailArmorTechID);
            EnableTech(playerId, GuildsTechID);
            EnableTech(playerId, FortifiedWallTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, StoneShaftMiningTechID);
            EnableTech(playerId, FaithTechID);
            break;
        }
        case cSlavs:
        {
            EnableTech(playerId, HandCannoneerTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, BracerTechID);
            EnableTech(playerId, HeresyTechID);
            break;
        }
        case cPortuguese:
        {
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, IlluminationTechID);
            EnableTech(playerId, GoldShaftMiningTechID);
            EnableTech(playerId, ArrowslitsTechID);
            EnableTech(playerId, HoardingsTechID);
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
            EnableTech(playerId, BracerTechID);
            EnableTech(playerId, SiegeEngineersTechID);
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, SiegeRamTechID);
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, ArrowslitsTechID);
            break;
        }
        case cBerbers:
        {
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, SiegeRamTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, KeepTechID);
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
            EnableTech(playerId, ChampionTechID);
            EnableTech(playerId, TwoManSawTechID);
            DisableTech(playerId, CavalryArcherTechID);
            DisableTech(playerId, PlateMailArmorTechID);
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
            EnableTech(playerId, SiegeOnagerTechID);
            EnableTech(playerId, ShipwrightTechID);
            EnableTech(playerId, HandCannoneerTechID);
            EnableTech(playerId, MasonryTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, GoldShaftMiningTechID);
            EnableTech(playerId, BlastFurnaceTechID);
            DisableTech(playerId, CavalryArcherTechID);
            DisableTech(playerId, HeavyCavalryArcherTechID);
            break;
        }
        case cBulgarians:
        {
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, SappersTechID);
            EnableTech(playerId, HoardingsTechID);
            break;
        }
        case cTatars:
        {
            EnableTech(playerId, TwoManSawTechID);
            EnableTech(playerId, SiegeOnagerTechID);
            EnableTech(playerId, ArchitectureTechID);
            EnableTech(playerId, HoardingsTechID);
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
            EnableTech(playerId, BlastFurnaceTechID);
            EnableTech(playerId, GuildsTechID);
            EnableTech(playerId, TwoManSawTechID);
            break;
        }
        case cRomans:
        {
            EnableTech(playerId, HussarTechID);
            EnableTech(playerId, BracerTechID);
            EnableTech(playerId, ArbalesterTechID);
            EnableTech(playerId, ArsonTechID);
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
            EnableTech(playerId, CropRotationTechID);
            EnableTech(playerId, SappersTechID);
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
            DisableTech(playerId, CashCropTechID);
            break;
        }
        case cMuisca:
        {
            EnableTech(playerId, ArsonTechID);
            break;
        }
        case cMapuche:
        {
            DisableTech(playerId, WheelBarrowTechID);
            DisableTech(playerId, HandCartTechID);
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


//  10037 - C-Bonus, free techs
void EffectFunction10037(int playerId = -1)
{
    FreeTech(playerId, LoomTechID);
    FreeTech(playerId, WheelBarrowTechID);
    FreeTech(playerId, HandCartTechID);
    FreeTech(playerId, TownWatchTechID);
    FreeTech(playerId, TownPatrolTechID);
    FreeTech(playerId, TownDefenseTechID);
    FreeTech(playerId, DoubleBitAxeTechID);
    FreeTech(playerId, BowSawTechID);
    FreeTech(playerId, TwoManSawTechID);
    FreeTech(playerId, ForestryTechID);
    FreeTech(playerId, HorseCollarTechID);
    FreeTech(playerId, HeavyPlowTechID);
    FreeTech(playerId, CropRotationTechID);
    FreeTech(playerId, CashCropTechID);
    FreeTech(playerId, DomesticationTechID);
    FreeTech(playerId, PastoralismTechID);
    FreeTech(playerId, TranshumanceTechID);
    FreeTech(playerId, GoldMiningTechID);
    FreeTech(playerId, GoldShaftMiningTechID);
    FreeTech(playerId, StoneMiningTechID);
    FreeTech(playerId, StoneShaftMiningTechID);
    FreeTech(playerId, CaravanTechID);
    FreeTech(playerId, CoinageTechID);
    FreeTech(playerId, BankingTechID);
    FreeTech(playerId, GuildsTechID);
    FreeTech(playerId, FishingLinesTechID);
    FreeTech(playerId, GillnetsTechID);
    FreeTech(playerId, PaddedArcherArmorTechID);
    FreeTech(playerId, LeatherArcherArmorTechID);
    FreeTech(playerId, RingArcherArmorTechID);
    FreeTech(playerId, FletchingTechID);
    FreeTech(playerId, BodkinArrowTechID);
    FreeTech(playerId, BracerTechID);
    FreeTech(playerId, ForgingTechID);
    FreeTech(playerId, IronCastingTechID);
    FreeTech(playerId, BlastFurnaceTechID);
    FreeTech(playerId, ScaleBardingArmorTechID);
    FreeTech(playerId, ChainBardingArmorTechID);
    FreeTech(playerId, PlateBardingArmorTechID);
    FreeTech(playerId, ScaleMailArmorTechID);
    FreeTech(playerId, ChainMailArmorTechID);
    FreeTech(playerId, PlateMailArmorTechID);
    FreeTech(playerId, MasonryTechID);
    FreeTech(playerId, ArchitectureTechID);
    FreeTech(playerId, TreadmillCraneTechID);
    FreeTech(playerId, HeatedShotTechID);
    FreeTech(playerId, BallisticsTechID);
    FreeTech(playerId, ChemistryTechID);
    FreeTech(playerId, BombardTowerTechID);
    FreeTech(playerId, SiegeEngineersTechID);
    FreeTech(playerId, MurderHolesTechID);
    FreeTech(playerId, FortifiedWallTechID);
    FreeTech(playerId, GuardTowerTechID);
    FreeTech(playerId, KeepTechID);
    FreeTech(playerId, ArrowslitsTechID);
    FreeTech(playerId, CareeningTechID);
    FreeTech(playerId, DryDockTechID);
    FreeTech(playerId, ClinkerConstructionTechID);
    FreeTech(playerId, CarvelHullTechID);
    FreeTech(playerId, ShipwrightTechID);
    FreeTech(playerId, SiphonsTechID);
    FreeTech(playerId, IncendiariesTechID);
    FreeTech(playerId, RedemptionTechID);
    FreeTech(playerId, AtonementTechID);
    FreeTech(playerId, HerbalMedicineTechID);
    FreeTech(playerId, HeresyTechID);
    FreeTech(playerId, SancityTechID);
    FreeTech(playerId, FervorTechID);
    FreeTech(playerId, DevotionTechID);
    FreeTech(playerId, IlluminationTechID);
    FreeTech(playerId, BlockPrintingTechID);
    FreeTech(playerId, FaithTechID);
    FreeTech(playerId, TheocracyTechID);
    FreeTech(playerId, TitheTechID);
    FreeTech(playerId, ArsonTechID);
    FreeTech(playerId, SquiresTechID);
    FreeTech(playerId, GambesonsTechID);
    FreeTech(playerId, BloodlinesTechID);
    FreeTech(playerId, HusbandryTechID);
    FreeTech(playerId, ThumbRingTechID);
    FreeTech(playerId, ParthianTacticsTechID);
    FreeTech(playerId, HoardingsTechID);
    FreeTech(playerId, SappersTechID);
    FreeTech(playerId, ConscriptTechID);
}


//  10018 - Persians Team Bonus
void EffectFunction10018(int playerId = -1)
{
    AddAttackForm(playerId, HeiGuangCavalryID, cDamageClassArchers, 2);
    AddAttackForm(playerId, HeavyHeiGuangCavalryID, cDamageClassArchers, 2);
    AddAttackForm(playerId, SipahiID, cDamageClassArchers, 2);
    AddAttackForm(playerId, EliteSipahiID, cDamageClassArchers, 2);
    AddAttackForm(playerId, GuanNingCavalryID, cDamageClassArchers, 2);
    AddAttackForm(playerId, CrusaderKnightID, cDamageClassArchers, 2);
    AddAttackForm(playerId, MountedSamuraiID, cDamageClassArchers, 2);
    AddAttackForm(playerId, EliteMountedSamuraiID, cDamageClassArchers, 2);
    AddAttackForm(playerId, GoguryeoHeavyCavalryID, cDamageClassArchers, 2);
    AddAttackForm(playerId, EliteGoguryeoHeavyCavalryID, cDamageClassArchers, 2);
    AddAttackForm(playerId, KeshikID, cDamageClassArchers, 2);
    AddAttackForm(playerId, EliteKeshikID, cDamageClassArchers, 2);
    AddAttackForm(playerId, MercenaryKeshikID, cDamageClassArchers, 2);
    AddAttackForm(playerId, MercenaryEliteKeshikID, cDamageClassArchers, 2);
}


//  10079 - Poles Team Bonus
void EffectFunction10079(int playerId = -1)
{
    AddAttackForm(playerId, MansabdarID, cDamageClassArchers, 1);
    AddAttackForm(playerId, VeteranMansabdarID, cDamageClassArchers, 1);
    AddAttackForm(playerId, EliteMansabdarID, cDamageClassArchers, 1);
    AddAttackForm(playerId, AuxiliaryCavalryID, cDamageClassArchers, 1);
    AddAttackForm(playerId, AuxiliaryCavalry2ID, cDamageClassArchers, 1);
    AddAttackForm(playerId, VeteranAuxiliaryCavalryID, cDamageClassArchers, 1);
    AddAttackForm(playerId, VeteranAuxiliaryCavalry2ID, cDamageClassArchers, 1);
    AddAttackForm(playerId, EliteAuxiliaryCavalryID, cDamageClassArchers, 1);
    AddAttackForm(playerId, EliteAuxiliaryCavalry2ID, cDamageClassArchers, 1);
}


//  10080 - Berbers Team Bonus
void EffectFunction10080(int playerId = -1)
{
    xsEffectAmount(cModifyTech, GenitourTechID, cAttrSetFoodCost, 0, playerId);
    xsEffectAmount(cModifyTech, GenitourTechID, cAttrSetTime, 0, playerId);

    int playerCiv = xsGetPlayerCivilization(playerId);

    if ((playerCiv == cSpanish) || (playerCiv == cBerbers) || (playerCiv == cPortuguese))
    {
        xsEffectAmount(cModifyTech, EliteGenitourTechID, cAttrMulAllCosts, 0.5, playerId);
    }
}


//  10088 - Franks Team Bonus
void EffectFunction10088(int playerId = -1)
{
    ModAttribute(playerId, GuanNingCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, CrusaderKnightID, cLineOfSight, 2);
    ModAttribute(playerId, HeiGuangCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, HeavyHeiGuangCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, SipahiID, cLineOfSight, 2);
    ModAttribute(playerId, EliteSipahiID, cLineOfSight, 2);
    ModAttribute(playerId, MountedSamuraiID, cLineOfSight, 2);
    ModAttribute(playerId, EliteMountedSamuraiID, cLineOfSight, 2);
    ModAttribute(playerId, GoguryeoHeavyCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, EliteGoguryeoHeavyCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, KeshikID, cLineOfSight, 2);
    ModAttribute(playerId, EliteKeshikID, cLineOfSight, 2);
    ModAttribute(playerId, MercenaryKeshikID, cLineOfSight, 2);
    ModAttribute(playerId, MercenaryEliteKeshikID, cLineOfSight, 2);

    ModAttribute(playerId, GuanNingCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, CrusaderKnightID, cSearchRadius, 2);
    ModAttribute(playerId, HeiGuangCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, HeavyHeiGuangCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, SipahiID, cSearchRadius, 2);
    ModAttribute(playerId, EliteSipahiID, cSearchRadius, 2);
    ModAttribute(playerId, MountedSamuraiID, cSearchRadius, 2);
    ModAttribute(playerId, EliteMountedSamuraiID, cSearchRadius, 2);
    ModAttribute(playerId, GoguryeoHeavyCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, EliteGoguryeoHeavyCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, KeshikID, cSearchRadius, 2);
    ModAttribute(playerId, EliteKeshikID, cSearchRadius, 2);
    ModAttribute(playerId, MercenaryKeshikID, cSearchRadius, 2);
    ModAttribute(playerId, MercenaryEliteKeshikID, cSearchRadius, 2);
}


//  10085 - Mongols Team Bonus
void EffectFunction10085(int playerId = -1)
{
    ModAttribute(playerId, MansabdarID, cLineOfSight, 2);
    ModAttribute(playerId, VeteranMansabdarID, cLineOfSight, 2);
    ModAttribute(playerId, EliteMansabdarID, cLineOfSight, 2);
    ModAttribute(playerId, AuxiliaryCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, AuxiliaryCavalry2ID, cLineOfSight, 2);
    ModAttribute(playerId, VeteranAuxiliaryCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, VeteranAuxiliaryCavalry2ID, cLineOfSight, 2);
    ModAttribute(playerId, EliteAuxiliaryCavalryID, cLineOfSight, 2);
    ModAttribute(playerId, EliteAuxiliaryCavalry2ID, cLineOfSight, 2);

    ModAttribute(playerId, MansabdarID, cSearchRadius, 2);
    ModAttribute(playerId, VeteranMansabdarID, cSearchRadius, 2);
    ModAttribute(playerId, EliteMansabdarID, cSearchRadius, 2);
    ModAttribute(playerId, AuxiliaryCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, AuxiliaryCavalry2ID, cSearchRadius, 2);
    ModAttribute(playerId, VeteranAuxiliaryCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, VeteranAuxiliaryCavalry2ID, cSearchRadius, 2);
    ModAttribute(playerId, EliteAuxiliaryCavalryID, cSearchRadius, 2);
    ModAttribute(playerId, EliteAuxiliaryCavalry2ID, cSearchRadius, 2);
}


//  10086 - Bohemians Team Bonus
void EffectFunction10086(int playerId = -1)
{
    MulAttribute(playerId, MarketID, cWorkRate, 1.5 / 1.8);
    MulAttribute(playerId, Market2ID, cWorkRate, 1.5 / 1.8);
    MulAttribute(playerId, Market3ID, cWorkRate, 1.5 / 1.8);
}


//  10087 - Gurjaras Team Bonus
void EffectFunction10087(int playerId = -1)
{
    MulAttribute(playerId, RaiderElephantID, cTrainTime, 0.8);
    MulAttribute(playerId, VeteranRaiderElephantID, cTrainTime, 0.8);
    MulAttribute(playerId, EliteRaiderElephantID, cTrainTime, 0.8);
}