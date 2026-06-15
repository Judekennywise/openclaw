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
  }
}
JSON
exec openclaw gateway run --allow-unconfigured --bind lan
