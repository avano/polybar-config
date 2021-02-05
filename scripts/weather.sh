#!/bin/sh

if [ -z "${WEATHER_API_KEY}" ]; then
	echo "WEATHER_API_KEY missing"
	exit 0
fi

if [ -z "${WEATHER_CITY}" ]; then
	echo "WEATHER_CITY missing"
	exit 0
fi

get_icon() {
    case $1 in
        # Icons for weather-icons
        01d) icon="%{F#f5f511}滛%{F-}";;
        01n) icon="%{F#f5f511}望%{F-}";;
        02*) icon="%{F#ffff82}杖%{F-}";;
        03*) icon="%{F#7780a1}摒%{F-}";;
        04*) icon="%{F#7780a1}摒%{F-}";;
        09*) icon="%{F#3998f7}歹%{F-}";;
        10*) icon="%{F#3998f7}歹%{F-}";;
        11*) icon="%{F#3998f7}ﭼ%{F-}";;
        13*) icon="%{F#FFFFFF}%{F-}";;
        50*) icon="%{F#FFFFFF}敖%{F-}";;
        *) icon="";
    esac

    echo $icon
}

SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

weather=$(curl -sf "${API}/weather?appid=${WEATHER_API_KEY}&id=${WEATHER_CITY}&units=metric")

if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
	feels_like=$(echo "$weather" | jq ".main.feels_like" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

	echo "$(get_icon "$weather_icon")" "Trnava - $weather_temp$SYMBOL ($feels_like$SYMBOL)"
fi
