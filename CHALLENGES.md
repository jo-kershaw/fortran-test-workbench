# Practice exercises

Start by building the default project and verifying that all tests pass. Then try these challenges **one at a time**.

1. **Make a test fail:** In `src/calculator.f90`, change `a + b` to `a - b`. Rebuild with `cmake --build build` and run `ctest --test-dir build --output-on-failure`. Observe which tests fail; then undo the change.
2. **Boundary values:** In `tests/test_calculator.pf`, add a test for `is_even(-4)`. Try the same case in `tests/manual_tests.f90`.
3. **The deceptive mean:** Change `sum(values) / real(size(values), real64)` to `sum(values) / real(size(values) - 1, real64)` in `src/statistics.f90`. Does the test for mean catch it? Restore the code when done.
4. **Floating-point tolerances:** In `tests/test_statistics.pf`, make the tolerance for the variance test unrealistically small, or use a slightly wrong expected value. Understand why the test fails.
5. **Scientific invariants:** For kinetic energy, test that `kinetic_energy(m, -v) == kinetic_energy(m, v)` within a tolerance. Also check that doubling speed multiplies energy by four.
6. **Add a function:** Implement `distance_3d(x, y, z)` returning the length of a 3D vector in `src/physics.f90`. Write a new pFUnit test: `(3,4,0)` should give `5`.
7. **Spot a missing test:** `src/physics.f90` assumes physical mass is nonnegative but does not validate input. Discuss what the function's contract should be and how invalid-input handling could be tested.

Tip: A useful unit test checks **one identifiable behaviour**, ideally with a descriptive test name.
