//数学函数定义


int minInt(int a = 0, int b = 0)
{
    if (a<b)
        return (a);
    return (b);
}


int maxInt(int a = 0, int b = 0)
{
    if (a<b)
        return (b);
    return (a);
}

float minFloat(float a = 0.0, float b = 0.0)
{
    if (a<b)
        return (a);
    return (b);
}


float maxFloat(float a = 0.0, float b = 0.0)
{
    if (a<b)
        return (b);
    return (a);
}


int BitwiseAnd(int a = 0, int b = 0)
{
    int result = 0;
    int tmpa = a;
    int tmpb = b;
    int CurrentBit = 1;

    while ((tmpa != 0) && (tmpb != 0))
    {
        if ((tmpa % 2 == 1) && (tmpb % 2 == 1))
            result = result + CurrentBit;
        CurrentBit = CurrentBit * 2;
        tmpa = tmpa / 2;
        tmpb = tmpb / 2;
    }
    return (result);
}


int BitwiseOr(int a = 0, int b = 0)
{
    int result = 0;
    int tmpa = a;
    int tmpb = b;
    int CurrentBit = 1;

    while ((tmpa != 0) || (tmpb != 0))
    {
        if ((tmpa % 2 == 1) || (tmpb % 2 == 1))
            result = result + CurrentBit;
        CurrentBit = CurrentBit * 2;
        tmpa = tmpa / 2;
        tmpb = tmpb / 2;
    }
    return (result);
}


int BitwiseRemove(int a = 0, int b = 0)
{
    int result = 0;
    int tmpa = a;
    int tmpb = b;
    int CurrentBit = 1;

    while ((tmpa != 0) || (tmpb != 0))
    {
        if ((tmpa % 2 == 1) && (tmpb % 2 == 0))
            result = result + CurrentBit;
        CurrentBit = CurrentBit * 2;
        tmpa = tmpa / 2;
        tmpb = tmpb / 2;
    }
    return (result);
}


float DistanceX(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (abs(xsVectorGetX(posa)-xsVectorGetX(posb)));
}


float DistanceY(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (abs(xsVectorGetY(posa)-xsVectorGetY(posb)));
}


float Distance(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (sqrt(pow(xsVectorGetX(posa)-xsVectorGetX(posb), 2)+pow(xsVectorGetY(posa)-xsVectorGetY(posb), 2)));
}


//  Manhattan Distance
float MDistance(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (abs(xsVectorGetX(posa)-xsVectorGetX(posb))+abs(xsVectorGetY(posa)-xsVectorGetY(posb)));
}


void PrintMessage(string Message = "")
{
    static int MessageNum = 0;
    xsChatData("Message " + MessageNum + ": " + Message);
    MessageNum ++;
}


bool isAlly(int player1 = -1, int player2 = -1)
{
    return (xsPlayerAttribute(player1, cAttributeTeam) == xsPlayerAttribute(player2, cAttributeTeam));
}

bool isEnemy(int player1 = -1, int player2 = -1)
{
    return (xsPlayerAttribute(player1, cAttributeTeam) != xsPlayerAttribute(player2, cAttributeTeam));
}


bool isResearched(int playerId = -1, int TechID = -1)
{
    return (xsGetTechState(TechID, playerId) == cTechStateDone);
}


void EnableObject(int playerId = -1, int ObjectID = -1)
{
    xsEffectAmount(cEnableObject, ObjectID, 1, 0, playerId);
}


void DisableObject(int playerId = -1, int ObjectID = -1)
{
    xsEffectAmount(cEnableObject, ObjectID, 0, 0, playerId);
}


void SetTechAuto(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetTime, 0, playerId);
    xsEffectAmount(cModifyTech, TechID, cAttrMulAllCosts, 0, playerId);
}


void EnableTech(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetState, cAttributeEnable, playerId);
}


void DisableTech(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cDisableTech, TechID, 0, 0, playerId);
}


void ForceEnableTech(int playerId = -1, int TechID = -1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetState, cAttributeForce, playerId);
}


void ForceResearchTech(int playerId = -1, int TechID = -1)
{
    if (isResearched(playerId, TechID) == false)
        xsEffectAmount(cModifyTech, TechID, cAttrSetState, cAttributeResearch, playerId);
}


void SetTechStack(int playerId = -1, int TechID = -1, int ResearchCap = 1)
{
    xsEffectAmount(cModifyTech, TechID, cAttrSetStacking, 1, playerId);
    xsEffectAmount(cModifyTech, TechID, cAttrSetStackingResearchCap, ResearchCap, playerId);
}


