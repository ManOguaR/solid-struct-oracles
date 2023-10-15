// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./baseMATICTicker.sol";

contract TickerMATICUSDT is BaseMATICTokenTicker {
    address private constant TETHER_TOKEN = 0xc2132D05D31c914a87C6611C10748AEb04B58e8F;
    
    constructor(address inPublisher)
    BaseMATICTokenTicker(inPublisher, TETHER_TOKEN) {
        
    }
}