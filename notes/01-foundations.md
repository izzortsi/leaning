# Lab 01: Foundations of ITT and Lean

## Overview

This lab introduces the foundational concepts of Intuitionistic Type Theory (ITT) and the Lean theorem prover, establishing the basis for all subsequent labs.

## Learning Objectives

- Understand the philosophical foundations of intuitionistic logic
- Recognize the role of type theory in constructive mathematics
- Set up and navigate the Lean development environment
- Write basic Lean definitions and theorems

## Intuitionistic Type Theory Concepts

### Constructive Mathematics

In ITT, mathematical objects are constructed rather than proven to exist non-constructively. Every proof must provide explicit constructions:

- **Existence proofs** must construct the object
- **Proofs of disjunction** must specify which disjunct holds
- The **Law of Excluded Middle** (LEM) is not assumed

### Type Theory as a Foundation

ITT serves as both:
1. A **logic** - for reasoning about mathematical propositions
2. A **programming language** - for constructing mathematical objects

## Lean Basics

### First Steps in Lean

```lean
-- Define a constant
def myNumber : Nat := 42

-- Define a function
def double (n : Nat) : Nat := n + n

-- State a theorem
theorem double_zero : double 0 = 0 := rfl
```

### The Lean Environment

- **Types** are first-class citizens
- **Definitions** introduce new terms
- **Theorems** are proven propositions
- **Tactics** help construct proofs interactively

## Connections to ITT

| ITT Concept | Lean Implementation |
|-------------|---------------------|
| Judgments | Type checking |
| Terms | Expressions |
| Types | `Type`, `Prop` |
| Definitional Equality | `rfl` |

## Exercises

1. Install Lean 4 and set up your development environment
2. Create a Lean file with basic definitions
3. Explore the Lean standard library
4. Write simple functions on natural numbers

## Next Steps

→ Continue to [Lab 02: Type Theory Basics](02-type-theory.md) to explore types, terms, and judgments in depth.

## Related Topics

- [Propositions as Types](03-propositions-as-types.md)
- [Tactics](07-tactics.md)
