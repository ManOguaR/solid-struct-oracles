// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./baseMATICTicker.sol";

contract TickerMATICETH is BaseMATICCurrencyTicker {
    constructor(address inPublisher)
    BaseMATICCurrencyTicker(inPublisher, "ETH") {
        
    }
}
