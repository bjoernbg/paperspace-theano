FROM terminus7/gpu-py3-th

ARG KERAS_VERSION=2.0.4

# new python dependencies
RUN pip --no-cache-dir install \
        h5py \
        tqdm

# Keras
RUN pip --no-cache-dir install git+git://github.com/fchollet/keras.git@${KERAS_VERSION}
RUN pip --no-cache-dir install --upgrade git+https://github.com/jayanthkoushik/keras.git

ENV KERAS_BACKEND theano
ENV THEANO_FLAGS='device=cuda,floatX=float32'

RUN pip install theano

RUN python -c "import theano"

WORKDIR "/root"
CMD ["/bin/bash"]
