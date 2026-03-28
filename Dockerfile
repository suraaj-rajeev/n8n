# Official image includes prebuilt native deps (isolated-vm); avoids npm compile failures on Render.
# Pin version to match package.json / self-hosted expectations.
FROM docker.n8n.io/n8nio/n8n:2.13.4

USER root
COPY start-render.sh /start-render.sh
RUN chmod +x /start-render.sh && chown node:node /start-render.sh

USER node
ENTRYPOINT ["/start-render.sh"]
