// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenVault is Ownable {
    // Event to log deposits
    event Deposit(address indexed from, uint256 amount);
    // Event to log withdrawals
    event Withdraw(address indexed to, uint256 amount);

    constructor() Ownable(msg.sender) {}

    // Function to deposit tokens into the vault
    function depositTokens(address tokenAddress, uint256 amount) public {
        bool isTokenDepositOk = IERC20(tokenAddress).transferFrom(
            msg.sender,
            address(this),
            amount
        );
        require(isTokenDepositOk, "Token transfer failed");

        emit Deposit(msg.sender, amount);
    }

    // Only owner can withdraw tokens
    function withdrawTokens(address tokenAddress, address to, uint256 amount) public onlyOwner {
        bool isTokenWithdrawOk = IERC20(tokenAddress).transfer(to, amount);
        require(isTokenWithdrawOk, "Transfer failed");

        emit Withdraw(to, amount);
    }
}
