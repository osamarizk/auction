pragma solidity >= 0.7.0 <0.9.0;
// auction 1- Beneficiary 2- AuctionEndTime.
// Auction Parameters 1- HighestBid 2- HighestBidder --- already we have msg.sender and msg.value
// functions 1- Bid 2- Withdraw 3- endAuction

contract Auction {
    // Paramters
uint public highestBid;
address public hightestBidder;
address payable public beneficairy;
uint public auctionEndTime;

constructor (address _benficiary , uint _auctionEndTime) {
    beneficairy =_benficiary;
    auctionEndTime=block.timestamp + _auctionEndTime;
}

mapping (address => uint) public pendingReturns;

bool ended =false;
event AuctionBid(adress bidder , uint amount);
event AuctionEnded(address Winner , uint amount);
}

function bid() public payable {
    if (block.timestamp > auctionEndTime) {
        revert("Auction already ended");
    }

    if(msg.value <=highestBid) {
        revert("already there is highest or equal bid");
    }

    if (highestBid !=0) {
        pendingReturns[hightestBidder]+=highestBid;
    }
    highestBid=msg.value;
    hightestBidder=msg.sender;
    AuctionBid(msg.sender ,msg.value );
    }


function withdraw() public  returns (bool){
    uint amount=pendingReturns[msg.sender];
    if(amount > 0) {
        pendingReturns[msg.sender]=0;

        if (!payable(msg.sender).send(amount)) {
            pendingReturns[msg.sender]=amount;
            return false;
        }

        return true;
    }

function auctionEnded () public {

if (block.timestamp < auctionEndTime ) {
    revert("Auction has not ended yet");
}

if (ended) {
    revert("the AuctionEnd Function already called");
}

    ended =true;
    emit AuctionEnded(hightestBidder , highestBid);
    beneficairy.transfer(highestBid)
}
    
}
