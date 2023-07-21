// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0<0.9.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ethPrice{

    AggregatorV3Interface internal priceFeed;

    constructor(){
        
        priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }
    function getLatestPrice() public view returns (int){
        (,int price,,,)=priceFeed.latestRoundData();
        return price;
    }
}
//this is the project to get real time ether price by using chainlink data feeds on goerli test network.
