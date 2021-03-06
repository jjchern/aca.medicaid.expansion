% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{status}
\alias{status}
\title{Status of State Action on the Medicaid Expansion Decision}
\format{
A data frame with six variables:
\itemize{
\item \code{fips}: FIPS State Code
\item \code{usps}: Official United States Postal Service (USPS) Code
\item \code{state}: State Name
\item \code{expansion_date}: State Medicaid expansion date
\item \code{expansion_status}: Expansion status (Not Adopted, Adopted and Implemented,
Adopted but Not Implemented)
\item \code{description}: Short description of expansion status
}
}
\source{
\href{https://www.kff.org/medicaid/issue-brief/status-of-state-medicaid-expansion-decisions-interactive-map/}{KFF: Status of State Action on the Medicaid Expansion Decision}
}
\usage{
status
}
\description{
States' decisions about adopting the Medicaid expansion as of
October 16, 2020.
}
\examples{

library(dplyr)
library(lubridate)

# Convert the data to state-year level

add_st_yr_dummy = function(dta, bgn_yr, end_yr) {
     dta \%>\%
         mutate(year = list(bgn_yr:end_yr)) \%>\%
         unnest(year) \%>\%
         mutate(round_exp_year = round_date(expansion_date, "year")) \%>\%
         mutate(round_exp_year = year(round_exp_year)) \%>\%
         mutate(expansion = if_else(year < round_exp_year |
             is.na(round_exp_year), FALSE, TRUE)) \%>\%
         select(-round_exp_year)
 }

 st_expansion_date \%>\%
     add_st_yr_dummy(bgn_yr = 2010, end_yr = 2020) \%>\%
     print() -> st_yr_expansion

# Convert the data to state-month level

add_st_yr_mo_dummy = function(dta, bgn_yr, bgn_mo, end_yr, end_mo) {

    bgn_dt = paste0(bgn_yr, "/", bgn_mo, "/1")
    end_dt = paste0(end_yr, "/", end_mo, "/1")
    yr_mo = seq(as.Date(bgn_dt), as.Date(end_dt), "months")

    dta \%>\%
        mutate(year_month = list(yr_mo)) \%>\%
        unnest(year_month) \%>\%
        mutate(round_exp_ym = round_date(expansion_date, "month")) \%>\%
        mutate(expansion = if_else(year_month < round_exp_ym |
                                   is.na(round_exp_ym), FALSE, TRUE)) \%>\%
        select(-round_exp_ym)
}

st_expansion_date \%>\%
    add_st_yr_mo_dummy(2010, 1, 2020, 12) \%>\%
    print() -> st_yr_mo_expansion

}
\keyword{datasets}
