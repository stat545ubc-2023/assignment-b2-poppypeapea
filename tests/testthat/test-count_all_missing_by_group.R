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
