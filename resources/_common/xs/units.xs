//  Functions related to units


bool isHouse(int ObjectID = -1)
{
    return ((ObjectID == 70) || (ObjectID == 463) || (ObjectID == 464) || (ObjectID == 465) || (ObjectID == 191) || (ObjectID == 192));
}


bool isCastle(int ObjectID = -1)
{
    return (ObjectID == 82);
}


bool isBarrack(int ObjectID = -1)
{
    return ((ObjectID == 12) || (ObjectID == 20) || (ObjectID == 132) || (ObjectID == 498));
}


bool isArcherRange(int ObjectID = -1)
{
    return ((ObjectID == 10) || (ObjectID == 14) || (ObjectID == 87));
}


bool isStable(int ObjectID = -1)
{
    return ((ObjectID == 86) || (ObjectID == 101) || (ObjectID == 153));
}


bool isBlackSmith(int ObjectID = -1)
{
    return ((ObjectID == 18) || (ObjectID == 19) || (ObjectID == 103) || (ObjectID == 105));
}


bool isMarket(int ObjectID = -1)
{
    return ((ObjectID == 84) || (ObjectID == 116) || (ObjectID == 137) || (ObjectID == 1646));
}


bool isSiegeWorkshop(int ObjectID = -1)
{
    return ((ObjectID == 49) || (ObjectID == 150));
}


bool isUniversity(int ObjectID = -1)
{
    return ((ObjectID == 209) || (ObjectID == 210));
}


bool isMonastery(int ObjectID = -1)
{
    return ((ObjectID == 30) || (ObjectID == 31) || (ObjectID == 32) || (ObjectID == 104));
}


bool isWonder(int ObjectID = -1)
{
    return (ObjectID == 276);
}


bool isTownCenter(int ObjectID = -1)
{
    return ((ObjectID == 71) || (ObjectID == 109) || (ObjectID == 141) || (ObjectID == 142));
}


bool isDock(int ObjectID = -1)
{
    return ((ObjectID == 45) || (ObjectID == 47) || (ObjectID == 51) || (ObjectID == 133) || (ObjectID == 1189));
}


bool isLandMilitaryClass(int ClassID = -1)
{
    return ((ClassID == cArcherClass) || (ClassID == cInfantryClass) || (ClassID == cCavalryClass) || (ClassID == cSiegeWeaponClass) || (ClassID == cMonkClass)
            || (ClassID == cConquistadorClass) || (ClassID == cPetardClass) || (ClassID == cCavalryArcherClass) || (ClassID == cMonkWithRelicClass)
            || (ClassID == cHandCannoneerClass) || (ClassID == cScoutCavalryClass) || (ClassID == cPackedUnitClass) || (ClassID == cUnpackedSiegeUnitClass)
            || (ClassID == cScorpionClass));
}


bool isLandMilitaryObject(int ObjectID = -1)
{
    return (isLandMilitaryClass(xsGetObjectClass(ObjectID)));
}


bool isLandMilitaryUnit(int UnitID = -1)
{
    return (isLandMilitaryClass(xsGetUnitClass(UnitID)));
}


bool isMilitaryClass(int ClassID = -1)
{
    return ((ClassID == cArcherClass) || (ClassID == cInfantryClass) || (ClassID == cCavalryClass) || (ClassID == cSiegeWeaponClass) || (ClassID == cMonkClass) || (ClassID == cTransportShipClass) || (ClassID == cWarshipClass)
            || (ClassID == cConquistadorClass) || (ClassID == cPetardClass) || (ClassID == cCavalryArcherClass) || (ClassID == cMonkWithRelicClass) || (ClassID == cHandCannoneerClass) || (ClassID == cScoutCavalryClass) || (ClassID == cPackedUnitClass) || (ClassID == cUnpackedSiegeUnitClass)
            || (ClassID == cScorpionClass));
}


bool isMilitaryObject(int ObjectID = -1)
{
    return (isMilitaryClass(xsGetObjectClass(ObjectID)));
}


bool isMilitaryUnit(int UnitID = -1)
{
    return (isMilitaryClass(xsGetUnitClass(UnitID)));
}


bool isEconomicClass(int ClassID = -1)
{
    return ((ClassID == cTradeBoatClass) || (ClassID == cVillagerClass) || (ClassID == cTradeCartClass) || (ClassID == cFishingBoatClass));
}


bool isEconomicObject(int ObjectID = -1)
{
    return (isEconomicClass(xsGetObjectClass(ObjectID)));
}


bool isEconomicUnit(int UnitID = -1)
{
    return (isEconomicClass(xsGetUnitClass(UnitID)));
}


