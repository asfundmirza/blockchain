// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract Retail{
    struct product{
        uint ID;
        string name;
        uint price;
        uint stock;
    }
    mapping(uint=>product) public products;
    mapping(address=>product[]) public customers;

    address payable owner;
    constructor(){
        owner=payable(msg.sender);
    }

    function addProduct(uint _ID,string memory _name,uint _price,uint _stock) public{
        require(msg.sender==owner,"you are not the owner");
        products[_ID]=product({
            ID:_ID,
            name:_name,
            price:_price,
            stock:_stock
        });
    }
    

    function purchase(uint _productID) public payable{
        require(products[_productID].ID!=0,"this product is not available");
        require(msg.value>=products[_productID].price,"amount is not enough to buy this product");
        require(products[_productID].stock!=0,"this product is out of stock");
        product storage productsData=products[_productID];
        customers[msg.sender].push(productsData);
        owner.transfer(msg.value);
        products[_productID].stock-=1;
        }
    function updatePrice(uint _productID,uint newPrice) public{
        require(msg.sender==owner,"you are not the owner");
        require(_productID==products[_productID].ID,"this product is not available");
        require(newPrice>0,"price should be greater than zero");
        require(newPrice!=products[_productID].price,"no changes in price .please enter new price");
        products[_productID].price=newPrice;
    }
    function updateStock(uint _productID,uint newStock) public{
        require(msg.sender==owner,"you are not the owner");
        require(_productID==products[_productID].ID,"this product is not available");
        require(newStock>0,"price should be greater than zero");
        require(newStock!=products[_productID].stock,"no changes in stock .please enter new stock value");
        products[_productID].stock=newStock;
    }
    function replace(uint _productID,uint newProductID) public payable{
       require(_productID==products[_productID].ID,"this product is not available");
       require(newProductID!=0,"new product does not exist");
       //require(products[_productID].price==products[newProductID].price,"price doesnot match with the new product");
        if(products[newProductID].price>products[_productID].price){
                   uint priceDiffer=products[newProductID].price-products[_productID].price;
                    owner.transfer(priceDiffer);
               }else if(products[_productID].price>products[newProductID].price){
                   uint priceDifference=products[_productID].price-products[newProductID].price;
                   payable (msg.sender).transfer(priceDifference);

               }
            for(uint i=0;i<customers[msg.sender].length;i++){
                if(_productID==customers[msg.sender][i].ID){
                customers[msg.sender][i]=products[newProductID];
           }
          
       }
    }
    function getProduct(uint ID)public view returns(uint,string memory,uint,uint){
        return(products[ID].ID,products[ID].name,products[ID].price,products[ID].stock);
    }
}