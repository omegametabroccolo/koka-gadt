module teq

abstract struct teqtok<a,b>
pub alias teq<a,b> = () -> teqtok<a,b>

pub extern inj(x: a, ?teq: teq<a,b>): b { inline "#1" }
pub extern prj(x: b, ?teq: teq<a,b>): a { inline "#1" }

pub fun refl/teq(): teqtok<a,a> Teqtok
pub fun default/sym/teq(?teq: teq<a,b>): teqtok<b,a> Teqtok
pub fun default/trans/teq(?fst/teq: teq<a,b>, ?snd/teq: teq<a,c>): teqtok<b,c> Teqtok

pub fun default/arr/con/teq(?dom/teq: teq<a,c>, ?rng/teq: teq<b,d>, ?eff/teq: teq<e,f>): teqtok<a -> b,c -> d> Teqtok
pub fun default/arr/dom/teq(?teq: teq<a -> _,c -> _>): teqtok<a,c> Teqtok
pub fun default/arr/rng/teq(?teq: teq<_ -> b,_ -> d>): teqtok<b,d> Teqtok

pub fun default/k1/con/teq(?fst/teq: teq<a,b>): teqtok<k<a>,k<b>> Teqtok
