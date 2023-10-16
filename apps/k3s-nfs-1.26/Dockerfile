ARG VERSION
FROM rancher/k3s:${VERSION} as k3s
FROM ghcr.io/onedr0p/alpine:rolling@sha256:b0b6f6f42bf9649ccaf0e98cd74d5e123471e2c4a4db4a5ee417b18dde9973a9 as builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

COPY --from=k3s /bin /bins

RUN set -ex; \
    mv /bins/aux /bin/aux; \
    mv -n /bins/* /bin; \
    rm -rf /bins

FROM ghcr.io/onedr0p/alpine:rolling@sha256:b0b6f6f42bf9649ccaf0e98cd74d5e123471e2c4a4db4a5ee417b18dde9973a9

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