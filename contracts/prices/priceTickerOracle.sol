// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../oraclebase.sol";

interface IPriceTickerOracle {
    function getPrice() external view returns (uint256);
    function decimals() external view returns (uint8);
    function description() external view returns (string memory);
    
    function tickerData()
      external
      view
      returns (
        string memory symbol,
        uint256 price,
        uint256 updatedAt
      );
    
    event Updated(uint256 indexed price, uint256 updatedAt);
}

abstract contract PriceTickerOracle is OracleBase, IPriceTickerOracle {
    uint8 private _decimals;
    string private _description;
    uint256 private _price;
    uint256 private _lastPrice;

    constructor(address inPublisher, string memory inDescription)
    OracleBase(inPublisher) {
      _description = inDescription;
      }
  
  function getPrice() public override view onlyRole(SUBSCRIBER_ROLE) returns (uint256) {
    return _price;
  }

  function getLastPrice() public view onlyRole(DEFAULT_ADMIN_ROLE) returns (uint256) {
    return _price;
  }
  
  function decimals() public override view onlyRole(SUBSCRIBER_ROLE) returns (uint8) {
    return _decimals;
  }

  function description() public override view onlyRole(SUBSCRIBER_ROLE) returns (string memory) {
    string memory temp_description = _description;
    return temp_description;
  }

  function tickerData() public override view onlyRole(SUBSCRIBER_ROLE)
    returns (
      string memory symbol,
      uint256 price,
      uint256 updatedAt
    ) {
      string memory temp_description = _description;
      
      return (
        temp_description,
        _price,
        _updatedAt
      );
    }

  function latestTickerData() public view onlyRole(DEFAULT_ADMIN_ROLE)
    returns (
      string memory symbol,
      uint256 price,
      uint256 updatedAt
    ) {
      string memory temp_description = _description;
      
      return (
        temp_description,
        _lastPrice,
        _lastUpdateAt
      );
    }
}