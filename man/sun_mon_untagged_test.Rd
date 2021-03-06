% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_viney_bates_test.R
\name{sun_mon_untagged_test}
\alias{sun_mon_untagged_test}
\title{Test for Sunday Monday Untagged Accumulations}
\usage{
sun_mon_untagged_test(fun_prcp_var, fun_dapr_var, stn_id, min_perc = 0.5)
}
\arguments{
\item{fun_prcp_var}{standard rnoaa format for precipiation, PRCP,
see rnoaa::meteo_pull_monitors()}

\item{fun_dapr_var}{standard rnoaa format for days accumulated precipitaiotn, DAPR,
see rnoaa::meteo_pull_monitors()}

\item{stn_id}{the station we want to consider
(optional, otherwise it defaults to the ID in fun_prcp_var)}

\item{min_perc}{minimum proportion of weekday observations per year needed to run the test,
defaults to a half}
}
\value{
Returns the a data frame with columns block, which is the year, and p_value.
}
\description{
Checks for the presence of untagged Sunday Monday accumulations as in
Viney and Bates (2004).
}
\details{
Test currently runs on yearly observations only. The block index returned
therefore corresponds to the year.
}
\examples{

stn_id = "ASN00010525" #"ASN00022000"

prcp_var <- meteo_pull_monitors(stn_id,
                                date_min = "1910-01-01",
                                date_max = "2000-01-01",
                                keep_flags = TRUE,
                                var = "PRCP")

dapr_var <- meteo_pull_monitors(stn_id,
                                date_min = "1910-01-01",
                                date_max = "2000-01-01",
                                keep_flags = TRUE,
                                var = "DAPR")

output <- sun_mon_untagged_test(prcp_var, dapr_var, stn_id)
output <- sun_mon_untagged_test(prcp_var, dapr_var)

ggplot(output, aes(x = block, y = p_value)) +
  geom_hline(yintercept = c(0.0008, 0.5), linetype = "dashed", col = "darkgray", size = 1.1) +
  geom_point() +
  geom_line() +
  scale_y_log10() +
  xlab("Year") +
  ylab("P-Value") +
  ggtitle(paste("Test for Sunday Monday accumulations at", stn_id)) +
  theme_bw()

}
