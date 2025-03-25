# LiteLLM Home Assistant Add-on Repository

This repository contains a Home Assistant add-on for running LiteLLM, a proxy server that provides unified access to various large language models through a standardized API.

## Installation

1. Add this repository to your Home Assistant add-on store:

   - Go to Settings → Add-ons → Add-on Store
   - Click the menu (⋮) in the top right
   - Select "Repositories"
   - Add the URL: `https://github.com/d1egoaz/litellm-homeassistant-addon`

2. Install the "LiteLLM" add-on from the store

## Available Add-ons

### [LiteLLM](./litellm)

Run a LiteLLM proxy server within Home Assistant to access various language models through a unified API.

## About LiteLLM

[LiteLLM](https://github.com/BerriAI/litellm) is an open-source project that simplifies the process of accessing various large language models through a unified API that follows the OpenAI format. It supports multiple providers including OpenAI, Anthropic, Cohere, and many others.

This add-on uses the official LiteLLM Docker image from `ghcr.io/berriai/litellm:main-latest`.

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
 general_settings:
   master_key: "sk-1234"
   database_url: "postgresql://..." 
# Port the LiteLLM server will listen on (default: 4000)
port: 4000
```

You can modify this configuration to add any supported LiteLLM settings. For full documentation on available configuration options, see the [LiteLLM documentation](https://docs.litellm.ai/docs/).

## Usage

Once configured and started, LiteLLM will be available at:

- URL: `http://homeassistant.local:4000`
- API Endpoint: `http://homeassistant.local:4000/v1/chat/completions`

You can use this with any OpenAI-compatible client by setting the appropriate base URL.
