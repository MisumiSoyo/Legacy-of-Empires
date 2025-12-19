void Shrine(int playerId = -1, int Time = -1)
{
    int SpawnUnitID = 0;
    float LastSpawnTime = 0.0;
    float SpawnTime = 0.0;
    int SpawnCount = 0;
    if (xsGetObjectCount(playerId, ShrineID) == 0)
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


void Ikko_Ikki(int playerId = -1, int Time = -1)
{
    float LastSpawnTime = 0.0;
    int Relics = 0;
    if (isResearched(playerId, IkkoIkkiTechID) == false)
        return;
    LastSpawnTime = xsPlayerAttribute(playerId, cAttributeSoheiLastSpawnTime);
    if (LastSpawnTime == 0.0)
    {
        LastSpawnTime = Time;
        SetResource(playerId, cAttributeSoheiLastSpawnTime, LastSpawnTime);
    }
    Relics = xsPlayerAttribute(playerId, cAttributeRelics);
    if (Relics == 0)
    {
        SetResource(playerId, cAttributeSoheiLastSpawnTime, Time);
        return;
    }
    if (xsPlayerAttribute(playerId, cAttributePopulationCap) <= 0.0)
        return;
    if (Time > (66.0 / Relics + LastSpawnTime))
    {
        SpawnUnit(playerId, SoheiID, MonasteryID, 1, 1);
        LastSpawnTime = LastSpawnTime + 66.0 / Relics;
        SetResource(playerId, cAttributeSoheiLastSpawnTime, LastSpawnTime);
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
        case cJapanese:
        {
            Ikko_Ikki(playerId, Time);
            break;
        }
        case cByzantines:
        {
            ByzantinesOliveOil(playerId, Time);
            break;
        }
        default:
        {
            break;
        }
    }

    Shrine(playerId, Time);
}


rule TimerRule
    active
    minInterval 1
    maxInterval 1
{
    int playerId = 0;
    int n = xsGetNumPlayers();
    int Time = xsGetGameTime();
    for (playerId = 0; <= n)
        if (xsPlayerAttribute(playerId, cAttributeLastRuleTime) < Time)
        {
            TimerEvent(playerId, Time);
            SetResource(playerId, cAttributeLastRuleTime, Time);
        }
}