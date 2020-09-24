FROM gradle:jdk14
USER root
RUN deluser gradle

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Install common Dojo scripts
ENV DOJO_VERSION=0.10.0 \
    RUNTIME_DEPS="sudo git ca-certificates wget make fish"

RUN apt-get update && \
    apt-get install -y --no-install-recommends $RUNTIME_DEPS && \
    echo 'dojo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    git clone --depth 1 -b ${DOJO_VERSION} https://github.com/kudulab/dojo.git /tmp/dojo_git &&\
    /tmp/dojo_git/image_scripts/src/install.sh && \
    rm -r /tmp/dojo_git && \
    apt-get clean

WORKDIR /dojo/work
ENTRYPOINT ["/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/usr/bin/fish"]
