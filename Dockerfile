FROM terminus7/gpu-py3-th

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
