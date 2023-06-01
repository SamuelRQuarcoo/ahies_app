# change here is you want to pin R version
FROM rocker/r-base:latest

# change maintainer here
LABEL maintainer="Samuel R Quarcoo <samuel.quarcoo@gmail.com>"

# add system dependencies for packages as needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    && rm -rf /var/lib/apt/lists/*

# we need remotes and renv
RUN install2.r -e remotes renv

# create non root user
RUN addgroup --system app \
    && adduser --system --ingroup app app

# switch over to the app user home
WORKDIR /home/app

COPY ./renv.lock .
RUN Rscript -e "options(renv.consent = TRUE);renv::restore(lockfile = '/home/app/renv.lock', repos = c(CRAN = 'https://cloud.r-project.org'), library = '/usr/local/lib/R/site-library', prompt = FALSE)"
RUN rm -f renv.lock

RUN Rscript -e "install.packages('shinyjs')"
RUN Rscript -e "install.packages('shinythemes')"

RUN Rscript -e "install.packages('bslib')"
RUN Rscript -e "install.packages('dbplyr')"
RUN Rscript -e "install.packages('lubridate')"
RUN Rscript -e "install.packages('plotly')"
RUN Rscript -e "install.packages('bsicons')"
RUN Rscript -e "install.packages('reactable')"
RUN Rscript -e "install.packages('echarts4r')"
RUN Rscript -e "install.packages('DBI')"
RUN Rscript -e "install.packages('stringr')"
RUN Rscript -e "install.packages('scales')"
RUN Rscript -e "install.packages('readr')"
RUN Rscript -e "install.packages('shinyWidgets')"
RUN Rscript -e "install.packages('shinymanager')"
RUN Rscript -e "install.packages('htmltools')"
RUN Rscript -e "install.packages('htmlwidgets')"
RUN Rscript -e "install.packages('shiny.fluent')"

RUN Rscript -e "install.packages('janitor')"
RUN Rscript -e "install.packages('heatmaply')"
RUN Rscript -e "install.packages('mapboxer')"

RUN Rscript -e "install.packages('bcrypt')"
RUN Rscript -e "install.packages('dplyr')"

# copy everything inside the app folder
COPY app .

# permissions
RUN chown app:app -R /home/app

# change user
USER app

# EXPOSE can be used for local testing, not supported in Heroku's container runtime
EXPOSE 8080

# web process/code should get the $PORT environment variable
ENV PORT=8080

# command we want to run
CMD ["R", "-e", "shiny::runApp('/home/app', host = '0.0.0.0', port=as.numeric(Sys.getenv('PORT')))"]