void SetAttribute(int playerId = -1, int ObjectID = -1, int AttributeID = -1, float value = -1)
{
    xsEffectAmount(cSetAttribute, ObjectID, AttributeID, value, playerId);
}


void ModAttribute(int playerId = -1, int ObjectID = -1, int AttributeID = -1, float value = -1)
{
    xsEffectAmount(cAddAttribute, ObjectID, AttributeID, value, playerId);
}


void MulAttribute(int playerId = -1, int ObjectID = -1, int AttributeID = -1, float value = -1)
{
    xsEffectAmount(cMulAttribute, ObjectID, AttributeID, value, playerId);
}


void SetAttack(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cSetAttribute, ObjectID, cAttack, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cSetAttribute, ObjectID, cAttack, 0 - DamageClass * 256 + value, playerId);
}


void SetArmor(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cSetAttribute, ObjectID, cArmor, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cSetAttribute, ObjectID, cArmor, 0 - DamageClass * 256 + value, playerId);
}


void ModAttack(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cAddAttribute, ObjectID, cAttack, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cAddAttribute, ObjectID, cAttack, 0 - DamageClass * 256 + value, playerId);
}


void ModAttackBonus(int playerId = -1, int ClassTarget = -1, float value = 0.0)
{
    ModAttack(playerId, ClassTarget, cDamageClassInfantry, value);
    ModAttack(playerId, ClassTarget, cDamageClassElephantUnits, value);
    ModAttack(playerId, ClassTarget, cDamageClassCavalry, value);
    ModAttack(playerId, ClassTarget, cDamageClassArchers, value);
    ModAttack(playerId, ClassTarget, cDamageClassAllBuildings, value);
    ModAttack(playerId, ClassTarget, cDamageClassStoneDefense, value);
    ModAttack(playerId, ClassTarget, cDamageClassPredatorAnimals, value);
    ModAttack(playerId, ClassTarget, cDamageClassShips, value);
    ModAttack(playerId, ClassTarget, cDamageClassRams, value);
    ModAttack(playerId, ClassTarget, cDamageClassUniqueUnits, value);
    ModAttack(playerId, ClassTarget, cDamageClassSiegeWeapons, value);
    ModAttack(playerId, ClassTarget, cDamageClassStandardBuildings, value);
    ModAttack(playerId, ClassTarget, cDamageClassGunpowderUnits, value);
    ModAttack(playerId, ClassTarget, cDamageClassMonks, value);
    ModAttack(playerId, ClassTarget, cDamageClassCastles, value);
    ModAttack(playerId, ClassTarget, cDamageClassSpearmen, value);
    ModAttack(playerId, ClassTarget, cDamageClassCavalryArchers, value);
    ModAttack(playerId, ClassTarget, cDamageClassShockInfantry, value);
    ModAttack(playerId, ClassTarget, cDamageClassCamelUnits, value);
    ModAttack(playerId, ClassTarget, cDamageClassFishingShips, value);
    ModAttack(playerId, ClassTarget, cDamageClassMamelukes, value);
    ModAttack(playerId, ClassTarget, cDamageClassHeroesAndKings, value);
    ModAttack(playerId, ClassTarget, cDamageClassHeavySiege, value);
    ModAttack(playerId, ClassTarget, cDamageClassSkirmishers, value);
    ModAttack(playerId, ClassTarget, cDamageClassMonastery, value);
    ModAttack(playerId, ClassTarget, cDamageClassLightCavalry, value);
}


void ModArmor(int playerId = -1, int ObjectID = -1, int DamageClass = -1, int value = -1)
{
    if  (value > 0)
        xsEffectAmount(cAddAttribute, ObjectID, cArmor, DamageClass * 256 + value, playerId);
    else
        xsEffectAmount(cAddAttribute, ObjectID, cArmor, 0 - DamageClass * 256 + value, playerId);
}


void MulAttack(int playerId = -1, int ObjectID = -1, int DamageClass = -1, float value = -1)
{
    if (DamageClass == -1)
    {
        int i = 0;
        for (i = 0; < TotalAttackForms)
            if (i != 39)
                if (value > 0)
                    xsEffectAmount(cMulAttribute, ObjectID, cAttack, value * 100 + i * 256, playerId);
                else
                    xsEffectAmount(cMulAttribute, ObjectID, cAttack, 0.0 - i * 256 + value * 100, playerId);
        return;
    }
    if (value > 0)
        xsEffectAmount(cMulAttribute, ObjectID, cAttack, value * 100 + DamageClass * 256, playerId);
    else
        xsEffectAmount(cMulAttribute, ObjectID, cAttack, 0.0 - i * 256 + DamageClass * 100, playerId);
}


