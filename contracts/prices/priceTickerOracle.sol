// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../oraclebase.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IPriceTickerOracle {
    function getPrice() external view returns (uint256);
    function decimals() external view returns (uint8);
    function description() external view returns (string memory);
    
    function getTokens()
      external
      view
      returns (
        address base,
        address pair
      );

    function getBaseToken() external view returns (address);
    function getPairToken() external view returns (address);

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
    address private _baseToken;
    uint8 private _decimals;
    uint256 private _price;
    uint256 private _lastPrice;
    string internal _description;

    constructor(address inPublisher, address inBaseToken, string memory pairString)
    OracleBase(inPublisher) {
      require(inBaseToken != address(0), "PriceTickerOracle: inBaseToken is the zero address.");
      _baseToken = inBaseToken;
      string memory base = ERC20(_baseToken).symbol();
      _description = string(abi.encodePacked(base, pairString));

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
    
    function getTokens() public virtual override view onlyRole(SUBSCRIBER_ROLE)
      returns (
        address base,
        address pair
      ) {
        return (_baseToken, address(0));
    }

    function getBaseToken() public override view onlyRole(SUBSCRIBER_ROLE) returns (address) {
      return _baseToken;
    }

    function updateBaseToken(address inBaseToken) public onlyRole(DEFAULT_ADMIN_ROLE) {
      require(inBaseToken != address(0), "PriceTickerOracle: inBaseToken is the zero address.");
      _baseToken = inBaseToken;
    }

    function getPairToken() public virtual override view onlyRole(SUBSCRIBER_ROLE) returns (address) {
      return address(0);
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

abstract contract PriceTickerTokensOracle is PriceTickerOracle {
    address private _pairToken;

    constructor(address inPublisher, address inBaseToken, address inPairToken)
    PriceTickerOracle(inPublisher, inBaseToken, "") {
      require(inPairToken != address(0), "PriceTickerOracle: inPairToken is the zero address.");
      require(inBaseToken != inPairToken, "PriceTickerOracle: inBaseToken and inPairToken are the same address.");
      _pairToken = inPairToken;
      string memory pair = ERC20(_pairToken).symbol();
      _description = string(abi.encodePacked(_description, pair));
    }
    
    function getTokens() public override view onlyRole(SUBSCRIBER_ROLE)
      returns (
        address base,
        address pair
      ) {
        return (getBaseToken(), _pairToken);
    }

    function updateTokens(address inBaseToken, address inPairToken) public onlyRole(DEFAULT_ADMIN_ROLE) {
      require(inBaseToken != address(0), "PriceTickerOracle: inBaseToken is the zero address.");
      require(inPairToken != address(0), "PriceTickerOracle: inPairToken is the zero address.");
      require(inBaseToken != inPairToken, "PriceTickerOracle: inBaseToken and inPairToken are the same address.");
      updateBaseToken(inBaseToken);
      _pairToken = inPairToken;
    }

    function getPairToken() public override view onlyRole(SUBSCRIBER_ROLE) returns (address) {
      return _pairToken;
    }
    
    function updatePairToken(address inPairToken) public onlyRole(DEFAULT_ADMIN_ROLE) {
      require(inPairToken != address(0), "PriceTickerOracle: inPairToken is the zero address.");
      require(inPairToken != getBaseToken(), "PriceTickerOracle:  inPairToken is the base token address.");
      _pairToken = inPairToken;
    }
}