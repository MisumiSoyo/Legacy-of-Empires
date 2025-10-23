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
    int TempArray = NewArrayInt();
    TempArray = xsGetPlayerUnitIds(playerId, ObjectID, TempArray);
    for (i = 0; <xsArrayGetSize(TempArray))
        if (Distance(xsGetUnitPosition(UnitID), xsGetUnitPosition(xsArrayGetInt(TempArray, i))) <= Range)
        {
            RecycleArrayInt(TempArray);
            return (true);
        }
    RecycleArrayInt(TempArray);
    return (false);
}


//  判断位置是否在某一类单位的范围内
bool isPosInRange(int playerId = -1, vector Pos = vector(-1.0, -1.0, -1.0), int ObjectID = -1, float Range = 0.0)
{
    int i = 0;
    int TempArray = NewArrayInt();
    TempArray = xsGetPlayerUnitIds(playerId, ObjectID, TempArray);
    for (i = 0; <xsArrayGetSize(TempArray))
        if (Distance(Pos, xsGetUnitPosition(xsArrayGetInt(TempArray, i))) <= Range)
        {
            RecycleArrayInt(TempArray);
            return (true);
        }
    RecycleArrayInt(TempArray);
    return (false);
}


//  类似功能, 但是判断的是矩形范围
bool isInRangeMatrix(int playerId = -1, int UnitID = -1, int ObjectID = -1, float Range = 0.0)
{
    int i = 0;
    int TempArray = NewArrayInt();
    TempArray = xsGetPlayerUnitIds(playerId, ObjectID, TempArray);
    for (i = 0; <xsArrayGetSize(TempArray))
    {
        vector UnitPos = xsGetUnitPosition(UnitID);
        vector TempUnitPos = xsGetUnitPosition(xsArrayGetInt(TempArray, i));
        if ((DistanceX(UnitPos, TempUnitPos) <= Range) && (DistanceY(UnitPos, TempUnitPos) <= Range))
        {
            RecycleArrayInt(TempArray);
            return (true);
        }
    }
    RecycleArrayInt(TempArray);
    return (false);
}


bool isPosInRangeMatrix(int playerId = -1, vector Pos = vector(-1.0, -1.0, -1.0), int ObjectID = -1, float Range = 0.0)
{
    int i = 0;
    int TempArray = NewArrayInt();
    TempArray = xsGetPlayerUnitIds(playerId, ObjectID, TempArray);
    for (i = 0; < xsArrayGetSize(TempArray))
    {
        vector TempUnitPos = xsGetUnitPosition(xsArrayGetInt(TempArray, i));
        if ((DistanceX(Pos, TempUnitPos) <= Range) && (DistanceY(Pos, TempUnitPos) <= Range))
        {
            RecycleArrayInt(TempArray);
            return (true);
        }
    }
    RecycleArrayInt(TempArray);
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


//为单位启动光环, isSelf为true时光环加成自身, 不能使用于类
void LaunchAura(int playerId = -1, int ObjectID = -1, bool isSelf = false)
{
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseOr(ObjectCombatAbility, 32);
    if (isSelf)
        ObjectCombatAbility = BitwiseOr(ObjectCombatAbility, 64);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}


//为单位关闭光环
void RemoveAura(int playerId = -1, int ObjectID = -1)
{
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseRemove(ObjectCombatAbility, 96);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}

//  为单位启动毒刺效果
void LaunchStinger(int playerId = -1, int ObjectID = -1)
{
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseOr(ObjectCombatAbility, 128);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}


//  为单位关闭毒刺效果
void RemoveStringer(int playerId = -1, int ObjectID = -1)
{
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseRemove(ObjectCombatAbility, 128);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}


//  判断科技是否已经研究完成
bool isResearched(int playerId = -1, int TechID = -1)
{
    return (xsGetTechState(TechID, playerId) == cTechStateDone);
}


//  启用单位
void EnableObject(int playerId = -1, int ObjectID = -1)
{
    xsEffectAmount(cEnableObject, ObjectID, 1, 0, playerId);
}


//  禁用单位
void DisableObject(int playerId = -1, int ObjectID = -1)
{
    xsEffectAmount(cEnableObject, ObjectID, 0, 0, playerId);
}


//  设置科技费用和研究时间均为0, 用于将一些科技变为自动研究, 例如为多个文明解锁一个单位的科技
void SetTechAuto(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetTime, 0, playerId);
    xsEffectAmount(cModifyTech, TechID, cAttrMulAllCosts, 0, playerId);
}


//  启用科技
void EnableTech(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetState, cAttributeEnable, playerId);
}


//  禁用科技
void DisableTech(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cDisableTech, TechID, 0, 0, playerId);
}


//  强制启用科技
void ForceEnableTech(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetState, cAttributeForce, playerId);
}


//  强制研究科技
void ForceResearchTech(int playerId = -1, int TechID = -1)
{
    if (isResearched(playerId, TechID) == false)
        xsEffectAmount(cModifyTech, TechID, cAttrSetState, cAttributeResearch, playerId);
}


//  启用科技堆叠并设置上限
void SetTechStack(int playerId = -1, int TechID = -1, int ResearchCap = 1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetStacking, 1, playerId);
    xsEffectAmount(cModifyTech, TechID, cAttrSetStackingResearchCap, ResearchCap, playerId);
}


//  为单位设置属性
void SetAttribute(int playerId = -1, int ObjectID = -1, int AttributeID = -1, float value = -1)
{
    xsEffectAmount(cSetAttribute, ObjectID, AttributeID, value, playerId);
}


