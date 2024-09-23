// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract BasicFrame {
    // 函数重载
    function saySomething() public pure returns (string memory) {
        return ("Nothing");
    }

    function saySomething(string memory something)
        public
        pure
        returns (string memory)
    {
        return (something);
    }

    // 实参匹配（Argument Matching）

    // 当调用f(50)时由于 50 可以同时匹配 uint8（0 到 255） 和 uint256 类型，Solidity 编译器将检查两个函数的定义，看哪一个更具体。
    // 在这种情况下，由于 50 在 uint8 的有效范围内（0 到 255），它也符合 uint8 类型的要求，因此存在两种可能的匹配。
    // 然而，Solidity 编译器会优先选择更具体的类型。在这种情况下，uint8 类型比 uint256 更具体，因为 uint8 的范围更小且更精确地匹配了实际传递的值。
    function f(uint8 _in) public pure returns (uint8 out) {
        out = _in;
    }

    function f(uint256 _in) public pure returns (uint256 out) {
        out = _in;
    }
    // 修饰器不能像函数一样重载 你不能定义两个同名的修饰器，即使它们的参数列表不同
}
