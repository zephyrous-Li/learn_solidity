// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
// 合约继承
contract Yeye {
event Log(string msg);
function hip() public virtual {
emit Log("Yeye");
}
function pop() public virtual {
emit Log("Yeye");
}
function yeye() public virtual {
emit Log("Yeye");
}
}
// 简单继承
contract Baba is Yeye {
// 继承两个function: hip()和pop()，输出改为Baba。
function hip() public virtual  override {
emit Log("Baba");
}
function pop() public virtual  override {
emit Log("Baba");
}
function baba() public virtual {
emit Log("Baba");
}
}

// 多重继承
// 继承时要按辈分最高到最低的顺序排。
// 比如我们写一个Erzi合约，继承Yeye合约和Baba合约，那么就要写成contract Erzi is Yeye, Baba，而不能写成contract Erzi is Baba, Yeye，不然就会报错。
// 如果某一个函数在多个继承的合约里都存在，比如例子中的hip()和pop()，在子合约里必须重写，不然会报错。
// 重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)。
contract Erzi is Yeye, Baba {
// 继承三个function: hip()、pop()和yeye()，输出改为Erzi。
function hip() public virtual  override (Yeye, Baba) {
emit Log("Erzi");
}
function pop() public virtual  override (Yeye, Baba) {
emit Log("Erzi");
}

}
{"mqtt":{"addr":"139.196.22.208:1883","user":"LE055_116","pass":"de4bac93ef2cc6ffb0d33874","debug": true},"mqtts": [{"addr":"139.196.20.116:1883","id":"LE055_116","user":"LE055_116_d02c5aac2496814f722895d1","pass":"LE055_116_d02c5aac2496814f722895d1"}],"modbus": {"rtu": "addr=/dev/ttymxc2&slaveId=3&baudrate=9600&databits=8&stopbits=1&parity=NONE", "tcp": "port=502&slaveId=3"}}

{"mqtt":{"addr":"139.196.22.208:1883","user":"LE055_180","pass":"3aad75cb234995a5f2c63fd6","debug": true},"mqtts": [{"addr":"139.196.20.116:1883","id":"LE055_180","user":"LE055_180_3aad75cb234995a5f2c63fd6","pass":"LE055_180_3aad75cb234995a5f2c63fd6"}]} 
LE055_180_3aad75cb234995a5f2c63fd6