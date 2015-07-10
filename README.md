# testing_guidelines
how-to for writing effective tests

##TLDR; Read http://betterspecs.org

## Purposes of tests
1. If you break something, you find out exactly what you broke as soon
   as you run the tests
1. Good tests document and prove behavior. If you're not sure what
   something is supposed to do, reading the tests is a good start.

## The Ideal Tests

1. If a test fails, it should be clear exactly what broke and where.
1. This means that you'd ideally shoot for one assertion per test.
1. Which means that TEST CODE IS NOT APPLICATION CODE. Let's unpack
   that:
  1. Being DRY is less important than being clear. Spending time
     refactoring test code to keep it DRY is usually a waste of time and
can makes fixing tests painful as you unwrap your abstractions.
  1. When a test breaks, you want to be able to see the issue ASAP. SRP
     is important here.
  1. Code that is difficult to test can (and should) usually be refactored.

## Bad Testing practices

1. Writing tests against a system's behavior just to ensure consistent
   state--not thinking about what/why you're testing the things you are.
1. Looping over a collection of things and making different assertions on
   each of those things. That is a pain in the ass to debug when something breaks.
1. Deeply abstracted test helpers. Some helper methods are ok, but you
   typically want to code close to the "bare metal" test methods--the
actual assertions and methods provided by the testing framework. This
makes failures easier to debug w/out having to go code spelunking.
1. Treating test code like application code. You want test code to be as
   straightforward and brain-dead as possible. It's NOT APPLICATION
CODE.

# TODO
refactor, refine, write example code using real-world examples (not the
bullshit overly simplified examples you typically see)
