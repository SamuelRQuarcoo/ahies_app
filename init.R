# init.R
#
# Example R code to install packages if not already installed in app

my_packages = c("shiny", 
                "shinyjs",
                "shinythemes",
                "shinyauthr",
                "bslib", 
                "dbplyr",
                "lubridate",
                "plotly",
                "bsicons", 
                "reactable",
                "echarts4r",
                "DBI",
                "stringr", 
                "tidyr",
                "scales",
                "stringr",
                "readr",
                "shinyWidgets",
                "shinymanager",
                "htmltools",
                "htmlwidgets",
                "shiny.fluent",
                "RMySQL",
                "janitor",
                "heatmaply",
                "aws.s3",
                "mapboxer",
                "bcrypt",
                "dplyr"
                )


install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))
install.packages("bslib")
install.packages("bsicons")
install.packages("shiny")


