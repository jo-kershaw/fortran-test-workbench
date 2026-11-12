# Fortran Test Workbench

A collection of small scientific Fortran examples for experimenting with unit testing and numerical verification.

Developed following a *Unit Testing in Fortran* workshop, with AI assistance.

## Contents

- **src/** — Fortran modules, including numerical examples
- **app/** — Example programs
- **tests/** — Manual and pFUnit tests

## Tools

GNU Fortran, CMake, CTest and pFUnit.

## Build and test

```bash
cmake -S . -B build -DENABLE_PFUNIT=ON -DCMAKE_PREFIX_PATH="$HOME/.local/pfunit"
cmake --build build
ctest --test-dir build --output-on-failure
```

See [SETUP.md](SETUP.md) for installation instructions.

## Future work

Explore further testing workflows, including fUnit and pFUnit, and extend the examples to more complex scientific codes.