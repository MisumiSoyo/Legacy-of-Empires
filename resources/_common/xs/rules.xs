rule Shrine
    active
    minInterval 1
    maxInterval 1
{
    int playerId = 0;
    int n = xsGetNumPlayers();
    int SpawnUnitID = 0;
    float LastSpawnTime = 0.0;
    float SpawnTime = 0.0;
    int SpawnCount = 0;
    int Time = xsGetGameTime();

    for (playerId = 0; <= n)
    {
        if (xsGetObjectCount(playerId, ShrineID) == 0)
            continue;

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
            SpawnUnit(playerId, SpawnUnitID, ShrineID, 1, 1000);
            ModResource(playerId, cAttributeShrineLastSpawnTime, SpawnTime);
        }
    }
}


rule Ikko_Ikki
    active
    minInterval 1
    maxInterval 1
{
    int playerId = 0;
    int n = xsGetNumPlayers();
    float LastSpawnTime = 0.0;
    int Relics = 0;
    int Time = xsGetGameTime();
    for (playerId = 0; <= n)
        if (xsGetPlayerCivilization(playerId) == cJapanese)
        {
            if (isResearched(playerId, 3068) == false)
                continue;
            LastSpawnTime = xsPlayerAttribute(playerId, cAttributeSoheiLastSpawnTime);
            if (LastSpawnTime == 0.0)
            {
                LastSpawnTime = Time;
                SetResource(playerId, cAttributeSoheiLastSpawnTime, LastSpawnTime);
            }
            Relics = xsPlayerAttribute(playerId, cAttributeRelics);
            if (Relics == 0)
                continue;
            if (Time > (75.0 / Relics + LastSpawnTime))
            {
                SpawnUnit(playerId, SoheiID, MonasteryID, 1, 1);
                LastSpawnTime = LastSpawnTime + 75.0 / Relics;
                SetResource(playerId, cAttributeSoheiLastSpawnTime, LastSpawnTime);
            }
        }
}


//  print the amount of olive oil
rule ByzantinesOliveOil
    active
    minInterval 1
    maxInterval 1
{
    int playerId = 0;
    int n = xsGetNumPlayers();
    int OliveOil = 0;
    for (playerId = 0; <= n)
        if (xsGetPlayerCivilization(playerId) == cByzantines)
        {
            OliveOil = xsPlayerAttribute(playerId, cAttributeOliveOil);
            SetAttribute(playerId, BarrackID, cMaxRange, OliveOil);
            SetAttribute(playerId, ArcheryRangeID, cMaxRange, OliveOil);
            SetAttribute(playerId, StableID, cMaxRange, OliveOil);
            SetAttribute(playerId, SiegeWorkshopID, cMaxRange, OliveOil);
        }
}