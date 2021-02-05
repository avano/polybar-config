#!/usr/bin/env bash
RESPONSE=$(playerctl --player spotify metadata --format "{{ title }} - {{ artist }}" 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
	echo "${RESPONSE}"
else
	echo "---"
fi

