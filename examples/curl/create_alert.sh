#!/usr/bin/env bash
# Track a Product with a Target Price – cURL example
# Usage: ASIN_API_KEY=your-key bash create_alert.sh
set -euo pipefail

curl -sS --fail-with-body -X POST "https://www.asin.dev/api/v1/products" \
  -H "Authorization: Bearer ${ASIN_API_KEY}" \
  -H "Content-Type: application/json" \
  --data '{"product": "B09DFCB66S", "marketplace": "com", "target_price": 70}'
