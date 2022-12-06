// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    uint8 public safeMathVar = 0;
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }

    function unsafeMath() public {
        unchecked {
            safeMathVar += 50;
        }
    }

    function safeMath() public {
        safeMathVar += 50;
    }
}