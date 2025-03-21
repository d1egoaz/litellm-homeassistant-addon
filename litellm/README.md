# LiteLLM Home Assistant Add-on

This add-on runs a [LiteLLM](https://github.com/BerriAI/litellm) proxy server in Home Assistant, allowing you to use various large language models through a unified API.

## Configuration

The add-on configuration allows you to define your LiteLLM configuration:

```yaml
# LiteLLM configuration in YAML format
config: |-
  model_list:
    - model_name: "*"
      litellm_params:
        model: openai/*
        api_key: os.environ/OPENAI_API_KEY
  environment_variables:
    OPENAI_API_KEY: <your-api-key-here>

# Port the LiteLLM server will listen on (default: 4000)
port: 4000
```

You can modify this configuration to add any supported LiteLLM settings. For full documentation on available configuration options, see the [LiteLLM documentation](https://docs.litellm.ai/docs/).

## Usage

Once configured and started, LiteLLM will be available at:

- URL: `http://homeassistant.local:4000`
- API Endpoint: `http://homeassistant.local:4000/v1/chat/completions`

You can use this with any OpenAI-compatible client by setting the appropriate base URL.
