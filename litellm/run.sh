#!/usr/bin/with-contenv bashio

# Enable debug mode to see all commands
set -x

CONFIG_PATH=/app/config.yaml
PORT=$(bashio::config 'port')

# Activate virtual environment path
export PATH="/opt/venv/bin:$PATH"
mkdir -p /app

# Get the config from options and write it to the config file
bashio::log.info "Writing configuration to ${CONFIG_PATH}"
bashio::config "config" >${CONFIG_PATH}

# Debug: Print the configuration file
bashio::log.info "Configuration content:"
cat ${CONFIG_PATH}

# Validate YAML configuration
bashio::log.info "Validating YAML configuration:"
if [ -f "/validate_yaml.py" ]; then
    python3 /validate_yaml.py ${CONFIG_PATH} || {
        bashio::log.error "Invalid YAML configuration"
        sleep 30
        exit 1
    }
else
    # Fallback validation using Python directly
    python3 -c "import yaml; yaml.safe_load(open('${CONFIG_PATH}'))" || {
        bashio::log.error "Invalid YAML configuration"
        sleep 30
        exit 1
    }
fi

# Debug: Check litellm installation
bashio::log.info "Checking litellm installation:"
which litellm || bashio::log.error "litellm not found in PATH"
python3 -m pip list | grep litellm

# Debug: Check Python version
bashio::log.info "Python version:"
python3 --version

# Debug: Verify the virtual environment is activated
bashio::log.info "Current Python path:"
which python3

# Start LiteLLM with the config file and configured port
bashio::log.info "Starting LiteLLM proxy server on port ${PORT}"

# Try running with verbose output
bashio::log.info "Running LiteLLM with verbose output"
exec litellm --config ${CONFIG_PATH} --port ${PORT} --verbose || {
    EXIT_CODE=$?
    bashio::log.error "LiteLLM failed to start. Error code: ${EXIT_CODE}"

    # Try to get more info about the failure
    bashio::log.info "Trying to run litellm with --help to verify command exists:"
    litellm --help || bashio::log.error "litellm --help failed, command may be invalid"

    # List directory contents to check permissions
    bashio::log.info "Directory contents of /app:"
    ls -la /app

    # Wait before exiting to capture logs
    sleep 30
    exit ${EXIT_CODE}
}
