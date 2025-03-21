#!/usr/bin/with-contenv bashio

CONFIG_PATH=/app/config.yaml
PORT=$(bashio::config 'port')

# Get the config from options and write it to the config file
bashio::log.info "Writing configuration to ${CONFIG_PATH}"
bashio::config.get "config" > ${CONFIG_PATH}

# Start LiteLLM with the config file and configured port
bashio::log.info "Starting LiteLLM proxy server on port ${PORT}"
exec litellm --config ${CONFIG_PATH} --port ${PORT}
