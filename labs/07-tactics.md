# Lab 07: Tactics

## Overview

This lab introduces **tactics** in Lean - the interactive method for constructing proofs. While proofs can be written as direct term constructions, tactics provide a more intuitive and incremental approach to building complex proofs.

## Learning Objectives

- Understand the relationship between tactics and proof terms
- Master basic tactics for common proof patterns
- Use tactic mode for interactive proof development
- Recognize when to use tactics vs. term mode

## Tactic Mode vs Term Mode

### Two Ways to Prove

```lean
-- Term mode: direct proof construction
theorem term_mode (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q :=
  And.intro hp hq

-- Tactic mode: interactive proof construction
theorem tactic_mode (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  apply And.intro
  · exact hp
  · exact hq
```

### The `by` Keyword

The `by` keyword switches from term mode to tactic mode:

```lean
theorem example_by : 2 + 2 = 4 := by
  rfl  -- tactic that applies reflexivity
```

## Basic Tactics

### `rfl` - Reflexivity

Proves goals by reflexivity (definitional equality):

```lean
example : 1 + 1 = 2 := by
  rfl

example (x : Nat) : x = x := by
  rfl
```

### `exact` - Provide Exact Proof Term

Closes the goal with an exact term:

```lean
theorem exact_example (P : Prop) (hp : P) : P := by
  exact hp
```

### `apply` - Apply Function/Theorem

Applies a function or theorem to the goal:

```lean
theorem apply_example (P Q : Prop) (hpq : P → Q) (hp : P) : Q := by
  apply hpq
  exact hp
```

### `intro` - Introduce Hypotheses

Introduces hypotheses for implications and universal quantifiers:

```lean
theorem intro_example (P Q : Prop) : P → Q → P := by
  intro hp
  intro hq
  exact hp

-- Or introduce multiple at once
theorem intro_multi (P Q : Prop) : P → Q → P := by
  intro hp hq
  exact hp
```

### `assumption` - Use a Hypothesis

Closes the goal using a hypothesis:

```lean
theorem assumption_example (P Q : Prop) (hp : P) : P := by
  assumption
```

## Logical Connectives

### Conjunction (∧)

```lean
-- Prove P ∧ Q
theorem and_intro (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor  -- same as: apply And.intro
  · exact hp
  · exact hq

-- Use P ∧ Q
theorem and_elim (P Q : Prop) (h : P ∧ Q) : P := by
  cases h with
  | intro hp hq => exact hp
  -- Or simply: exact h.left
```

### Disjunction (∨)

```lean
-- Prove P ∨ Q (from P)
theorem or_intro_left (P Q : Prop) (hp : P) : P ∨ Q := by
  apply Or.inl
  exact hp

-- Use P ∨ Q
theorem or_elim (P Q R : Prop) (h : P ∨ Q) (hpr : P → R) (hqr : Q → R) : R := by
  cases h with
  | inl hp => apply hpr; exact hp
  | inr hq => apply hqr; exact hq
```

### Implication (→)

```lean
-- Already covered by intro
theorem impl_intro (P Q : Prop) : P → (P → Q) → Q := by
  intro hp hpq
  apply hpq
  exact hp
```

### Negation (¬)

```lean
-- Negation is implication to False
theorem not_example (P : Prop) : P → ¬¬P := by
  intro hp hnp
  apply hnp
  exact hp
```

## Structural Tactics

### `constructor` - Construct Using Introduction Rule

Applies the appropriate constructor:

```lean
example (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor
  · exact hp
  · exact hq
```

### `cases` - Case Analysis

Performs case analysis on an inductive type:

```lean
theorem cases_example (n : Nat) : n = 0 ∨ n > 0 := by
  cases n with
  | zero => 
    apply Or.inl
    rfl
  | succ n' =>
    apply Or.inr
    exact Nat.zero_lt_succ n'
```

### `induction` - Structural Induction

Performs induction on an inductive type:

```lean
theorem induction_example (n : Nat) : 0 + n = n := by
  induction n with
  | zero => rfl
  | succ n' ih =>
    rw [Nat.add_succ]
    rw [ih]
```

## Rewriting

### `rw` - Rewrite

Rewrites using an equality:

```lean
theorem rw_example (x y : Nat) (h : x = y) : x + 1 = y + 1 := by
  rw [h]

-- Multiple rewrites
theorem rw_multi (x y z : Nat) (h1 : x = y) (h2 : y = z) : x = z := by
  rw [h1, h2]
```

### `rw [← h]` - Rewrite Backwards

Rewrites from right to left:

```lean
theorem rw_backward (x y : Nat) (h : y = x) : x + 1 = y + 1 := by
  rw [← h]
```

## Goal Management

### `·` - Focus on First Goal

The dot notation focuses on one goal:

```lean
theorem focus_example (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor
  · exact hp
  · exact hq
```

### `have` - Introduce Intermediate Results

Introduces an intermediate lemma:

```lean
theorem have_example (n : Nat) : n + 0 = n := by
  have h : 0 + n = n := Nat.zero_add n
  -- Use h in the rest of the proof
  sorry
```

### `show` - Explicitly State Goal

Makes the current goal explicit:

```lean
theorem show_example (P Q : Prop) (hp : P) : P ∨ Q := by
  show P ∨ Q
  apply Or.inl
  exact hp
```

## Advanced Tactics

### `simp` - Simplification

Simplifies using a database of lemmas:

```lean
theorem simp_example (x : Nat) : x + 0 = x := by
  simp

theorem simp_list : [1, 2] ++ [] = [1, 2] := by
  simp
```

### `ring` - Ring Arithmetic

Solves goals in commutative rings:

```lean
theorem ring_example (x y : Nat) : x + y = y + x := by
  ring
```

### `omega` - Linear Arithmetic

Solves linear arithmetic goals:

```lean
theorem omega_example (x y : Nat) (h1 : x < y) (h2 : y < 10) : x < 10 := by
  omega
```

## The Relationship to ITT

### Tactics Generate Terms

Every tactic sequence generates a proof term:

```lean
-- These are equivalent:
theorem version1 (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q :=
  And.intro hp hq

theorem version2 (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor
  · exact hp
  · exact hq

-- Check they produce similar terms
#print version1
#print version2
```

### Tactics as Proof Construction

Tactics are a meta-language for constructing proof terms. They provide:
- **Automation** - tactics can search for proofs
- **Readability** - tactic proofs are often clearer
- **Incrementality** - build proofs step by step

## Exercises

1. Prove logical tautologies using tactics
2. Prove properties of natural numbers using `induction`
3. Use `rw` to prove arithmetic identities
4. Compare tactic proofs with term-mode proofs

## Next Steps

Congratulations! You've completed the core labs on ITT and Lean. Review the [Topic Graph](../GRAPH.md) to explore connections between concepts.

## Related Topics

- [Propositions as Types](03-propositions-as-types.md)
- [Inductive Types](05-inductive-types.md)
- [Equality](06-equality.md)
