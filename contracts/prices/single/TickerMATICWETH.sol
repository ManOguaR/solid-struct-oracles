// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./baseMATICTicker.sol";

contract TickerMATICWETH is BaseMATICTokenTicker {
    address private constant WRAPPED_ETHER_TOKEN = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;

    constructor(address inPublisher)
    BaseMATICTokenTicker(inPublisher, WRAPPED_ETHER_TOKEN) {
        
    }
}