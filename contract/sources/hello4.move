module hello4_addr::helloworld4 {
  use std::debug::print;
  use std::string::{ String, utf8 };

  fun sample_for_loop(count: u64): u64 {
    let value = 0;
    for (i in 0..count) {
      value = value + 1;
    };
    value
  }

  fun sample_while_loop(count: u64): u64 {
    let value: u64 = 0;
    let i: u64 = 1;
    while (i <= count) {
      value = value + 1;
      i = i + 1;
    };
    value
  }

  fun sample_loop(count: u64): u64 {
    let value = 0;
    let i: u64 = 1;
    loop {
      value = value + 1;
      i = i + 1;
      if (i > count)
        break;
    };
    value
  }

  fun sample_abort_error(value: String) {
    if (value == utf8(b"hello")) {
      print(&utf8(b"Correct!"));
    }
    else  {
      abort 123
    }
  }

  fun sample_assert_error(value: String) {
    assert!(value == utf8(b"hello"), 123);
    print(&utf8(b"Correct!"));
  }

  // #[test]
  fun test_for_loop() {
    let result = sample_for_loop(5);
    print(&result);
  }
  // #[test]
  fun test_while_loop() {
    let result = sample_while_loop(5);
    print(&result);
  }
  // #[test]
  fun test_loop() {
    let result = sample_loop(5);
    print(&result);
  }
  // #[test]
  fun test_abort1() {
    sample_abort_error(utf8(b"hello"));
  }
  // #[test]
  // #[expected_failure]
  fun test_abort2() {
    sample_abort_error(utf8(b"hello world"));
  }
  // #[test]
  fun test_abort3() {
    sample_assert_error(utf8(b"hello"));
  }
  // #[test]
  // #[expected_failure]
  fun test_abort4() {
    sample_assert_error(utf8(b"hello world"));
  }
}