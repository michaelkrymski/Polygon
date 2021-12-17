//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol"; //Base ERC20 + Mint?
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol"; //Burn
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol"; //Pause
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol"; //Roles
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol"; //No Construct

contract ContractV7 is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, PausableUpgradeable, AccessControlUpgradeable {

    bytes32 public constant OWNER = keccak256("OWNER"); 
    bytes32 public constant ADMINISTRATOR = keccak256("ADMINISTRATOR"); //Administrators
    bytes32 public constant PLAYER = keccak256("PLAYER"); //Regular Players
    uint256 mintAmount;
    uint256 burnAmount;
    //New vars after here only. 

    // //Test Contract Start

    // uint256 private value;
 
    // // Emitted when the stored value changes
    // event ValueChanged(uint256 newValue);
 
    // // Stores a new value in the contract
    // function store(uint256 newValue) public {
    //     value = newValue;
    //     emit ValueChanged(newValue);
    // }
 
    // // Reads the last stored value
    // function retrieve() public view returns (uint256) {
    //     return value;
    // }

    // //Test Contract End


    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    function initialize() initializer public {
        __ERC20_init("Krimea", "KRM");
        __ERC20Burnable_init();
        __Pausable_init();
        __AccessControl_init();

        _grantRole(OWNER, msg.sender);
        _grantRole(ADMINISTRATOR, msg.sender);
        _grantRole(PLAYER, msg.sender);

        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
    // constructor () ERC20("MKTest2", "MKT") {
    //     _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    // }

    modifier gnosisWallet {
        require(
            msg.sender == 0xC3dd25201AF90ECDbf9FCCAbc95bFF950e72985D,
            "Sender has to be the gnosis wallet."
        );
        _;
    }

    function oneTimeUpgrade() public gnosisWallet {
        _grantRole(OWNER, msg.sender);
        _grantRole(ADMINISTRATOR, msg.sender);
        _grantRole(PLAYER, msg.sender);
    }

    function checkValue() public pure returns(bytes32, bytes32, bytes32) {
        bytes32[3] memory variables = [OWNER, ADMINISTRATOR, PLAYER];
        return (variables[0], variables[1], variables[2]);
    }
    
    function promoteAdmin(address developer, bytes32 role) public onlyRole(OWNER) {
        _grantRole(role, developer);
    }

    function redeem(address player) public payable { //, uint _amount
        _grantRole(PLAYER, player);
        uint _amount = 1;
        uint r_amount = _amount * 1000000000000000; //Gives 0.0001 token. Useful for giving thousands. 15 Zeroes. 
        payable(player).transfer(r_amount); //Makes it payable. 
    }

    function pause() public onlyRole(ADMINISTRATOR){
        _pause();
    }

    function unpause() public onlyRole(ADMINISTRATOR){
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyRole(ADMINISTRATOR) {
        mintAmount = amount * 1000000000000000000;
        _mint(to, mintAmount);
    }

    function burn(address to, uint256 amount) public onlyRole(ADMINISTRATOR) {
        burnAmount = amount * 1000000000000000000;
        _burn(to, burnAmount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) 
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}       