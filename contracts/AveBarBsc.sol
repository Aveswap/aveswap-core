// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./farm/token/BEP20/BEP20.sol";

// AveBar is the coolest bar in town. You come in with some Ave, and leave with more! The longer you stay, the more Ave you get.
//
// This contract handles swapping to and from xAve, Aveswap's staking token.
contract AveBar is BEP20("Staked Ave", "xAve"){
    using SafeMath for uint256;
    IBEP20 public ave;

    // Define the Ave token contract
    constructor(IBEP20 _ave) public {
        ave = _ave;
    }

    // Enter the bar. Ave some AVEs. Earn some shares.
    // Locks Ave and mints xAve
    function enter(uint256 _amount) public {
        // Gets the amount of Ave locked in the contract
        uint256 totalAve = ave.balanceOf(address(this));
        // Gets the amount of xAve in existence
        uint256 totalShares = totalSupply();
        // If no xAve exists, mint it 1:1 to the amount put in
        if (totalShares == 0 || totalAve == 0) {
            _mint(msg.sender, _amount);
        } 
        // Calculate and mint the amount of xAve the Ave is worth. The ratio will change overtime, as xAve is burned/minted and Ave deposited + gained from fees / withdrawn.
        else {
            uint256 what = _amount.mul(totalShares).div(totalAve);
            _mint(msg.sender, what);
        }
        // Lock the Ave in the contract
        ave.transferFrom(msg.sender, address(this), _amount);
    }

    // Leave the bar. Claim back your AVEs.
    // Unlocks the staked + gained Ave and burns xAve
    function leave(uint256 _share) public {
        // Gets the amount of xAve in existence
        uint256 totalShares = totalSupply();
        // Calculates the amount of Ave the xAve is worth
        uint256 what = _share.mul(ave.balanceOf(address(this))).div(totalShares);
        _burn(msg.sender, _share);
        ave.transfer(msg.sender, what);
    }
}
