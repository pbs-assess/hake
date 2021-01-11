load_all("../hakedata")

theme_set(hake_theme())
# Read data from the CSV files extracted manually
fetch_catch_data()
d <- load_catch_data()

fetch_sample_data()
d <- get_age_props()

fetch_sample_data_gfdata()
comm <- load_sample_data()
wa_comm <- get_comm_wa(comm)

fetch_survey_data()
surv <- load_survey_data()
wa_surv <- get_surv_wa(surv)

wa_fn <- here::here("data", "LengthWeightAge_data.rds")
wa_old <- readRDS(wa_fn) %>%
  filter(!is.na(Source))
# Remove Canadian data (except JV)
wa <- wa_old %>%
  filter(!Source %in% c("CAN_acoustic", "CAN_shoreside")) %>%
  bind_rows(wa_surv, wa_comm)
write_csv(wa, wa_fn)
saveRDS(wa, here::here("data", "LengthWeightAge_data.rds"))

fetch_spatial_catch_data("ft", overwrite_file = FALSE)
fetch_spatial_catch_data("ss", overwrite_file = FALSE)
fetch_spatial_catch_data("jv", overwrite_file = FALSE)
ft_depth <- load_spatial_catch_data("ft")
ss_depth <- load_spatial_catch_data("ss")
jv_depth <- load_spatial_catch_data("jv")
yr <- 2020
get_depth_by_year(ft_depth, "bottom", yrs = 2008:yr)
get_depth_by_year(ss_depth, "bottom", yrs = 2008:yr)
get_depth_by_year(jv_depth, "bottom", yrs = 2008:yr)
get_depth_by_year(ft_depth, "gear", yrs = 2008:yr)
get_depth_by_year(ss_depth, "gear", yrs = 2008:yr)
get_depth_by_year(jv_depth, "gear", yrs = 2008:yr)

# Get catches from each fishery (by day)
ct_ft <- get_catch(d, type = "ft")
ct_ss <- get_catch(d, type = "ss")
ct_jv <- get_catch(d, type = "jv")
create_catch_csv_file(ct_ft, here("data", "can-ft-catch-by-month.csv"))
create_catch_csv_file(ct_ss, here("data", "can-ss-catch-by-month.csv"))
create_catch_csv_file(ct_jv, here("data", "can-jv-catch-by-month.csv"))

# Get data with lat/longs from the database for each fishery
spct_ft <- conv_spatial(ft_depth)
spct_ss <- conv_spatial(ss_depth)
spct_jv <- conv_spatial(jv_depth)

# Merge the spatial catch data frames and make them into a spatial `sf` object
spct <- conv_spatial(spct_ft,
                     spct_ss,
                     spct_jv)