bool isBuildingClass(int ClassID = -1)
{
    return ((ClassID == cBuildingClass) || (ClassID == cWallClass) || (ClassID == cGateClass) || (ClassID == cTowerClass) || (ClassID == cFarmClass));
}


bool isBuildingObject(int ObjectID = -1)
{
    return (isBuildingClass(xsGetObjectClass(ObjectID)));
}


bool isBuildingUnit(int UnitID = -1)
{
    return (isBuildingClass(xsGetUnitClass(UnitID)));
}


bool isAnimalClass(int ClassID = -1)
{
    return ((ClassID == cBuildingClass) || (ClassID == cWallClass) || (ClassID == cGateClass) || (ClassID == cTowerClass) || (ClassID == cFarmClass));
}


bool isAnimalObject(int ObjectID = -1)
{
    return (isAnimalClass(xsGetObjectClass(ObjectID)));
}


bool isAnimalUnit(int UnitID = -1)
{
    return (isAnimalClass(xsGetUnitClass(UnitID)));
}


bool isResourceClass(int ClassID = -1)
{
    return ((ClassID == cSeaFishClass) || (ClassID == cForageBushClass) || (ClassID == cStoneMineClass) || (ClassID == cPreyAnimalClass)
            || (ClassID == cPredatorAnimalClass) || (ClassID == cTreeClass) || (ClassID == cTreeStumpClass) || (ClassID == cGoldMine)
            || (ClassID == cShoreFish) || (ClassID == cResourcePileClass) || (ClassID == cOreMineClass) || (ClassID == cGoldFishClass));
}


bool isClassOperable(int ClassID = -1)
{
    return(isMilitaryClass(ClassID) || isEconomicClass(ClassID) || isBuildingClass(ClassID) || (ClassID == cKingClass));
}


bool isObjectOperable(int ObjectID = -1)
{
    return (isClassOperable(xsGetObjectClass(ObjectID)));
}


bool isUnitOperable(int UnitID = -1)
{
    return (isClassOperable(xsGetUnitClass(UnitID)));
}


bool isGarrison(int UnitID1 = -1, int UnitID2 = -1)
{
    return (xsGetUnitPosition(UnitID1) == xsGetUnitPosition(UnitID2));
}


//  Consume a relic
//  Relics always belong to Gaia even captured by players
bool ConsumeRelic(int playerId = -1)
{
    static int RelicList = 0;
    if (RelicList == 0)
        RelicList = xsGetPlayerUnitIds(0, cRelicClass);
    else
        RelicList = xsGetPlayerUnitIds(0, cRelicClass, RelicList);
    static int PlayerBuildings = 0;
    if (PlayerBuildings == 0)
        PlayerBuildings = xsGetPlayerUnitIds(playerId, cBuildingClass);
    else
        PlayerBuildings = xsGetPlayerUnitIds(playerId, cBuildingClass, PlayerBuildings);
    int i = 0;
    int j = 0;
    for (i = 0; < xsArrayGetSize(RelicList))
    {
        int RelicUnitID = xsArrayGetInt(RelicList, i);
        vector RelicUnitPos = xsGetUnitPosition(RelicUnitID);
        for (j = 0; < xsArrayGetSize(PlayerBuildings))
        {
            int BuildingID = xsArrayGetInt(PlayerBuildings, j);
            if (isMonastery(xsGetUnitObjectId(BuildingID)) && (RelicUnitPos == xsGetUnitPosition(BuildingID)))
            {
                xsSetUnitHitpoints(RelicUnitID, 0);
                return (true);
            }
        }
    }
    return (false);
}


void PrintPlayerUnitObjectIDs(int playerId = -1)
{
    int UnitArray = xsArrayCreateInt(1000, -1);
    int UnitCnt = 0;
    int TempArray = -1;
    int i = 0;
    int j = 0;
    for (i = 900; <= 964)
    {
        if (TempArray == -1)
            TempArray = xsGetPlayerUnitIds(playerId, i);
        else
            TempArray = xsGetPlayerUnitIds(playerId, i, TempArray);
        if (xsArrayGetSize(TempArray) > 0)
        {
            for (j = 0; < xsArrayGetSize(TempArray))
            {
                xsArraySetInt(UnitArray, UnitCnt, xsGetUnitObjectId(xsArrayGetInt(TempArray, j)));
                UnitCnt = UnitCnt + 1;
            }
        }
    }
    xsArrayResizeInt(UnitArray, UnitCnt);
    PrintMessage("Player " + playerId + "'s units' object IDs: " + ArrayToStringInt(UnitArray));
}