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
fetch_catch()
d <- load_data()

# Get catches from each fishery (by day)
ct_ft <- get_catch(d, type = "ft")
ct_ss <- get_catch(d, type = "ss")
ct_jv <- get_catch(d, type = "jv")
create_catch_csv_file(ct_ft, here("data", "can-ft-catch-by-month.csv"))
create_catch_csv_file(ct_ss, here("data", "can-ss-catch-by-month.csv"))
create_catch_csv_file(ct_jv, here("data", "can-jv-catch-by-month.csv"))

# Get data with lat/longs from the database for each fishery
spct_ft <- get_spatial_catch_sql("ft")
spct_ss <- get_spatial_catch_sql("ss")
spct_jv <- get_spatial_catch_sql("jv")

# Merge the spatial catch data frames and make them into a spatial `sf` object
spct <- merge_into_spatial(spct_ft,
                           spct_ss,
                           spct_jv)

