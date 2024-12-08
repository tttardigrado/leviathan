import gleeunit
import gleeunit/should
import leviathan as lv

pub fn main() {
  gleeunit.main()
}

pub fn go_test() {
  lv.State(fn(s) { #(s + 1, s + 2) })
  |> lv.go(1)
  |> should.equal(#(2, 3))
}

pub fn eval_test() {
  lv.State(fn(s) { #(s + 1, s + 2) })
  |> lv.eval(1)
  |> should.equal(2)
}

pub fn exec_test() {
  lv.State(fn(s) { #(s + 1, s + 2) })
  |> lv.exec(1)
  |> should.equal(3)
}

pub fn return_test() {
  lv.return("X")
  |> lv.go(1)
  |> should.equal(#("X", 1))
}

pub fn tick_test() {
  {
    use x <- lv.do(lv.get())
    lv.put(x + 1)
  }
  |> lv.go(0)
  |> should.equal(#(Nil, 1))
}

pub fn use_do_return_test() {
  {
    use x <- lv.do(lv.get())
    use _ <- lv.do(lv.put(x + 1))
    lv.return("X")
  }
  |> lv.go(0)
  |> should.equal(#("X", 1))
}

pub fn get_test() {
  lv.get()
  |> lv.go(1)
  |> should.equal(#(1, 1))
}

pub fn put_test() {
  lv.put(2)
  |> lv.go(1)
  |> should.equal(#(Nil, 2))
}

pub fn modify_test() {
  lv.modify(fn(n) { n + 1 })
  |> lv.go(1)
  |> should.equal(#(Nil, 2))
}

pub fn map_test() {
  lv.State(fn(s) { #(1, s) })
  |> lv.map(fn(n) { n + 1 })
  |> lv.go(1)
  |> should.equal(#(2, 1))
}

pub fn gen_id_test() {
  {
    use n1 <- lv.do(lv.gen_id())
    use n2 <- lv.do(lv.gen_id())
    use n3 <- lv.do(lv.gen_id())
    lv.return(#(n1, n2, n3))
  }
  |> lv.go(1)
  |> should.equal(#(#(1, 2, 3), 4))
}

pub fn seq_test() {
  lv.seq(lv.get(), lv.put(5))
  |> lv.go(1)
  |> should.equal(#(Nil, 5))
}

pub fn all_empty_test() {
  lv.all([])
  |> lv.go(1)
  |> should.equal(#([], 1))
}

pub fn all_singleton_test() {
  lv.all([lv.gen_id()])
  |> lv.go(1)
  |> should.equal(#([1], 2))
}

pub fn all_list_test() {
  lv.all([lv.gen_id(), lv.gen_id(), lv.gen_id(), lv.gen_id(), lv.gen_id()])
  |> lv.go(1)
  |> should.equal(#([1, 2, 3, 4, 5], 6))
}

pub fn exec_all_empty_test() {
  lv.exec_all([])
  |> lv.go(1)
  |> should.equal(#(Nil, 1))
}

pub fn exec_all_singleton_test() {
  lv.exec_all([lv.gen_id()])
  |> lv.go(1)
  |> should.equal(#(Nil, 2))
}

pub fn exec_all_list_test() {
  lv.exec_all([lv.gen_id(), lv.gen_id(), lv.gen_id(), lv.gen_id(), lv.gen_id()])
  |> lv.go(1)
  |> should.equal(#(Nil, 6))
}

pub fn locally_test() {
  lv.locally(lv.seq(lv.gen_id(), lv.gen_id())) 
  |> lv.go(1)
  |> should.equal(#(2, 1))

}
