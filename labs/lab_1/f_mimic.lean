-- F system mimic in lean
-- define and, or, false

#check And
#check and

namespace poly

variable (p q : Prop)

def and : Prop :=
  ∀r : Prop, (p → q → r) → r

def or : Prop :=
  ∀r : Prop, (p → r) → (q → r) → r

def false : Prop :=
  ∀r : Prop, r

#check and
#print and
#check or
#print or
#check false
#print false

#check and p q -- our p ∧ q
#check or p q  -- our p ∨ q
#check false   -- our false

-- and intro, ordered pair
theorem op (x : p) (y : q) : and p q := by
  intro r
  intro f
  apply f
  repeat assumption

-- and elim
theorem π_l (z : and p q) : p := by
  apply z
  intros; assumption

theorem π_r (z : and p q) : q := by
  apply z
  intros; assumption

-- or intro, left
theorem in_l (z : p) : or p q := by
  intro r
  intro f g
  apply f
  assumption

-- or intro, right
theorem in_r (z : q) : or p q := by
  intro r
  intro f g
  apply g
  assumption

-- false elim
theorem ex_falso (z : false) : p := by
  apply z

#print ex_falso


section print
variable (x : p) (y : q) (z : and p q)

#check op p q x y -- and p q
#check π_l p q z -- p
#check π_r p q z -- q
#check op _ _ x y

-- implicit variables
variable {s t : Prop}

theorem op_implicit (x : s) (y : t) : and s t := by
  intro r
  intro f
  apply f
  repeat assumption

#check op_implicit x y -- and s t
#check @op_implicit p q x y

end print
