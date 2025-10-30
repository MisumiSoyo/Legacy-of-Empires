//  units.xs中定义了单位相关的函数


include "array.xs";


bool isHouse(int ObjectID = -1)
{
    int HouseIDs = NewArrayInt(6);
    xsArraySetInt(HouseIDs, 0, 70);
    xsArraySetInt(HouseIDs, 1, 463);
    xsArraySetInt(HouseIDs, 2, 464);
    xsArraySetInt(HouseIDs, 3, 465);
    xsArraySetInt(HouseIDs, 4, 191);
    xsArraySetInt(HouseIDs, 5, 192);
    int i = 0;
    for (i = 0; < xsArrayGetSize(HouseIDs))
        if (ObjectID == xsArrayGetInt(HouseIDs, i))
            return (true);
    return (false);
}


bool isCastle(int ObjectID = -1)
{
    int CastleID = 82;
    return (ObjectID == CastleID);
}


bool isBarrack(int ObjectID = -1)
{
    return ((ObjectID == 12) || (ObjectID != 20) || (ObjectID != 132) || (ObjectID != 498));
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


//  判断单位是否在某一类单位的范围内
bool isInRange(int playerId = -1, int UnitID = -1, int ObjectID = -1, float Range = 0.0)
{
    int i = 0;
    int TempArray = xsGetPlayerUnitIds(playerId, ObjectID);
    for (i = 0; <xsArrayGetSize(TempArray))
        if (Distance(xsGetUnitPosition(UnitID), xsGetUnitPosition(xsArrayGetInt(TempArray, i))) <= Range)
            return (true);
    return (false);
}


//  判断位置是否在某一类单位的范围内
bool isPosInRange(int playerId = -1, vector Pos = vector(-1.0, -1.0, -1.0), int ObjectID = -1, float Range = 0.0)
{
    int i = 0;
    int TempArray = xsGetPlayerUnitIds(playerId, ObjectID);
    for (i = 0; <xsArrayGetSize(TempArray))
        if (Distance(Pos, xsGetUnitPosition(xsArrayGetInt(TempArray, i))) <= Range)
            return (true);
    return (false);
}


//  类似功能, 但是判断的是矩形范围
bool isInRangeMatrix(int playerId = -1, int UnitID = -1, int ObjectID = -1, float Range = 0.0)
{
    int i = 0;
    int TempArray = xsGetPlayerUnitIds(playerId, ObjectID);
    for (i = 0; <xsArrayGetSize(TempArray))
    {
        vector UnitPos = xsGetUnitPosition(UnitID);
        vector TempUnitPos = xsGetUnitPosition(xsArrayGetInt(TempArray, i));
        if ((DistanceX(UnitPos, TempUnitPos) <= Range) && (DistanceY(UnitPos, TempUnitPos) <= Range))
            return (true);
    }
    return (false);
}


bool isPosInRangeMatrix(int playerId = -1, vector Pos = vector(-1.0, -1.0, -1.0), int ObjectID = -1, float Range = 0.0)
{
    int i = 0;
    int TempArray = xsGetPlayerUnitIds(playerId, ObjectID);
    for (i = 0; < xsArrayGetSize(TempArray))
    {
        vector TempUnitPos = xsGetUnitPosition(xsArrayGetInt(TempArray, i));
        if ((DistanceX(Pos, TempUnitPos) <= Range) && (DistanceY(Pos, TempUnitPos) <= Range))
            return (true);
    }
    return (false);
}



//  判断是否为陆地军事单位类型
bool isLandMilitaryClass(int ClassID = -1)
{
    return ((ClassID == cArcherClass) || (ClassID == cInfantryClass) || (ClassID == cCavalryClass) || (ClassID == cSiegeWeaponClass) || (ClassID == cMonkClass)
            || (ClassID == cConquistadorClass) || (ClassID == cPetardClass) || (ClassID == cCavalryArcherClass) || (ClassID == cMonkWithRelicClass)
            || (ClassID == cHandCannoneerClass) || (ClassID == cScoutCavalryClass) || (ClassID == cPackedUnitClass) || (ClassID == cUnpackedSiegeUnitClass)
            || (ClassID == cScorpionClass));
}


//  判断单位是否为陆地军事单位
bool isLandMilitaryObject(int ObjectID = -1)
{
    return (isLandMilitaryClass(xsGetObjectClass(ObjectID)));
}


//  判断地图单位是否为陆地军事单位
bool isLandMilitaryUnit(int UnitID = -1)
{
    return (isLandMilitaryClass(xsGetUnitClass(UnitID)));
}


//  判断是否为军事单位类型
bool isMilitaryClass(int ClassID = -1)
{
    return ((ClassID == cArcherClass) || (ClassID == cInfantryClass) || (ClassID == cCavalryClass) || (ClassID == cSiegeWeaponClass) || (ClassID == cMonkClass) || (ClassID == cTransportShipClass) || (ClassID == cWarshipClass)
            || (ClassID == cConquistadorClass) || (ClassID == cPetardClass) || (ClassID == cCavalryArcherClass) || (ClassID == cMonkWithRelicClass) || (ClassID == cHandCannoneerClass) || (ClassID == cScoutCavalryClass) || (ClassID == cPackedUnitClass) || (ClassID == cUnpackedSiegeUnitClass)
            || (ClassID == cScorpionClass));
}


//  判断单位是否为军事单位
bool isMilitaryObject(int ObjectID = -1)
{
    return (isMilitaryClass(xsGetObjectClass(ObjectID)));
}


//  判断地图单位是否为军事单位
bool isMilitaryUnit(int UnitID = -1)
{
    return (isMilitaryClass(xsGetUnitClass(UnitID)));
}


//  判断是否为经济单位类型
bool isEconomicClass(int ClassID = -1)
{
    return ((ClassID == cTradeBoatClass) || (ClassID == cVillagerClass) || (ClassID == cTradeCartClass) || (ClassID == cFishingBoatClass));
}


//  判断单位是否为经济单位
bool isEconomicObject(int ObjectID = -1)
{
    return (isEconomicClass(xsGetObjectClass(ObjectID)));
}


//  判断地图单位是否为经济单位
bool isEconomicUnit(int UnitID = -1)
{
    return (isEconomicClass(xsGetUnitClass(UnitID)));
}


//  判断是否为建筑类型
bool isBuildingClass(int ClassID = -1)
{
    return ((ClassID == cBuildingClass) || (ClassID == cWallClass) || (ClassID == cGateClass) || (ClassID == cTowerClass) || (ClassID == cFarmClass));
}


//  判断单位是否为建筑
bool isBuildingObject(int ObjectID = -1)
{
    return (isBuildingClass(xsGetObjectClass(ObjectID)));
}


//  判断地图单位是否为建筑
bool isBuildingUnit(int UnitID = -1)
{
    return (isBuildingClass(xsGetUnitClass(UnitID)));
}


//  判断是否为资源类型
bool isResourceClass(int ClassID = -1)
{
    return ((ClassID == cSeaFishClass) || (ClassID == cForageBushClass) || (ClassID == cStoneMineClass) || (ClassID == cPreyAnimalClass)
            || (ClassID == cPredatorAnimalClass) || (ClassID == cTreeClass) || (ClassID == cTreeStumpClass) || (ClassID == cGoldMine)
            || (ClassID == cShoreFish) || (ClassID == cResourcePileClass) || (ClassID == cOreMineClass) || (ClassID == cGoldFishClass));
}


//  判断是否为可操作的类型 (军事单位, 经济单位或建筑)
bool isClassOperable(int ClassID = -1)
{
    return(isMilitaryClass(ClassID) || isEconomicClass(ClassID) || isBuildingClass(ClassID));
}


//  判断单位是否为可操作的类型
bool isObjectOperable(int ObjectID = -1)
{
    return (isClassOperable(xsGetObjectClass(ObjectID)));
}


//  判断地图单位是否为可操作的类型
bool isUnitOperable(int UnitID = -1)
{
    return (isClassOperable(xsGetUnitClass(UnitID)));
}


//  获取玩家所有单位的ID, 只考虑可操作类型
int PlayerAllUnits(int playerId = -1, bool includeBuilding = false, int ArrayID = -1, bool includeFarm = False)
{
    int i = 0;
    int ResultArray = 0;
    if (ArrayID == -1)
        ResultArray = NewArrayInt();
    else
    {
        ResultArray = ArrayID;
        xsArrayResizeInt(ResultArray, 0);
    }
    int TempArray = NewArrayInt();

    for (i = 900; <= 964)
        if (isClassOperable(i) || (includeFarm && (i == cFarmClass)))
        {
            if (isBuildingClass(i) && (includeBuilding == false))
                continue;
            TempArray = xsGetPlayerUnitIds(playerId, i, TempArray);
            int TempResult = ResultArray;
            ResultArray = MergeArrayInt(ResultArray, TempArray);
            RecycleArrayInt(TempResult);
        }
    RecycleArrayInt(TempArray);
    return (ResultArray);
}


//  判断单位是否驻扎
//  单位驻扎之后，它的坐标就会变成驻扎目标的坐标，直到解除驻扎。但是，如果驻扎目标移动的话，它的坐标并不会随着被驻扎的单位移动而改变
//  考虑到建筑物一般不移动，简单地比较坐标是否相等从而判断单位是否驻扎到建筑物还是可行的，除了TC这种里面能走人的建筑
bool isGarrison(int UnitID1 = -1, int UnitID2 = -1)
{
    return (xsGetUnitPosition(UnitID1) == xsGetUnitPosition(UnitID2));
}


//  统计指定玩家驻扎在指定单位中的指定单位
//  这个函数还没有被使用以验证其正确性
int GarrisonUnitIDs(int playerId = -1, int UnitID = -1, int ObjectID = -1, int ArrayID = -1)
{
    static int UnitIDs = 0;
    int ResultArray = ArrayID;
    if (ResultArray == -1)
        ResultArray = xsArrayCreateInt(0, 0);
    else
        xsArrayResizeInt(ResultArray, 0);

    int i = 0;
    if (UnitIDs == 0)
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    else
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID, UnitIDs);
    for (u = 0; < xsArrayGetSize(UnitIDs))
        if (isGarrison(UnitID, xsArrayGetInt(UnitIDs, i)))
            ArrayAppendInt(ResultArray, xsArrayGetInt(UnitIDs, i));
    return (ResultArray);
}


