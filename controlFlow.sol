// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ControlFlow {
    // if-else函数
    function ifElseTest(uint256 _number) public pure returns (bool) {
        if (_number == 0) {
            return (true);
        } else {
            return (false);
        }
    }
    // for循环函数
    function forLoopTest() public pure returns (uint256) {
        uint256 sum = 0;
        for (uint i = 0; i < 5; i++) {
            sum += i;
        }
        return sum;
    }
    // while循环函数
    function whileTest() public pure returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;
        while (i < 10) {
            sum += i;
            i++;
        }
        return sum;
    }
    // do-while循环函数
    function doWhileTest() public pure returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;
        do {
            sum += i;
            i++;
        } while (i < 10);
        return sum;
    }
    //三元运算符
    function ternaryTest(uint256 x, uint256 y) public pure returns (uint256) {
        return x > y ? x : y;
    }
    // continue关键字
    function continueTest() public pure returns (uint256) {
        uint256 sum = 0;
        for (uint i = 0; i < 10; i++) {
            if (i == 5) {
                continue;
            }
            sum += i;
        }
        return sum;
    }
    //break关键字
    function breakTest() public pure returns (uint256) {
        uint256 sum = 0;
        for (uint i = 0; i < 10; i++) {
            if (i == 5) {
                break;
            }
            sum += i;
        }
        return sum;
    }
    // 插入排序算法
    function insertionSort(uint256[] memory arr) public pure returns (uint256[] memory) {

        for (uint i = 1; i < arr.length; i++) {
            uint256 key = arr[i];
            // uint取到负值会报错，所以这里不是常规的j=i-1而是j=1
            uint j = i ;
           while (j >= 1 && arr[j-1] > key) {
                arr[j] = arr[j-1];
                j =j-1;
            }
            arr[j ] = key;
        }
        return arr;
    }
}
