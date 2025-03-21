ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python and pip
RUN \
  apk add --no-cache \
    python3 \
    py3-pip

# Install LiteLLM with proxy dependencies
RUN pip3 install --no-cache-dir 'litellm[proxy]'

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
