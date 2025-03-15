module todolist_addr::todolist {
  use aptos_framework::account;
  use std::signer;
  use aptos_framework::event;
  use std::string::String;
  use aptos_std::table::{Self, Table};

  struct TodoList has key {
    tasks: Table<u64, Task>,
    set_task_event: event::EventHandle<Task>,
    task_counter: u64
  }
  struct Task has store, drop, copy {
    task_id: u64,
    address:address,
    content: String,
    completed: bool
  }

  public entry fun create_list(account: &signer) {
    let tasks_holder = TodoList {
      tasks: table::new(),
      set_task_event: account::new_event_handle<Task>(account),
      task_counter: 0
    };
    move_to(account, tasks_holder);
  }

  public entry fun create_task(account: &signer, content: String) acquires TodoList {
    // gets the signer address
    let signer_addr = signer::address_of(account);
    assert!(exists<TodoList>(signer_addr), 1);
    // gets the TodoList resource 
    let todo_list = borrow_global_mut<TodoList>(signer_addr);
    // increment counter
    let counter = todo_list.task_counter + 1;
    let new_task = Task {
      task_id: counter,
      address: signer_addr,
      content,
      completed: false
    };
    // adding a new task
    table::upsert(&mut todo_list.tasks, counter, new_task);
    // sets the counter to the incremented counter;
    todo_list.task_counter = counter;
    // fires a new task created 
    event::emit_event<Task>(
      &mut borrow_global_mut<TodoList>(signer_addr).set_task_event,
      new_task,
    );
  }

  public entry fun complete_task(account: &signer, task_id: u64) acquires TodoList {
    let signer_addr = signer::address_of(account);
    assert!(exists<TodoList>(signer_addr),1);
    let todo_list = borrow_global_mut<TodoList>(signer_addr);
    assert!(table::contains(&todo_list.tasks, task_id), 2);
    let task_record = table::borrow_mut(&mut todo_list.tasks, task_id);
    assert!(task_record.completed == false, 3);
    task_record.completed = true;
  }

}