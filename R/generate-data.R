library(hakedata)
hake_theme <- function(){
  theme_bw() +
    theme(legend.box.background = element_rect(fill = alpha("white", 0.7)),
          legend.box.margin = margin(1, 1, 1, 1, "mm"),
          legend.key = element_blank(),
          legend.margin = margin(),
          legend.text.align = 1,
          panel.grid.major = element_line(colour = "darkgrey", size = 0.2),
          panel.grid.minor = element_line(colour = "darkgrey", size = 0.1),
          legend.background = element_rect(fill = "transparent"),
          #panel.spacing.x=unit(3, "lines"),
          plot.margin = unit(c(0.1, 0.6, 0.1, 0.1), "lines"))
}

# Read data from the CSV files extracted manually
fetch_catch_data()
d <- load_catch_data()

fetch_sample_data()
d <- get_age_props()

fetch_spatial_catch_data("ft")
fetch_spatial_catch_data("ss")
fetch_spatial_catch_data("jv")
ft_depth <- load_spatial_catch_data("ft")
ss_depth <- load_spatial_catch_data("ss")
jv_depth <- load_spatial_catch_data("jv")
get_depth_by_year(ft_depth, "bottom", yrs = 2008:2019)
get_depth_by_year(ss_depth, "bottom", yrs = 2008:2019)
get_depth_by_year(jv_depth, "bottom", yrs = 2008:2019)
get_depth_by_year(ft_depth, "gear", yrs = 2008:2019)
get_depth_by_year(ss_depth, "gear", yrs = 2008:2019)
get_depth_by_year(jv_depth, "gear", yrs = 2008:2019)

# Get catches from each fishery (by day)
ct_ft <- get_catch(d, type = "ft")
ct_ss <- get_catch(d, type = "ss")
ct_jv <- get_catch(d, type = "jv")
create_catch_csv_file(ct_ft, here("data", "can-ft-catch-by-month.csv"))
create_catch_csv_file(ct_ss, here("data", "can-ss-catch-by-month.csv"))
create_catch_csv_file(ct_jv, here("data", "can-jv-catch-by-month.csv"))

# Get data with lat/longs from the database for each fishery
spct_ft <- conv_spatial("ft")
spct_ss <- conv_spatial("ss")
spct_jv <- conv_spatial("jv")

# Merge the spatial catch data frames and make them into a spatial `sf` object
spct <- conv_spatial(spct_ft,
                     spct_ss,
                     spct_jv)

