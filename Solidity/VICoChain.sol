// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract VICoChain {

    struct Content{
        uint index;
        string hash;
        string data;
        string watermark;
        uint admin;
    }
    mapping(uint => Content) public Contents;
    mapping(address => string) public User;
    mapping(address => bool) public isUser;
    struct Admin{
        uint index;
        string key;
        string email;
    }
    mapping(address => Admin) public Admins;
    //mapping(address => bool) public isAdmin;
    uint public counter;
    uint public AdminCounter;
    string public Name;

    constructor(string memory name, string memory email, string memory pk) {
        //Owner = msg.sender;
        //isAdmin[msg.sender] = true;
        Name = name;
        counter = 0;
        Admins[msg.sender].index = 1;
        Admins[msg.sender].key = pk;
        Admins[msg.sender].email = email;
        AdminCounter = 1;
    }
    
    function addAdmin(address adr,string memory email, string memory pk) public {
        require(
           Admins[msg.sender].index == 1,
            "Only owner is allowed to add new admin"
        );
        require(
            Admins[adr].index == 0,
            "the admin already exist!"
        );
        Admins[adr].index = AdminCounter + 1;
        Admins[adr].key = pk;
        Admins[adr].email = email;
        AdminCounter = AdminCounter + 1;
        //isAdmin[adr] == true;
    }
    
    function setKey(string memory key) public {
        require(
            Admins[msg.sender].index > 0,
            "Only owner is allowed to change the key"
        );
        Admins[msg.sender].key = key;
    }
    
    function addUser(address adr, string memory pk) public {
        require(
            Admins[msg.sender].index > 0,
            "Only admin is allowed to add new user"
        );
        require(
            isUser[adr] == false,
            "the user already exist!"
        );
        User[adr] = pk;
        isUser[adr] = true;
    }
    
    function addContent(string memory hash, string memory data, uint admin) public {
        require(
            isUser[msg.sender] == true,
            "Unauthorized user!"
        );
        Contents[counter].index = counter;
        Contents[counter].hash = hash;
        Contents[counter].data = data;
        Contents[counter].watermark = "";
        Contents[counter].admin = admin;
        counter = counter +1;
    }
    
    function setWatermark(string memory watermark, uint index) public {
        require(
            Admins[msg.sender].index == Contents[index].admin,
            "Unauthorized access!"
        );
        Contents[index].watermark = watermark;
    }
    
    function getReqContent(uint index) public view returns (string memory content_){
        require(
            Admins[msg.sender].index > 0,
            "Only admin can get the req. content!"
        );
        content_ = Contents[index].data;
    }
    
    function getWatermark(uint index) public view returns (string memory content_){
        content_ = Contents[index].watermark;
    }
    
}
