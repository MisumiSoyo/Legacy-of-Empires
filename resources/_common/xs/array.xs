//  定义数组相关操作, 以及矩阵, 即二维数组
//  目前Vector相关操作似乎存在问题, 暂时谨慎使用


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

string ArrayToStringFloat(int ArrayID = -1)
{
    string result = "[";
    int i = 0;
    if (xsArrayGetSize(ArrayID) > 0)
    {
        for (i = 0; < xsArrayGetSize(ArrayID) - 1)
            result = result + xsArrayGetFloat(ArrayID, i) + ",";
        result = result + xsArrayGetFloat(ArrayID, xsArrayGetSize(ArrayID) - 1);
    }
    result = result + "]";
    return (result);
}


string ArrayToStringVector(int ArrayID = -1)
{
    string result = "[";
    int i = 0;
    if (xsArrayGetSize(ArrayID) > 0)
    {
        for (i = 0; < xsArrayGetSize(ArrayID) - 1)
            result = result + xsArrayGetVector(ArrayID, i) + ",";
        result = result + xsArrayGetVector(ArrayID, xsArrayGetSize(ArrayID) - 1);
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

void ArraySwapValueFloat(int ArrayID = -1, int p = -1, int q = -1)
{
    if ((p != -1) && (q != -1))
    {
        float temp = xsArrayGetInt(ArrayID, p);
        xsArraySetFloat(ArrayID, p, xsArrayGetFloat(ArrayID, q));
        xsArraySetFloat(ArrayID, q, temp);
    }
}

void ArraySwapValueVector(int ArrayID = -1, int p = -1, int q = -1)
{
    if ((p != -1) && (q != -1))
    {
        vector temp = xsArrayGetVector(ArrayID, p);
        xsArraySetVector(ArrayID, p, xsArrayGetVector(ArrayID, q));
        xsArraySetVector(ArrayID, q, temp);
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

int ArrayFindFloat(int ArrayID = -1, float target = -1.0)
{
    int i = 0;
    for (i = 0; < xsArrayGetSize(ArrayID))
        if (target == xsArrayGetInt(ArrayID, i))
            return (i);
    return (0-1);
}

int ArrayFindVector(int ArrayID = -1, vector target = vector(-1.0, -1.0, -1.0))
{
    int i = 0;
    for (i = 0; < xsArrayGetSize(ArrayID))
        if (target == xsArrayGetVector(ArrayID, i))
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

void ArrayInsertFloat(int ArrayID = -1, int index = 0, float value = 0.0)
{
    int i = 0;
    xsArrayResizeFloat(ArrayID, xsArrayGetSize(ArrayID) + 1);
    for (i = xsArrayGetSize(ArrayID) - 1; > index)
        xsArraySetFloat(ArrayID, i, xsArrayGetFloat(ArrayID, i - 1));
    xsArraySetFloat(ArrayID, index, value);
}

void ArrayInsertVector(int ArrayID = -1, int index = 0, vector value = vector(-1.0, -1.0, -1.0))
{
    int i = 0;
    xsArrayResizeVector(ArrayID, xsArrayGetSize(ArrayID) + 1);
    for (i = xsArrayGetSize(ArrayID) - 1; > index)
        xsArraySetVector(ArrayID, i, xsArrayGetVector(ArrayID, i - 1));
    xsArraySetVector(ArrayID, index, value);
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

void ArrayRemoveFloat(int ArrayID = -1, int index = 0)
{
    if (xsArrayGetSize(ArrayID) == 1)
    {
        xsArrayResizeFloat(ArrayID, 0);
        return;
    }
    int i = 0;
    for (i = index; < xsArrayGetSize(ArrayID) - 1)
        xsArraySetFloat(ArrayID, i, xsArrayGetFloat(ArrayID, i + 1));
    xsArrayResizeFloat(ArrayID, xsArrayGetSize(ArrayID) - 1);
}

void ArrayRemoveVector(int ArrayID = -1, int index = 0)
{
    if (xsArrayGetSize(ArrayID) == 1)
    {
        xsArrayResizeVector(ArrayID, 0);
        return;
    }
    int i = 0;
    for (i = index; < xsArrayGetSize(ArrayID) - 1)
        xsArraySetVector(ArrayID, i, xsArrayGetVector(ArrayID, i + 1));
    xsArrayResizeVector(ArrayID, xsArrayGetSize(ArrayID) - 1);
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

void ArrayPushFrontFloat(int ArrayID = -1, float value = 0.0)
{
    if (xsArrayGetSize(ArrayID) == 0)
    {
        xsArrayResizeFloat(ArrayID, 1);
        xsArraySetFloat(ArrayID, 1, value);
        return;
    }
    ArrayInsertFloat(ArrayID, 0, value);
}

void ArrayPushFrontVector(int ArrayID = -1, vector value = vector(-1.0, -1.0, -1.0))
{
    if (xsArrayGetSize(ArrayID) == 0)
    {
        xsArrayResizeVector(ArrayID, 1);
        xsArraySetVector(ArrayID, 1, value);
        return;
    }
    ArrayInsertVector(ArrayID, 0, value);
}

//  在数组末尾添加元素
void ArrayAppendInt(int ArrayID = -1, int value = 0)
{
    xsArrayResizeInt(ArrayID, xsArrayGetSize(ArrayID) + 1);
    xsArraySetInt(ArrayID, xsArrayGetSize(ArrayID) - 1, value);
}

void ArrayAppendFloat(int ArrayID = -1, float value = 0.0)
{
    xsArrayResizeFloat(ArrayID, xsArrayGetSize(ArrayID) + 1);
    xsArraySetFloat(ArrayID, xsArrayGetSize(ArrayID) - 1, value);
}

void ArrayAppendVector(int ArrayID = -1, vector value = vector(-1.0, -1.0, -1.0))
{
    xsArrayResizeVector(ArrayID, xsArrayGetSize(ArrayID) + 1);
    xsArraySetVector(ArrayID, xsArrayGetSize(ArrayID) - 1, value);
}

void ArrayPushBackInt(int ArrayID = -1, int value = 0)
{
    ArrayAppendInt(ArrayID, value);
}

void ArrayPushBackFloat(int ArrayID = -1, float value = 0.0)
{
    ArrayAppendFloat(ArrayID, value);
}

void ArrayPushBackVector(int ArrayID = -1, vector value = vector(-1.0, -1.0, -1.0))
{
    ArrayAppendVector(ArrayID, value);
}

//  删除数组头部元素
void ArrayPopFrontInt(int ArrayID = -1)
{
    ArrayRemoveInt(ArrayID, 0);
}

void ArrayPopFrontFloat(int ArrayID = -1)
{
    ArrayRemoveFloat(ArrayID, 0);
}

void ArrayPopFrontVector(int ArrayID = -1)
{
    ArrayRemoveVector(ArrayID, 0);
}

//  删除数组末尾元素
void ArrayPopBackInt(int ArrayID = -1)
{
    xsArrayResizeInt(ArrayID, xsArrayGetSize(ArrayID) - 1);
}

void ArrayPopBackFloat(int ArrayID = -1)
{
    xsArrayResizeFloat(ArrayID, xsArrayGetSize(ArrayID) - 1);
}

void ArrayPopBackVector(int ArrayID = -1)
{
    xsArrayResizeVector(ArrayID, xsArrayGetSize(ArrayID) - 1);
}

//  获取数组头部元素
int ArrayFrontInt(int ArrayID = -1)
{
    return (xsArrayGetInt(ArrayID, 0));
}

int ArrayFrontFloat(int ArrayID = -1)
{
    return (xsArrayGetFloat(ArrayID, 0));
}

vector ArrayFrontVector(int ArrayID = -1)
{
    return (xsArrayGetVector(ArrayID, 0));
}

//  获取数组末尾元素
int ArrayEndInt(int ArrayID = -1)
{
    return (xsArrayGetInt(ArrayID, xsArrayGetSize(ArrayID) - 1));
}

int ArrayEndFloat(int ArrayID = -1)
{
    return (xsArrayGetFloat(ArrayID, xsArrayGetSize(ArrayID) - 1));
}

vector ArrayEndVector(int ArrayID = -1)
{
    return (xsArrayGetVector(ArrayID, xsArrayGetSize(ArrayID) - 1));
}

//  对数组的指定元素进行增加
void ArrayIncInt(int ArrayID = -1, int index = 0, int value = -1)
{
    xsArraySetInt(ArrayID, index, xsArrayGetInt(ArrayID, index) + value);
}

void ArrayIncFloat(int ArrayID = -1, int index = 0, float value = -1.0)
{
    xsArraySetFloat(ArrayID, index, xsArrayGetFloat(ArrayID, index) + value);
}


//  对数组的指定元素进行倍乘
void ArrayMulInt(int ArrayID = -1, int index = 0, int value = -1)
{
    xsArraySetInt(ArrayID, index, xsArrayGetInt(ArrayID, index) * value);
}

void ArrayMulFloat(int ArrayID = -1, int index = 0, float value = -1.0)
{
    xsArraySetFloat(ArrayID, index, xsArrayGetFloat(ArrayID, index) * value);
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


//  等待回收的数组id
extern int RecycleArraysInt = 0;
extern int RecycleArraysFloat = 0;
extern int RecycleArraysVector = 0;


//  数组复用机制

//  ArrayRecycleInit()函数初始化待回收数组队列
void ArrayRecycleInit()
{
    RecycleArraysInt = xsArrayCreateInt(0, 0);
    RecycleArraysFloat = xsArrayCreateInt(0, 0);
    RecycleArraysVector = xsArrayCreateInt(0, 0);
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

int NewArrayFloat(int size = 0, float defaultValue = 0.0)
{
    int NewArrayID = 0;
    int i = 0;

    if (xsArrayGetSize(RecycleArraysFloat) > 0)  //有待回收的数组id可用
    {
        NewArrayID = ArrayFrontInt(RecycleArraysFloat);
        ArrayPopFrontInt(RecycleArraysFloat);
        xsArrayResizeFloat(NewArrayID, size);
        for (i = 0; < size)
            xsArraySetFloat(NewArrayID, i, defaultValue);
        return (NewArrayID);
    }
    //没有待回收的数组id可用
    NewArrayID = xsArrayCreateFloat(size, defaultValue);
    return (NewArrayID);
}

int NewArrayVector(int size = 0, vector defaultValue = vector(-1.0, -1.0, -1.0))
{
    int NewArrayID = 0;
    int i = 0;

    if (xsArrayGetSize(RecycleArraysVector) > 0)  //有待回收的数组id可用
    {
        NewArrayID = ArrayFrontInt(RecycleArraysVector);
        ArrayPopFrontInt(RecycleArraysVector);
        xsArrayResizeVector(NewArrayID, size);
        for (i = 0; < size)
            xsArraySetVector(NewArrayID, i, defaultValue);
        return (NewArrayID);
    }
    //没有待回收的数组id可用
    NewArrayID = xsArrayCreateVector(size, defaultValue);
    return (NewArrayID);
}


//  RecycleArrayInt()函数将数组加入待回收的队列中
void RecycleArrayInt(int ArrayID = -1)
{
    xsArrayResizeInt(ArrayID, 0);
    ArrayAppendInt(RecycleArraysInt, ArrayID);
}

void RecycleArrayFloat(int ArrayID = -1)
{
    xsArrayResizeFloat(ArrayID, 0);
    ArrayAppendInt(RecycleArraysFloat, ArrayID);
}

void RecycleArrayVector(int ArrayID = -1)
{
    xsArrayResizeVector(ArrayID, 0);
    ArrayAppendInt(RecycleArraysVector, ArrayID);
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

int NewMatrixFloat(int sizea = 0, int sizeb = 0, float defaultValue = 0.0)
{
    int NewMatrixID = NewArrayInt(sizea, 0);
    int i = 0;
    for (i = 0; < sizea)
        xsArraySetInt(NewMatrixID, i, NewArrayFloat(sizeb, defaultValue));
    return (NewMatrixID);
}

int NewMatrixVector(int sizea = 0, int sizeb = 0, vector defaultValue = vector(-1.0, -1.0, -1.0))
{
    int NewMatrixID = NewArrayInt(sizea, 0);
    int i = 0;
    for (i = 0; < sizea)
        xsArraySetInt(NewMatrixID, i, NewArrayVector(sizeb, defaultValue));
    return (NewMatrixID);
}


//  获取矩阵中的元素
int MatrixGetInt(int MatrixID = -1, int indexa = 0, int indexb = 0)
{
    return (xsArrayGetInt(xsArrayGetInt(MatrixID, indexa), indexb));
}

float MatrixGetFloat(int MatrixID = -1, int indexa = 0, int indexb = 0)
{
    return (xsArrayGetFloat(xsArrayGetInt(MatrixID, indexa), indexb));
}

vector MatrixGetVector(int MatrixID = -1, int indexa = 0, int indexb = 0)
{
    return (xsArrayGetVector(xsArrayGetInt(MatrixID, indexa), indexb));
}


//  修改矩阵中的元素
void MatrixSetInt(int MatrixID = -1, int indexa = 0, int indexb = 0, int value = 0)
{
    xsArraySetInt(xsArrayGetInt(MatrixID, indexa), indexb, value);
}

void MatrixSetFloat(int MatrixID = -1, int indexa = 0, int indexb = 0, float value = 0.0)
{
    xsArraySetFloat(xsArrayGetInt(MatrixID, indexa), indexb, value);
}

void MatrixSetVector(int MatrixID = -1, int indexa = 0, int indexb = 0, vector value = vector(-1.0, -1.0, -1.0))
{
    xsArraySetVector(xsArrayGetInt(MatrixID, indexa), indexb, value);
}


//  在矩阵末尾增加一行
void MatrixAppendRowInt(int MatrixID = -1, int ArrayID = -1)
{
    if (ArrayID == -1)
        ArrayAppendInt(MatrixID, NewArrayInt());
    else
        ArrayAppendInt(MatrixID, ArrayID);
}

void MatrixAppendRowFloat(int MatrixID = -1, int ArrayID = -1)
{
    if (ArrayID == -1)
        ArrayAppendInt(MatrixID, NewArrayFloat());
    else
        ArrayAppendInt(MatrixID, ArrayID);
}

void MatrixAppendRowVector(int MatrixID = -1, int ArrayID = -1)
{
    if (ArrayID == -1)
        ArrayAppendInt(MatrixID, NewArrayVector());
    else
        ArrayAppendInt(MatrixID, ArrayID);
}


//  在矩阵中删除一行, 并且这个数组会被回收
void MatrixRemoveRowInt(int MatrixID = -1, int index = 0)
{
    RecycleArrayInt(xsArrayGetInt(MatrixID, index));
    ArrayRemoveInt(MatrixID, index);
}

void MatrixRemoveRowFloat(int MatrixID = -1, int index = 0)
{
    RecycleArrayFloat(xsArrayGetInt(MatrixID, index));
    ArrayRemoveInt(MatrixID, index);
}

void MatrixRemoveRowVector(int MatrixID = -1, int index = 0)
{
    RecycleArrayVector(xsArrayGetInt(MatrixID, index));
    ArrayRemoveInt(MatrixID, index);
}


//  在矩阵中插入一行
void MatrixInsertRowInt(int MatrixID = -1, int index = 0, int ArrayID = -1)
{
    ArrayInsertInt(MatrixID, index, ArrayID);
}

void MatrixInsertRowFloat(int MatrixID = -1, int index = 0, int ArrayID = -1)
{
    ArrayInsertInt(MatrixID, index, ArrayID);
}

void MatrixInsertRowVector(int MatrixID = -1, int index = 0, int ArrayID = -1)
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

void RecycleMatrixFloat(int MatrixID = -1)
{
    int i = 0;
    for (i = 0; < xsArrayGetSize(MatrixID))
        RecycleArrayFloat(xsArrayGetInt(MatrixID, i));
    RecycleArrayInt(MatrixID);
}

void RecycleMatrixVector(int MatrixID = -1)
{
    int i = 0;
    for (i = 0; < xsArrayGetSize(MatrixID))
        RecycleArrayVector(xsArrayGetInt(MatrixID, i));
    RecycleArrayInt(MatrixID);
}


//  矩阵转换为字符串
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

string MatrixToStringFloat(int MatrixID = -1)
{
    string result = "[";
    int i = 0;
    if (xsArrayGetSize(MatrixID) > 0)
    {
        for (i = 0; < xsArrayGetSize(MatrixID) - 1)
            result = result + ArrayToStringFloat(xsArrayGetInt(MatrixID, i)) + ",";
        result = result + ArrayToStringFloat(xsArrayGetInt(MatrixID, xsArrayGetSize(MatrixID) - 1));
    }
    result = result + "]";
    return (result);
}

string MatrixToStringVector(int MatrixID = -1)
{
    string result = "[";
    int i = 0;
    if (xsArrayGetSize(MatrixID) > 0)
    {
        for (i = 0; < xsArrayGetSize(MatrixID) - 1)
            result = result + ArrayToStringVector(xsArrayGetInt(MatrixID, i)) + ",";
        result = result + ArrayToStringVector(xsArrayGetInt(MatrixID, xsArrayGetSize(MatrixID) - 1));
    }
    result = result + "]";
    return (result);
}


//  在矩阵中的某一行查找元素
int MatrixFindInt(int MatrixID = -1, int row = -1, int value = -1)
{
    return (ArrayFindInt(xsArrayGetInt(MatrixID, row), value));
}

int MatrixFindFloat(int MatrixID = -1, int row = -1, float value = -1.0)
{
    return (ArrayFindFloat(xsArrayGetInt(MatrixID, row), value));
}

int MatrixFindVector(int MatrixID = -1, int row = -1, vector value = vector(-1.0, -1.0, -1.0))
{
    return (ArrayFindVector(xsArrayGetInt(MatrixID, row), value));
}


//  对矩阵的指定元素进行增加
void MatrixIncInt(int MatrixID = -1, int row = -1, int column = -1 , int value = -1)
{
    ArrayIncInt(xsArrayGetInt(MatrixID, row), column, value);
}

void MatrixIncFloat(int MatrixID = -1, int row = -1, int column = -1 , float value = -1.0)
{
    ArrayIncFloat(xsArrayGetInt(MatrixID, row), column, value);
}


//  对矩阵的指定元素进行倍乘
void MatrixMulInt(int MatrixID = -1, int row = -1, int column = -1 , int value = -1)
{
    ArrayMulInt(xsArrayGetInt(MatrixID, row), column, value);
}

void MatrixMulFloat(int MatrixID = -1, int row = -1, int column = -1 , float value = -1.0)
{
    ArrayMulFloat(xsArrayGetInt(MatrixID, row), column, value);
}


//  在矩阵中插入一个元素
void MatrixInsertInt(int MatrixID = -1, int row = -1, int column = -1, int value = -1)
{
    ArrayInsertInt(xsArrayGetInt(MatrixID, row), column, value);
}

void MatrixInsertFloat(int MatrixID = -1, int row = -1, int column = -1, float value = -1.0)
{
    ArrayInsertFloat(xsArrayGetInt(MatrixID, row), column, value);
}

void MatrixInsertVector(int MatrixID = -1, int row = -1, int column = -1, vector value = vector(-1.0, -1.0, -1.0))
{
    ArrayInsertVector(xsArrayGetInt(MatrixID, row), column, value);
}


//  在矩阵中添加一个元素
void MatrixAppendInt(int MatrixID = -1, int row = -1, int value = -1)
{
    ArrayAppendInt(xsArrayGetInt(MatrixID, row), value);
}

void MatrixAppendFloat(int MatrixID = -1, int row = -1, float value = -1.0)
{
    ArrayAppendFloat(xsArrayGetInt(MatrixID, row), value);
}

void MatrixAppendVector(int MatrixID = -1, int row = -1, vector value = vector(-1.0, -1.0, -1.0))
{
    ArrayAppendVector(xsArrayGetInt(MatrixID, row), value);
}


//  在矩阵中删除一个元素
void MatrixRemoveInt(int MatrixID = -1, int row = -1, int column = -1)
{
    ArrayRemoveInt(xsArrayGetInt(MatrixID, row), column);
}

void MatrixRemoveFloat(int MatrixID = -1, int row = -1, int column = -1)
{
    ArrayRemoveFloat(xsArrayGetInt(MatrixID, row), column);
}

void MatrixRemoveVector(int MatrixID = -1, int row = -1, int column = -1)
{
    ArrayRemoveVector(xsArrayGetInt(MatrixID, row), column);
}


//  删除矩阵指定行的头部元素
void MatrixPopFrontInt(int MatrixID = -1, int row = -1)
{
    ArrayPopFrontInt(xsArrayGetInt(MatrixID, row));
}

void MatrixPopFrontFloat(int MatrixID = -1, int row = -1)
{
    ArrayPopFrontFloat(xsArrayGetInt(MatrixID, row));
}

void MatrixPopFrontVector(int MatrixID = -1, int row = -1)
{
    ArrayPopFrontVector(xsArrayGetInt(MatrixID, row));
}


//  删除矩阵指定行的末尾元素
void MatrixPopBackInt(int MatrixID = -1, int row = -1)
{
    ArrayPopBackInt(xsArrayGetInt(MatrixID, row));
}

void MatrixPopBackFloat(int MatrixID = -1, int row = -1)
{
    ArrayPopBackFloat(xsArrayGetInt(MatrixID, row));
}

void MatrixPopBackVector(int MatrixID = -1, int row = -1)
{
    ArrayPopBackVector(xsArrayGetInt(MatrixID, row));
}


//  获取矩阵指定行的长度
int MatrixRowLength(int MatrixID = -1, int row = -1)
{
    return (xsArrayGetSize(xsArrayGetInt(MatrixID, row)));
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

int MergeArrayFloat(int ArrayID1 = -1, int ArrayID2 = -1)
{
    int i = 0;
    int ResultArray = 0;
    ResultArray = NewArrayFloat();
    for (i = 0; < xsArrayGetSize(ArrayID1))
        ArrayAppendFloat(ResultArray, xsArrayGetFloat(ArrayID1, i));
    for (i = 0; < xsArrayGetSize(ArrayID2))
        ArrayAppendFloat(ResultArray, xsArrayGetFloat(ArrayID2, i));
    return (ResultArray);
}

int MergeArrayVector(int ArrayID1 = -1, int ArrayID2 = -1)
{
    int i = 0;
    int ResultArray = 0;
    ResultArray = NewArrayVector();
    for (i = 0; < xsArrayGetSize(ArrayID1))
        ArrayAppendVector(ResultArray, xsArrayGetVector(ArrayID1, i));
    for (i = 0; < xsArrayGetSize(ArrayID2))
        ArrayAppendVector(ResultArray, xsArrayGetVector(ArrayID2, i));
    return (ResultArray);
}