# Lab 03: Propositions as Types

## Overview

This lab explores the **Curry-Howard correspondence**, the fundamental insight that propositions correspond to types and proofs correspond to programs. This is the heart of the connection between ITT and Lean.

## Learning Objectives

- Understand the Curry-Howard isomorphism
- Recognize propositions as types in Lean
- Construct proofs as terms
- Work with logical connectives as type constructors

## The Curry-Howard Correspondence

### The Big Idea

There is a deep correspondence between:

| Logic | Programming | Type Theory |
|-------|-------------|-------------|
| Proposition | Type | Type |
| Proof | Program | Term |
| True proposition | Inhabited type | Type with a term |
| False proposition | Empty type | Type with no terms |

### In ITT and Lean

A proposition `P` is a type, and a proof of `P` is a term `p : P`.

```lean
-- A proposition
def MyProp : Prop := 2 + 2 = 4

-- A proof is a term of that type
theorem myProof : MyProp := rfl
```

## Logical Connectives as Type Constructors

### Implication (→)

**Logic**: P → Q (if P then Q)  
**Type Theory**: Function type P → Q

```lean
-- Implication is function type
theorem modus_ponens (P Q : Prop) : P → (P → Q) → Q :=
  fun hp : P =>
  fun hpq : P → Q =>
  hpq hp
```

### Conjunction (∧)

**Logic**: P ∧ Q (P and Q)  
**Type Theory**: Product type P × Q

```lean
-- Conjunction as a pair
theorem and_intro (P Q : Prop) : P → Q → P ∧ Q :=
  fun hp : P =>
  fun hq : Q =>
  And.intro hp hq

-- Projections
theorem and_elim_left (P Q : Prop) : P ∧ Q → P :=
  fun h : P ∧ Q => h.left
```

### Disjunction (∨)

**Logic**: P ∨ Q (P or Q)  
**Type Theory**: Sum type P ⊕ Q

```lean
-- Disjunction as sum
theorem or_intro_left (P Q : Prop) : P → P ∨ Q :=
  fun hp : P => Or.inl hp

theorem or_intro_right (P Q : Prop) : Q → P ∨ Q :=
  fun hq : Q => Or.inr hq
```

### Negation (¬)

**Logic**: ¬P (not P)  
**Type Theory**: P → False

```lean
-- Negation is function to False
def Not (P : Prop) : Prop := P → False

-- Example: prove something leads to contradiction
theorem not_true_eq_false : ¬(True = False) :=
  fun h : True = False =>
  -- h : True = False leads to absurdity
  nomatch h
```

### Universal Quantification (∀)

**Logic**: ∀ x : A, P(x)  
**Type Theory**: Dependent function type Π x : A, P(x)

```lean
-- Universal quantification
theorem forall_example : ∀ n : Nat, n = n :=
  fun n => rfl
```

### Existential Quantification (∃)

**Logic**: ∃ x : A, P(x)  
**Type Theory**: Dependent pair type Σ x : A, P(x)

```lean
-- Existential quantification
theorem exists_example : ∃ n : Nat, n > 0 :=
  ⟨1, Nat.zero_lt_one⟩
```

## Prop vs Type

In Lean, `Prop` is the universe of propositions, distinct from `Type`:

```lean
-- Propositions
def P : Prop := 2 + 2 = 4

-- Data types
def N : Type := Nat

-- Prop is proof-irrelevant
-- Two proofs of the same proposition are considered equal
```

## Examples: Proofs as Programs

### Simple Proof

```lean
-- Proposition
theorem simple : 1 + 1 = 2 := 
  rfl  -- proof by reflexivity

-- The proof 'rfl' is a term of type '1 + 1 = 2'
```

### Proof by Construction

```lean
-- Proposition with implication
theorem implication_example (P Q : Prop) (hp : P) (hpq : P → Q) : Q :=
  hpq hp  -- Apply function hpq to argument hp
```

## ITT Perspective

### Type Formation for Propositions

In ITT, propositions are formed using specific type constructors:

```
Γ ⊢ A : Prop    Γ ⊢ B : Prop
────────────────────────────
   Γ ⊢ A ∧ B : Prop
```

### Proof Terms

Every proposition in ITT must be proven constructively:
- A proof of `A ∧ B` must contain proofs of both `A` and `B`
- A proof of `A ∨ B` must specify which disjunct holds
- A proof of `∃ x : A, P(x)` must provide a witness `a : A` and a proof of `P(a)`

## Exercises

1. Prove basic logical tautologies using term notation
2. Construct proofs of propositions involving ∧, ∨, →
3. Write proofs that use universal and existential quantifiers
4. Compare proof irrelevance in `Prop` vs data in `Type`

## Next Steps

→ Continue to [Lab 04: Dependent Types](04-dependent-types.md) to explore the full power of dependent type theory.

## Related Topics

- [Type Theory Basics](02-type-theory.md)
- [Dependent Types](04-dependent-types.md)
- [Tactics](07-tactics.md)
