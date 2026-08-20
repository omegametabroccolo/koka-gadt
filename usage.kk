import lambda

val id' = Lam fn(x) x
val const' = Lam fn(x) Lam fn(_) x
val wrong/loop = App(Lam fn(x) App(x,x), Lam fn(x) App(x,x))

fun main()
  val zero = lam fn(_) lam fn(x) x
  val succ = lam fn(n) lam fn(f) lam fn(x) f.app(n.app(f).app(x))

  val add = lam fn(m) lam fn(n) lam fn(f) lam fn(x) m.app(f).app(n.app(f).app(x))

  val two = succ.app(succ.app(zero))
  val twoplustwo = add.app(two).app(two)
  val four = succ.app(succ.app(succ.app(succ.app(zero))))

  trace("- 2 + 2:")
  twoplustwo.show.trace
  trace("- reduced:")
  twoplustwo.eval.show.trace
  trace("====")
  trace("- 4:")
  four.show.trace
  trace("- reduced:")
  four.eval.show.trace
  trace("====")

  // cheating, since equality doesn't work...
  if twoplustwo.eval.show == four.eval.show then trace("2 + 2 = 4!")
