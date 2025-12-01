/-
  Compositional Algebra

  Extends Heyting algebra with named operations for conceptual composition.

  Author: Igor Strozzi
  Course: Intuitionistic Type Theory and Lean (Prof. Francesco Noseda)
-/

import Ontology.Algebra

universe v

/-! ## Compositional Algebra -/

/-- A compositional algebra extends Heyting algebra with
    named operations for conceptual composition -/
class CompositionalAlgebra (A : Type v) extends HeytingAlgebra A where
  /-- Derivability relation -/
  derives : A → A → Prop := fun a b => Lattice'.inf a b = a

namespace CompositionalAlgebra
variable {A : Type v} [CompositionalAlgebra A]

open Lattice' HeytingAlgebra BoundedLattice

/-- Conceptual conjunction/composition -/
def compose (a b : A) : A := inf a b

/-- Sequential composition (implication) -/
def seq (a b : A) : A := himp a b

/-- Conceptual disjunction -/
def choice (a b : A) : A := sup a b

scoped notation:70 a " ⊗ " b => compose a b
scoped notation:60 a " ⟹ " b => seq a b
scoped notation:65 a " ⊕ " b => choice a b

-- Composition properties
theorem compose_comm (a b : A) : compose a b = compose b a := inf_comm a b

theorem compose_assoc (a b c : A) : compose (compose a b) c = compose a (compose b c) := inf_assoc a b c

theorem compose_idem (a : A) : compose a a = a := inf_idem a

/-- The adjunction captures the deductive nature -/
theorem adjunction (a b c : A) : compose a b ≤ c ↔ a ≤ seq b c := le_himp_iff

end CompositionalAlgebra
