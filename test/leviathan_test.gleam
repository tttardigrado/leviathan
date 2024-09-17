import gleeunit
import gleeunit/should
import leviathan as st

pub fn main() {
  gleeunit.main()
}

pub fn go_test() {
  st.go(st.State(fn(s) { #(s + 1, s + 2) }), 1)
  |> should.equal(#(2, 3))
}

pub fn eval_test() {
  st.eval(st.State(fn(s) { #(s + 1, s + 2) }), 1)
  |> should.equal(2)
}

pub fn exec_test() {
  st.exec(st.State(fn(s) { #(s + 1, s + 2) }), 1)
  |> should.equal(3)
}
