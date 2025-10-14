# Topic Graph: Connections in ITT and Lean

This graph shows the relationships between topics covered in the lab course. Topics are organized to show prerequisites, connections, and the learning path.

## Visual Topic Map

```
                    ┌─────────────────────────────┐
                    │   01: Foundations of ITT    │
                    │        and Lean             │
                    │                             │
                    │  • Constructive mathematics │
                    │  • Type theory basics       │
                    │  • Lean environment         │
                    └──────────────┬──────────────┘
                                   │
                                   ↓
                    ┌─────────────────────────────┐
                    │   02: Type Theory Basics    │
                    │                             │
                    │  • Types, terms, judgments  │
                    │  • Function types           │
                    │  • Universe hierarchy       │
                    └───────┬──────────────┬──────┘
                            │              │
                    ┌───────┘              └───────┐
                    ↓                              ↓
     ┌─────────────────────────────┐   ┌─────────────────────────────┐
     │ 03: Propositions as Types   │   │   04: Dependent Types       │
     │                             │   │                             │
     │  • Curry-Howard             │   │  • Π-types (∀)              │
     │  • Logical connectives      │   │  • Σ-types (∃)              │
     │  • Proofs as programs       │   │  • Type families            │
     └────────┬────────────────────┘   └──────────┬──────────────────┘
              │                                   │
              │        ┌──────────────────────────┤
              │        │                          │
              ↓        ↓                          ↓
     ┌─────────────────────────────┐   ┌─────────────────────────────┐
     │   05: Inductive Types       │   │      06: Equality           │
     │                             │   │                             │
     │  • Nat, List, Tree          │   │  • Definitional equality    │
     │  • Pattern matching         │   │  • Propositional equality   │
     │  • Recursion principles     │   │  • Substitution             │
     └────────┬────────────────────┘   └──────────┬──────────────────┘
              │                                   │
              │        ┌──────────────────────────┘
              │        │
              ↓        ↓
     ┌─────────────────────────────┐
     │       07: Tactics           │
     │                             │
     │  • Interactive proving      │
     │  • Tactic mode vs term mode │
     │  • Proof automation         │
     └─────────────────────────────┘
```

## Learning Paths

### Path 1: Foundations to Tactics (Linear)
The recommended sequential path through all materials:

1. **[Foundations](labs/01-foundations.md)** → Start here
2. **[Type Theory Basics](labs/02-type-theory.md)** → Build on foundations
3. **[Propositions as Types](labs/03-propositions-as-types.md)** → Understand logic
4. **[Dependent Types](labs/04-dependent-types.md)** → Learn powerful abstractions
5. **[Inductive Types](labs/05-inductive-types.md)** → Define data structures
6. **[Equality](labs/06-equality.md)** → Master reasoning about equality
7. **[Tactics](labs/07-tactics.md)** → Build proofs interactively

### Path 2: Theory-Focused
Emphasizes ITT theoretical foundations:

1. [Foundations](labs/01-foundations.md)
2. [Type Theory Basics](labs/02-type-theory.md)
3. [Dependent Types](labs/04-dependent-types.md)
4. [Propositions as Types](labs/03-propositions-as-types.md)
5. [Inductive Types](labs/05-inductive-types.md)
6. [Equality](labs/06-equality.md)

### Path 3: Practice-Focused
Emphasizes Lean programming and proving:

1. [Foundations](labs/01-foundations.md)
2. [Type Theory Basics](labs/02-type-theory.md)
3. [Tactics](labs/07-tactics.md)
4. [Inductive Types](labs/05-inductive-types.md)
5. [Propositions as Types](labs/03-propositions-as-types.md)
6. [Dependent Types](labs/04-dependent-types.md)

## Concept Connections

### Core ITT Concepts

