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


//  Goths, obtain 1 villager from every three killed enemies
void GothsVillager(int playerId = -1, int Time = 0)
{
    int CalcedBonus = xsPlayerAttribute(playerId, cAttributeGothsVillagerBonus);
    if (CalcedBonus >= 20)
        return;
    int Bonus = xsPlayerAttribute(playerId, cAttributeKills) / 2;
    if (CalcedBonus < Bonus)
    {
        SpawnUnit(playerId, 83, TownCenterID, Bonus - CalcedBonus, 1);
    }
    SetResource(playerId, cAttributeGothsVillagerBonus, Bonus);
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
    if (xsPlayerAttribute(playerId, cAttributeCurrentAge) < 1)
        return;
    int MalayArmyTimer = xsPlayerAttribute(playerId, cAttributeMalayArmyTimer);
    if (MalayArmyTimer <= 0)
    {
        ModResource(playerId, cAttributeMalayArmyCount, 1);
        MalayArmyTimer = MalayArmyTimer + 120;
    }
    SetResource(playerId, cAttributeMalayArmyTimer, MalayArmyTimer - 1);
}


void BengalisRelicBonus(int playerId = -1, int Time = -1)
{
    int RelicBonus = xsPlayerAttribute(playerId, cAttributeBengalisRelicBonus);
    if (RelicBonus > 0)
    {
        int RelicCounted = xsPlayerAttribute(playerId, cAttributeBengalisRelicCount);
        int RelicCount = xsPlayerAttribute(playerId, cAttributeRelics);
        RelicCounted = minInt(RelicCounted, 7);
        RelicCount = minInt(RelicCount, 7);
        if (RelicCounted == RelicCount)
            return;
        switch (RelicBonus)
        {
            case 1:
            {
                RelicMonkArmor(playerId, RelicCount, RelicCounted);
                break;
            }
            case 2:
            {
                RelicInfCavAttack(playerId, RelicCount, RelicCounted);
                break;
            }
            case 3:
            {
                RelicArcherArmor(playerId, RelicCount, RelicCounted);
                break;
            }
            case 4:
            {
                RelicNavyAttack(playerId, RelicCount, RelicCounted);
                break;
            }
            default:
                break;
        }
        SetResource(playerId, cAttributeBengalisRelicCount, xsPlayerAttribute(playerId, cAttributeRelics));
    }
}


void MuiscaFreeWood(int playerId = -1, int Time = -1)
{
    if ((Time > 0) && (Time % 420 == 0) && (Time <= 3360))
        ModResource(playerId, cAttributeWoodGeneration, 30);
}


void BerbersDonkeyNumLimit(int playerId = -1, int Time = -1)
{
    if (xsGetObjectAttribute(playerId, DonkeyID, cDisabledFlag) > 0)
        SetAttribute(playerId, DonkeyID, cAvailableFlag, 10 + 2 * minInt(5, xsPlayerAttribute(playerId, cAttributeCastle)));
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
        case cGoths:
        {
            GothsVillager(playerId, Time);
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
        case cBengalis:
        {
            BengalisRelicBonus(playerId, Time);
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