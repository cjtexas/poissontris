# Install R version 3.5
FROM r-base:3.5.0

# Install Ubuntu packages
RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev \
    libssl-dev

# Install R packages that are required
# TODO: add further package if you need!
RUN R -e "install.packages(c('shiny', 'oaColors', 'oaPlots', 'htmltools', 'svglite', 'pryr', 'devtools'), repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('glue', 'stringi', 'stringr'), repos='http://cran.rstudio.com/')"

COPY .Renviron /root/.Renviron

ARG CACHE_DATE=2016-01-01
RUN R -e "devtools::install_github('lincis/poissontris')"

EXPOSE 80

ENTRYPOINT [ "R", "-e", "options(shiny.port = 80, shiny.host = '0.0.0.0'); library(poissontris); runPoissontris()" ]
# CMD ["R", -e \"options(shiny.port = 80, shiny.host = '0.0.0.0'); library(poissontris); runPoissontris()\""]
