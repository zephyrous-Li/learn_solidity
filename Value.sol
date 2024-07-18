// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract InitialValue {
    // Value Types
    bool public _bool; //false
    string public _string; //""
    int256 public _int; //0
    uint256 public _uint; //0
    address public _address; //0x00000000000000000000000000000
    enum ActionSet {
        Buy,
        Hold,
        Sell
    }
    ActionSet public _enum; // 0

    function fi() internal {} //internal空白函数

    function fe() external {} //external空白函数

    // Reference Types

    uint[8] public _staticArray;  //所有成员为默认的静态数组
    uint[] public _dynamicArray;   // '[]'
    mapping(uint=>address)public  _mapping;  //所有成员为默认的mapping
    struct Student {
        uint256 id;
        uint256 score;
    }
    Student public student;

    // 利用constructor初始化immutable变量，因此可以利用
    // immutable变量可以在constructor里初始化，之后不能改变
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;
     constructor(){
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_NUM = 1118;
        IMMUTABLE_TEST = test();
     }
     function test() public pure returns(uint256){
        uint256 what = 9;
        return (what);
     }

}
