# Fortran unit-testing practice

A small Fortran project for practising unit tests in VS Code, particularly with **pFUnit and CMake**.

All the source code works without pFUnit. The `tests/*.pf` files can be used later when pFUnit has been installed.

## Contents

- `src/calculator.f90`: integer addition, squaring, even/odd
- `src/statistics.f90`: mean and population variance of nonempty real arrays
- `src/physics.f90`: kinetic energy and 3D speed
- `app/main.f90`: a tiny program demonstrating the functions
- `tests/manual_tests.f90`: runnable basic tests, **no framework needed**
- `tests/test_*.pf`: pFUnit tests for use during/after the workshop
- `CHALLENGES.md`: ideas for writing tests and deliberately introducing bugs

## Option A: Run with WSL Ubuntu in VS Code (recommended)

This is a particularly straightforward way of using Fortran and pFUnit on a Windows computer.

1. Extract the whole folder to `C:\Users\amtjke\code\fortran-unit-testing`.
2. Open that folder in VS Code (`File > Open Folder`).
3. Install the **Modern Fortran** extension (publisher `fortran-lang`).
4. Open `Terminal > New Terminal`; start Ubuntu by running `wsl` if your terminal is PowerShell.
5. In the Ubuntu terminal:

```bash
cd /mnt/c/Users/amtjke/code/fortran-unit-testing
gfortran --version
cmake --version
```

If either is missing in Ubuntu:

```bash
sudo apt update
sudo apt install -y gfortran cmake make
```

Then build and test:

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build
ctest --test-dir build --output-on-failure
./build/example_app
```

`ctest` should report `100% tests passed` before you make any changes.

**Note:** Executables built in Ubuntu are Linux executables, even though the source is stored on the Windows C: drive.

## Option B: Native Windows, if a working gfortran + CMake is installed

Open the folder in VS Code, start a PowerShell terminal and check:

```powershell
gfortran --version
cmake --version
```

If both commands work:

```powershell
cmake -S . -B build
cmake --build build
ctest --test-dir build --output-on-failure
```

If they do **not** work, use WSL Ubuntu (Option A) rather than spending workshop time installing a native Windows compiler.

## Running the pFUnit tests

The `*.pf` files are written for pFUnit. They are **not ordinary Fortran** and cannot be passed directly to `gfortran`. pFUnit preprocesses them during the build.

After pFUnit is installed, tell CMake where to find its installation and enable the optional pFUnit suite:

```bash
cmake -S . -B build-pfunit -DCMAKE_BUILD_TYPE=Debug \
  -DENABLE_PFUNIT=ON -DCMAKE_PREFIX_PATH=/path/to/pfunit/install
cmake --build build-pfunit
ctest --test-dir build-pfunit --output-on-failure
```

Replace `/path/to/pfunit/install` with the actual directory used in the workshop. If `PFUNIT` is already on CMake's search path, omit `-DCMAKE_PREFIX_PATH=...`.

Keep `build/` and `build-pfunit/` separate: each remembers its CMake configuration.

## What is being tested?

For example, `add(2,3)` should return `5`. In `tests/test_calculator.pf`:

```fortran
@Test
subroutine test_add_positive()
    @assertEqual(5, add(2, 3))
end subroutine test_add_positive
```

With floating-point results, avoid strict `==` comparisons. Use an absolute tolerance, e.g. `abs(actual - expected) < 1.0e-12_real64`.

## Troubleshooting

- `gfortran: command not found`: compiler is missing from **that terminal/environment**.
- `cmake: command not found`: install CMake in that environment.
- `Could not find PFUNIT`: your CMake configuration needs pFUnit installed or its correct `CMAKE_PREFIX_PATH`.
- Fortran `.mod` files are generated during compilation; you do not need to create them manually.
- `tests/*.pf` may show syntax warnings in VS Code because they contain pFUnit `@` directives; those are intentional.
