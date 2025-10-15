# Lab 05: Inductive Types

## Overview

This lab explores **inductive types**, the mechanism for defining data structures and propositions in ITT and Lean. Inductive types are fundamental to both data representation and logical reasoning.

## Learning Objectives

- Understand inductive type definitions in ITT
- Define custom data types in Lean
- Work with recursion and pattern matching
- Recognize inductive propositions

## Inductive Types in ITT

### The Concept

Inductive types are defined by:
1. **Type constructors** - rules for forming the type
2. **Introduction rules** - constructors that create values
3. **Elimination rules** - pattern matching/recursion for using values

### Basic Form

```
inductive TypeName : Type where
  | constructor1 : ... → TypeName
  | constructor2 : ... → TypeName
  ...
```

## Simple Inductive Types

### Natural Numbers

The quintessential inductive type:

```lean
-- Natural numbers (built into Lean, shown for illustration)
inductive Nat : Type where
  | zero : Nat
  | succ : Nat → Nat

-- Examples
#check Nat.zero          -- 0
#check Nat.succ Nat.zero -- 1
```

In ITT, this is the type of natural numbers with:
- **Base case**: `zero : Nat`
- **Inductive case**: `succ : Nat → Nat`

### Lists

```lean
-- Lists parameterized by element type
inductive List (α : Type u) : Type u where
  | nil : List α
  | cons : α → List α → List α

-- Examples
def emptyList : List Nat := List.nil
def oneTwo : List Nat := List.cons 1 (List.cons 2 List.nil)

-- Lean's notation: [1, 2, 3]
```

### Binary Trees

```lean
-- Binary trees
inductive Tree (α : Type) : Type where
  | empty : Tree α
  | node : Tree α → α → Tree α → Tree α

-- Example tree
def exampleTree : Tree Nat :=
  Tree.node 
    (Tree.node Tree.empty 1 Tree.empty)
    2
    (Tree.node Tree.empty 3 Tree.empty)
```

## Recursive Functions on Inductive Types

### Pattern Matching

```lean
-- Length of a list
def length {α : Type} : List α → Nat
  | List.nil => 0
  | List.cons _ tail => 1 + length tail

-- Sum of a list
def sum : List Nat → Nat
  | List.nil => 0
  | List.cons head tail => head + sum tail
```

### The Elimination Principle

For every inductive type, Lean generates an elimination principle (recursor):

```lean
-- List.rec allows structural recursion
#check @List.rec
-- {α : Type u_1} → 
-- {motive : List α → Sort u_2} → 
-- motive [] → 
-- ((head : α) → (tail : List α) → motive tail → motive (head :: tail)) → 
-- (t : List α) → motive t
```

## Indexed Inductive Types

### Length-Indexed Vectors

```lean
-- Vector: list with length in the type
inductive Vector (α : Type u) : Nat → Type u where
  | nil : Vector α 0
  | cons : {n : Nat} → α → Vector α n → Vector α (n + 1)

-- Type-safe head function
def vhead {α : Type} {n : Nat} : Vector α (n + 1) → α
  | Vector.cons a _ => a
  -- No need for nil case - type system prevents it!
```

### Even Numbers

```lean
-- Inductive definition of even numbers
inductive Even : Nat → Prop where
  | zero : Even 0
  | add_two : {n : Nat} → Even n → Even (n + 2)

-- Proofs
example : Even 4 := 
  Even.add_two (Even.add_two Even.zero)
```

## Inductive Propositions

### Equality

Lean's equality is an indexed inductive type:

```lean
-- Simplified version of Eq
inductive Eq {α : Type} : α → α → Prop where
  | refl (a : α) : Eq a a

-- Notation: a = b
```

### Accessibility (Well-foundedness)

```lean
-- Inductive definition of accessibility
inductive Acc {α : Type} (r : α → α → Prop) : α → Prop where
  | intro : ∀ x, (∀ y, r y x → Acc r y) → Acc r x
```

## Mutual Induction

Types can be defined mutually:

```lean
-- Mutually inductive types
mutual
  inductive Even : Nat → Prop where
    | zero : Even 0
    | succ_odd : {n : Nat} → Odd n → Even (n + 1)
  
  inductive Odd : Nat → Prop where
    | succ_even : {n : Nat} → Even n → Odd (n + 1)
end
```

## The ITT Perspective

### Formation Rule for Inductive Types

For natural numbers:
```
─────────────
Nat : Type
```

### Introduction Rules

```
─────────────        n : Nat
zero : Nat          ─────────────
                    succ(n) : Nat
```

### Elimination Rule (Recursion)

```
C : Nat → Type
c₀ : C(zero)
cₛ : (n : Nat) → C(n) → C(succ(n))
n : Nat
───────────────────────────────────
rec_Nat(C, c₀, cₛ, n) : C(n)
```

### Computation Rules

```
rec_Nat(C, c₀, cₛ, zero) ≡ c₀
rec_Nat(C, c₀, cₛ, succ(n)) ≡ cₛ(n, rec_Nat(C, c₀, cₛ, n))
```

## Advanced: Nested Inductive Types

```lean
-- Trees with variable branching
inductive RoseTree (α : Type) : Type where
  | node : α → List (RoseTree α) → RoseTree α
```

## Exercises

1. Define an inductive type for binary trees and implement tree traversal
2. Create an indexed inductive type for binary numbers
3. Define an inductive proposition and prove instances of it
4. Implement map and filter for lists using pattern matching

## Next Steps

→ Continue to [Lab 06: Equality](06-equality.md) to explore different notions of equality in ITT and Lean.

## Related Topics

- [Type Theory Basics](02-type-theory.md)
- [Dependent Types](04-dependent-types.md)
- [Equality](06-equality.md)
