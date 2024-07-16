# Solidity 函数知识点

## Solidity 函数基础

```solidity
function <function name>(<parameter types>){internal | external | public | private} [pure|view|payable] [returns (<return types>)]
```

1. parameter types：圆括号内写入函数的参数，即输入到函数的变量类型和名称。
2. {internal|external|public|private}：函数可见性说明符，共有 4 种。

- public：内部和外部均可见。
- private：只能从本合约内部访问，继承的合约也不能使用。
- external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f 是函数名）。
- internal: 只能从合约内部访问，继承的合约可以用。

tips1. 函数可见性说明符没有默认值
tips2. public|private|internal 也可用于修饰状态变量。public 变量会自动生成同名的 getter 函数，用于查询数值。未标明可见性类型的状态变量，默认为 internal。

3. [pure|view|payable]：决定函数权限/功能的关键字。以太坊交易需要支付气费（gas fee）。合约的状态变量存储在链上，gas fee 很贵，如果计算不改变链上状态，就可以不用付 gas。包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的。payable（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH 。Pure 函数既不能读取也不能写入链上的状态变量。view 函数能读取但也不能写入状态变量。

4. [returns ()]：函数返回的变量类型和名称。

## Solidity 函数输出

1. 返回值

- return 用于函数主体中，返回指定的变量。
- returns 跟在函数名后面，用于声明返回的变量类型及变量名。

```solidity
    function retuerMultiple() public pure returns (uint256,bool,uint256[3]memory){
        return (1,true,[uint256(1),2,5]);
    }
```

2. 命名式返回
   我们可以在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 return。

```
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
// 命名式返回，依然支持return
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```

3. 结构式赋值
   读取所有返回值：声明变量，然后将要赋值的变量用,隔开，按顺序排列。

```
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```
