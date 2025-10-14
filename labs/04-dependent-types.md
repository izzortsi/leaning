# Lab 04: Dependent Types

## Overview

This lab explores **dependent types**, the feature that distinguishes ITT from simple type theory. Dependent types allow types to depend on values, enabling precise specifications and powerful abstractions.

## Learning Objectives

- Understand dependent function types (Π-types)
- Work with dependent pair types (Σ-types)
- Use dependent types for precise specifications
- Implement dependent types in Lean

## What are Dependent Types?

In simple type theory, types are static. In dependent type theory, types can depend on **values**:

```lean
-- Non-dependent: type doesn't depend on the value
def repeat (n : Nat) : String := "x"

-- Dependent: return type depends on the value of n
def Vector (α : Type) (n : Nat) : Type := 
  { l : List α // l.length = n }
```

## Dependent Function Types (Π-types)

### The General Form

**Non-dependent function**: `A → B` (type B doesn't depend on the input)  
**Dependent function**: `(x : A) → B(x)` (type B depends on input x)

In ITT notation: `Π x : A, B(x)`  
In Lean notation: `(x : A) → B x` or `∀ x : A, B x`

### Examples in Lean

```lean
-- Non-dependent function type
def simple : Nat → String := 
  fun n => "number"

-- Dependent function type
def typeFamily (n : Nat) : Type := 
  if n = 0 then Nat else String

-- Function with dependent return type
def dependentFunc (n : Nat) : typeFamily n :=
  if h : n = 0 then 
    42  -- returns Nat when n = 0
  else 
    "hello"  -- returns String when n ≠ 0
```

### Universal Quantification

Universal quantification is a dependent function type:

```lean
-- ∀ x : Nat, x = x  is the same as  (x : Nat) → x = x
theorem forall_is_pi : ∀ x : Nat, x = x :=
  fun x => rfl  -- returns a proof for each x

-- The type of the result depends on x
#check (forall_is_pi 5)  -- 5 = 5
```

## Dependent Pair Types (Σ-types)

### The General Form

**Non-dependent pair**: `A × B` (both components have fixed types)  
**Dependent pair**: `Σ x : A, B(x)` (second component's type depends on first)

In Lean: `(x : A) × B x` or `Σ x : A, B x`

### Examples in Lean

```lean
-- Non-dependent pair
def simplePair : Nat × String := (42, "answer")

-- Dependent pair: type of second component depends on first
def DependentPair : Type := 
  (n : Nat) × (if n = 0 then String else Bool)

def depPairExample1 : DependentPair := 
  ⟨0, "zero"⟩  -- String when n = 0

def depPairExample2 : DependentPair := 
  ⟨5, true⟩  -- Bool when n ≠ 0
```

### Existential Quantification

Existential quantification is a dependent pair type:

```lean
-- ∃ x : Nat, x > 0  is the same as  Σ x : Nat, x > 0
theorem exists_is_sigma : ∃ x : Nat, x > 0 :=
  ⟨1, Nat.zero_lt_one⟩  -- provide witness and proof

-- The proof depends on the witness
```

## Dependent Types for Specifications

### Length-Indexed Vectors

```lean
-- Vector type: lists with statically-known length
inductive Vector (α : Type u) : Nat → Type u where
  | nil : Vector α 0
  | cons : α → {n : Nat} → Vector α n → Vector α (n + 1)

-- Head function with precise type
def head {α : Type} {n : Nat} : Vector α (n + 1) → α :=
  fun v => match v with
  | Vector.cons a _ => a
  -- No need to handle empty case - impossible by types!
```

### Bounded Natural Numbers

```lean
-- Natural numbers less than n
def Fin (n : Nat) : Type := 
  { i : Nat // i < n }

-- Type-safe array indexing
def safeGet {α : Type} {n : Nat} (arr : Vector α n) (i : Fin n) : α :=
  sorry  -- implementation uses the fact that i < n
```

## The ITT Perspective

### Π-type Formation Rule

```
Γ ⊢ A : Type    Γ, x : A ⊢ B(x) : Type
───────────────────────────────────────
      Γ ⊢ (Π x : A, B(x)) : Type
```

Introduction (lambda abstraction):
```
Γ, x : A ⊢ b(x) : B(x)
──────────────────────────────
Γ ⊢ (λ x, b(x)) : (Π x : A, B(x))
```

Elimination (application):
```
Γ ⊢ f : (Π x : A, B(x))    Γ ⊢ a : A
─────────────────────────────────────
      Γ ⊢ f(a) : B(a)
```

### Σ-type Formation Rule

```
Γ ⊢ A : Type    Γ, x : A ⊢ B(x) : Type
───────────────────────────────────────
      Γ ⊢ (Σ x : A, B(x)) : Type
```

Introduction (pairing):
```
Γ ⊢ a : A    Γ ⊢ b : B(a)
──────────────────────────────
Γ ⊢ (a, b) : (Σ x : A, B(x))
```

## Dependent Types vs Generics

### Generics (Polymorphism)

```lean
-- Type parameter (polymorphism)
def identity (α : Type) (x : α) : α := x

-- Lean infers type parameters
def id {α : Type} (x : α) : α := x
```

### True Dependent Types

```lean
-- Return type depends on *value* of n
def replicate (α : Type) (n : Nat) (x : α) : Vector α n :=
  match n with
  | 0 => Vector.nil
  | n + 1 => Vector.cons x (replicate α n x)
```

The key difference: dependent types allow types to depend on **values**, not just other types.

## Exercises

1. Define a dependent function where the return type depends on the input
2. Create a dependent pair type and construct examples
3. Implement a safe `head` function for lists using dependent types
4. Define a `Fin` type and operations on it

## Next Steps

→ Continue to [Lab 05: Inductive Types](05-inductive-types.md) to learn how to define custom data structures.

## Related Topics

- [Type Theory Basics](02-type-theory.md)
- [Propositions as Types](03-propositions-as-types.md)
- [Inductive Types](05-inductive-types.md)
