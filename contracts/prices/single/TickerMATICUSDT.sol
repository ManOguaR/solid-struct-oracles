// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../priceTickerOracle.sol";

contract TickerMATICUSD is PriceTickerOracle {
    constructor(address inPublisher)
    PriceTickerOracle(inPublisher, "MATICUSD") {
        
    }
}