void MulAttackBonus(int playerId = -1, int ClassTarget = -1, float value = 0.0)
{
    MulAttack(playerId, ClassTarget, cDamageClassInfantry, value);
    MulAttack(playerId, ClassTarget, cDamageClassElephantUnits, value);
    MulAttack(playerId, ClassTarget, cDamageClassCavalry, value);
    MulAttack(playerId, ClassTarget, cDamageClassArchers, value);
    MulAttack(playerId, ClassTarget, cDamageClassAllBuildings, value);
    MulAttack(playerId, ClassTarget, cDamageClassStoneDefense, value);
    MulAttack(playerId, ClassTarget, cDamageClassPredatorAnimals, value);
    MulAttack(playerId, ClassTarget, cDamageClassShips, value);
    MulAttack(playerId, ClassTarget, cDamageClassRams, value);
    MulAttack(playerId, ClassTarget, cDamageClassUniqueUnits, value);
    MulAttack(playerId, ClassTarget, cDamageClassSiegeWeapons, value);
    MulAttack(playerId, ClassTarget, cDamageClassStandardBuildings, value);
    MulAttack(playerId, ClassTarget, cDamageClassGunpowderUnits, value);
    MulAttack(playerId, ClassTarget, cDamageClassMonks, value);
    MulAttack(playerId, ClassTarget, cDamageClassCastles, value);
    MulAttack(playerId, ClassTarget, cDamageClassSpearmen, value);
    MulAttack(playerId, ClassTarget, cDamageClassCavalryArchers, value);
    MulAttack(playerId, ClassTarget, cDamageClassShockInfantry, value);
    MulAttack(playerId, ClassTarget, cDamageClassCamelUnits, value);
    MulAttack(playerId, ClassTarget, cDamageClassFishingShips, value);
    MulAttack(playerId, ClassTarget, cDamageClassMamelukes, value);
    MulAttack(playerId, ClassTarget, cDamageClassHeroesAndKings, value);
    MulAttack(playerId, ClassTarget, cDamageClassHeavySiege, value);
    MulAttack(playerId, ClassTarget, cDamageClassSkirmishers, value);
    MulAttack(playerId, ClassTarget, cDamageClassMonastery, value);
    MulAttack(playerId, ClassTarget, cDamageClassLightCavalry, value);
}


void MulArmor(int playerId = -1, int ObjectID = -1, int DamageClass = -1, float value = -1)
{
    if (DamageClass == -1)
    {
        int i = 0;
        for (i = 0; < TotalAttackForms)
            if (value > 0)
                xsEffectAmount(cMulAttribute, ObjectID, cArmor, value * 100 + i * 256, playerId);
            else
                xsEffectAmount(cMulAttribute, ObjectID, cArmor, 0.0 - i * 256 + value * 100, playerId);
        return;
    }
    if (value > 0)
        xsEffectAmount(cMulAttribute, ObjectID, cArmor, value * 100 + DamageClass * 256, playerId);
    else
        xsEffectAmount(cMulAttribute, ObjectID, cArmor, 0.0 - i * 256 + DamageClass * 100, playerId);
}


void SetResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    xsEffectAmount(cModResource, ResourceID, 0, value, playerId);
}


void ModResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    xsEffectAmount(cModResource, ResourceID, 1, value, playerId);
}


void MulResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    xsEffectAmount(cMulResource, ResourceID, 0, value, playerId);
}


void SetAllyResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if ((i == playerId) || (isAlly(playerId, i)))
            xsEffectAmount(cModResource, ResourceID, 0, value, i);
}


void ModAllyResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if ((i == playerId) || (isAlly(playerId, i)))
            xsEffectAmount(cModResource, ResourceID, 1, value, i);
}


void MulAllyResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if ((i == playerId) || (isAlly(playerId, i)))
            xsEffectAmount(cMulResource, ResourceID, 0, value, i);
}


