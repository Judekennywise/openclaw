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
      "model": { "primary": "nvidia/nvidia/nemotron-3-ultra-550b-a55b" },
      "timeoutSeconds": 500
    }
  }
}
JSON
exec openclaw gateway run --allow-unconfigured --bind lan
