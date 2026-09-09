//  Franks, loan
void FranksLoan(int playerId = -1, int Time = 0)
{
    int FrankLoanTime = xsPlayerAttribute(playerId, cAttributeTechEffectTime);
    if (FrankLoanTime > 0)
    {
        FrankLoanTime --;
        if (FrankLoanTime % 60 == 0)
            xsEffectAmount(cModResource, cAttributeGold, 1, xsPlayerAttribute(playerId, cAttributeFrankLoan), playerId);
        if (FrankLoanTime == 0)
            xsEffectAmount(cModResource, cAttributeLoanLimit, 1, 1, playerId);
        SetResource(playerId, cAttributeTechEffectTime, FrankLoanTime);
    }
}


void KoreansMineral(int playerId = -1, int Time = -1)
{
    float TotalMineCount = xsPlayerAttribute(playerId, cAttributeGoldTotal) + xsPlayerAttribute(playerId, cAttributeStoneTotal);
    ModResource(playerId, cAttributeGold, minFloat(TotalMineCount/ 1980.0, 2.5));
}


void PortugueseFeitoria(int playerId = -1, int Time = -1)
{
    if (isResearched(playerId, CartaRegiaTechID) == false)
        return;
    int TeamFeitoriaCount = 0;
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if (i != playerId)
            if (isAlly(i, playerId))
                TeamFeitoriaCount = TeamFeitoriaCount + xsPlayerAttribute(i, cAttributeExtraFeitoriaCount);
    ModResource(playerId, cAttributeFood, 0.8 * TeamFeitoriaCount);
    ModResource(playerId, cAttributeWood, 0.35 * TeamFeitoriaCount);
    ModResource(playerId, cAttributeStone, 0.15 * TeamFeitoriaCount);
    ModResource(playerId, cAttributeGold, 0.5* TeamFeitoriaCount);
}


void MalayFreeArmy(int playerId = -1, int Time = -1)
{
    int Age = xsPlayerAttribute(playerId, cAttributeCurrentAge);
    if (Age < FeudalAge)
        return;
    float MalayArmyTimer = xsPlayerAttribute(playerId, cAttributeMalayArmyTimer);
    if (MalayArmyTimer >= 1.0)
    {
        ModResource(playerId, cAttributeMalayArmyCount, 1);
        MalayArmyTimer = MalayArmyTimer - 1.0;
    }
    int TimeRequired = 120;
    if (Age == CastleAge)
        TimeRequired = 105;
    if (Age == ImperialAge)
        TimeRequired = 90;
    MalayArmyTimer = minFloat(MalayArmyTimer + 1.0 / TimeRequired, 5.0);
    SetResource(playerId, cAttributeMalayArmyTimer, MalayArmyTimer);
}


void MuiscaFreeWood(int playerId = -1, int Time = -1)
{
    if ((Time > 0) && (Time % 360 == 0) && (Time <= 3600))
        ModResource(playerId, cAttributeWoodGeneration, 36);
}


void BerbersDonkeyNumLimit(int playerId = -1, int Time = -1)
{
    if (xsGetObjectAttribute(playerId, DonkeyID, cDisabledFlag) > 0)
        SetAttribute(playerId, DonkeyID, cAvailableFlag, 6 + 3 * minInt(6, xsPlayerAttribute(playerId, cAttributeCastle)));
}


void MercenaryContract(int playerId = -1, int Time = -1)
{
    int Progress = xsPlayerAttribute(playerId, cAttributeCondottieroMercenaryTimer);
    if (isResearched(playerId, MercenaryContractTechID) == false)
        return;
    if ((Progress >= 120) && (xsPlayerAttribute(playerId, cAttributePopulationCap) > 0))
    {
        SpawnUnit(playerId, CondottieroID, TownCenterID, xsPlayerAttribute(playerId, cAttributeCondottieroMercenaryNum), 1);
        Progress = Progress - 120;
    }
    SetResource(playerId, cAttributeCondottieroMercenaryTimer, minInt(Progress + 1, 120));
}


