#!/usr/bin/with-contenv bashio

CONFIG_PATH=/app/config.yaml
PORT=$(bashio::config 'port')

# Activate virtual environment path
export PATH="/opt/venv/bin:$PATH"
mkdir -p /app

# Get the config from options and write it to the config file
bashio::log.info "Writing configuration to ${CONFIG_PATH}"
bashio::config "config" > ${CONFIG_PATH}

# Start LiteLLM with the config file and configured port
bashio::log.info "Starting LiteLLM proxy server on port ${PORT}"
exec litellm --config ${CONFIG_PATH} --port ${PORT}
