/// State monad
pub type State(s, a) {
  State(run: fn(s) -> #(a, s))
}

/// Apply a state function `st` to an initial state and return a pair of a value and the final state
pub fn go(st: State(s, a), initial: s) -> #(a, s) {
  st.run(initial)
}

/// Apply a state function `st` to an initial state and just return the computation's result
pub fn eval(st: State(s, a), initial: s) -> a {
  go(st, initial).0
}

/// Apply a state function `st` to an initial state and return the final state
pub fn exec(st: State(s, a), with initial: s) -> s {
  go(st, initial).1
}

/// Monadic return that allows you to use gleam's `use` syntax as a replacement for `do` notation
/// Check `do` for examples
pub fn return(x: a) -> State(s, a) {
  State(fn(s) { #(x, s) })
}

/// Monadic bind (>>=) that allows you to use gleam's `use` syntax as a replacement for `do` notation
pub fn do(st: State(s, a), f: fn(a) -> State(s, b)) -> State(s, b) {
  State(fn(s1) {
    case go(st, s1) {
      #(x, s2) -> go(f(x), s2)
    }
  })
}

/// Sets the resulting value to the current state
pub fn get() -> State(s, s) {
  State(fn(s) { #(s, s) })
}

/// Sets the state value to a given state `x`
/// Replaces the return value with Nil
pub fn put(x: s) -> State(s, Nil) {
  State(fn(_) { #(Nil, x) })
}

/// Apply the function `f` to the current state
/// Replaces the return value with Nil
pub fn modify(f: fn(s) -> s) -> State(s, Nil) {
  use x <- do(get())
  put(f(x))
}

/// Apply the function `f` to the resulting value of `s`
pub fn map(st: State(s, a), f: fn(a) -> b) -> State(s, b) {
  State(fn(s1) {
    case go(st, s1) {
      #(x, s2) -> #(f(x), s2)
    }
  })
}
