#!/bin/sh

API="https://api.kraken.com/0/public/Ticker"

quote=$(curl -sf $API?pair=XRPEUR | jq -r ".result.XXRPZEUR.c[0]")
quote=$(LANG=C printf "%.2f" "$quote")

echo "$quote€"
