ARG VERSION
FROM rancher/k3s:${VERSION} as k3s
FROM ghcr.io/onedr0p/alpine:rolling@sha256:3fbc581cb0fe29830376161ae026e2a765dcc11e1747477fe9ebf155720b8638 as builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

COPY --from=k3s /bin /bins

# RUN set -ex; \ # Maybe this will work again someday
RUN set -x; \
    mv /bins/aux /bin/aux; \
    mv -n /bins/* /bin; \
    rm -rf /bins

FROM ghcr.io/onedr0p/alpine:rolling@sha256:3fbc581cb0fe29830376161ae026e2a765dcc11e1747477fe9ebf155720b8638

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