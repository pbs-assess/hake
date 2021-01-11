library(lubridate)

yrs <- 2019
depth_yrs <- 2010:2019
# Get data with lat/longs from the database for each fishery
ft <- ct_ft_latlon <- fetch_spatial_catch_data("ft")
ss <- ct_ss_latlon <- fetch_spatial_catch_data("ss")
jv <- ct_jv_latlon <- fetch_spatial_catch_data("jv")

ct_depths <- bind_rows(ct_ft_latlon, ct_ss_latlon) %>%
  filter(year(catchdate) %in% depth_yrs)

ct_ft_latlon <- ct_ft_latlon %>%
  filter(year(catchdate) %in% yrs)
ct_ss_latlon <- ct_ss_latlon %>%
  filter(year(catchdate) %in% yrs)
ct_jv_latlon <- ct_jv_latlon %>%
  filter(year(catchdate) %in% yrs)


# Merge the catch data frames that have lat/longs and make them into a spatial `sf` objects
spct <- conv_spatial(ct_ft_latlon,
                     ct_ss_latlon)
#                           ct_jv_latlon)
spct_ft <- conv_spatial(ct_ft_latlon)
spct_ss <- conv_spatial(ct_ss_latlon)
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
                          data_fncs = mean)
grd_sum_catch_ft <- make_grid(spct_ft,
                              cell_size = 10000,
                              min_num_fids = 3,
                              data_col = vars(catch),
                              data_fncs = sum)
grd_catch_ss <- make_grid(spct_ss,
                          cell_size = 10000,
                          min_num_fids = 3,
                          data_col = vars(catch),
                          data_fncs = mean)
grd_sum_catch_ss <- make_grid(spct_ss,
                              cell_size = 10000,
                              min_num_fids = 3,
                              data_col = vars(catch),
                              data_fncs = sum)

plot_depths(ft, depth_type = "gear", fishery_type = "ft", depth_max = 600, ylim = c(NA, 1300))
plot_depths(ss, depth_type = "gear", fishery_type = "ss", depth_max = 600, ylim = c(NA, 550))
