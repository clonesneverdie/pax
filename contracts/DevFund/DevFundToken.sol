// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DevFundToken is ERC20 {
	constructor() ERC20("CND Dev Fund Token", "CNDDEV") {
		_mint(msg.sender, 100 * 1e18);
	}
}
