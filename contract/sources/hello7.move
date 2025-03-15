module hello7_addr::helloworld7 {


  const E_NOTENOUGH: u64 = 0;

  const INDR: u64 = 1;
  const APT: u64 = 2;
  const WETH: u64 = 3;
  
  const POOL1_INDR: u64 = 312;
  const POOL1_USDT: u64 = 3201;
  const INDR_name: vector<u8> = b"INDR Rewards";

  const POOL2_APT: u64 = 21500;
  const POOL2_USDT: u64 = 124700;
  const APT_name: vector<u8> = b"APT";

  const POOL3_WETH: u64 = 1310;
  const POOL3_USDT: u64 = 2750000;
  const WETH_name: vector<u8> = b"WETH";

  fun get_supply(coin_symbol: u64): (u64, u64, vector<u8>) { 
    if (coin_symbol == INDR)  {
      return (POOL1_USDT, POOL1_INDR, INDR_name)
    } else if (coin_symbol == APT) {
      return (POOL2_USDT, POOL2_APT, APT_name)
    } else {
      return (POOL3_USDT, POOL3_WETH, WETH_name)
    }
  }

  fun token_price(coin1: u64, coin2: u64): u64 {
    assert!(coin1 > 0, E_NOTENOUGH);
    assert!(coin2 > 0, E_NOTENOUGH);
    return coin1 / coin2
  }

  // this applies a 5% fee to each swap tx.
  fun calculate_swap(coin1: u64, coin2: u64, coin1_amt: u64): u64 {
    assert!(coin1_amt > 0, E_NOTENOUGH);
    let fee = coin1_amt * 5 / 1000;
    let mix_supply: u64 = coin1 * coin2;
    let new_USDT = coin1 + coin1_amt;
    let new_INDR = mix_supply / (new_USDT - fee);
    let receive = coin2 - new_INDR;
    return receive
  }


  #[test_only]
  use std::debug::print;
  use std::string::{utf8};
  #[test]
  fun test() {
    let swap_amount = 495;
    let (coin1, coin2, name) = get_supply(INDR);
    print(&utf8(b"Swap USDT for:"));
    print(&utf8(name));

    print(&utf8(b"Token Price Before"));
    let price_before = token_price(coin1, coin2);
    print(&price_before);

    let result = calculate_swap(coin1, coin2, swap_amount);

    print(&utf8(b"Token Received:"));
    print(&result);

    print(&utf8(b"Token Price After"));
    let coin1_after = coin1 + swap_amount;
    let coin2_after = coin2 - result;
    let price_after = token_price(coin1_after, coin2_after);
    print(&price_after);

  }
  // #[test]
  fun test1() {
    let swap_amount = 495;
    let (coin1, coin2, name) = get_supply(APT);
    print(&utf8(b"Swap USDT for:"));
    print(&utf8(name));
    let result = calculate_swap(coin1, coin2, swap_amount);
    print(&result);
  }
  // #[test]
  fun test2() {
    let swap_amount = 3000;
    let (coin1, coin2, name) = get_supply(WETH);
    print(&utf8(b"Swap USDT for:"));
    print(&utf8(name));
    let result = calculate_swap(coin1, coin2, swap_amount);
    print(&result);
  }


   /*
    Liquidity Pool

    Coin1 = 3201 USDT
    Coin2 = 312 INDR

    495 USDT -> INDR

    FORMULA with 5 % fee

    Value1 = Aplly a 5% fee to the USDT amount to be swapped.
          Fee: 495 * 5 / 1000 = 2

    Value2 = Multiply both USDT and INDR Supply
          MixSup: USDT(Coin1) * INDR(Coin2) = 998,712

    Value3 = Determine the new supply of USDT after swap
          NewUSDT: Coin1 + 495 = 3696
    
    Value4 = Determine the new supply of INDR after the swap
          NewINDR: MixSup / (NewUSDT - fee) = 270

    Value5 = Determine the amount of INDRs to transfer to user
          Transfer = Coin2 - NewINDR = 42

   */
}