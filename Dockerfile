FROM alpine

ARG ARG_FRP_VERSION="0.31.1" 
ARG ARG_FRP_DOWNLOAD_URL="https://github.com/fatedier/frp/releases/download/v${ARG_FRP_VERSION}/frp_${ARG_FRP_VERSION}_linux_amd64.tar.gz"

RUN set -xu && \
    wget ${ARG_FRP_DOWNLOAD_URL} && \
    tar -xf /frp_${ARG_FRP_VERSION}_linux_amd64.tar.gz && \
    mv /frp_${ARG_FRP_VERSION}_linux_amd64/frps /usr/local/bin/frps && \
    chmod +x /usr/local/bin/frps && \
    rm /frp_${ARG_FRP_VERSION}_linux_amd64.tar.gz && \
    rm -rf /frp_${ARG_FRP_VERSION}_linux_amd64

COPY frps.ini /etc/

COPY frps-startup.sh /usr/local/bin/

ENV \
    FRPS_BIND_PORT="7000" \
    FRPS_DASHBOARD_PORT="7001" \
    FRPS_DASHBOARD_USER="admin" \
    FRPS_DASHBOARD_PASS="admin" \
    FRPS_SUBDOMAIN_HOST="frp.example.com" \
    FRPS_TOKEN="1234567890"

EXPOSE 80/tcp 443/tcp ${FRPS_BIND_PORT}/tcp ${FRPS_DASHBOARD_PORT}/tcp

CMD [ "/usr/local/bin/frps-startup.sh" ]