```
Judgments (Lab 02)
    │
    ├──→ Type Formation ──→ Inductive Types (Lab 05)
    │                            │
    ├──→ Term Introduction ──→ Constructors ──→ Pattern Matching
    │                                              │
    ├──→ Type Equality ──────→ Definitional Equality (Lab 06)
    │                                              │
    └──→ Term Equality ──────→ Propositional Equality (Lab 06)
```

### Curry-Howard Correspondence

```
Logic                    Programming              Type Theory
─────────────────────────────────────────────────────────────
Proposition (Lab 03)  ←→  Type               ←→  Type
Proof                 ←→  Program            ←→  Term
Implication (P → Q)   ←→  Function type      ←→  A → B
Conjunction (P ∧ Q)   ←→  Product type       ←→  A × B
Disjunction (P ∨ Q)   ←→  Sum type           ←→  A ⊕ B
Universal (∀x. P)     ←→  Dependent function ←→  Π x:A, B(x) (Lab 04)
Existential (∃x. P)   ←→  Dependent pair     ←→  Σ x:A, B(x) (Lab 04)
```

### Type Hierarchy

```
Sort
  ├── Type 0 (Type)
  │     ├── Nat (Lab 05)
  │     ├── List α (Lab 05)
  │     ├── Function types A → B (Lab 02)
  │     └── Dependent types
  │           ├── Π-types (Lab 04)
  │           └── Σ-types (Lab 04)
  │
  ├── Type 1
  │     └── Type 0
  │
  └── Prop (Lab 03)
        ├── Equality a = b (Lab 06)
        ├── Logical connectives (Lab 03)
        └── Inductive propositions (Lab 05)
```

## Topic Dependencies

### Prerequisites

- **Lab 01** (Foundations): No prerequisites - start here
- **Lab 02** (Type Theory): Requires Lab 01
- **Lab 03** (Propositions as Types): Requires Lab 02
- **Lab 04** (Dependent Types): Requires Lab 02; recommended Lab 03
- **Lab 05** (Inductive Types): Requires Lab 02; recommended Lab 04
- **Lab 06** (Equality): Requires Lab 03 and Lab 05
- **Lab 07** (Tactics): Requires Lab 03; recommended Lab 05 and Lab 06

### Related Concepts

| Topic | Builds Upon | Enables |
|-------|-------------|---------|
| Foundations | - | Everything |
| Type Theory | Foundations | All other topics |
| Propositions as Types | Type Theory | Logical reasoning, Tactics |
| Dependent Types | Type Theory | Precise specifications, Indexed types |
| Inductive Types | Type Theory, Dependent Types | Data structures, Propositions |
| Equality | Propositions, Inductive Types | Proofs, Substitution |
| Tactics | Propositions, Equality | Interactive proving |

## Cross-References Between Labs

### Concepts That Span Multiple Labs

#### 1. **Function Types** (→)
- Introduced: [Lab 02 - Type Theory](labs/02-type-theory.md)
- As implication: [Lab 03 - Propositions as Types](labs/03-propositions-as-types.md)
- Dependent version (Π): [Lab 04 - Dependent Types](labs/04-dependent-types.md)
- In tactics: [Lab 07 - Tactics](labs/07-tactics.md)

#### 2. **Equality**
- Definitional: [Lab 02 - Type Theory](labs/02-type-theory.md)
- Propositional: [Lab 03 - Propositions as Types](labs/03-propositions-as-types.md)
- Inductive definition: [Lab 05 - Inductive Types](labs/05-inductive-types.md)
- In depth: [Lab 06 - Equality](labs/06-equality.md)
- Tactics for: [Lab 07 - Tactics](labs/07-tactics.md)

#### 3. **Universal Quantification** (∀)
- As function type: [Lab 02 - Type Theory](labs/02-type-theory.md)
- As Π-type: [Lab 04 - Dependent Types](labs/04-dependent-types.md)
- As logical quantifier: [Lab 03 - Propositions as Types](labs/03-propositions-as-types.md)