void SpawnUnit(int playerId = -1, int SpawnUnitID = -1, int SpawnBuidingID = -1, int SpawnNum = -1, int SpawnBuildingCap = 1, bool isInside = false)
{
    xsEffectAmount(cModResource, cAttributeSpawnCap, 0, SpawnBuildingCap, playerId);
    if (isInside)
        xsEffectAmount(cModResource, cAttributeSpawnStayInside, 0, 1, playerId);
    xsEffectAmount(cSpawnUnit, SpawnUnitID, SpawnBuidingID, SpawnNum, playerId);
    xsEffectAmount(cModResource, cAttributeSpawnStayInside, 0, 0, playerId);
}


//  Must carefully use this function for classes
void LaunchAura(int playerId = -1, int ObjectID = -1, bool isSelf = false)
{
    if ((ObjectID >= 900) && (ObjectID <= 964))
    {
        ModAttribute(playerId, ObjectID, cCombatAbility, 32);
        if (isSelf)
            ModAttribute(playerId, ObjectID, cCombatAbility, 64);
        return;
    }
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseOr(ObjectCombatAbility, 32);
    if (isSelf)
        ObjectCombatAbility = BitwiseOr(ObjectCombatAbility, 64);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}


void RemoveAura(int playerId = -1, int ObjectID = -1, bool isSelf = false)
{
    if ((ObjectID >= 900) && (ObjectID <= 964))
    {
        ModAttribute(playerId, ObjectID, cCombatAbility, -32);
        if (isSelf)
            ModAttribute(playerId, ObjectID, cCombatAbility, -64);
        return;
    }
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseRemove(ObjectCombatAbility, 96);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}


void LaunchStinger(int playerId = -1, int ObjectID = -1)
{
    if ((ObjectID >= 900) && (ObjectID <= 964))
    {
        ModAttribute(playerId, ObjectID, cCombatAbility, 128);
        return;
    }
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseOr(ObjectCombatAbility, 128);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}


void RemoveStinger(int playerId = -1, int ObjectID = -1)
{
    if ((ObjectID >= 900) && (ObjectID <= 964))
    {
        ModAttribute(playerId, ObjectID, cCombatAbility, -128);
        return;
    }
    int ObjectCombatAbility = xsGetObjectAttribute(playerId, ObjectID, cCombatAbility);
    ObjectCombatAbility = BitwiseRemove(ObjectCombatAbility, 128);
    xsEffectAmount(cSetAttribute, ObjectID, cCombatAbility, ObjectCombatAbility, playerId);
}


float ObjectTotalCost(int playerId = -1, int ObjectID = -1)
{
    return (xsGetObjectAttribute(playerId, ObjectID, cFoodCost) + xsGetObjectAttribute(playerId, ObjectID, cWoodCost)
            + xsGetObjectAttribute(playerId, ObjectID, cGoldCost) + xsGetObjectAttribute(playerId, ObjectID, cStoneCost));
}


float round(float number = 0.0)
{
    float IntegerPart = floor(number);
    if (number - IntegerPart >= 0.5)
        return (IntegerPart + 1);
    return (IntegerPart);
}


int roundToInt(float number = 0.0)
{
    int IntegerPart = floor(number);
    if (number - IntegerPart >= 0.5)
        return (IntegerPart + 1);
    return (IntegerPart);
}


void ApplyToAllMilitaryTargets(int playerId = -1, int ClassTarget = -1, int TaskType = -1)
{
    xsTask(ClassTarget, TaskType, cArcherClass, playerId);
    xsTask(ClassTarget, TaskType, cInfantryClass, playerId);
    xsTask(ClassTarget, TaskType, cCavalryClass, playerId);
    xsTask(ClassTarget, TaskType, cSiegeWeaponClass, playerId);
    xsTask(ClassTarget, TaskType, cMonkClass, playerId);
    xsTask(ClassTarget, TaskType, cTransportShipClass, playerId);
    xsTask(ClassTarget, TaskType, cWarshipClass, playerId);
    xsTask(ClassTarget, TaskType, cConquistadorClass, playerId);
    xsTask(ClassTarget, TaskType, cPetardClass, playerId);
    xsTask(ClassTarget, TaskType, cCavalryArcherClass, playerId);
    xsTask(ClassTarget, TaskType, cMonkWithRelicClass, playerId);
    xsTask(ClassTarget, TaskType, cHandCannoneerClass, playerId);
    xsTask(ClassTarget, TaskType, cScoutCavalryClass, playerId);
    xsTask(ClassTarget, TaskType, cPackedUnitClass, playerId);
    xsTask(ClassTarget, TaskType, cUnpackedSiegeUnitClass, playerId);
    xsTask(ClassTarget, TaskType, cScorpionClass, playerId);
}