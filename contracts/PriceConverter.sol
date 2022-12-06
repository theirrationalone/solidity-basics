// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        // 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e goerli testnet contract address
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (, int256 latestPrice,,,) = priceFeed.latestRoundData();

        return uint256 (latestPrice * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 latestEthUsdPrice = getPrice();

        uint256 latestConvertedPrice = (latestEthUsdPrice * ethAmount) / 1e18;

        return latestConvertedPrice;
    }
}