#### 4. **Existential Quantification** (∃)
- As Σ-type: [Lab 04 - Dependent Types](labs/04-dependent-types.md)
- As logical quantifier: [Lab 03 - Propositions as Types](labs/03-propositions-as-types.md)
- In inductive props: [Lab 05 - Inductive Types](labs/05-inductive-types.md)

#### 5. **Pattern Matching**
- Inductive types: [Lab 05 - Inductive Types](labs/05-inductive-types.md)
- Cases tactic: [Lab 07 - Tactics](labs/07-tactics.md)

## Thematic Groupings

### Theoretical Foundations (ITT Focus)
- [Lab 01: Foundations](labs/01-foundations.md)
- [Lab 02: Type Theory Basics](labs/02-type-theory.md)
- [Lab 04: Dependent Types](labs/04-dependent-types.md)

### Logic and Proof (Curry-Howard)
- [Lab 03: Propositions as Types](labs/03-propositions-as-types.md)
- [Lab 06: Equality](labs/06-equality.md)
- [Lab 07: Tactics](labs/07-tactics.md)

### Programming and Data Structures
- [Lab 02: Type Theory Basics](labs/02-type-theory.md)
- [Lab 05: Inductive Types](labs/05-inductive-types.md)
- [Lab 04: Dependent Types](labs/04-dependent-types.md)

## Quick Reference: Where to Find Topics

| Looking for... | See Lab |
|----------------|---------|
| What is ITT? | [01 - Foundations](labs/01-foundations.md) |
| Setting up Lean | [01 - Foundations](labs/01-foundations.md) |
| Types and terms | [02 - Type Theory](labs/02-type-theory.md) |
| Function types | [02 - Type Theory](labs/02-type-theory.md) |
| Judgments | [02 - Type Theory](labs/02-type-theory.md) |
| Proofs as programs | [03 - Propositions as Types](labs/03-propositions-as-types.md) |
| Logical connectives | [03 - Propositions as Types](labs/03-propositions-as-types.md) |
| Curry-Howard | [03 - Propositions as Types](labs/03-propositions-as-types.md) |
| Π-types (∀) | [04 - Dependent Types](labs/04-dependent-types.md) |
| Σ-types (∃) | [04 - Dependent Types](labs/04-dependent-types.md) |
| Type families | [04 - Dependent Types](labs/04-dependent-types.md) |
| Defining data types | [05 - Inductive Types](labs/05-inductive-types.md) |
| Pattern matching | [05 - Inductive Types](labs/05-inductive-types.md) |
| Recursion | [05 - Inductive Types](labs/05-inductive-types.md) |
| Natural numbers | [05 - Inductive Types](labs/05-inductive-types.md) |
| Lists and trees | [05 - Inductive Types](labs/05-inductive-types.md) |
| Definitional equality | [06 - Equality](labs/06-equality.md) |
| Propositional equality | [06 - Equality](labs/06-equality.md) |
| Substitution | [06 - Equality](labs/06-equality.md) |
| Transport | [06 - Equality](labs/06-equality.md) |
| Building proofs | [07 - Tactics](labs/07-tactics.md) |
| Tactic mode | [07 - Tactics](labs/07-tactics.md) |
| Proof automation | [07 - Tactics](labs/07-tactics.md) |

## External Resources

### ITT Theory
- Martin-Löf, P. (1984). "Intuitionistic Type Theory"
- The HoTT Book: https://homotopytypetheory.org/book/

### Lean Documentation
- Lean 4 Documentation: https://leanprover.github.io/lean4/doc/
- Theorem Proving in Lean 4: https://leanprover.github.io/theorem_proving_in_lean4/
- Functional Programming in Lean: https://leanprover.github.io/functional_programming_in_lean/

### Community
- Lean Zulip Chat: https://leanprover.zulipchat.com/
- Lean Community: https://leanprover-community.github.io/

---

**Navigation**: Return to [README](README.md) | Start with [Lab 01: Foundations](labs/01-foundations.md)
