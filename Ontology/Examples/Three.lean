/-
  Three-Element Chain Example

  A simple three-element Heyting algebra: ⊥ < a < ⊤

  Author: Igor Strozzi
  Course: Intuitionistic Type Theory and Lean (Prof. Francesco Noseda)
-/

import Ontology.Compositional

/-! ## Three-Element Chain -/

/-- A simple three-element Heyting algebra: ⊥ < a < ⊤ -/
inductive Three where
  | bot : Three
  | mid : Three
  | top : Three
  deriving DecidableEq, Repr

namespace Three

def le : Three → Three → Prop
  | bot, _ => True
  | mid, bot => False
  | mid, _ => True
  | top, top => True
  | top, _ => False

def inf : Three → Three → Three
  | bot, _ => bot
  | _, bot => bot
  | top, y => y
  | x, top => x
  | mid, mid => mid

def sup : Three → Three → Three
  | top, _ => top
  | _, top => top
  | bot, y => y
  | x, bot => x
  | mid, mid => mid

def himp : Three → Three → Three
  | _, top => top
  | bot, _ => top
  | top, bot => bot
  | top, mid => mid
  | mid, bot => bot
  | mid, mid => top

instance : PartialOrder' Three where
  le := le
  le_refl := fun a => by cases a <;> trivial
  le_trans := fun {a b c} hab hbc => by
    cases a <;> cases b <;> cases c <;> simp_all [le]
  le_antisymm := fun {a b} hab hba => by
    cases a <;> cases b <;> simp_all [le]

instance : Lattice' Three where
  inf := inf
  sup := sup
  inf_le_left := fun a b => by cases a <;> cases b <;> trivial
  inf_le_right := fun a b => by cases a <;> cases b <;> trivial
  le_inf := fun {a b c} hab hac => by
    cases a <;> cases b <;> cases c <;> simp_all [inf]
  le_sup_left := fun a b => by cases a <;> cases b <;> trivial
  le_sup_right := fun a b => by cases a <;> cases b <;> trivial
  sup_le := fun {a b c} hac hbc => by
    cases a <;> cases b <;> cases c <;> simp_all [sup]

instance : BoundedLattice Three where
  top := Three.top
  bot := Three.bot
  le_top := fun a => by cases a <;> trivial
  bot_le := fun a => by trivial

instance : HeytingAlgebra Three where
  himp := himp
  le_himp_iff := fun {a b c} => by
    cases a <;> cases b <;> cases c <;> simp [himp] <;> trivial

instance : CompositionalAlgebra Three where

end Three
