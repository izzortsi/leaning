# Lab 02: Type Theory Basics

## Overview

This lab explores the fundamental concepts of type theory: types, terms, and judgments. We examine how these concepts are formalized in ITT and implemented in Lean.

## Learning Objectives

- Understand the four forms of judgment in ITT
- Work with basic types in Lean
- Construct terms and verify their types
- Distinguish between type checking and type inference

## The Four Forms of Judgment in ITT

Martin-Löf's ITT is based on four fundamental forms of judgment:

1. **Type formation**: `A type` - A is a well-formed type
2. **Term introduction**: `a : A` - term a has type A
3. **Type equality**: `A = B type` - types A and B are equal
4. **Term equality**: `a = b : A` - terms a and b are equal at type A

## Types in Lean

### Universe Hierarchy

```lean
-- Type hierarchy
#check Nat           -- Nat : Type
#check Type          -- Type : Type 1
#check Type 1        -- Type 1 : Type 2

-- Prop is the universe of propositions
#check Prop          -- Prop : Type
```

### Basic Types

```lean
-- Natural numbers
def n : Nat := 5

-- Booleans
def b : Bool := true

-- Strings
def s : String := "Hello, ITT!"

-- Function types
def f : Nat → Nat := fun x => x + 1
```

## Terms and Type Checking

### Type Checking vs Type Inference

```lean
-- Explicit type annotation
def explicitType : Nat := 42

-- Type inference
def inferredType := 42  -- Lean infers : Nat

-- #check reveals types
#check explicitType     -- explicitType : Nat
#check inferredType     -- inferredType : Nat
```

### Term Construction

Every term in Lean must have a type:

```lean
-- Valid term
def validTerm : Nat := 10

-- Function application
def applyFunc : Nat := double 5

-- Lambda abstraction
def increment : Nat → Nat := fun n => n + 1
```

## Function Types

### Simple Functions

```lean
-- Function type: A → B
def addOne (n : Nat) : Nat := n + 1

-- Equivalent lambda form
def addOne' : Nat → Nat := fun n => n + 1
```

### Multi-argument Functions

```lean
-- Multiple arguments (curried)
def add (m n : Nat) : Nat := m + n

-- Type is: Nat → Nat → Nat
#check add

-- Partial application
def add5 : Nat → Nat := add 5
```

## ITT Perspective

### Context and Judgments

In ITT, judgments are made in a context:

```
Γ ⊢ a : A
```

This means "in context Γ, term a has type A."

In Lean, the context includes:
- Previously defined constants
- Function parameters
- Tactic state variables

### Type Formation Rules

Example for function types:
```
Γ ⊢ A type    Γ, x : A ⊢ B type
─────────────────────────────────
    Γ ⊢ (Π x : A, B) type
```

In Lean: `(x : A) → B` or `∀ x : A, B`

## Exercises

1. Define functions with explicit type annotations
2. Use `#check` to explore types in the Lean standard library
3. Create functions that take functions as arguments
4. Experiment with partial application

## Next Steps

→ Continue to [Lab 03: Propositions as Types](03-propositions-as-types.md) to discover the Curry-Howard correspondence.

## Related Topics

- [Foundations](01-foundations.md)
- [Dependent Types](04-dependent-types.md)
- [Tactics](07-tactics.md)