void VikingsDeathBonus(int playerId = -1, int Time = -1)
{
    int CountedDeath = xsPlayerAttribute(playerId, cAttributeVikingsCountedDeath);
    int TotalDeath = xsPlayerAttribute(playerId, cAttributeKilledByOthers);
    float Rate1 = VikingsDeathBonusRate(CountedDeath);
    float Rate2 = VikingsDeathBonusRate(TotalDeath);
    if (Rate2 > Rate1)
        MulAllResourceOut(playerId, Rate2 / Rate1);
    SetResource(playerId, cAttributeVikingsCountedDeath, TotalDeath);
}


void LithuniansPopulationGold(int playerId = -1, int Time = -1)
{
    float PopulationCap = xsPlayerAttribute(playerId, cAttributePopulationCap) + xsPlayerAttribute(playerId, cAttributePopulation);
    ModResource(playerId, cAttributeGold, PopulationCap / 5.0 * 3.0 / 60.0);
}


void MagyarFreeArmy(int playerId = -1, int Time = -1)
{
    int Progress = xsPlayerAttribute(playerId, cAttributeMagyarFreeArmyTimer);
    if (isResearched(playerId, HussarHeritageTechID) == false)
        return;
    if ((Progress >= 120) && (xsPlayerAttribute(playerId, cAttributePopulationCap) > 0))
    {
        SpawnUnit(playerId, EliteMagyarHuszarID, CastleID, 1);
        SpawnUnit(playerId, PaladinID, CastleID, 1);
        Progress = Progress - 120;
    }
    SetResource(playerId, cAttributeMagyarFreeArmyTimer, minInt(Progress + 1, 120));
}


void ByzantinesFreeMercenary(int playerId = -1, int Time = -1)
{
    int Progress = xsPlayerAttribute(playerId, cAttributeByzantinesMercenaryTimer);
    if (MinAge(playerId, CastleAge) == false)
        return;
    Progress = minInt(Progress + 1, 300);
    if (Progress >= 300)
        if ((xsGetObjectCount(playerId, TownCenterID) > 0) && (xsPlayerAttribute(playerId, cAttributePopulationCap) > 0))
        {
            int MercenaryID = xsGetRandomNumberMax(CivCount) + 1;
            int Compensation = xsPlayerAttribute(playerId, cAttributeByzantinesMercenaryCompensation);
            while (isChroniclesCiv(MercenaryID))
                MercenaryID = xsGetRandomNumberMax(CivCount) + 1;
            int MercenaryUnitID = 0;
            if (isAge(playerId, CastleAge))
                MercenaryUnitID = GetUniqueUnitID(MercenaryID);
            else
                MercenaryUnitID = GetUniqueUnitID(MercenaryID, true);
            int MercenaryValue = 450 + Compensation;
            if (xsGetObjectClass(playerId, MercenaryUnitID) == cInfantryClass)
                MercenaryValue = MercenaryValue + 50;
            int UnitValue = ObjectTotalCost(playerId, MercenaryUnitID);
            if ((MercenaryUnitID == BlackwoodArcherID) || (MercenaryUnitID == EliteBlackwoodArcherID))
                UnitValue = UnitValue / 2;
            int MercenaryNum = MercenaryValue / UnitValue;
            SpawnUnit(playerId, MercenaryUnitID, TownCenterID, MercenaryNum, 1);
            Progress = Progress - 300;
            SetResource(playerId, cAttributeByzantinesMercenaryCompensation, MercenaryValue - UnitValue * MercenaryNum);
        }
    SetResource(playerId, cAttributeByzantinesMercenaryTimer, Progress);
}


