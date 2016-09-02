FROM ubuntu:14.04

# Base install
RUN apt-get update && apt-get install -y \
    sudo \
    supervisor \
    cron \
    default-jre \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libpq-dev \
    libcurl4-gnutls-dev \
    libxt-dev \
    postgresql

RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list' && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | sudo apt-key add - && \
    apt-get install -y r-base

RUN R --version

# Install
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:opencpu/opencpu-1.5 && \
    apt-get update && \
    apt-get install -y opencpu rstudio-server

RUN apt-get install -y \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-latex-extra

# Install R packages
RUN R -e "install.packages(c('digest', 'DBI', 'RPostgreSQL', 'httr','curl','stringr','reshape2','ggplot2','magrittr','dplyr', 'opencpu','Rcpp','BH','rjson','lubridate','knitr', 'foreach', 'doParallel','boot','scales', 'MASS', 'RPresto', 'devtools', 'ggfortify'), repos='http://cran.rstudio.com/', dependencies=TRUE)"
