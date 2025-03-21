ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python, pip and build dependencies
RUN \
  apk add --no-cache \
    python3 \
    py3-pip \
    python3-dev \
    py3-virtualenv \
    gcc \
    musl-dev \
    libffi-dev

# Create and use a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install LiteLLM with proxy dependencies in the virtual environment
RUN /opt/venv/bin/pip install --no-cache-dir "litellm[proxy]"

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
