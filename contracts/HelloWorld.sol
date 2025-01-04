pragma solidity 0.8.19;

contract HelloWorld {
    /*
    *ایده : یک هلو ورد ساده به مرور بزرگ و بزرگ تر بشه
    */
    function sayHello() public pure returns (string memory){
        return "HelloMamad";
    }


    /**
    ye dadeh begire sabt kone va hey uno bede */

    uint private arefnumber;

    function setAref(uint _aref) public {
        arefnumber = _aref;
    }
    function getAref() public view returns (uint){
        return arefnumber;
    }


    /**
    *
    *   har ki biad ye dade base khodesh shamele yekseri etelaate shaksi mesle shomare etelaaate kartesho sabt kone va khodesh fagat betune bebine
    *
    *
     */
    struct bankAccount {
        string name;
        uint balance;
    }
    mapping(address=>bankAccount) userAccounts;
    mapping(address=>bool) userHasAccounts;

    struct Cart {
        string CardNumber;
        uint16 CVV2;
        uint8 mount;
        uint8 year;
    }

    mapping(address=>Cart) userCarts;
    mapping(address=>bool) userhasCarts;
    

    modifier oneAccountPerUser(address _address){
        require(!userHasAccounts[_address] ,"You Already Opened an account");
        _;
    }
    modifier requireAtleasOneAccount(address _address){
        require(userHasAccounts[_address],"You should open an account first");
        _;
    }
    modifier requireAtleasOneCart(address _address){
        require(userhasCarts[_address],"You should open an account first");
        _;
    }
    modifier doIhaveThisamountInMyAccount(address _address , uint256 amount){
        require(userAccounts[_address].balance>=amount,"You don't posses this much moeny");
        _;
    }
    event BankAccountCreated(
        address indexed owner,
        string name
    );
    event BankCartCreated(
        address indexed owner,
        string cartnumber
    );

    event MyWholeFuckingData(
        address indexed owner,
        uint balance,
        string CardNumber,
        uint16 CVV2,
        uint8 mount,
        uint8 year

    );


    function createAccount(string memory name) public payable oneAccountPerUser(msg.sender) {
        /**
        create an account and emit event */
        bankAccount memory account = bankAccount(name , msg.value);
        userAccounts[msg.sender] = account;
        userHasAccounts[msg.sender]=true;
        emit BankAccountCreated(msg.sender , name);
    }

    function incraeseBankAccountAmount() public payable requireAtleasOneAccount(msg.sender){
        /**
        Increase account and emit event */
        bankAccount storage account = userAccounts[msg.sender];
        account.balance+=msg.value;
    }

    function withdrawfromMyAccount(uint _requiredAmount) public payable doIhaveThisamountInMyAccount(msg.sender,_requiredAmount){
        bankAccount storage account = userAccounts[msg.sender];
        account.balance-=_requiredAmount;
        payable(msg.sender).transfer(_requiredAmount);
    }

    function getACard() public requireAtleasOneAccount(msg.sender) {
        /** emit event with card data */
        userCarts[msg.sender] = Cart('111-222-333-444',123,12,25);
        userhasCarts[msg.sender] = true;
        emit BankCartCreated(msg.sender , '111-222-333-444');
    }
    
    function getAllMyFuckingData() public requireAtleasOneCart(msg.sender)  requireAtleasOneAccount(msg.sender){
        emit MyWholeFuckingData(msg.sender, userAccounts[msg.sender].balance, userCarts[msg.sender].CardNumber,
         userCarts[msg.sender].CVV2, userCarts[msg.sender].mount, userCarts[msg.sender].year);
    }

    // function getMyCardData() public view requireAtleasOneCart(msg.sender) returns (string memory cnum , unit16 cvv2 , uint8 mount , uint8 year){
        
    // }



    /**
    *
    *   آزمون بعدی....دائو 
    *   بعدش مباحث دايو جداگانه مطالعه میشه
    */



    /**
    *
    *   آزمون بعدی....MultisSig 
        بعدش مباحث مولتی سیگ جداگانه مطالعه میشه
    *
    */


    /**
    *
    *   آزمون بعدی....ERC20 ,ERC721  , ERC1155
        بعدش مباحث ERC20 و ERC721 و ERC1155
    *   جداگانه مطالعه میشه
    */
}