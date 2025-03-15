address hello3_addr {

  module one {
    friend hello3_addr::two;
    friend hello3_addr::three;
    public(friend) fun get_value(): u64 {
      100
    }

    #[view]

    public fun get_prices(): u64 {
      return 143
    }

  }

  module two {

    #[test_only]
    use std::debug::print;

    // #[test]
    fun test_function() {
      let result = hello3_addr::one::get_value();
      print(&result);
    }

  }
  module three {

    #[test_only]
    use std::debug::print;

    // #[test]
    fun test_function() {
      let result = hello3_addr::one::get_value();
      print(&result);
    }


  }
}