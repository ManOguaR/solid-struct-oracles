// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

interface IOracle {
    function getTimestamp() external view returns (uint256);
}

interface ISecureOracle {
    function assignPublisherRole(address assignedPublisher) external;
    function revokePublisherRole(address revokedPublisher) external;
    function assignSubscriberRole(address assignedSubscriber) external;
    function revokeSubscriberRole(address revokedSubscriber) external;
}

abstract contract OracleBase is AccessControl, IOracle, ISecureOracle {
    bytes32 public constant PUBLISHER_ROLE = keccak256("PUBLISHER_ROLE");
    bytes32 public constant SUBSCRIBER_ROLE = keccak256("SUBSCRIBER_ROLE");

    uint256 internal _updatedAt;
    uint256 internal _lastUpdateAt;

    constructor(address defaultPublisher){
        require(defaultPublisher != address(0), "OracleBase: defaultPublisher is the zero address.");

        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(SUBSCRIBER_ROLE, _msgSender());
        _grantRole(PUBLISHER_ROLE, _msgSender());
        _grantRole(PUBLISHER_ROLE, defaultPublisher);
    }

    function getTimestamp() public override view onlyRole(SUBSCRIBER_ROLE) returns (uint256){
        return _updatedAt;
    }

    function getLastTimestamp() public view onlyRole(DEFAULT_ADMIN_ROLE) returns (uint256){
        return _lastUpdateAt;
    }

    function assignPublisherRole(address assignedPublisher) public override onlyRole(DEFAULT_ADMIN_ROLE) {
        require(assignedPublisher != address(0), "OracleBase: assignedPublisher is the zero address.");
        _grantRole(PUBLISHER_ROLE, assignedPublisher);
    }

    function revokePublisherRole(address revokedPublisher) public override onlyRole(DEFAULT_ADMIN_ROLE) {
        require(revokedPublisher != address(0), "OracleBase: revokedPublisher is the zero address.");
        _revokeRole(PUBLISHER_ROLE, revokedPublisher);
    }

    function assignSubscriberRole(address assignedSubscriber) public override onlyRole(DEFAULT_ADMIN_ROLE){
        require(assignedSubscriber != address(0), "OracleBase: assignedSubscriber is the zero address.");
        _grantRole(SUBSCRIBER_ROLE, assignedSubscriber);
    }

    function revokeSubscriberRole(address revokedSubscriber) public override onlyRole(DEFAULT_ADMIN_ROLE){
        require(revokedSubscriber != address(0), "OracleBase: revokedSubscriber is the zero address.");
        _grantRole(SUBSCRIBER_ROLE, revokedSubscriber);
    }


}