# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(regexcite)

test_check("regexcite")

test_that("Output matches direct call to dplyr", {
  small_tbl <- tribble(~group, ~var1, ~var2,
                       "A", 1, NA,
                       "A", 2, "x",
                       "B", NA, "y",
                       "C", 3, "z")

  expect_equal( small_tbl |> group_by(group) |>
                  summarize(across(everything(), ~sum(is.na(.x))),
                            .groups = "drop"),
                countMissing(small_tbl, group)
  )

  expect_equal( small_tbl |> group_by(group) |>
                  summarize(across(everything(), ~sum(is.na(.x))),
                            .groups = NULL),
                countMissing(small_tbl, group, NULL)
  )
})
