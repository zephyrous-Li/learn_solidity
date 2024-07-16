# Solidity中的变量类型


- 值类型 
- 引用类型  
- 映射类型

### 值类型

#### 1. 布尔型

   ``` Solidity
bool public _bool = true   //  true or false
   ```
##### 运算符：
- !   
- &&  
- ||  
- ==  
- !=

#### 2. 整型
   ``` Solidity
int public _int = -1  //整数包括负数
uint public _uint = 1   // 正整数
uint256 public _uint256= 20240715   // 256位正整数
   ```

##### 运算符：
1. 比较运算符
  - <= or >=
  - < or >
  - == or !=
2. 算数运算符 
  - + or - or * or /
  - %(取余) or **(幂运算)

#### 3.地址类型

1. 普通地址： 存储一个 20 字节的值（以太坊地址的大小）。
2. payable address: 比普通地址多了 `transfer` 和 `send` 两个成员方法，用于接收转账。
   - transfer方法：下列代码为合约向addr转账1wei

   ``` Solidity
   //地址
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71
address payable public _address1 = payable(_address)  // payable address，可以转账、查余额
//地址类型的成员
uint256 public balance = _address.balance   // 256位正整数
   ```

#### 4.定长字节数组

1. 定长字节数组：属于值类型，数组长度在声明之后不能改变。根据字节数组长度分为 `bytes1`, `bytes8`,`bytes32` 等类型，最多存储32 bytes数据
2. 不定长字节数组: 属于引用类型，数组长度在声明之后可以改变，包括 bytes 等。

   ``` Solidity
   //固定长度的字节数组
bytes32  public _bytes32 = "MiniSolidity"; 
bytes1 public _byte = __bytes32[0]
   ```
在上述代码中，MiniSolidity 变量以字节的方式存储进变量 _byte32。如果把它转换成 16 进制，就是：0x4d696e69536f6c69646974790000000000000000000000000000000000000000
_byte 变量的值为 _byte32 的第一个字节，即 0x4d。


#### 5.枚举（enum）

枚举（enum）是 Solidity 中用户定义的数据类型。它主要用于为 uint 分配名称，使程序易于阅读和维护。它与 C 语言 中的 enum 类似，使用名称来代替从 0 开始的 uint：

   ``` Solidity
// 用enum 将uint 0,1,2表示为Buy，Hold，Sell
enum ActionSet {Buy,Hold,Sell }
//创建enum变量 action
ActionSet action =ActionSet.Buy
   ```

   枚举可以显式地和 uint 相互转换，并会检查转换的正整数是否在枚举的长度内，否则会报错：

   ``` Solidity
// enum可以和uint显式的转换
function enumToUint() external view returns(uint){
    return uint(action);
}
   ```









