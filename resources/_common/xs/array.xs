//  定义数组相关操作, 以及矩阵, 即二维数组


include "math.xs";



string ArrayToStringInt(int ArrayID = -1)
{
    string result = "[";
    int i = 0;
    if (xsArrayGetSize(ArrayID) > 0)
    {
        for (i = 0; < xsArrayGetSize(ArrayID) - 1)
            result = result + xsArrayGetInt(ArrayID, i) + ",";
        result = result + xsArrayGetInt(ArrayID, xsArrayGetSize(ArrayID) - 1);
    }
    result = result + "]";
    return (result);
}


//交换数组中两个元素
void ArraySwapValueInt(int ArrayID = -1, int p = -1, int q = -1)
{
    if ((p != -1) && (q != -1))
    {
        int temp = xsArrayGetInt(ArrayID, p);
        xsArraySetInt(ArrayID, p, xsArrayGetInt(ArrayID, q));
        xsArraySetInt(ArrayID, q, temp);
    }
}


//查找元素, 返回其在数组中的下标, 找不到返回 -1
int ArrayFindInt(int ArrayID = -1, int target = -1)
{
    int i = 0;
    for (i = 0; < xsArrayGetSize(ArrayID))
        if (target == xsArrayGetInt(ArrayID, i))
            return (i);
    return (0-1);
}


//二分查找元素，必须是已从小到大排序的数组
int ArrayFindIntBS(int ArrayID = -1, int target = -1)
{
    int l = 0;
    int r = xsArrayGetSize(ArrayID) - 1;

    while (l <= r)
    {
        int mid = (l + r) / 2;
        int MidValue = xsArrayGetInt(ArrayID, mid);
        if (MidValue == target)
            return (mid);
        if (MidValue < target)
            l = mid + 1;
        else
            r = mid - 1;
    }
    return (0-1);
}


//  在数组中指定位置插入元素
void ArrayInsertInt(int ArrayID = -1, int index = 0, int value = 0)
{
    int i = 0;
    xsArrayResizeInt(ArrayID, xsArrayGetSize(ArrayID) + 1);
    for (i = xsArrayGetSize(ArrayID) - 1; > index)
        xsArraySetInt(ArrayID, i, xsArrayGetInt(ArrayID, i - 1));
    xsArraySetInt(ArrayID, index, value);
}


//  删除数组中指定位置的元素
void ArrayRemoveInt(int ArrayID = -1, int index = 0)
{
    if (xsArrayGetSize(ArrayID) == 1)
    {
        xsArrayResizeInt(ArrayID, 0);
        return;
    }
    int i = 0;
    for (i = index; < xsArrayGetSize(ArrayID) - 1)
        xsArraySetInt(ArrayID, i, xsArrayGetInt(ArrayID, i + 1));
    xsArrayResizeInt(ArrayID, xsArrayGetSize(ArrayID) - 1);
}

//  在数组头部添加元素
void ArrayPushFrontInt(int ArrayID = -1, int value = 0)
{
    if (xsArrayGetSize(ArrayID) == 0)
    {
        xsArrayResizeInt(ArrayID, 1);
        xsArraySetInt(ArrayID, 1, value);
        return;
    }
    ArrayInsertInt(ArrayID, 0, value);
}

//  在数组末尾添加元素
void ArrayAppendInt(int ArrayID = -1, int value = 0)
{
    xsArrayResizeInt(ArrayID, xsArrayGetSize(ArrayID) + 1);
    xsArraySetInt(ArrayID, xsArrayGetSize(ArrayID) - 1, value);
}

void ArrayPushBackInt(int ArrayID = -1, int value = 0)
{
    ArrayAppendInt(ArrayID, value);
}

//  删除数组头部元素
void ArrayPopFrontInt(int ArrayID = -1)
{
    ArrayRemoveInt(ArrayID, 0);
}

//  删除数组末尾元素
void ArrayPopBackInt(int ArrayID = -1)
{
    xsArrayResizeInt(ArrayID, xsArrayGetSize(ArrayID) - 1);
}

//  获取数组头部元素
int ArrayFrontInt(int ArrayID = -1)
{
    return (xsArrayGetInt(ArrayID, 0));
}

//  获取数组末尾元素
int ArrayEndInt(int ArrayID = -1)
{
    return (xsArrayGetInt(ArrayID, xsArrayGetSize(ArrayID) - 1));
}

//  对数组的指定元素进行增加
void ArrayIncInt(int ArrayID = -1, int index = 0, int value = -1)
{
    xsArraySetInt(ArrayID, index, xsArrayGetInt(ArrayID, index) + value);
}


//  对数组的指定元素进行倍乘
void ArrayMulInt(int ArrayID = -1, int index = 0, int value = -1)
{
    xsArraySetInt(ArrayID, index, xsArrayGetInt(ArrayID, index) * value);
}


