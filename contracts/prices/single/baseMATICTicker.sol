// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../priceTickerOracle.sol";

abstract contract BaseMATICCurrencyTicker is PriceTickerOracle {
    address private constant MATIC_TOKEN = 0x0000000000000000000000000000000000001010;

    constructor(address inPublisher, string memory inPair)
    PriceTickerOracle(inPublisher, MATIC_TOKEN, inPair) {

    }
}

abstract contract BaseMATICTokenTicker is PriceTickerTokensOracle {
    address private constant MATIC_TOKEN = 0x0000000000000000000000000000000000001010;

    constructor(address inPublisher, address inPairToken)
    PriceTickerTokensOracle(inPublisher, MATIC_TOKEN, inPairToken) {

    }
}