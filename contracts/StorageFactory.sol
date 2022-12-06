// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public SimpleStorageContractsArray;

    function createContract() public {
        SimpleStorage createdContract = new SimpleStorage();
        SimpleStorageContractsArray.push(createdContract);
    }

    function sfStore(uint256 _contractIdx, uint256 _favoriteNumber) public {
        SimpleStorageContractsArray[_contractIdx].store(_favoriteNumber);
    }

    function sfRetrieve(uint256 _contractIdx) public view returns (uint256) {
        return SimpleStorageContractsArray[_contractIdx].retrieve();
    }

    function sfAddPerson(string memory _name, uint256 _favoriteNumber, uint256 _contractIdx) public {
        SimpleStorageContractsArray[_contractIdx].addPerson(_name, _favoriteNumber);
    }

    function sfGetPerson(uint256 _contractIdx, uint256 _personIdx) public view returns (SimpleStorage.People memory) {
        return SimpleStorageContractsArray[_contractIdx].getPerson(_personIdx);
    }

    function sfGetFavoriteNumberOfPerson(string memory _name, uint256 _contractIdx) public view returns (uint256) {
        return SimpleStorageContractsArray[_contractIdx].getFavoriteNumberOfPerson(_name);
    }
}