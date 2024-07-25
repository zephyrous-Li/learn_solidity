# Solidity中的引用类型
引用类型(Reference Type)：包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要声明数据存储的位置

## 数据存储位置
不同存储位置的gas成本不同。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少。大致用法：
有三类：
- storage ：合约里的状态变量，存储在链上。
- memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链，如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
- calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。例如：
```Solidity
function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
    //参数为calldata数组，不能被修改
    // _x[0] = 0 //这样修改会报错
    return(_x);
}
```
## 数据位置和赋值规则
1. 赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步
- storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。例子:
```solidity
uint[] x = [1,2,3]; // 状态变量：数组 x

function fStorage() public{
    //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
    uint[] storage xStorage = x;
    xStorage[0] = 100;
}
```
- memory赋值给memory，会创建引用，改变新变量会影响原变量。
- 其他情况下，赋值创建的是本体的副本，即对二者之一的修改，并不会同步到另一方
## 变量的作用域
- 状态变量（state variable）:数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高,状态变量在合约内、函数外声明：
```solidity
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
}
//可以在函数内改变状态变量的值
function foo() external{
    // 可以在函数里更改状态变量的值
    x = 5;
    y = 2;
    z = "0xAA";
}
```
- 局部变量（local variable）：局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。局部变量在函数内声明：
```solidity
function bar() external pure returns(uint){
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return(zz);
}
```
- 全局变量(global variable)：全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用：
 ```solidity
function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return(sender, blockNum, data);
}
```
常用局部变量：msg.sender，block.number和msg.data 他们分别代表请求发起地址，当前区块高度，和请求数据。
完整列表查看[链接](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)
- 以太单位与时间单位
  - 以太单位
Solidity中不存在小数点，以0代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易。 
     - wei: 1
     - gwei: 1e9= 1000000000
     - ether: 1e18= 1000000000000000000
  - 时间单位
可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。因此，时间单位在Solidity中是一个重要的概念，有助于提高合约的可读性和可维护性。
     - seconds: 1
     - minutes: 60 seconds= 60
     - hours: 60 minutes = 3600
     - days: 24 hours = 86400
     - weeks: 7 days = 604800


## 数组 array
 ```solidity
 // 固定长度 Array
uint[8] array1;
bytes1[5] array2;
address[100] array3;
// 可变长度 Array
uint[] array4;
bytes1[] array5;
address[] array6;
bytes array7;
// bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas
```
- 对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变
```solidity
// 第一个元素指定了是uint类型了，里面每一个元素的type都以第一个元素为准
// memory动态数组
uint[] memory array8 = new uint[](5);
bytes memory array9 = new bytes(9);
// 如果创建的是动态数组，你需要一个一个元素的赋值。
uint[] memory x = new uint[](3);
x[0] = 1;
x[1] = 3;
x[2] = 4;
```
  - length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的
  - push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
  - push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。
  - pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。
## 结构体 struct
Solidity支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。
```solidity
// 结构体
struct Student{
    uint256 id;
    uint256 score; 
}

Student student; // 初始一个student结构体
// 赋值
// 方法1:在函数中创建一个storage的struct引用
function initStudent1() external{
    Student storage _student = student; // assign a copy of student
    _student.id = 11;
    _student.score = 100;
}
// 方法2:直接引用状态变量的struct
function initStudent2() external{
    student.id = 1;
    student.score = 80;
}
// 方法3:构造函数式
function initStudent3() external {
    student = Student(3, 90);
}
// 方法4:key value
function initStudent4() external {
    student = Student({id: 4, score: 60});
}

```


