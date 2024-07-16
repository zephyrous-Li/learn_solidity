// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract FunctionTyps {
    uint256 public number = 5;
    //external可见性标识
    // 默认+1函数
    function add() external {
        number = number + 1;
    }

    // pure标记函数
    function addPure(
        uint256 _number
    ) external pure returns (uint256 new_number) {
        new_number = _number + 1;
    }

    // view标记函数
    function addView() external view returns (uint256 new_number) {
        new_number = number + 1;
    }
    // internal标识符
    // 内部函数
    function minus() internal {
        number = number - 1;
    }
    // 合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }
    // payable
    // 给智能合约支付eth的函数
    function minusPayable() external payable returns (uint256 balance) {
        minus();
        balance = address(this).balance;
    }
}
