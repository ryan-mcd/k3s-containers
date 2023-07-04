FROM ghcr.io/onedr0p/alpine:rolling@sha256:4b666f73ee079b4feac9527fae3b0e60b0e9883213758bdb28af852c9acb4efe as builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

COPY --from=rancher/k3s:v1.25.6-k3s1 /bin /bins

RUN set -ex; \
    mv /bins/aux /bin/aux; \
    mv -n /bins/* /bin; \
    rm -rf /bins

FROM ghcr.io/onedr0p/alpine:rolling@sha256:4b666f73ee079b4feac9527fae3b0e60b0e9883213758bdb28af852c9acb4efe

RUN rm -rf /bin

COPY --from=builder /bin /bin

RUN set -ex; \
    apk add --no-cache nfs-utils; \
    echo 'hosts: files dns' > /etc/nsswitch.conf; 

VOLUME /var/lib/kubelet
VOLUME /var/lib/rancher/k3s
VOLUME /var/lib/cni
VOLUME /var/log

ENV PATH="$PATH:/bin/aux"
ENV CRI_CONFIG_FILE="/var/lib/rancher/k3s/agent/etc/crictl.yaml"

ENTRYPOINT ["/bin/k3s"]
CMD ["agent"]

LABEL org.opencontainers.image.source="https://github.com/k3s-io/k3s"