//  为单位修改属性
void ModAttribute(int playerId = -1, int ObjectID = -1, int AttributeID = -1, float value = -1)
{
    xsEffectAmount(cAddAttribute, ObjectID, AttributeID, value, playerId);
}


//  为单位倍乘属性
void MulAttribute(int playerId = -1, int ObjectID = -1, int AttributeID = -1, float value = -1)
{
    xsEffectAmount(cMulAttribute, ObjectID, AttributeID, value, playerId);
}


//  为单位设置攻击力
void SetAttack(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cSetAttribute, ObjectID, cAttack, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cSetAttribute, ObjectID, cAttack, 0 - DamageClass * 256 + value, playerId);
}


//  为单位设置护甲
void SetArmor(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cSetAttribute, ObjectID, cArmor, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cSetAttribute, ObjectID, cArmor, 0 - DamageClass * 256 + value, playerId);
}


//  为单位修改攻击力
void ModAttack(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cAddAttribute, ObjectID, cAttack, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cAddAttribute, ObjectID, cAttack, 0 - DamageClass * 256 + value, playerId);
}


//  为单位修改护甲
void ModArmor(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cAddAttribute, ObjectID, cArmor, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cAddAttribute, ObjectID, cArmor, 0 - DamageClass * 256 + value, playerId);
}


//  设置资源
void SetResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    xsEffectAmount(cModResource, ResourceID, 0, value, playerId);
}


//  修改资源
void ModResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    xsEffectAmount(cModResource, ResourceID, 1, value, playerId);
}


//  倍乘资源
void MulResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    xsEffectAmount(cMulResource, ResourceID, 0, value, playerId);
}


//  生成单位
void SpawnUnit(int playerId = -1, int SpawnUnitID = -1, int SpawnBuidingID = -1, int SpawnNum = -1, int SpawnBuildingCap = 1, bool isInside = false)
{
    xsEffectAmount(cModResource, cAttributeSpawnCap, 0, SpawnBuildingCap, playerId);
    if (isInside)
        xsEffectAmount(cModResource, cAttributeSpawnStayInside, 0, 1, playerId);
    xsEffectAmount(cSpawnUnit, SpawnUnitID, SpawnBuidingID, SpawnNum, playerId);
    xsEffectAmount(cModResource, cAttributeSpawnStayInside, 0, 0, playerId);
}


//  批量设置单位充能
void SetObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    int UnitIDs = NewArrayInt();
    UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID, UnitIDs);
    int i = 0;
    for (i = 0; < xsArrayGetSize(UnitIDs))
        xsSetUnitCharge(xsArrayGetInt(UnitIDs, i), value);
    RecycleArrayInt(UnitIDs);
}


//  批量修改单位充能
void ModObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    int UnitIDs = NewArrayInt();
    UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID, UnitIDs);
    int i = 0;
    float MaxCharge = xsGetObjectAttribute(playerId, ObjectID, cMaxCharge);
    for (i = 0; < xsArrayGetSize(UnitIDs))
    {
        int UnitID = xsArrayGetInt(UnitIDs, i);
        float ChargeValue = maxFloat(minFloat(xsGetUnitCharge(UnitID) + value, MaxCharge), 0);
        xsSetUnitCharge(UnitID, ChargeValue);
    }
    RecycleArrayInt(UnitIDs);
}


//  批量倍乘单位充能
void MulObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    int UnitIDs = NewArrayInt();
    UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID, UnitIDs);
    int i = 0;
    float MaxCharge = xsGetObjectAttribute(playerId, ObjectID, cMaxCharge);
    for (i = 0; < xsArrayGetSize(UnitIDs))
    {
        int UnitID = xsArrayGetInt(UnitIDs, i);
        float ChargeValue = maxFloat(minFloat(xsGetUnitCharge(UnitID) * value, MaxCharge), 0);
        xsSetUnitCharge(UnitID, ChargeValue);
    }
    RecycleArrayInt(UnitIDs);
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
    int UnitIDs = NewArrayInt();
    int ResultArray = ArrayID;
    if (ResultArray == -1)
        ResultArray = NewArrayInt();
    else
        xsArrayResizeInt(ResultArray, 0);

    int i = 0;
    UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    for (u = 0; < xsArrayGetSize(UnitIDs))
        if (isGarrison(UnitID, xsArrayGetInt(UnitIDs, i)))
            ArrayAppendInt(ResultArray, xsArrayGetInt(UnitIDs, i));
    RecycleArrayInt(UnitIDs);
    return (ResultArray);
}


int GarrisonUnitCount(int playerId = -1, int UnitID = -1, int ObjectID = -1)
{
    int UnitIDs = GarrisonUnitIDs(playerId, UnitID, ObjectID);
    int Result = xsArrayGetSize(UnitIDs);
    RecycleArrayInt(UnitIDs);
    return (Result);
}


//  统计驻扎在ObjectID1中的ObjectID2的单位总数
int GarrisonObjectCount(int playerId = -1, int ObjectID1 = -1, int ObjectID2 = -1)
{
    int UnitIDs1 = NewArrayInt();
    int UnitIDs2 = NewArrayInt();
    UnitIDs1 = xsGetPlayerUnitIds(playerId, ObjectID1, UnitIDs1);
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
    RecycleArrayInt(UnitIDs1);
    RecycleArrayInt(UnitIDs2);
    return (Result);
}