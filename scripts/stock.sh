#!/usr/bin/env bash

if [ -z "${STOCK_API_KEY}" ]; then
	echo "STOCK_API_KEY missing"
	exit 0
fi

function get_value() {
	awk -F ',' '{print $5}' <<< "$1"
}

URL="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=1min&apikey=${STOCK_API_KEY}&datatype=csv"

RECORDS="$(curl -Ls --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 30 "${URL}" | tail -n +2)"
CURRENT_PRICE=$(get_value "$(head -n 1 <<< "${RECORDS}")")
PREVIOUS_PRICE=$(get_value "$(tail -n 1 <<< "${RECORDS}")")
if [ "$(echo "${CURRENT_PRICE} - ${PREVIOUS_PRICE} > 0" | bc)" = 1 ]; then
	echo "%{T2}%{F#21de28}勤%{F-}%{T-} \$${CURRENT_PRICE}"
else
	echo "%{T2}%{F#e61e1e}免%{F-}%{T-} \$${CURRENT_PRICE}"
fi
