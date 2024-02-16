// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "../tokens/CDP.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// import "hardhat/console.sol";

contract CDPView is OwnableUpgradeable {
    // ETH-snUSDC
    address public constant weth = 0x24457b0983B5D18Ed0e60bD7eAeB871c8072F275;
    address public constant nsnUSDC =
        0x4E0195cCE75159DC6aA9831D289e117d1f22B58F;
    address public constant snUSDC = 0xA5b277B48E5D1BB43F00d80C69D407997778927D;
    address public constant ethCDP = 0x585c82f7DAc53263800b59D276d573ef87Af8119;

    // USDC-snETH
    address public constant usdc = 0x90a8Aa5cc323F9947c46c8F4b65c37FAaE0117F1;
    address public constant nsnETH = 0x452F7F627c2718c5dE896B534CbB7DAE9B7414C3;
    address public constant snETH = 0xb2e3A0CFaf2f1d869d9d1f1cb7e1c810894e7285;
    address public constant usdcCDP =
        0xD57BD23eb22029abc78EF22E02E866f55827E744;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() external initializer {
        __Ownable_init();
    }

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

    function getCDPInfo() public view returns (CDPInfo[] memory) {
        CDPInfo[] memory cdpInfos = new CDPInfo[](2);
        cdpInfos[0] = _getSingleCDPInfo(ethCDP);
        cdpInfos[1] = _getSingleCDPInfo(usdcCDP);
        return cdpInfos;
    }

    function _getSingleCDPInfo(
        address _cdpAddress
    ) internal view returns (CDPInfo memory cdpInfo) {
        cdpInfo.cdpAddress = _cdpAddress;
        cdpInfo.collateralToken = CDP(_cdpAddress).collateralToken();
        cdpInfo.debtToken = CDP(_cdpAddress).debtToken();
        cdpInfo.collateralSymbol = ERC20(cdpInfo.collateralToken).symbol();
        cdpInfo.debtSymbol = ERC20(cdpInfo.debtToken).symbol();
        cdpInfo.collateralAmount = CDP(_cdpAddress).totalCollateral();
        cdpInfo.debtAmount = CDP(_cdpAddress).totalDebt();
        if (_cdpAddress == ethCDP) {
            cdpInfo.collateralPrice =
                CDP(_cdpAddress).collateralPrice() *
                10 ** 14;
            cdpInfo.debtPrice = 10 ** 18;
        } else {
            cdpInfo.collateralPrice = 10 ** 18;
            cdpInfo.debtPrice = 10 ** 22 / CDP(_cdpAddress).collateralPrice();
        }
        cdpInfo.feeRatio = 10 ** 16;
        if (cdpInfo.collateralAmount != 0)
            cdpInfo.globalLTV = CDP(_cdpAddress).globalLTV();
        cdpInfo.globalHealthFactor = CDP(_cdpAddress).globalHealthFactor();
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

    function getUserInfo(
        address account
    ) external view returns (UserInfo[] memory) {
        uint256 count;
        for (uint256 i = 0; i < CDP(ethCDP).id(); i++) {
            if (CDP(ethCDP).ownerOf(i) == account) count++;
        }
        for (uint256 i = 0; i < CDP(usdcCDP).id(); i++) {
            if (CDP(usdcCDP).ownerOf(i) == account) count++;
        }

        UserInfo[] memory userInfos = new UserInfo[](count);

        count = 0;
        for (uint256 i = 0; i < CDP(ethCDP).id(); i++) {
            if (CDP(ethCDP).ownerOf(i) == account) {
                userInfos[count].cdpAddress = ethCDP;
                userInfos[count].id = i;
                userInfos[count].isSafe = CDP(ethCDP).isSafe(i);
                userInfos[count].healthFactor = CDP(ethCDP).healthFactor(i);
                CDP.CollateralizedDebtPosition memory cdp = CDP(ethCDP).cdp(i);
                if (cdp.collateral != 0)
                    userInfos[count].currentLTV = CDP(ethCDP).currentLTV(i);
                userInfos[count].collateral = cdp.collateral;
                userInfos[count].debt = cdp.debt;
                userInfos[count].fee = cdp.fee;
                userInfos[count].latestUpdate = cdp.latestUpdate;
                count++;
            }
        }
        for (uint256 i = 0; i < CDP(usdcCDP).id(); i++) {
            if (CDP(usdcCDP).ownerOf(i) == account) {
                userInfos[count].cdpAddress = usdcCDP;
                userInfos[count].id = i;
                userInfos[count].isSafe = CDP(usdcCDP).isSafe(i);
                userInfos[count].healthFactor = CDP(usdcCDP).healthFactor(i);
                CDP.CollateralizedDebtPosition memory cdp = CDP(usdcCDP).cdp(i);
                if (cdp.collateral != 0)
                    userInfos[count].currentLTV = CDP(usdcCDP).currentLTV(i);
                userInfos[count].collateral = cdp.collateral;
                userInfos[count].debt = cdp.debt;
                userInfos[count].fee = cdp.fee;
                userInfos[count].latestUpdate = cdp.latestUpdate;
                count++;
            }
        }
        return userInfos;
    }
}
