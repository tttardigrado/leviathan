import gleeunit
import gleeunit/should
import gleam/list
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
