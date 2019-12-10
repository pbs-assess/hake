yrs <- 2019
depth_yrs <- 2010:2019
# Get data with lat/longs from the database for each fishery
ct_ft_latlon <- get_spatial_catch_sql("ft")
ct_ss_latlon <- get_spatial_catch_sql("ss")
ct_jv_latlon <- get_spatial_catch_sql("jv")

ct_depths <- bind_rows(ct_ft_latlon, ct_ss_latlon) %>%
  filter(lubridate::year(catchdate) %in% depth_yrs)

ct_ft_latlon <- ct_ft_latlon %>%
  filter(lubridate::year(catchdate) %in% yrs)
ct_ss_latlon <- ct_ss_latlon %>%
  filter(lubridate::year(catchdate) %in% yrs)
ct_jv_latlon <- ct_jv_latlon %>%
  filter(lubridate::year(catchdate) %in% yrs)


# Merge the catch data frames that have lat/longs and make them into a spatial `sf` objects
spct <- merge_into_spatial(ct_ft_latlon,
                           ct_ss_latlon)
#                           ct_jv_latlon)
spct_ft <- merge_into_spatial(ct_ft_latlon)
spct_ss <- merge_into_spatial(ct_ss_latlon)
#spct_jv <- merge_into_spatial(ct_jv_latlon)

grd_ft <- make_grid(spct_ft,
                    cell_size = 10000,
                    min_num_fids = 3)
grd_ss <- make_grid(spct_ss,
                    cell_size = 10000,
                    min_num_fids = 3)
grd_catch_ft <- make_grid(spct_ft,
                          cell_size = 10000,
                          min_num_fids = 3,
                          data_col = vars(catch),
                          data_fncs = funs(mean))
grd_sum_catch_ft <- make_grid(spct_ft,
                              cell_size = 10000,
                              min_num_fids = 3,
                              data_col = vars(catch),
                              data_fncs = funs(sum))
grd_catch_ss <- make_grid(spct_ss,
                          cell_size = 10000,
                          min_num_fids = 3,
                          data_col = vars(catch),
                          data_fncs = funs(mean))
grd_sum_catch_ss <- make_grid(spct_ss,
                              cell_size = 10000,
                              min_num_fids = 3,
                              data_col = vars(catch),
                              data_fncs = funs(sum))

# grd_jv <- make_grid(spct_jv,
#                     cell_size = 10000,
#                     min_num_fids = 3)
#grd_all <- make_grid(spct,
#                     cell_size = 10000,
#                     min_num_fids = 3)
