module hello2_addr::helloworld2 {

  const MY_ADDR: address = @hello2_addr;

  fun confirm_value(number: u64): ( bool, u64 ) {
    if (number > 0)
      return ( true, number )
    else
      return ( false, number )
  }

  #[test_only]
  use std::debug::print;

  // #[test]
  fun test_function() {
    let (choice, number) = confirm_value(10);
    print(&choice);
    print(&number);
  }
}