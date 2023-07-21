// SPDX-License-Identifier: MIT
pragma solidity>=0.5.0<0.9.0;

contract BookManagment{

    struct book{
        string title;
        string author;
        bool completed;
    }
    mapping(address=>mapping(uint=>book)) books;

    function addBook(uint id,string memory _title,string memory _author,bool ) public{
        books[msg.sender][id]=book(_title, _author,false);

    }
    function getBooks(uint id)public view returns(book memory) {
        return books[msg.sender][id];
    } 

    function update(uint id) public{
       if (books[msg.sender][id].completed==true){
           books[msg.sender][id].completed=false;
       }
       else{
           books[msg.sender][id].completed=true;
       }
    }
    function del(uint id) public{
        delete books[msg.sender][id];
    }


}