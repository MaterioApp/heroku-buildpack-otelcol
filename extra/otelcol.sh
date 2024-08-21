#!/usr/bin/env bash

export PATH="$PATH:$HOME/bin"

APP_OTELCOL="/app/otelcol"
OTEL_CONFIG_FILE="$APP_OTELCOL/config.yaml"

PRERUN_SCRIPT="$APP_OTELCOL/prerun.sh"
if [ -e "$PRERUN_SCRIPT" ]; then
  source "$PRERUN_SCRIPT"
fi

if [ -n "$DISABLE_OTELCOL" ]; then
  echo "The OpenTelemetry Collector agent has been disabled. Unset the $DISABLE_OTELCOL or set missing environment variables."
elif [ ! -f "$OTEL_CONFIG_FILE" ]; then
  echo "OpenTelemetry Collector config file $OTEL_CONFIG_FILE is missing. OpenTelemetry Collector agent is disabled."
else
  bash -c "otelcol --config $OTEL_CONFIG_FILE 2>&1 &"
fi
