#!/bin/sh
set -e
mkdir -p "$OPENCLAW_STATE_DIR"
cat > "$OPENCLAW_STATE_DIR/openclaw.json" <<JSON
{
  "gateway": {
    "controlUi": {
      "allowedOrigins": ["https://openclaw-nj79.onrender.com"],
      "dangerouslyAllowHostHeaderOriginFallback": true,
      "dangerouslyDisableDeviceAuth": true
    }
  },
  "models": {
    "providers": {
      "nvidia": {
        "baseUrl": "https://integrate.api.nvidia.com/v1",
        "api": "openai-completions",
        "timeoutSeconds": 500
      }
    }
  },
  "agents": {
    "defaults": {
      "model": { "primary": "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning" },
      "timeoutSeconds": 500
    }
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "botToken": "8842543688:AAGgL5TcsGbT8wANygOsJ8BXj7FVkgG8L4s",
      "dmPolicy": "allowlist",
      "allowFrom": ["tg:6220157483"]
    }
  }
}
JSON
exec openclaw gateway run --allow-unconfigured --bind lan
openclaw clawhub install imap-smtp-email \
  || echo "[entrypoint] email skill install failed; gateway will start without it"
