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
    libffi-dev \
    jq \
    curl

# Create and use a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install LiteLLM with proxy dependencies in the virtual environment
RUN /opt/venv/bin/pip install --no-cache-dir "litellm[proxy]" PyYAML

# Copy data for add-on
COPY run.sh /
COPY validate_yaml.py /
RUN chmod a+x /run.sh /validate_yaml.py

CMD ["/run.sh"]
