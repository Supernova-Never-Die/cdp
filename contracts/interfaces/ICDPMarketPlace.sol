// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface ICDPMarketPlace {
    //============ Params ============//

    struct IdInfo {
        address seller;
        address cdpAddress;
        uint256 id;
        uint256 registeredAmount;
        address buyer;
    }

    //============ View ============//

    function getRegisteredIdInfo(
        uint256 registeredId
    ) external view returns (IdInfo memory);

    function getIsRegisteredIds(
        uint256 registeredId
    ) external view returns (bool);

    function getRegisteredIds(
        address cdpAddress,
        uint256 cdpId
    ) external view returns (uint256 registeredId);

    function getTotalId() external view returns (uint256);

    //============ Functions ============//

    function register(
        address cdpAddress,
        uint256 cdpId,
        uint256 amount
    ) external;

    function buyCDP(uint256 registeredId) external;

    //============ Received Function ============//

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
