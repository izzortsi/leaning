# Lab 06: Equality

## Overview

This lab explores the different notions of equality in ITT and Lean: definitional equality, propositional equality, and their relationships. Understanding equality is crucial for both theoretical foundations and practical theorem proving.

## Learning Objectives

- Distinguish definitional and propositional equality
- Use propositional equality in proofs
- Understand equality elimination (transport and substitution)
- Work with heterogeneous equality when needed

## Two Kinds of Equality

### Definitional Equality (≡)

**Definitional equality** is a judgment, not a type. Two terms are definitionally equal if they are the same by definition, up to computation.

```lean
-- These are definitionally equal
#reduce 2 + 2        -- 4
#reduce 4            -- 4

-- Definitional equality is automatic
def x : Nat := 2 + 2
def y : Nat := 4
-- x and y have definitionally equal values

-- rfl works for definitional equality
example : 2 + 2 = 4 := rfl
```

### Propositional Equality (=)

**Propositional equality** is a type (proposition). It must be proven.

```lean
-- Propositional equality is a type
#check (2 + 2 = 4)   -- Prop

-- Equality type
inductive Eq {α : Type} : α → α → Prop where
  | refl (a : α) : Eq a a

-- Notation: a = b  means  Eq a b
```

## The Equality Type in ITT

### Formation Rule

```
Γ ⊢ A : Type    Γ ⊢ a : A    Γ ⊢ b : A
───────────────────────────────────────
        Γ ⊢ (a = b) : Prop
```

### Introduction Rule (Reflexivity)

```
Γ ⊢ a : A
──────────────
Γ ⊢ refl : a = a
```

### Elimination Rule (Substitution/Transport)

Also known as the **J rule** or **path induction**:

```
Γ ⊢ C : (x : A) → (y : A) → (x = y) → Type
Γ ⊢ c : (x : A) → C x x refl
Γ ⊢ a : A
Γ ⊢ b : A  
Γ ⊢ p : a = b
────────────────────────────────────────────
Γ ⊢ J(C, c, a, b, p) : C a b p
```

## Working with Equality in Lean

### Reflexivity

```lean
-- rfl proves x = x
theorem refl_example (x : Nat) : x = x := rfl

-- Works for any definitionally equal terms
example : 2 + 2 = 4 := rfl
example : (fun x => x + 1) 5 = 6 := rfl
```

### Symmetry

```lean
-- If x = y then y = x
theorem symm_example {α : Type} (x y : α) (h : x = y) : y = x :=
  h.symm

-- Or using Eq.symm
theorem symm_explicit {α : Type} (x y : α) (h : x = y) : y = x :=
  Eq.symm h
```

### Transitivity

```lean
-- If x = y and y = z then x = z
theorem trans_example {α : Type} (x y z : α) 
    (h1 : x = y) (h2 : y = z) : x = z :=
  h1.trans h2

-- Or using Eq.trans
theorem trans_explicit {α : Type} (x y z : α)
    (h1 : x = y) (h2 : y = z) : x = z :=
  Eq.trans h1 h2
```

### Substitution (Congruence)

```lean
-- If x = y, then f(x) = f(y)
theorem congr_example {α β : Type} (f : α → β) (x y : α) 
    (h : x = y) : f x = f y :=
  congrArg f h

-- For functions: if f = g and x = y, then f(x) = g(y)
theorem congr_fun_arg {α β : Type} (f g : α → β) (x y : α)
    (hf : f = g) (hx : x = y) : f x = g y :=
  hf ▸ hx ▸ rfl
```

### Transport (Substitution in Propositions)

```lean
-- The ▸ operator is transport/substitution
-- If h : x = y and p : P(x), then h ▸ p : P(y)

example {α : Type} (P : α → Prop) (x y : α) 
    (h : x = y) (px : P x) : P y :=
  h ▸ px

-- Explicit form
example {α : Type} (P : α → Prop) (x y : α)
    (h : x = y) (px : P x) : P y :=
  Eq.subst h px
```

## Equality and Computation

### Computation Rules

Definitional equality follows computation rules:

```lean
-- Beta reduction: (λx. e) a ≡ e[a/x]
example : (fun x => x + 1) 5 = 6 := rfl

-- Pattern matching reduces
def isZero : Nat → Bool
  | 0 => true
  | _ => false

example : isZero 0 = true := rfl
```

### Eta Conversion

```lean
-- Eta conversion for functions
example (f : Nat → Nat) : (fun x => f x) = f := rfl

-- Eta conversion for pairs
example (p : Nat × Nat) : (p.1, p.2) = p := rfl
```

## Heterogeneous Equality (HEq)

Sometimes we need to compare terms of potentially different types:

```lean
-- Heterogeneous equality
axiom HEq {α : Sort u} (a : α) {β : Sort u} (b : β) : Prop

-- Notation: a == b

-- If types are equal and terms are equal, then heq
theorem heq_of_eq {α : Type} (a b : α) (h : a = b) : a == b :=
  sorry -- implementation details
```

## Proof Irrelevance

In `Prop`, all proofs of the same proposition are equal:

```lean
-- Proof irrelevance
axiom proof_irrel {P : Prop} (h1 h2 : P) : h1 = h2

-- This means we can't distinguish between different proofs
-- Only matters that a proof exists, not which proof
```

## The K Axiom and UIP

**Uniqueness of Identity Proofs (UIP)**: All proofs of equality are equal.

```lean
-- UIP: for any type with decidable equality
theorem uip {α : Type} [DecidableEq α] (x : α) (h : x = x) : h = rfl :=
  sorry -- proof omitted
```

In Lean's type theory, UIP holds for all types (not just those with decidable equality).

## Exercises

1. Prove symmetry and transitivity of equality from scratch
2. Use equality to prove arithmetic properties
3. Practice using `▸` for substitution
4. Prove that equality is an equivalence relation

## Next Steps

→ Continue to [Lab 07: Tactics](07-tactics.md) to learn interactive proof construction.

## Related Topics

- [Propositions as Types](03-propositions-as-types.md)
- [Inductive Types](05-inductive-types.md)
- [Tactics](07-tactics.md)
