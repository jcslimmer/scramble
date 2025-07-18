FROM rocker/r-ver:4.2.0

RUN apt-get update && \
    apt-get install -y \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    libxml2-dev \
    ncbi-blast+ \
    zlib1g-dev \
    libhts-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN Rscript -e "install.packages(c('remotes', 'optparse', 'stringr'))"
RUN Rscript -e "remotes::install_github('mhahsler/rBLAST@devel')"

# install scramble
COPY . /app

RUN cd /app/cluster_identifier/src && \
  make
RUN ln -s /app/cluster_identifier/src/build/cluster_identifier /usr/local/bin

# define default command
CMD ["Rscript"]
