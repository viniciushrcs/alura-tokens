// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "@lib/forge/src/Test.sol";
import "../src/BankToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface CheatCodes {
    function prank(address) external;
    // Sets msg.sender to the specified address for the next call. “The next call” includes static calls as well, but not calls to the cheat code address
    function startPrank(address) external;
    // Sets msg.sender for all subsequent calls until stopPrank is called.
    function stopPrank() external;
    // Stops the effect of startPrank or prank.
    function expectRevert() external;
    // Sets the next call to expect a revert.
}

contract BankTokenTest is Test {
    BankToken private btk; // Instância do token BankToken
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS); // Interface para interações de teste avançadas

    address defaultOwner = address(1); // Endereço do proprietário padrão
    address minter = address(3); // Endereço do minter
    uint256 initialSupply = 1000 * 1e18; // Suprimento inicial de 1000 tokens

    function setUp() public {
        cheats.startPrank(defaultOwner); // Inicia a simulação como o proprietário padrão
        btk = new BankToken(defaultOwner, initialSupply); // Cria uma nova instância do BankToken
        cheats.stopPrank(); // Para a simulação
    }

    function testInitialSetup() public {
        assertEq(btk.totalSupply(), initialSupply, "Initial supply should match"); // Verifica o suprimento inicial
        assertEq(btk.owner(), defaultOwner, "Default owner should match"); // Verifica se o proprietário é o endereço esperado
    }

    function testMintFunctionality() public {
        address recipient = address(0x5); // Endereço do destinatário
        uint256 mintAmount = 500 * 1e18; // Quantidade de tokens a serem mintados

        cheats.prank(defaultOwner); // Simula a ação como o proprietário
        btk.mint(recipient, mintAmount); // Minta os tokens
        uint256 newBalance = btk.balanceOf(recipient); // Verifica o saldo do destinatário

        // Verifica se os tokens foram corretamente mintados para o destinatário
        assertEq(newBalance, mintAmount, "Recipient's balance should be increased by the mint amount");

        // Verifica se o suprimento total foi atualizado corretamente
        uint256 newSupply = btk.totalSupply();
        assertEq(newSupply, initialSupply + mintAmount, "Total supply should be increased by the mint amount");
    }

    function testBurnFunctionality() public {
        address tokenHolder = address(0x123); // Endereço do detentor do token
        uint256 burnAmount = 100 * 1e18; // Quantidade de tokens a serem queimados

        cheats.prank(defaultOwner); // Simula a ação como o proprietário
        btk.mint(tokenHolder, burnAmount); // Minta tokens para o detentor

        uint256 initialTotalSupply = btk.totalSupply(); // Suprimento total inicial
        uint256 initialHolderBalance = btk.balanceOf(tokenHolder); // Saldo inicial do detentor

        cheats.prank(tokenHolder); // Simula a ação como o detentor do token
        btk.burn(burnAmount); // Queima os tokens

        uint256 finalHolderBalance = btk.balanceOf(tokenHolder); // Saldo final do detentor
        uint256 finalTotalSupply = btk.totalSupply(); // Suprimento total final

        assertEq(finalHolderBalance, initialHolderBalance - burnAmount, "Token holder's balance should be decreased by the burn amount");
        assertEq(finalTotalSupply, initialTotalSupply - burnAmount, "Total supply should be decreased by the burn amount");
    }

     function testUnauthorizedMint() public {
        address unauthorizedAddress = address(0x456); // Endereço não autorizado
        address recipient = address(0x789); // Endereço do destinatário
        uint256 mintAmount = 500 * 1e18; // Quantidade de tokens a serem mintados

        cheats.startPrank(unauthorizedAddress); // Simula a ação como o endereço não autorizado
        cheats.expectRevert(); // Espera que a próxima transação reverta
        btk.mint(recipient, mintAmount); // Tenta mintar os tokens
        cheats.stopPrank(); // Para a simulação

        // Verifica se a transação realmente reverteu e nenhum token foi mintado
        uint256 newBalance = btk.balanceOf(recipient); // Verifica o saldo do destinatário
        assertEq(newBalance, 0, "Recipient's balance should remain unchanged");
    }

    function testTransferFunctionality() public {
        address sender = defaultOwner; // Endereço do remetente (proprietário padrão)
        address recipient = address(0x5); // Endereço do destinatário
        uint256 transferAmount = 100 * 1e18; // Quantidade de tokens a serem transferidos

        cheats.startPrank(sender); // Simula a ação como o remetente
        btk.transfer(recipient, transferAmount); // Realiza a transferência
        cheats.stopPrank(); // Para a simulação

        // Verifica o saldo do remetente após a transferência
        uint256 senderFinalBalance = btk.balanceOf(sender);
        assertEq(senderFinalBalance, initialSupply - transferAmount, "Sender's balance should be decreased by the transfer amount");

        // Verifica o saldo do destinatário após a transferência
        uint256 recipientFinalBalance = btk.balanceOf(recipient);
        assertEq(recipientFinalBalance, transferAmount, "Recipient's balance should be increased by the transfer amount");
    }

}
