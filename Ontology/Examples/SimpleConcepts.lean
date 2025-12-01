/-
  Simple Ontology Example

  A simple two-concept ontology demonstrating the framework.

  Author: Igor Strozzi
  Course: Intuitionistic Type Theory and Lean (Prof. Francesco Noseda)
-/

import Ontology.OntologicalAlgebra
import Ontology.Examples.Three

/-! ## Simple Concepts Ontology -/

/-- A simple two-concept ontology -/
inductive SimpleConcepts where
  | entity : SimpleConcepts    -- Generic entity
  | everything : SimpleConcepts -- Universal top
  deriving DecidableEq, Repr

namespace SimpleConcepts

def partOf : SimpleConcepts → SimpleConcepts → Prop
  | entity, _ => True
  | everything, everything => True
  | everything, entity => False

def C : SimpleConcepts → SimpleConcepts → Prop := fun _ _ => True

instance : MereotopologicalOntology SimpleConcepts where
  partOf := partOf
  C := C
  partOf_refl := fun x => by cases x <;> trivial
  partOf_trans := fun {x y z} hxy hyz => by
    cases x <;> cases y <;> cases z <;> simp_all [partOf]
  partOf_antisymm := fun {x y} hxy hyx => by
    cases x <;> cases y <;> simp_all [partOf]
  C_refl := fun x => by trivial
  C_symm := fun {x y} h => by trivial
  part_connected := fun {x y} h => by trivial

/-- The interpretation into Three -/
def interpSimple : SimpleConcepts → Three
  | entity => Three.mid
  | everything => Three.top

instance : OntologicalAlgebra SimpleConcepts Three where
  interp := interpSimple
  interp_mono := fun {c₁ c₂} h => by
    cases c₁ <;> cases c₂ <;> first | trivial | simp_all [interpSimple, partOf]
  connected_nontrivial := fun {c₁ c₂} h => by
    cases c₁ <;> cases c₂ <;> simp only [interpSimple] <;> decide

-- Example computations
#eval interpSimple SimpleConcepts.entity  -- Three.mid
#eval Three.inf (interpSimple SimpleConcepts.entity)
                (interpSimple SimpleConcepts.everything)  -- Three.mid

end SimpleConcepts
