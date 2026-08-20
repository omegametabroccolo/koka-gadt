module lambda

import std/core/undiv
import teq

abstract div type term<t>
  Free<a>(v: int, ?teq: teq<t,a>)
  Lam<a,b>(f: term<a> -> term<b>, ?teq: teq<t,a -> b>)
  App<a,b>(t1: term<a -> b>, t2: term<a>, ?teq: teq<t,b>)

pub fun lam(f: term<a> -> term<b>): term<a -> b> { Lam(f) }
pub fun app(t1: term<a -> b>, t2: term<a>): term<b> { App(t1,t2) }

pub fun term/show(t: term<t>, d: int = 1): div string
  match t
    Free(v)    -> "x" ++ v.show
    Lam(f)     -> "\\x" ++ d.show ++ "." ++ f(Free(d)).show(d+1)
    App(t1,t2) -> "(" ++ t1.show(d) ++ " " ++ t2.show(d) ++ ")"

//

fun eq1/teq(?bc/teq: teq<a,b -> c>, ?de/teq: teq<a,d -> e>): teqtok<term<c>,term<e>>
  k1/con/teq {arr/rng/teq {trans/teq()}}

pub fun term/(==)(t1: term<a>, t2: term<a>, d: int = 0): div bool
  match t1
    Free(v1) -> match t2
      Free(v2) -> v1 == v2
      _ -> False
    Lam(f1,f1/teq) -> match t2
      Lam(f2,f2/teq) ->
        val t1' = f1(Free(d))
        val t2' = f2(Free(d))
        (==)(t1'.prj(eq1/teq), t2', d+1)
      _ -> False
    App(_,_) -> impossible(":(")

//

fun eval1/teq(?ab-cd/teq: teq<a -> c,b -> d>): teqtok<term<a> -> term<c>,term<b> -> term<d>>
  val tac = k1/con/teq {arr/dom/teq()}
  val tbd = k1/con/teq {arr/rng/teq()}
  arr/con/teq({tac}, {tbd})

pub fun term/eval(t: term<t>): div term<t>
  match t
    Free(v) -> Free(v)
    Lam(f,t/teq) -> Lam fn(x) pretend-no-div {eval(f(x))}
    App(t1,t2,app/teq) -> match t1.eval
      Lam(f1,f1/teq) ->
        val f1' = f1.prj(eval1/teq)
        f1'(t2.eval).prj{k1/con/teq(app/teq)}
      t1' -> App(t1', t2.eval)
