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


void PolesFolwarkBonus(int playerId = -1, int Time = -1)
{
    int KillCount = xsPlayerAttribute(playerId, cAttributeKills);
    float Bonus = minInt(KillCount / 20, 5);
    Bonus = 0.01 * Bonus;
    SetResource(playerId, cAttributeFolwarkCollectionAmount, (0.1 + Bonus) * xsPlayerAttribute(playerId, cAttributeFarmFood));
}


void CumansHunters(int playerId = -1, int Time = -1)
{
    static int VillagerUnitIDs = -1;
    int i = 0;
    int UnitID = 0;
    int ObjectID = 0;
    float ResHeld = 0.0;
    float TotalRes = 0.0;

    if (VillagerUnitIDs == -1)
        VillagerUnitIDs = xsGetPlayerUnitIds(playerId, cVillagerClass);
    else
        VillagerUnitIDs = xsGetPlayerUnitIds(playerId, cVillagerClass, VillagerUnitIDs);
    for (i = 0; < xsArrayGetSize(VillagerUnitIDs))
    {
        UnitID = xsArrayGetInt(VillagerUnitIDs, i);
        ObjectID = xsGetUnitObjectId(UnitID);
        if ((ObjectID == MaleHunterID) || (ObjectID == FemaleHunterID) || (ObjectID == MaleFishermanID) || (ObjectID == FemaleFishermanID)
            || (ObjectID == MaleForagerID) || (ObjectID == FemaleForagerID) || (ObjectID == MaleShepherdID) || (ObjectID == FemaleShepherdID))
        {
            ResHeld = xsGetUnitAttributeHeld(UnitID);
            TotalRes = TotalRes + ResHeld;
            xsSetUnitAttributeHeld(UnitID, 0.0);
        }
    }
    ModResource(playerId, cAttributeFood, TotalRes);
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
        case cCumans:
        {
            CumansHunters(playerId, Time);
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