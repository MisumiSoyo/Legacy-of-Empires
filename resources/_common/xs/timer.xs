void Shrine(int playerId = -1, int Time = -1)
{
    int SpawnUnitID = 0;
    float LastSpawnTime = 0.0;
    float SpawnTime = 0.0;
    int SpawnCount = 0;
    if (xsPlayerAttribute(playerId, cAttributeShrineCount) == 0)
        return;

    SpawnUnitID = xsPlayerAttribute(playerId, cAttributeShrineSpawnUnitID);
    LastSpawnTime = xsPlayerAttribute(playerId, cAttributeShrineLastSpawnTime);
    if (LastSpawnTime == 0.0)
    {
        LastSpawnTime = Time;
        SetResource(playerId, cAttributeShrineLastSpawnTime, Time);
    }
    SpawnTime = xsPlayerAttribute(playerId, cAttributeShrineSpawnTime);
    if (xsGetObjectCount(playerId, FloatingGardenBuildingID) > 0)
        SpawnTime = SpawnTime / 1.2;
    if (xsGetPlayerCivilization(playerId) == cAztecs)
        SpawnTime = SpawnTime / 1.15;
    if (Time - LastSpawnTime >= SpawnTime)
    {
        if (xsPlayerAttribute(playerId, cAttributePopulationCap) <= 0.0)
            return;
        SpawnUnit(playerId, SpawnUnitID, ShrineID, 1, 1000);
        SetResource(playerId, cAttributeShrineLastSpawnTime, Time);
    }
}


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


void KhanLimit(int playerId = -1, int Time = -1)
{
    SetAttribute(playerId, KhanID, cAvailableFlag, xsPlayerAttribute(playerId, cAttributeCastle));
}


void KoreansMineral(int playerId = -1, int Time = -1)
{
    float TotalMineCount = xsPlayerAttribute(playerId, cAttributeGoldTotal) + xsPlayerAttribute(playerId, cAttributeStoneTotal);
    ModResource(playerId, cAttributeGold, minFloat(TotalMineCount/ 1980.0, 3.333333));
}


void PolesFolwarkBonus(int playerId = -1, int Time = -1)
{
    int KillCount = xsPlayerAttribute(playerId, cAttributeKills);
    float Bonus = minInt(KillCount / 15, 10);
    Bonus = 0.01 * Bonus;
    SetResource(playerId, cAttributeFolwarkCollectionAmount, (0.1 + Bonus) * xsPlayerAttribute(playerId, cAttributeFarmFood));
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
        case cKoreans:
        {
            KoreansMineral(playerId, Time);
            break;
        }
        case cPoles:
        {
            PolesFolwarkBonus(playerId, Time);
            break;
        }
        default:
        {
            break;
        }
    }

    Shrine(playerId, Time);
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