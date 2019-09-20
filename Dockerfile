FROM terminus7/gpu-py3-th

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
       
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
RUN cat ~/.bashrc

# new python dependencies
RUN pip --no-cache-dir install \
        h5py \
        tqdm

# Keras
RUN pip --no-cache-dir install --upgrade git+https://github.com/jayanthkoushik/keras.git

ENV KERAS_BACKEND theano
ENV THEANO_FLAGS='device=cuda,floatX=float32'

RUN pip --no-cache-dir install theano

RUN python3 --version
RUN python3 -c "import theano"

WORKDIR "/root"
CMD ["/bin/bash"]
