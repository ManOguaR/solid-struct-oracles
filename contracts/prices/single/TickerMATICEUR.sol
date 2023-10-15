// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./baseMATICTicker.sol";

contract TickerMATICEUR is BaseMATICCurrencyTicker {
    constructor(address inPublisher)
    BaseMATICCurrencyTicker(inPublisher, "EUR") {
        
    }
}