void TangFreeMoDaoWarrior(int playerId = -1, int Time = -1)
{
    if (isResearched(playerId, TangDynastyTechID) == false)
        return;
    int Progress = xsPlayerAttribute(playerId, cAttributeTangFreeMoDaoTimer);
    Progress = minInt(Progress + 1, 120);
    if (Progress >= 120)
        if (xsPlayerAttribute(playerId, cAttributePopulationCap) > 0)
        {
            SpawnUnit(playerId, MoDaoID, TownCenterID, 1, 4);
            SpawnUnit(playerId, MoDaoID, CastleID, 1);
            Progress = Progress - 120;
        }
    SetResource(playerId, cAttributeTangFreeMoDaoTimer, Progress);
}


void AztecsFreeArmy(int playerId = -1, int Time = -1)
{
    int CountedDeath = xsPlayerAttribute(playerId, cAttributeAztecsCountedDeath);
    int TotalDeath = xsPlayerAttribute(playerId, cAttributeKilledByOthers);
    if (TotalDeath / 15 > CountedDeath / 15)
        if (CountedDeath < 150)
            SpawnUnit(playerId, MaleVillagerID, TownCenterID, 1, 1);
    SetResource(playerId, cAttributeAztecsCountedDeath, TotalDeath);

    if (MinAge(playerId, FeudalAge) == false)
        return;
    int FreeArmyTimer = minInt(xsPlayerAttribute(playerId, cAttributeAztecsArmyTimer) + 1, 120);
    if (FreeArmyTimer >= 120)
        if (xsPlayerAttribute(playerId, cAttributePopulationCap) > 0)
        {
            SpawnUnit(playerId, JaguarWarriorID, TownCenterID, minInt(TotalDeath / 15, 10), 1);
            FreeArmyTimer = FreeArmyTimer - 120;
        }
    SetResource(playerId, cAttributeAztecsArmyTimer, FreeArmyTimer);
}


void EnclosureSheep(int playerId = -1, int Time = -1)
{
    if (isResearched(playerId, EnclosureTechID) == false)
        return;
    int Timer = xsPlayerAttribute(playerId, cAttributeEnclosureTimer) + 1;
    if (Timer >= 120)
    {
        SpawnUnit(playerId, SheepID, TownCenterID, 1, 5);
        Timer = Timer - 120;
    }
    SetResource(playerId, cAttributeEnclosureTimer, Timer);
}


void TimerEvent(int playerId = -1, int Time = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cBritons:
        {
            EnclosureSheep(playerId, Time);
            break;
        }
        case cFranks:
        {
            FranksLoan(playerId, Time);
            break;
        }
        case cChinese:
        {
            TangFreeMoDaoWarrior(playerId, Time);
            break;
        }
        case cByzantines:
        {
            ByzantinesFreeMercenary(playerId, Time);
            break;
        }
        case cVikings:
        {
            VikingsDeathBonus(playerId, Time);
            break;
        }
        case cAztecs:
        {
            AztecsFreeArmy(playerId, Time);
            break;
        }
        case cKoreans:
        {
            KoreansMineral(playerId, Time);
            break;
        }
        case cPortuguese:
        {
            PortugueseFeitoria(playerId, Time);
            break;
        }
        case cBerbers:
        {
            BerbersDonkeyNumLimit(playerId, Time);
            break;
        }
        case cMalay:
        {
            MalayFreeArmy(playerId, Time);
            break;
        }
        case cLithuanians:
        {
            LithuniansPopulationGold(playerId, Time);
            break;
        }
        case cMuisca:
        {
            MuiscaFreeWood(playerId, Time);
            break;
        }
        default:
        {
            break;
        }
    }

    MercenaryContract(playerId, Time);
    MagyarFreeArmy(playerId, Time);
}


void EffectFunction10000(int playerId = -1)
{
    int Time = xsGetGameTime();
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if (xsPlayerAttribute(i, cAttributeLastRuleTime) < Time)
        {
            TimerEvent(i, Time);
            SetResource(i, cAttributeLastRuleTime, Time);
        }
}