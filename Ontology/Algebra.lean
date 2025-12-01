/-
  Algebraic Foundations for Mereotopological Ontology

  No Mathlib dependencies - all structures defined from first principles.

  Author: Igor Strozzi
  Course: Intuitionistic Type Theory and Lean (Prof. Francesco Noseda)
-/

universe u

/-! ## Partial Order -/

/-- A partial order with explicit axioms -/
class PartialOrder' (α : Type u) where
  le : α → α → Prop
  le_refl : ∀ a, le a a
  le_trans : ∀ {a b c}, le a b → le b c → le a c
  le_antisymm : ∀ {a b}, le a b → le b a → a = b

instance {α : Type u} [PartialOrder' α] : LE α := ⟨PartialOrder'.le⟩

/-! ## Lattice -/

/-- A lattice has meet and join operations -/
class Lattice' (α : Type u) extends PartialOrder' α where
  inf : α → α → α
  sup : α → α → α
  inf_le_left : ∀ a b, le (inf a b) a
  inf_le_right : ∀ a b, le (inf a b) b
  le_inf : ∀ {a b c}, le a b → le a c → le a (inf b c)
  le_sup_left : ∀ a b, le a (sup a b)
  le_sup_right : ∀ a b, le b (sup a b)
  sup_le : ∀ {a b c}, le a c → le b c → le (sup a b) c

namespace Lattice'
variable {α : Type u} [Lattice' α]

-- Useful derived properties
theorem inf_comm (a b : α) : inf a b = inf b a := by
  apply PartialOrder'.le_antisymm
  · exact le_inf (inf_le_right a b) (inf_le_left a b)
  · exact le_inf (inf_le_right b a) (inf_le_left b a)

theorem inf_assoc (a b c : α) : inf (inf a b) c = inf a (inf b c) := by
  apply PartialOrder'.le_antisymm
  · apply le_inf
    · exact PartialOrder'.le_trans (inf_le_left _ _) (inf_le_left _ _)
    · apply le_inf
      · exact PartialOrder'.le_trans (inf_le_left _ _) (inf_le_right _ _)
      · exact inf_le_right _ _
  · apply le_inf
    · apply le_inf
      · exact inf_le_left _ _
      · exact PartialOrder'.le_trans (inf_le_right _ _) (inf_le_left _ _)
    · exact PartialOrder'.le_trans (inf_le_right _ _) (inf_le_right _ _)

theorem inf_idem (a : α) : inf a a = a := by
  apply PartialOrder'.le_antisymm
  · exact inf_le_left a a
  · exact le_inf (PartialOrder'.le_refl a) (PartialOrder'.le_refl a)

theorem sup_comm (a b : α) : sup a b = sup b a := by
  apply PartialOrder'.le_antisymm
  · exact sup_le (le_sup_right b a) (le_sup_left b a)
  · exact sup_le (le_sup_right a b) (le_sup_left a b)

end Lattice'

/-! ## Bounded Lattice -/

/-- A bounded lattice has top and bottom elements -/
class BoundedLattice (α : Type u) extends Lattice' α where
  top : α
  bot : α
  le_top : ∀ a, le a top
  bot_le : ∀ a, le bot a

namespace BoundedLattice
variable {α : Type u} [BoundedLattice α]

notation "⊤" => top
notation "⊥" => bot

theorem inf_bot (a : α) : Lattice'.inf a bot = bot := by
  apply PartialOrder'.le_antisymm
  · exact Lattice'.inf_le_right a bot
  · exact bot_le _

theorem sup_top (a : α) : Lattice'.sup a top = top := by
  apply PartialOrder'.le_antisymm
  · exact le_top _
  · exact Lattice'.le_sup_right a top

end BoundedLattice

/-! ## Heyting Algebra -/

/-- A Heyting algebra: the algebraic semantics of intuitionistic logic -/
class HeytingAlgebra (α : Type u) extends BoundedLattice α where
  /-- Relative pseudo-complement (Heyting implication) -/
  himp : α → α → α
  /-- The defining adjunction: a ⊓ b ≤ c ↔ a ≤ b ⇨ c -/
  le_himp_iff : ∀ {a b c}, le (Lattice'.inf a b) c ↔ le a (himp b c)

namespace HeytingAlgebra
variable {α : Type u} [HeytingAlgebra α]

-- Notation for Heyting implication
infixr:60 " ⇨ " => himp

/-- Pseudo-complement (negation) -/
def hnot (a : α) : α := himp a BoundedLattice.bot
prefix:80 "∼" => hnot

-- Key theorems

/-- Modus ponens in the algebra -/
theorem himp_inf_le (a b : α) : Lattice'.inf a (a ⇨ b) ≤ b := by
  have h := le_himp_iff.mpr (PartialOrder'.le_refl (a ⇨ b))
  rw [Lattice'.inf_comm] at h
  exact h

/-- a ≤ b implies a ⇨ b = ⊤ -/
theorem himp_eq_top_of_le {a b : α} (h : a ≤ b) : (a ⇨ b) = BoundedLattice.top := by
  apply PartialOrder'.le_antisymm
  · exact BoundedLattice.le_top _
  · apply le_himp_iff.mp
    calc Lattice'.inf BoundedLattice.top a
        = Lattice'.inf a BoundedLattice.top := Lattice'.inf_comm _ _
      _ = a := by apply PartialOrder'.le_antisymm; exact Lattice'.inf_le_left _ _;
                  exact Lattice'.le_inf (PartialOrder'.le_refl _) (BoundedLattice.le_top a)
      _ ≤ b := h

/-- Reflexivity of implication -/
theorem himp_self (a : α) : (a ⇨ a) = BoundedLattice.top := himp_eq_top_of_le (PartialOrder'.le_refl a)

/-- Double negation introduction -/
theorem le_hnot_hnot (a : α) : a ≤ ∼(∼a) := by
  apply le_himp_iff.mp
  exact himp_inf_le a BoundedLattice.bot

end HeytingAlgebra
