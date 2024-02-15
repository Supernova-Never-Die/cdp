// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDC is ERC20("USD Coin", "USDC") {
    // TODO: test-purpose only
    function mint(address account_, uint256 amount_) public payable {
        _mint(account_, amount_);
    }
}
