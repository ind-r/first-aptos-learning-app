module hello5_addr::helloworld5 {
  const ADD: u64 = 0;
  const SUB: u64 = 1;
  const MUL: u64 = 2;
  const DIV: u64 = 3;
  const MOD: u64 = 4;

  fun arth_op(a: u64, b: u64, operator: u64): u64 {
    if (operator == ADD) {
      return a+b
    }
    else if (operator == SUB) {
      return a-b
    }
    else if (operator == MUL) {
      return a*b
    }
    else if (operator == DIV) {
      return a/b
    }
    else {
      return a%b
    }
  }
  #[test_only]
  use std::debug::print;
  // #[test]
  fun test_op() {
    let result1 = arth_op(2, 3, ADD);
    let result2 = arth_op(3, 2, SUB);
    let result3 = arth_op(2, 3, MUL);
    let result4 = arth_op(2, 3, DIV);
    let result5 = arth_op(2, 3, MOD);
    print(&result1);
    print(&result2);
    print(&result3);
    print(&result4);
    print(&result5);
  }
}