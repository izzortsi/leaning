/-
  Ontological Algebra - The Action

  Defines how the compositional algebra acts on the mereotopological ontology.

  Author: Igor Strozzi
  Course: Intuitionistic Type Theory and Lean (Prof. Francesco Noseda)
-/

import Ontology.Mereotopology
import Ontology.Compositional

universe u v

/-! ## Ontological Algebra -/

/-- An ontological algebra: the algebra 𝒜 acting on ontology 𝒪 -/
class OntologicalAlgebra (O : Type u) (A : Type v)
    [MereotopologicalOntology O] [CompositionalAlgebra A] where
  /-- Interpretation function -/
  interp : O → A
  /-- Preserves mereological structure -/
  interp_mono : ∀ {c₁ c₂ : O}, MereotopologicalOntology.partOf c₁ c₂ →
    interp c₁ ≤ interp c₂
  /-- Connected concepts have non-trivial composition -/
  connected_nontrivial : ∀ {c₁ c₂ : O}, MereotopologicalOntology.C c₁ c₂ →
    Lattice'.inf (interp c₁) (interp c₂) ≠ BoundedLattice.bot

namespace OntologicalAlgebra
variable {O : Type u} {A : Type v}
variable [MereotopologicalOntology O] [CompositionalAlgebra A]
variable [OntologicalAlgebra O A]

open Lattice' HeytingAlgebra BoundedLattice CompositionalAlgebra

/-- Semantic brackets -/
notation "⦃" c "⦄" => interp c

/-- The fundamental operation: (C₁, C₂) ↦ ⦃C₁⦄ ⊓ ⦃C₂⦄ ∈ A -/
def combine (c₁ c₂ : O) : A := inf ⦃c₁⦄ ⦃c₂⦄

/-- Conceptual implication -/
def conceptImpl (c₁ c₂ : O) : A := himp ⦃c₁⦄ ⦃c₂⦄

notation c₁ " ▷ " c₂ => combine c₁ c₂
notation c₁ " ⊸ " c₂ => conceptImpl c₁ c₂

-- Key theorems

/-- Parthood induces algebraic derivability -/
theorem partOf_derives {c₁ c₂ : O}
    (h : MereotopologicalOntology.partOf c₁ c₂) :
    inf (interp (A := A) c₁) (interp c₂) = interp c₁ := by
  apply PartialOrder'.le_antisymm
  · exact inf_le_left (interp c₁) (interp c₂)
  · exact le_inf (PartialOrder'.le_refl (interp c₁)) (interp_mono h)

/-- Overlapping concepts have non-trivial combination -/
theorem overlap_nontrivial {c₁ c₂ : O}
    (h : MereotopologicalOntology.Overlap c₁ c₂) :
    (c₁ ▷ c₂) ≠ (BoundedLattice.bot : A) := by
  obtain ⟨z, hz1, hz2⟩ := h
  intro hcontra
  have h1 : (interp z : A) ≤ interp c₁ := interp_mono hz1
  have h2 : (interp z : A) ≤ interp c₂ := interp_mono hz2
  have h3 : (interp z : A) ≤ (c₁ ▷ c₂) := le_inf h1 h2
  have h4 : (interp z : A) ≤ BoundedLattice.bot := by rw [← hcontra]; exact h3
  have hconn := MereotopologicalOntology.C_refl z
  have hne := connected_nontrivial (A := A) hconn
  rw [inf_idem] at hne
  have heq : (interp z : A) = BoundedLattice.bot := PartialOrder'.le_antisymm h4 (bot_le (interp z))
  exact hne heq

/-- Modus ponens for concepts -/
theorem concept_modus_ponens (c₁ c₂ : O) :
    inf (interp (A := A) c₁) (c₁ ⊸ c₂) ≤ interp c₂ :=
  himp_inf_le (interp c₁) (interp c₂)

/-- Parthood implies implication is top -/
theorem partOf_impl_top {c₁ c₂ : O}
    (h : MereotopologicalOntology.partOf c₁ c₂) :
    (c₁ ⊸ c₂) = (BoundedLattice.top : A) :=
  himp_eq_top_of_le (interp_mono h)

end OntologicalAlgebra
