void DataCount(int playerId = -1)
{
    SetResource(playerId, LoeAttrTotalMilitaryOwned, xsPlayerAttribute(playerId, cAttributeMilitaryPopulation) + xsPlayerAttribute(playerId, LoeAttrMilitaryDeath));
}


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


void BritonsMilitiaLineDiscount(int playerId = -1, int Time = -1)
{
    int CountedCastle = xsPlayerAttribute(playerId, cAttributeBritonsCountedCastle);
    int CastleCount = minInt(xsPlayerAttribute(playerId, cAttributeCastle), 5);

    if (CastleCount != CountedCastle)
    {
        ModAttribute(playerId, MilitiaID, cFoodCost, (CountedCastle - CastleCount) * 4);
        ModAttribute(playerId, ManAtArmsID, cFoodCost, (CountedCastle - CastleCount) * 5);
        ModAttribute(playerId, LongSwordmanID, cFoodCost, (CountedCastle - CastleCount) * 5);
        ModAttribute(playerId, TwoHandedSwordmanID, cFoodCost, (CountedCastle - CastleCount) * 4);
        ModAttribute(playerId, ChampionID, cFoodCost, (CountedCastle - CastleCount) * 4);
    }
    SetResource(playerId, cAttributeBritonsCountedCastle, CastleCount);
}


void TatarsFreeScoutAndCA(int playerId = -1, int Time = -1)
{
    if (MinAge(playerId, FeudalAge) == false)
        return;
    int Timer = minInt(xsPlayerAttribute(playerId, cAttributeTatarsScoutTimer) + 1, 240);
    if (Timer >= 240)
    {
        SpawnUnit(playerId, ScoutCavalryID, StableID, 1, 5);
        Timer = Timer - 240;
    }
    SetResource(playerId, cAttributeTatarsScoutTimer, Timer);

    Timer = minInt(xsPlayerAttribute(playerId, cAttributeTatarsCATimer) + 1, 300);
    if (Timer >= 300)
    {
        SpawnUnit(playerId, CavalryArcherID, ArcheryRangeID, 1, 5);
        Timer = Timer - 300;
    }
    SetResource(playerId, cAttributeTatarsCATimer, Timer);
}


void BulgariansFreeArmy(int playerId = -1, int Time = -1)
{
    int ArmyCount = xsPlayerAttribute(playerId, LoeAttrBulgariansArmyCount);
    if (ArmyCount >= 10)
        return;
    int ArmyType = xsPlayerAttribute(playerId, LoeAttrBulgariansArmyType);
    int TotalMilitaryCount = xsPlayerAttribute(playerId, LoeAttrTotalMilitaryOwned) - xsPlayerAttribute(playerId, LoeAttrBulgariansArmyFlag);

    if (TotalMilitaryCount >= (20 + 2 * ArmyCount) * (ArmyCount + 1))
    {
        if (ArmyType == 0)
        {
            SpawnUnit(playerId, SkirmisherID, TownCenterID, 3, 1);
            SpawnUnit(playerId, MilitiaID, TownCenterID, 3, 1);
            ModResource(playerId, LoeAttrBulgariansArmyFlag, 6);
        }
        if (ArmyType == 1)
        {
            SpawnUnit(playerId, ScoutCavalryID, TownCenterID, 3, 1);
            SpawnUnit(playerId, SpearmanID, TownCenterID, 3, 1);
            ModResource(playerId, LoeAttrBulgariansArmyFlag, 6);
        }
        if (ArmyType == 2)
        {
            SpawnUnit(playerId, ArcherID, TownCenterID, 5, 1);
            SpawnUnit(playerId, MaleVillagerID, TownCenterID, 1, 1);
            ModResource(playerId, LoeAttrBulgariansArmyFlag, 5);
        }
        SetResource(playerId, LoeAttrBulgariansArmyCount, ArmyCount + 1);
    }
}


void TimerEvent(int playerId = -1, int Time = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    DataCount(playerId);

    switch (playerCiv)
    {
        case cBritons:
        {
            BritonsMilitiaLineDiscount(playerId, Time);
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
        case cBulgarians:
        {
            BulgariansFreeArmy(playerId, Time);
            break;
        }
        case cTatars:
        {
            TatarsFreeScoutAndCA(playerId, Time);
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