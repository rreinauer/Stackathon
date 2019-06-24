pragma solidity ^0.5.8;

contract Verifications {

  function recover(bytes32 hash, bytes memory signature)
  public
  pure
  returns (address)
  {
    bytes32 r;
    bytes32 s;
    uint8 v;

    if(signature.length != 65) {
      return (address(0));
    }

    assembly {
      r := mload(add(signature, 0x20))
      s := mload(add(signature, 0x40))
      v := byte(0, mload(add(signature, 0x60)))
    }

    if(v < 27) {
      v += 27;
    }

    if(v != 27 && v != 28) {
      return (address(0));
    } else {
      return ecrecover(hash, v, r, s);
    }

  }

}
