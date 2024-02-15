// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./CDP.sol";

/**
 * @title Collateralized Debt Position.
 * @author Eric Lee (topkids5326@gmail.com)
 * @notice This Contract extends CDP to create a deployable vsrsion of the abstract contract
 */
contract CDPConcrete is CDP {
    /**
     * @dev Constructor for CDPConcrete, simply forwards parameters to the CDP constructor.
     * @param name_ Name of the ERC721 token.
     * @param symbol_ Symbol of the ERC721 token.
     * @param oracleFeeder_ Address of the oracle feeder.
     * @param feeTo_ Address to which fees are sent.
     * @param collateralToken_ Address of the collateral token (e.g., WETH).
     * @param debtToken_ Address of the debt token (e.g., SIN).
     * @param maxLTV_ Maximum loan-to-value ratio.
     * @param cap_ Total debt cap for the system.
     * @param feeRatio_ Fee ratio for the CDP.
     * @param liquidationPenaltyRatio_ Penalty ratio for liquidation.
     * @param liquidationBufferRatio_ Buffer ratio for liquidation calculations.
     */
    constructor(
        string memory name_,
        string memory symbol_,
        address oracleFeeder_,
        address feeTo_,
        address collateralToken_,
        address debtToken_,
        uint256 maxLTV_,
        uint256 cap_,
        uint256 feeRatio_,
        uint256 liquidationPenaltyRatio_,
        uint256 liquidationBufferRatio_
    )
        CDP(
            name_,
            symbol_,
            oracleFeeder_,
            feeTo_,
            collateralToken_,
            debtToken_,
            maxLTV_,
            cap_,
            feeRatio_,
            liquidationPenaltyRatio_,
            liquidationBufferRatio_
        )
    {}
}
