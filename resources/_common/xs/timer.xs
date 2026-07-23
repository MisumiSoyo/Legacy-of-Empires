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


void TurksTradeIncome(int playerId = -1, int Time = -1)
{
    float IncomePercent = 0.05;
    float IncomeSum = xsPlayerAttribute(playerId, cAttributeTurksTradeIncome);
    float tmp = 0.0;
    int i = 0;
    for (i = 1; <= xsGetNumPlayers())
        if (i != playerId)
            tmp = tmp + xsPlayerAttribute(i, cAttributeTradeIncomeSummation);
    tmp = tmp * IncomePercent;
    if (tmp > IncomeSum)
    {
        ModResource(playerId, cAttributeGold, tmp - IncomeSum);
        SetResource(playerId, cAttributeTurksTradeIncome, tmp);
    }
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


void TimerEvent(int playerId = -1, int Time = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    switch (playerCiv)
    {
        case cFranks:
        {
            FranksLoan(playerId, Time);
            break;
        }
        case cTurks:
        {
            TurksTradeIncome(playerId, Time);
            break;
        }
        case cVikings:
        {
            VikingsDeathBonus(playerId, Time);
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