int GarrisonUnitCount(int playerId = -1, int UnitID = -1, int ObjectID = -1)
{
    int UnitIDs = GarrisonUnitIDs(playerId, UnitID, ObjectID);
    int Result = xsArrayGetSize(UnitIDs);
    return (Result);
}


//  统计驻扎在ObjectID1中的ObjectID2的单位总数
int GarrisonObjectCount(int playerId = -1, int ObjectID1 = -1, int ObjectID2 = -1)
{
    static int UnitIDs1 = 0;
    if (UnitIDs1 == 0) 
        UnitIDs1 = xsGetPlayerUnitIds(playerId, ObjectID1);
    else
        UnitIDs1 = xsGetPlayerUnitIds(playerId, ObjectID1, UnitIDs1);
    static int UnitIDs2 = 0;
    if (UnitIDs2 == 0) 
        UnitIDs2 = xsGetPlayerUnitIds(playerId, ObjectID2);
    else
        UnitIDs2 = xsGetPlayerUnitIds(playerId, ObjectID2, UnitIDs2);
    int UnitCount1 = xsArrayGetSize(UnitIDs1);
    int UnitCount2 = xsArrayGetSize(UnitIDs2);
    int Result = 0;
    int i = 0;
    int j = 0;
    for (j = 0; < UnitCount2)
    {
        bool flag = false;
        for (i = 0; < UnitCount1)
            if (xsGetUnitPosition(xsArrayGetInt(UnitIDs1, i)) == xsGetUnitPosition(xsArrayGetInt(UnitIDs2, j)))
            {
                flag = true;
                break;
            }
        if (flag)
            Result ++;
    }
    return (Result);
}


//  消耗一个圣物
//  即使被玩家获取, 圣物也是属于Gaia的
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