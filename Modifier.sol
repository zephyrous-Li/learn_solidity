// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

address owner //定义owner变量

constructor() {
    owner = msg.sender; //将部署合约的地址赋值给owner
}
// 定义modifier
modifier onlyOwner(){
    require(msg.sender == owner);
    _;
}
// 调用changeOwner函数，需要调用者拥有合约的所有权，只有owner地址运行这个函数，并改变owner
function changeOwner(address _newOwner) public onlyOwner {
    owner = _newOwner;
}