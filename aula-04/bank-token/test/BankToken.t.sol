// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "@lib/forge/src/Test.sol";
import "../src/BankToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// Arrange, Act, Assert

interface CheatCodes {
    function startPrank(address) external;
    function stopPrank() external;
    function expectRevert() external;
}

contract BankTokenTest is Test {
    BankToken private btk; 
    CheatCodes cheats = CheatCodes(VM_ADDRESS); 

    address defaultOwner = address(1); 
    address minter = address(3); 
    uint256 initialSupply = 1000 * 1e18; 

    function setUp() public {
        cheats.startPrank(defaultOwner); 
        btk = new BankToken(defaultOwner, initialSupply); 
        cheats.stopPrank();
    }

    function testInitialSetup() public view {
        assertEq(btk.totalSupply(), initialSupply, "Initial supply should match"); 
        assertEq(btk.owner(), defaultOwner, "Default owner should match"); 
    }

    function testMintFunctionality() public {
        // Arrange
        address recipient = address(0x5); 
        uint256 mintAmount = 500 * 1e18; 

        // Act
        cheats.startPrank(defaultOwner); 
        btk.mint(recipient, mintAmount); 
        uint256 newBalance = btk.balanceOf(recipient); 
        cheats.stopPrank();

        // Assert
        assertEq(newBalance, mintAmount, "Recipient's balance should be increased by the mint amount");
        uint256 newSupply = btk.totalSupply();
        assertEq(newSupply, initialSupply + mintAmount, "Total supply should be increased by the mint amount");
    }

     function testUnauthorizedMint() public {
        // Arrange
        address unauthorizedAddress = address(0x456); 
        address recipient = address(0x789); 
        uint256 mintAmount = 500 * 1e18; 

        // Act
        cheats.startPrank(unauthorizedAddress); 
        cheats.expectRevert(); 
        btk.mint(recipient, mintAmount); 
        cheats.stopPrank(); 
        uint256 newBalance = btk.balanceOf(recipient);

        // Assert
        assertEq(newBalance, 0, "Recipient's balance should remain unchanged");
    }

    function testTransferFunctionality() public {
        // Arrange
        address sender = defaultOwner; 
        address recipient = address(0x5); 
        uint256 transferAmount = 100 * 1e18; 

        // Act
        cheats.startPrank(sender); 
        btk.transfer(recipient, transferAmount);
        cheats.stopPrank(); 
        uint256 senderFinalBalance = btk.balanceOf(sender);
        uint256 recipientFinalBalance = btk.balanceOf(recipient);

        // Assert
        assertEq(senderFinalBalance, initialSupply - transferAmount, "Sender's balance should be decreased by the transfer amount");
        assertEq(recipientFinalBalance, transferAmount, "Recipient's balance should be increased by the transfer amount");
    }

}
