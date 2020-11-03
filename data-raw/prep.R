
# Source: https://www.kff.org/health-reform/state-indicator/state-activity-around-expanding-medicaid-under-the-affordable-care-act/

library(tidyverse)
library(lubridate)
library(usethis)

# Add raw data from KFF ---------------------------------------------------

url = "https://www.kff.org/wp-content/uploads/2019/04/expansion-status-interactive-map_10.1.20-2.csv"

read_csv(url) %>%
    docxtractr::mcga() %>%
    mutate(description = str_trim(description)) %>%
    mutate(expansion_date = str_extract(description, "[0-9]{1,}/[0-9]{1,}/[0-9]{4}")) %>%
    mutate(expansion_date = mdy(expansion_date)) %>%
    left_join(fips::state) %>%
    select(fips, usps, state, expansion_date, everything()) %>%
    print(n = 51) -> status

use_data(status, overwrite = TRUE)
