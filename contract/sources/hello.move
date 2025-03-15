module hello_addr::helloworld {
  use std::debug;
  use std::string::{String, utf8};

  const ID: u64 = 134;

  fun printHello(): u64 {
    let value_id: u64 = 200;
    let string_val: String = utf8(b"hello world!");
    let string_byte: vector<u8> = b"This is a Btye String";
    debug::print(&value_id);
    debug::print(&string_val);
    debug::print(&utf8(string_byte));
    // this is how you return a value
    ID
  }

  // #[test]
  fun test_function() {
    let id_value = printHello();
    debug::print(&id_value);
  }
}