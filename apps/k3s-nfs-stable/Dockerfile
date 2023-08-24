ARG VERSION
FROM rancher/k3s:${VERSION} as k3s
FROM ghcr.io/onedr0p/alpine:rolling@sha256:974f5883eb9b838792f1b27b812d8b9f80375ba9ac1f8b038fda27a53f6cd763 as builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

COPY --from=k3s /bin /bins

RUN set -ex; \
    mv /bins/aux /bin/aux; \
    mv -n /bins/* /bin; \
    rm -rf /bins

FROM ghcr.io/onedr0p/alpine:rolling@sha256:974f5883eb9b838792f1b27b812d8b9f80375ba9ac1f8b038fda27a53f6cd763

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

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