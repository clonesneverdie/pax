// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/access/Ownable.sol";
import "../openzeppelin/contracts/utils/Context.sol";
import "../openzeppelin/contracts/utils/math/SafeMath.sol";
import "../openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "../interfaces/IPax.sol";

contract Pax is Context, ERC20, ERC20Burnable, ERC20Snapshot, Ownable {
	using SafeMath for uint256;

	constructor() ERC20("CND Pax", "PAX") {
		_mint(_msgSender(), INITIAL_SUPPLY);
	}

	address public emitter;
	address public whitehole;
	address public buyback;
	uint256 public INITIAL_SUPPLY = 23773339822368706954660494;

	modifier onlyEmitter() {
		require(_msgSender() == emitter);
		_;
	}

	function snapshot() public onlyOwner {
		_snapshot();
	}

	function mint(address to, uint256 amount) public onlyEmitter {
		_mint(to, amount);
	}

	function setEmitter(address _emitter) external onlyOwner {
		emitter = _emitter;
	}

	function setWhitehole(address _whitehole) external onlyOwner {
		whitehole = _whitehole;
	}

	function setBuybackFund(address _buyback) external onlyOwner {
		buyback = _buyback;
	}

	function burn(uint256 amount) public override {
		uint256 toFund = amount.mul(5).div(1000);
		transfer(whitehole, toFund);
		transfer(buyback, toFund);
		_burn(_msgSender(), amount - toFund.mul(2));
	}

	function burnFrom(address account, uint256 amount) public override {
		uint256 toFund = amount.mul(5).div(1000);
		transferFrom(account, whitehole, toFund);
		transferFrom(account, buyback, toFund);
		_burn(account, amount - toFund.mul(2));
	}

	// The following functions are overrides required by Solidity.

	function _beforeTokenTransfer(
		address from,
		address to,
		uint256 amount
	) internal override(ERC20, ERC20Snapshot) {
		super._beforeTokenTransfer(from, to, amount);
	}
}
