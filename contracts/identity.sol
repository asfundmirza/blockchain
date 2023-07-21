// SPDX-License-Identifier: MIT

pragma solidity>=0.5.0<0.9.0;

//state variables declaration below

contract test{

    /*string name; //state variables
    uint age;

    constructor(){
        name="asfund";
        age=20;
    }

    /*function getname() public view returns(string memory){
        return name;
    }
    function getage() public view returns(uint){
        return age;
    }

    //local variables declration below.
    //string variables by default stored on chain that is it is declared 
    //in contract level by default.if we want to declare in funtion we use string memory.

    function setNum() public pure returns(uint){
       // string memory school="djps";
        uint num=11;        //local variables
        return num;
    

    //setter and getter functions
    //in getter we use view returns because there is no change in values
    //if we use public in state variables then we dont need to creat getter function

    function getter() public view returns(uint){
        return age;
    }
    //in setter we dont use view returns  because we change values

    function setter(uint num) public{
        age=num;

    }

    //fixed sized array
    uint[3] public students=[1,2,3];

    function setter(uint index,uint value) public{
        students[index]=value;
    }    
    function arrayLength() public view returns(uint){
        return students.length;
    }
    

    //dynamic sized array

    uint[] public students;

    function pushNumber(uint number) public{
        students.push(number); // add indexed++ and numbers accordingly 
    }
    function popNumber() public{
        students.pop(); // remove the last array value not indexed value
    }
    function arrlength() public view returns(uint){
       return students.length;
    } 

    // fixed bytes arrays

    bytes2 public b2;
    bytes1 public b1;

    function setter() public{
        b1='a';
        b2='ab';
        //we can use length function for getting length
    }
    //dynamic size array

    bytes public b3='abc';
//bytes1 is used because we want to have only one index number

    function setelement(uint i) public view returns(bytes1){
        return b3[i];
    }
    

    //struct usage

    struct Student{
        uint roll;
        string name;
    }
    Student public s1;

    constructor(uint _roll,string memory _name) {
        s1.roll=_roll;
        s1.name=_name;
    }

    function change(uint _roll,string memory _name) public{
        Student memory new_student=Student({
            roll:_roll,
            name:_name
        });
        s1=new_student;
    }
    

    //mapping
    //differnece between mapping and arrays is no sequestial indexes in mapping just like arrays.

    mapping(uint=>string) public reg;

    function setter(uint regNo,string memory name)public{

        reg[regNo]=name;
    }
    

    //mapping with struct

    struct Student{
        string  name;
        uint reg;
        
     }

     mapping(uint=>Student) public record;
         function setter(uint _id,string memory _name,uint _reg) public{
             record[_id]=Student(_name,_reg);
         }
     

     //difference between storage and memory

     string[] public student=['asfund','mirza'];

     function mem() public view{
         string[] memory  s1=student;
             s1[0]='kashif';
//usage of memory will creat new copy and changes index value in that copy not in original student
     }
     function stor() public {
         string[] storage  s1=student;
            s1[0]='kashif';
     }
//storage will hold the original student array and changes original index value


    //contract balance

    function bal() public payable{
                //transfer balance to this contract
    }
    function check() public view returns(uint){
        return address(this).balance; //check contract balance
    }
    address payable user=payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);

    function send() public{
        user.transfer(1 ether);  //send balance to upper given address
    }
    */

    
}