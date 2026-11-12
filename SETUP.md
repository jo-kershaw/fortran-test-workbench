# Fortran Unit Testing — Setup

This project uses GNU Fortran, CMake, CTest and pFUnit.

## Tested environment

- Ubuntu 24.04 (WSL)
- GNU Fortran 13.3.0
- CMake 3.28.3
- Python 3.12.3
- GNU M4 1.4.19
- pFUnit commit:
  e1ca5f3f9a885b99aded51b5e9e8756fdf16b25d

## 1. Install prerequisites

On Ubuntu:

    sudo apt update
    sudo apt install gfortran cmake m4 git python3 make

## 2. Install pFUnit

    mkdir -p ~/code
    cd ~/code

    git clone --recursive https://github.com/Goddard-Fortran-Ecosystem/pFUnit.git

    cd pFUnit
    git checkout e1ca5f3f9a885b99aded51b5e9e8756fdf16b25d
    git submodule update --init --recursive
    cd ..

    cmake -S pFUnit -B pFUnit/build \
      -DCMAKE_INSTALL_PREFIX="$HOME/.local/pfunit" \
      -DSKIP_MPI=YES \
      -DSKIP_OPENMP=YES \
      -DSKIP_FHAMCREST=YES

    cmake --build pFUnit/build -j 2
    cmake --install pFUnit/build

## 3. Build the example project

From the directory containing CMakeLists.txt:

    cmake -S . -B build \
      -DENABLE_PFUNIT=ON \
      -DCMAKE_PREFIX_PATH="$HOME/.local/pfunit"

    cmake --build build -j 1

## 4. Run the tests

    ctest --test-dir build --output-on-failure

To see individual pFUnit results:

    ./build/pfunit_unit_tests

## Notes

- pFUnit is installed separately from the project.
- Build directories are excluded from Git.
- The recorded pFUnit commit pins its source version.
- These instructions reproduce the tested setup;
  exact compiler versions may require additional
  package pinning or a container.
- MPI and OpenMP tests are not enabled in this setup.
