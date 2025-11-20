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


//按位与
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


//按位或
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


//  按位清除
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


//X轴距离
float DistanceX(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (abs(xsVectorGetX(posa)-xsVectorGetX(posb)));
}


//Y轴距离
float DistanceY(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (abs(xsVectorGetY(posa)-xsVectorGetY(posb)));
}


//欧几里得距离
float Distance(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (sqrt(pow(xsVectorGetX(posa)-xsVectorGetX(posb), 2)+pow(xsVectorGetY(posa)-xsVectorGetY(posb), 2)));
}


//曼哈顿距离
float MDistance(vector posa = vector(-1.0, -1.0, -1.0), vector posb = vector(-1.0, -1.0, -1.0))
{
    return (abs(xsVectorGetX(posa)-xsVectorGetX(posb))+abs(xsVectorGetY(posa)-xsVectorGetY(posb)));
}


//  输出调试信息
void PrintMessage(string Message = "")
{
    static int MessageNum = 0;
    xsChatData("Message " + MessageNum + ": " + Message);
    MessageNum ++;
}


//  判断是否同一队伍
bool isAlly(int player1 = -1, int player2 = -1)
{
    return (xsPlayerAttribute(player1, cAttributeTeam) == xsPlayerAttribute(player2, cAttributeTeam));
}

bool isEnemy(int player1 = -1, int player2 = -1)
{
    return (xsPlayerAttribute(player1, cAttributeTeam) != xsPlayerAttribute(player2, cAttributeTeam));
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


//  为单位倍乘攻击力
void MulAttack(int playerId = -1, int ObjectID = -1, int DamageClass = -1, float value = -1)
{
    if (DamageClass == -1)
    {
        int i = 0;
        for (i = 0; <= TotalAttackForm)
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


//  为单位倍乘护甲
void MulArmor(int playerId = -1, int ObjectID = -1, int DamageClass = -1, float value = -1)
{
    if (DamageClass == -1)
    {
        int i = 0;
        for (i = 0; <= TotalAttackForm)
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


//  团队设置资源
void SetAllyResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if ((i == playerId) || (isAlly(playerId, i)))
            xsEffectAmount(cModResource, ResourceID, 0, value, i);
}


//  团队修改资源
void ModAllyResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if ((i == playerId) || (isAlly(playerId, i)))
            xsEffectAmount(cModResource, ResourceID, 1, value, i);
}


//  团队倍乘资源
void MulAllyResource(int playerId = -1, int ResourceID = -1, float value = 0.0)
{
    int i = 0;
    for (i = 0; <= xsGetNumPlayers())
        if ((i == playerId) || (isAlly(playerId, i)))
            xsEffectAmount(cMulResource, ResourceID, 0, value, i);
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
    int UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    int i = 0;
    for (i = 0; < xsArrayGetSize(UnitIDs))
        xsSetUnitCharge(xsArrayGetInt(UnitIDs, i), value);
}


//  批量修改单位充能
void ModObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    int UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    int i = 0;
    float MaxCharge = xsGetObjectAttribute(playerId, ObjectID, cMaxCharge);
    for (i = 0; < xsArrayGetSize(UnitIDs))
    {
        int UnitID = xsArrayGetInt(UnitIDs, i);
        float ChargeValue = maxFloat(minFloat(xsGetUnitCharge(UnitID) + value, MaxCharge), 0);
        xsSetUnitCharge(UnitID, ChargeValue);
    }
}


//  批量倍乘单位充能
void MulObjectCharge(int playerId = -1, int ObjectID = -1, float value = 0.0)
{
    int UnitIDs = xsGetPlayerUnitIds(playerId, ObjectID);
    int i = 0;
    float MaxCharge = xsGetObjectAttribute(playerId, ObjectID, cMaxCharge);
    for (i = 0; < xsArrayGetSize(UnitIDs))
    {
        int UnitID = xsArrayGetInt(UnitIDs, i);
        float ChargeValue = maxFloat(minFloat(xsGetUnitCharge(UnitID) * value, MaxCharge), 0);
        xsSetUnitCharge(UnitID, ChargeValue);
    }
}


//为单位启动光环, isSelf为true时光环加成自身, 如果使用于种属, 无法判断是否对已经启用光环的单位错误执行, 需要附加处理
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


//为单位关闭光环
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

//  为单位启动毒刺效果
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


//  为单位关闭毒刺效果
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


//  计算单位总价
float ObjectTotalCost(int playerId = -1, int ObjectID = -1)
{
    return (xsGetObjectAttribute(playerId, ObjectID, cFoodCost) + xsGetObjectAttribute(playerId, ObjectID, cWoodCost)
            + xsGetObjectAttribute(playerId, ObjectID, cGoldCost) + xsGetObjectAttribute(playerId, ObjectID, cStoneCost));
}


//  计算四舍五入
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