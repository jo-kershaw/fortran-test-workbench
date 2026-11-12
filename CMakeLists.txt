cmake_minimum_required(VERSION 3.18)
project(fortran_unit_testing LANGUAGES Fortran)

option(ENABLE_PFUNIT "Build pFUnit tests (requires installed pFUnit)" OFF)

add_library(practice_code
    src/calculator.f90
    src/statistics.f90
    src/physics.f90
    src/finite_difference.f90
)

# Keep generated Fortran .mod files separate from the source tree.
set_target_properties(practice_code PROPERTIES
    Fortran_MODULE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/modules"
)
file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/modules")
target_include_directories(practice_code PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/modules")

add_executable(example_app app/main.f90)
target_link_libraries(example_app PRIVATE practice_code)

enable_testing()
add_executable(manual_tests tests/manual_tests.f90)
target_link_libraries(manual_tests PRIVATE practice_code)
add_test(NAME manual_unit_tests COMMAND manual_tests)

if(ENABLE_PFUNIT)
   find_package(PFUNIT REQUIRED)
    add_pfunit_ctest(pfunit_unit_tests
        TEST_SOURCES
            "${CMAKE_CURRENT_SOURCE_DIR}/tests/test_calculator.pf"
            "${CMAKE_CURRENT_SOURCE_DIR}/tests/test_statistics.pf"
            "${CMAKE_CURRENT_SOURCE_DIR}/tests/test_physics.pf"
            "${CMAKE_CURRENT_SOURCE_DIR}/tests/test_finite_difference.pf"
        LINK_LIBRARIES practice_code
    )
    
endif()


