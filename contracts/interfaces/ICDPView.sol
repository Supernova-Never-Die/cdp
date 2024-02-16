// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface ICDPView {
    //============ Params ============//

    struct CDPInfo {
        address cdpAddress;
        address collateralToken;
        address debtToken;
        string collateralSymbol;
        string debtSymbol;
        uint256 collateralAmount;
        uint256 debtAmount;
        uint256 collateralPrice;
        uint256 debtPrice;
        uint256 feeRatio;
        uint256 globalLTV;
        uint256 globalHealthFactor;
    }

    struct UserInfo {
        address cdpAddress;
        uint256 id;
        bool isSafe;
        uint256 currentLTV;
        uint256 healthFactor;
        uint256 collateral;
        uint256 debt;
        uint256 fee;
        uint256 latestUpdate;
    }

    struct MarketInfo {
        address seller;
        address cdpAddress;
        uint256 id;
        address collateralToken;
        uint256 collateralAmount;
        address debtToken;
        uint256 debtAmount;
        uint256 registeredAmount;
    }

    //============ View ============//

    function getCDPInfo() external view returns (CDPInfo[] memory);

    function getUserInfo(
        address account
    ) external view returns (UserInfo[] memory);

    function getMarketInfo() external view returns (MarketInfo[] memory);
}
