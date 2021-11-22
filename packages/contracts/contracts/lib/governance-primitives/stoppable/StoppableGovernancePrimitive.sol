/*
 * SPDX-License-Identifier:    MIT
 */

pragma solidity ^0.8.0;

import "./../GovernancePrimitive.sol";

/// @title Abstract implementation of the stoppable governance primitive
/// @author Samuel Furter - Aragon Association - 2021
/// @notice This contract can be used to implement concrete stoppable governance primitives and being fully compatible with the DAO framework and UI of Aragon
/// @dev You only have to define the specific custom logic for your needs in _start, _execute, and _stop
abstract contract StoppableGovernancePrimitive is GovernancePrimitive {
    event GovernancePrimitiveStopped(Execution indexed execution, uint256 indexed executionId);

    /// @notice If called the execution is stopped.
    /// @dev The state of the container does get changed to STOPPED and the concrete implementation in _stop called.
    /// @param executionId The identifier of the current execution
    /// @param data The arbitrary custom data used for the concrete implementation
    function stop(uint256 executionId, bytes calldata data) external {
        Execution memory execution = _getExecution(executionId);

        require(
            Permissions(dao.permissions.address).checkPermission(
                execution.process.permissions.stop
            ),
            "Not allowed to execute!"
        );

        _stop(data);

        execution.state = State.STOPPED;

        emit GovernancePrimitiveStopped(execution, executionId);
    }

    // @dev The concrete implementation of stop.
    /// @param data The arbitrary custom data used for the concrete implementation
    function _stop(bytes calldata data) internal virtual;
}
