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