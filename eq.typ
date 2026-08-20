#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

#set document(title: [GADTs in Koka])
#set text(font: "New Computer Modern")

#let rule-set = (..args) => align(center, rule-set(..args))
#let prooftree = (..args) => align(center, prooftree(..args))

#show title: set align(center)

//#title()

= Inference rules

#let refl = prooftree(rule(
  name: "refl",
  $A = A$,
))

#let sym = prooftree(rule(
  name: "sym",
  $A = B$,
  $B = A$,
))

#let trans = prooftree(rule(
  name: "trans",
  $A = B$,
  $A = C$,
  $B = C$,
))

#let arr-con = prooftree(rule(
  name: "arr/con",
  $A = C$,
  $B = D$,
  $A -> B = C -> D$,
))

#let arr-dom = prooftree(rule(
  name: "arr/dom",
  $A -> \_ = C -> \_$,
  $A = C$,
))

#let arr-rng = prooftree(rule(
  name: "arr/rng",
  $\_ -> B = \_ -> D$,
  $B = D$,
))

#let k1-con = prooftree(rule(
  name: "k1/con",
  $A = B$,
  $K(A) = K(B)$,
))

#rule-set(refl)
#rule-set(sym, trans)
#rule-set(arr-con, arr-dom, arr-rng)
#rule-set(k1-con)

= Some proofs

== `eq1/teq`

- $A = B -> C, A = D -> E tack K(C) = K(E)$

#prooftree(rule(
  rule(
    rule(
      $A = B -> C$,
      $A = D -> E$,
      name: "trans",
      $B -> C = D -> E$,
    ),
    name: "arr/rng",
    $C = E$,
  ),
  name: "k1/con",
  $K(C) = K(E)$,
))

== `eval1/teq`

=== $A -> B = C -> D tack K(A) -> K(B) = K(C) -> K(D)$

#prooftree(rule(
  rule(
    rule(
      $A -> B = C -> D$,
      name: "arr/dom",
      $A = C$,
    ),
    name: "k1/con",
    $K(A) = K(C)$
  ),
  rule(
    rule(
      $A -> B = C -> D$,
      name: "arr/rng",
      $B = D$,
    ),
    name: "k1/con",
    $K(B) = K(D)$
  ),
  name: "arr/con",
  $K(A) -> K(B) = K(C) -> K(D)$,
))
