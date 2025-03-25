ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python, pip and build dependencies
RUN \
  apk add --no-cache \
    gcc \
    libffi-dev \
    musl-dev \
    nodejs \
    npm \
    openssl \
    openssl-dev \
    py3-pip \
    py3-virtualenv \
    python3 \
    python3-dev

# Create and use a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install required Python packages in the virtual environment
RUN /opt/venv/bin/pip install --no-cache-dir \
    "litellm[proxy]" \
    prometheus_client \
    langfuse \
    prisma

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
