// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/utils/Context.sol";
import "../openzeppelin/contracts/utils/math/SafeMath.sol";
import "../openzeppelin/contracts/utils/math/SignedSafeMath.sol";
import "../openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/IPaxEmitter.sol";
import "../interfaces/IPax.sol";
import "../interfaces/IERC20StakingPool.sol";

contract ERC20StakingPool is Context, IERC20StakingPool {
	using SafeMath for uint256;
  using SignedSafeMath for int256;

	IPaxEmitter public paxEmitter;
	IPax public pax;
	uint256 public pid;
	IERC20 public token;

	constructor(
		IPaxEmitter _paxEmitter,
		uint256 _pid,
		IERC20 _token
	) {
		paxEmitter = _paxEmitter;
		pax = _paxEmitter.pax();
		pid = _pid;
		token = _token;
	}

	uint256 internal currentBalance = 0;
	uint256 public totalShares = 0;
	mapping(address => uint256) public shares;

	uint256 internal constant pointsMultiplier = 2**128;
	uint256 internal pointsPerShare = 0;
	mapping(address => int256) internal pointsCorrection;
	mapping(address => uint256) internal claimed;

	function updateBalance() internal {
		if (totalShares > 0) {
			paxEmitter.updatePool(pid);
			uint256 balance = pax.balanceOf(address(this));
			uint256 value = balance.sub(currentBalance);
			if (value > 0) {
				pointsPerShare = pointsPerShare.add(value.mul(pointsMultiplier).div(totalShares));
				emit Distribute(_msgSender(), value);
			}
			currentBalance = balance;
		} else {
			paxEmitter.updatePool(pid);
			uint256 balance = pax.balanceOf(address(this));
			uint256 value = balance.sub(currentBalance);
			if (value > 0) pax.burn(value);
		}
	}

	function claimedOf(address owner) public view returns (uint256) {
		return claimed[owner];
	}

	function accumulativeOf(address owner) public view returns (uint256) {
		uint256 _pointsPerShare = pointsPerShare;
		if (totalShares > 0) {
			uint256 balance = paxEmitter.pendingPax(pid).add(pax.balanceOf(address(this)));
			uint256 value = balance.sub(currentBalance);
			if (value > 0) {
				_pointsPerShare = _pointsPerShare.add(value.mul(pointsMultiplier).div(totalShares));
			}
			return uint256(int256(_pointsPerShare.mul(shares[owner])).add(pointsCorrection[owner])).div(pointsMultiplier);
		}
		return 0;
	}

	function claimableOf(address owner) external view returns (uint256) {
		return accumulativeOf(owner).sub(claimed[owner]);
	}

	function _accumulativeOf(address owner) internal view returns (uint256) {
		return uint256(int256(pointsPerShare.mul(shares[owner])).add(pointsCorrection[owner])).div(pointsMultiplier);
	}

	function _claimableOf(address owner) internal view returns (uint256) {
		return _accumulativeOf(owner).sub(claimed[owner]);
	}

	function claim() external {
		updateBalance();
		uint256 claimable = _claimableOf(_msgSender());
		if (claimable > 0) {
			claimed[_msgSender()] = claimed[_msgSender()].add(claimable);
			emit Claim(_msgSender(), claimable);
			pax.transfer(_msgSender(), claimable);
			currentBalance = currentBalance.sub(claimable);
		}
	}

	function _addShare(uint256 share) internal {
		updateBalance();
		totalShares = totalShares.add(share);
		shares[_msgSender()] = shares[_msgSender()].add(share);
		pointsCorrection[_msgSender()] = pointsCorrection[_msgSender()].sub(int256(pointsPerShare.mul(share)));
	}

	function _subShare(uint256 share) internal {
		updateBalance();
		totalShares = totalShares.sub(share);
		shares[_msgSender()] = shares[_msgSender()].sub(share);
		pointsCorrection[_msgSender()] = pointsCorrection[_msgSender()].add(int256(pointsPerShare.mul(share)));
	}

	function stake(uint256 amount) external {
		_addShare(amount);
		token.transferFrom(_msgSender(), address(this), amount);
		emit Stake(_msgSender(), amount);
	}

	function unstake(uint256 amount) external {
		_subShare(amount);
		token.transfer(_msgSender(), amount);
		emit Unstake(_msgSender(), amount);
	}
}
