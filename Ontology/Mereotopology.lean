/-
  Mereotopological Ontology

  Defines concepts with part-whole and connection relations.

  Author: Igor Strozzi
  Course: Intuitionistic Type Theory and Lean (Prof. Francesco Noseda)
-/

universe u

/-! ## Mereotopological Ontology -/

/-- A mereotopological ontology: concepts with part-whole and connection -/
class MereotopologicalOntology (O : Type u) where
  /-- Parthood relation -/
  partOf : O → O → Prop
  /-- Connection relation -/
  C : O → O → Prop
  -- Mereological axioms
  partOf_refl : ∀ x, partOf x x
  partOf_trans : ∀ {x y z}, partOf x y → partOf y z → partOf x z
  partOf_antisymm : ∀ {x y}, partOf x y → partOf y x → x = y
  -- Topological axioms
  C_refl : ∀ x, C x x
  C_symm : ∀ {x y}, C x y → C y x
  -- Coherence
  part_connected : ∀ {x y}, partOf x y → C x y

namespace MereotopologicalOntology
variable {O : Type u} [MereotopologicalOntology O]

/-- Proper parthood -/
def PP (x y : O) : Prop := partOf x y ∧ x ≠ y

/-- Overlap -/
def Overlap (x y : O) : Prop := ∃ z, partOf z x ∧ partOf z y

/-- Disjointness -/
def Disjoint (x y : O) : Prop := ¬ Overlap x y

/-- External connection -/
def EC (x y : O) : Prop := C x y ∧ Disjoint x y

-- Basic theorems
theorem Overlap_refl (x : O) : Overlap x x := ⟨x, partOf_refl x, partOf_refl x⟩

theorem Overlap_symm {x y : O} (h : Overlap x y) : Overlap y x :=
  let ⟨z, hz1, hz2⟩ := h; ⟨z, hz2, hz1⟩

theorem partOf_implies_Overlap {x y : O} (h : partOf x y) : Overlap x y :=
  ⟨x, partOf_refl x, h⟩

end MereotopologicalOntology
