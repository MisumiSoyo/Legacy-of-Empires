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


void ModAttackBonus(int playerId = -1, int ObjectID = -1, float value = -1, bool ignoreNone = true)
{
    int i = 0;
    for (i = 0; < TotalAttackForms)
        if ((i != 3) && (i != 4) && (i != 39))
            if ((ignoreNone == false) || (xsGetObjectAttribute(playerId, ObjectID, cAttack, i)) > 0)
                if (value > 0)
                    xsEffectAmount(cAddAttribute, ObjectID, cAttack, value + i * 256, playerId);
                else
                    xsEffectAmount(cAddAttribute, ObjectID, cAttack, value - i * 256, playerId);
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


void MulAttackBonus(int playerId = -1, int ObjectID = -1, float value = -1)
{
    int i = 0;
    for (i = 0; < TotalAttackForms)
        if ((i != 3) && (i != 4) && (i != 39))
            if (value > 0)
                xsEffectAmount(cMulAttribute, ObjectID, cAttack, value * 100 + i * 256, playerId);
            else
                xsEffectAmount(cMulAttribute, ObjectID, cAttack, 0.0 - i * 256 + value * 100, playerId);
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


void SetObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    static int UnitIDs = -1;
    if (UnitIDs == -1)
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    else
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID, UnitIDs);
    int i = 0;
    for (i = 0; < xsArrayGetSize(UnitIDs))
        xsSetUnitCharge(xsArrayGetInt(UnitIDs, i), value);
}


void ModObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    static int UnitIDs = -1;
    if (UnitIDs == -1)
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    else
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID, UnitIDs);
    int i = 0;
    float MaxCharge = xsGetObjectAttribute(playerId, ObjectID, cMaxCharge);
    for (i = 0; < xsArrayGetSize(UnitIDs))
    {
        int UnitID = xsArrayGetInt(UnitIDs, i);
        float ChargeValue = maxFloat(minFloat(xsGetUnitCharge(UnitID) + value, MaxCharge), 0);
        xsSetUnitCharge(UnitID, ChargeValue);
    }
}


void MulObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    static int UnitIDs = -1;
    if (UnitIDs == -1)
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    else
        UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID, UnitIDs);
    int i = 0;
    float MaxCharge = xsGetObjectAttribute(playerId, ObjectID, cMaxCharge);
    for (i = 0; < xsArrayGetSize(UnitIDs))
    {
        int UnitID = xsArrayGetInt(UnitIDs, i);
        float ChargeValue = maxFloat(minFloat(xsGetUnitCharge(UnitID) * value, MaxCharge), 0);
        xsSetUnitCharge(UnitID, ChargeValue);
    }
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