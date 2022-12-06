// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error FundMe__notOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 constant MINIMUM_USD = 50 * 1e18;
    address[] public s_funders;
    mapping(address => uint256) public s_funderToAmountFunded;

    address immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }
    
    fallback() external payable {
        fund();
    }
    
    receive() external payable {
        fund();
    }

    modifier only_owner() {
        if (i_owner != msg.sender) {
            revert FundMe__notOwner();
        }
        _;
    }

    function fund() public payable {
        // revert is a substitute for require
        require(msg.value.getConversionRate() > MINIMUM_USD, "didn't sent enough!");
        
        s_funders.push(msg.sender);
        s_funderToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public only_owner {
        for (uint256 i = 0; i < s_funders.length; i++) {
            s_funderToAmountFunded[s_funders[i]] = 0;
        }

        s_funders = new address[](0);

        // payable(msg.sender).transfer(address(this).balance); // throws error if gas limit reaches above 2300
        // bool isSuccess = payable(msg.sender).send(address(this).balance); // returns boolean if gas limit reaches above 2300

        // // use all gas or set gas and returns a boolean and data returned by the function (if that function returns any data or value) if called by call method
        (bool isSuccess,) = payable(msg.sender).call{ value: address(this).balance }("");

        // can be altered with revert.
        require(isSuccess, "Withdrawal failed!");
    }
}
