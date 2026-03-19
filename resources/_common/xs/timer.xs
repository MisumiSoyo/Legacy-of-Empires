//  print the amount of olive oil
void ByzantinesOliveOil(int playerId = -1, int Time = -1)
{
    int OliveOil = 0;
    OliveOil = xsPlayerAttribute(playerId, cAttributeOliveOil);
    SetAttribute(playerId, BarracksID, cMaxRange, OliveOil);
    SetAttribute(playerId, ArcheryRangeID, cMaxRange, OliveOil);
    SetAttribute(playerId, StableID, cMaxRange, OliveOil);
    SetAttribute(playerId, SiegeWorkshopID, cMaxRange, OliveOil);
}


//  Franks, loan
void FranksLoan(int playerId = -1, int Time = 0)
{
    int FrankLoanTime = xsPlayerAttribute(playerId, cAttributeTechEffectTime);
    if (FrankLoanTime > 0)
    {
        if (FrankLoanTime % 60 == 0)
            xsEffectAmount(cModResource, cAttributeGold, 1, xsPlayerAttribute(playerId, cAttributeFrankLoan), playerId);
        FrankLoanTime --;
        if (FrankLoanTime == 0)
            xsEffectAmount(cModResource, cAttributeLoanLimit, 1, 1, playerId);
        SetResource(playerId, cAttributeTechEffectTime, FrankLoanTime);
    }
}


//  Goths, obtain 1 villager from every three killed enemies
void GothsVillager(int playerId = -1, int Time = 0)
{
    int CalcedBonus = xsPlayerAttribute(playerId, cAttributeGothsVillagerBonus);
    if (CalcedBonus >= 20)
        return;
    int Bonus = xsPlayerAttribute(playerId, cAttributeKills) / 3;
    if (CalcedBonus < Bonus)
    {
        if (Bonus % 3 == 0)
            SpawnUnit(playerId, 83, 109, Bonus - CalcedBonus, 1);
        else
            SpawnUnit(playerId, 293, 109, Bonus - CalcedBonus, 1);
    }
    SetResource(playerId, cAttributeGothsVillagerBonus, Bonus);
}


void SpanishExplorer(int playerId = -1, int Time = -1)
{
    if (isResearched(playerId, ExplorerTechID) == false)
        return;
    float ExplorerGoldRate = 0.015;
    int i = 0;
    float CalcedGold = xsPlayerAttribute(playerId, cAttributeSpanishExplorerGoldCalced);
    float CurrentGold = 0;
    for (i = 1; <= xsGetNumPlayers())
        if (i != playerId)
            CurrentGold = CurrentGold + xsPlayerAttribute(i, cAttributeGoldTotal);
    ModResource(playerId, cAttributeGold, (CurrentGold - CalcedGold) * ExplorerGoldRate);
    SetResource(playerId, cAttributeSpanishExplorerGoldCalced, CurrentGold);
}


void KoreansMineral(int playerId = -1, int Time = -1)
{
    float TotalMineCount = xsPlayerAttribute(playerId, cAttributeGoldTotal) + xsPlayerAttribute(playerId, cAttributeStoneTotal);
    ModResource(playerId, cAttributeGold, minFloat(TotalMineCount/ 1980.0, 3.333333));
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
    int MalayArmyTimer = xsPlayerAttribute(playerId, cAttributeMalayArmyTimer);
    if (MalayArmyTimer <= 0)
    {
        ModResource(playerId, cAttributeMalayArmyCount, 1);
        MalayArmyTimer = MalayArmyTimer + 120;
    }
    SetResource(playerId, cAttributeMalayArmyTimer, MalayArmyTimer - 1);
}

void KhanLimit(int playerId = -1, int Time = -1)
{
    SetAttribute(playerId, KhanID, cAvailableFlag, xsPlayerAttribute(playerId, cAttributeCastle));
}


void TimerEvent(int playerId = -1, int Time = -1)
{
    int playerCiv = xsGetPlayerCivilization(playerId);

    SetResource(playerId, cAttributeRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));

    switch (playerCiv)
    {
        case cFranks:
        {
            FranksLoan(playerId, Time);
            break;
        }
        case cGoths:
        {
            GothsVillager(playerId, Time);
            break;
        }
        case cByzantines:
        {
            ByzantinesOliveOil(playerId, Time);
            break;
        }
        case cSpanish:
        {
            SpanishExplorer(playerId, Time);
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
        case cMalay:
        {
            MalayFreeArmy(playerId, Time);
            break;
        }
        default:
        {
            break;
        }
    }

    KhanLimit(playerId, Time);
}


void EffectFunction10000(int playerId = -1)
{
    int Time = xsGetGameTime();
    if (xsPlayerAttribute(playerId, cAttributeLastRuleTime) < Time)
    {
        TimerEvent(playerId, Time);
        SetResource(playerId, cAttributeLastRuleTime, Time);
    }
}