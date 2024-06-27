// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


import "./base.sol";


contract Derived is Base {
   bool public isDataUpdated;


   constructor(uint _initialData) Base(_initialData) {
       isDataUpdated = false; 
   }


   function setData(uint _data) public override {
       super.setData(_data); 
       isDataUpdated = true; 
   }


   function resetUpdateStatus() public {
       isDataUpdated = false;
   }
}