//快速排序
void QuickSortInt(int ArrayID = -1, int left = 0, int right = -1)
{
    int i = left;
    int j = right;
    if (right == -1)
        j = xsArrayGetSize(ArrayID) - 1;
    int mid = xsArrayGetInt(ArrayID, (i + j) / 2);

    while (true)
    {
        while (xsArrayGetInt(ArrayID, i) < mid)
            i++;
        while (xsArrayGetInt(ArrayID, j) > mid)
            j--;
        if (i <= j)
        {
            ArraySwapValueInt(ArrayID, i, j);
            i++;
            j--;
        }
        if (i > j)
            break;
    }
    if (left < j)
        QuickSortInt(ArrayID, left, j);
    if (i < right)
        QuickSortInt(ArrayID, i, right);
}


extern int RecycleArraysInt = 0;   //等待回收的数组id


//  数组复用机制

//  ArrayRecycleInit()函数初始化待回收数组队列
void ArrayRecycleInit()
{
    RecycleArraysInt = xsArrayCreateInt(0, 0);
}


//  创建新数组: NewArrayInt()函数维护一个队列, 该队列存储已被丢弃的数组id, 当创建时进行复用
int NewArrayInt(int size = 0, int defaultValue = 0)
{
    int NewArrayID = 0;
    int i = 0;

    if (xsArrayGetSize(RecycleArraysInt) > 0)  //有待回收的数组id可用
    {
        NewArrayID = ArrayFrontInt(RecycleArraysInt);
        ArrayPopFrontInt(RecycleArraysInt);
        xsArrayResizeInt(NewArrayID, size);
        for (i = 0; < size)
            xsArraySetInt(NewArrayID, i, defaultValue);
        return (NewArrayID);
    }
    //没有待回收的数组id可用
    NewArrayID = xsArrayCreateInt(size, defaultValue);
    return (NewArrayID);
}


//  RecycleArrayInt()函数将数组加入待回收的队列中
void RecycleArrayInt(int ArrayID = -1)
{
    xsArrayResizeInt(ArrayID, 0);
    ArrayAppendInt(RecycleArraysInt, ArrayID);
}


//  二维数组的实现, 称为矩阵
//  创建新矩阵
int NewMatrixInt(int sizea = 0, int sizeb = 0, int defaultValue = 0)
{
    int NewMatrixID = NewArrayInt(sizea, 0);
    int i = 0;
    for (i = 0; < sizea)
        xsArraySetInt(NewMatrixID, i, NewArrayInt(sizeb, defaultValue));
    return (NewMatrixID);
}


//  获取矩阵中的元素
int MatrixGetInt(int MatrixID = -1, int indexa = 0, int indexb = 0)
{
    return (xsArrayGetInt(xsArrayGetInt(MatrixID, indexa), indexb));
}


//  修改矩阵中的元素
void MatrixSetInt(int MatrixID = -1, int indexa = 0, int indexb = 0, int value = 0)
{
    xsArraySetInt(xsArrayGetInt(MatrixID, indexa), indexb, value);
}


//  在矩阵末尾增加一行
void MatrixAppendInt(int MatrixID = -1, int ArrayID = -1)
{
    if (ArrayID == -1)
        ArrayAppendInt(MatrixID, NewArrayInt());
    else
        ArrayAppendInt(MatrixID, ArrayID);
}


//  在矩阵中删除一行, 并且这个数组会被回收
void MatrixRemoveInt(int MatrixID = -1, int index = 0)
{
    xsChatData("MatrixRemoveInt(" + MatrixID + ", " + index + ")");
    RecycleArrayInt(xsArrayGetInt(MatrixID, index));
    ArrayRemoveInt(MatrixID, index);
}


//  在矩阵中插入一行
void MatrixInsertInt(int MatrixID = -1, int index = 0, int ArrayID = -1)
{
    ArrayInsertInt(MatrixID, index, ArrayID);
}


//  回收矩阵的空间
void RecycleMatrixInt(int MatrixID = -1)
{
    int i = 0;
    for (i = 0; < xsArrayGetSize(MatrixID))
        RecycleArrayInt(xsArrayGetInt(MatrixID, i));
    RecycleArrayInt(MatrixID);
}


//  合并数组
int MergeArrayInt(int ArrayID1 = -1, int ArrayID2 = -1)
{
    int i = 0;
    int ResultArray = 0;
    ResultArray = NewArrayInt();
    for (i = 0; < xsArrayGetSize(ArrayID1))
        ArrayAppendInt(ResultArray, xsArrayGetInt(ArrayID1, i));
    for (i = 0; < xsArrayGetSize(ArrayID2))
        ArrayAppendInt(ResultArray, xsArrayGetInt(ArrayID2, i));
    return (ResultArray);
}


string MatrixToStringInt(int MatrixID = -1)
{
    string result = "[";
    int i = 0;
    if (xsArrayGetSize(MatrixID) > 0)
    {
        for (i = 0; < xsArrayGetSize(MatrixID) - 1)
            result = result + ArrayToStringInt(xsArrayGetInt(MatrixID, i)) + ",";
        result = result + ArrayToStringInt(xsArrayGetInt(MatrixID, xsArrayGetSize(MatrixID) - 1));
    }
    result = result + "]";
    return (result);
}