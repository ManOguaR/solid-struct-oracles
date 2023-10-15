// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./baseMATICTicker.sol";

contract TickerMATICDRACO is BaseMATICTokenTicker {
    address private constant DRACO_TOKEN = 0x1005891BbB3A33e08672764F9A4a77A1ebed89E2;

    constructor(address inPublisher)
    BaseMATICTokenTicker(inPublisher, DRACO_TOKEN) {
        
    }
}