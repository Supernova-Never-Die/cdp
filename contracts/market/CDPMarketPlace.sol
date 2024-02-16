// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "../tokens/CDP.sol";

import "../interfaces/ICDPMarketPlace.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract CDPMarketPlace is ICDPMarketPlace, OwnableUpgradeable {
    //============ Params ============//

    address public constant baseToken =
        0xA5b277B48E5D1BB43F00d80C69D407997778927D; // Address of snUSDC

    mapping(uint256 => IdInfo) internal _registeredIdInfo;
    mapping(uint256 => bool) internal _isRegisteredIds;
    mapping(address => mapping(uint256 => uint256)) internal _registeredIds;

    uint256 internal _totalId;

    //============ Initialize ============//

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() external initializer {
        __Ownable_init();
    }

    //============ View ============//

    function getRegisteredIdInfo(
        uint256 registeredId
    ) external view returns (IdInfo memory) {
        return _registeredIdInfo[registeredId];
    }

    function getIsRegisteredIds(
        uint256 registeredId
    ) external view returns (bool) {
        return _isRegisteredIds[registeredId];
    }

    function getRegisteredIds(
        address cdpAddress,
        uint256 cdpId
    ) external view returns (uint256 registeredId) {
        return _registeredIds[cdpAddress][cdpId];
    }

    function getTotalId() external view returns (uint256) {
        return _totalId;
    }

    //============ Functions ============//

    /**
     * @dev Registers a CDP for sale.
     * @param cdpAddress Address of the CDP contract.
     * @param cdpId The ID of the CDP.
     * @param amount The amount for which the CDP is to be sold.
     */
    function register(
        address cdpAddress,
        uint256 cdpId,
        uint256 amount
    ) external {
        CDP(cdpAddress).safeTransferFrom(msg.sender, address(this), cdpId);

        _registeredIds[cdpAddress][cdpId] = _totalId;
        _isRegisteredIds[_totalId] = true;

        _registeredIdInfo[_totalId] = IdInfo({
            seller: msg.sender,
            cdpAddress: cdpAddress,
            id: cdpId,
            registeredAmount: amount,
            buyer: address(0)
        });

        _totalId++;
    }

    /**
     * @dev Buy a registered CDP.
     * @param registeredId The ID under which the CDP is registered in the marketplace.
     */
    function buyCDP(uint256 registeredId) external {
        ERC20(baseToken).transferFrom(
            msg.sender,
            _registeredIdInfo[registeredId].seller,
            _registeredIdInfo[registeredId].registeredAmount
        );
        CDP(_registeredIdInfo[registeredId].cdpAddress).safeTransferFrom(
            address(this),
            msg.sender,
            _registeredIdInfo[registeredId].id
        );

        _registeredIdInfo[registeredId].buyer = msg.sender;

        delete _isRegisteredIds[registeredId];
    }

    //============ Received Function ============//

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public pure returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
