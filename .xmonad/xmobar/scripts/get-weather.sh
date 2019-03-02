#!/bin/bash

#Calgary: https://weather.gc.ca/wxlink/site_js/s0000047_e.js
#Calgary Olympic Park: https://weather.gc.ca/wxlink/site_js/s0000126_e.js
#Vancouver: https://weather.gc.ca/wxlink/site_js/s0000141_e.js
#Script: https://weather.gc.ca/wxlink/js/wxlink.js

WEATHER_URL=$(get-config '.xmobar["weather-url"]')
SUN_TIME_START=$(get-config '.xmobar["weather-sun-start-time"]')
SUN_TIME_END=$(get-config '.xmobar["weather-sun-end-time"]')
AMBIG_TIME_START=$(get-config '.xmobar["weather-ambiguous-start-time"]')
AMBIG_TIME_END=$(get-config '.xmobar["weather-ambiguous-end-time"]')
TEMPERATURE_HOT_THRESHOLD=$(get-config '.xmobar["weather-hot-threshold"]')
TEMPERATURE_COLD_THRESHOLD=$(get-config '.xmobar["weather-cold-threshold"]')

city_name="N/A"
province_name="N/A"
city_url="N/A"
is_warning="N/A"
is_watch="N/A"
is_statement="N/A"
temperature="N/A"
condition="N/A"
wind_direction="N/A"
wind_speed="N/A"
wind_gust="N/A"
wind_chill="N/A"
humidex="N/A"

fa_prefix="<fn=2>"
fa_suffix="</fn>"
temperature_prefix=""
temperature_suffix=""
no_internet=""

get_variable()
{
	variable_name=$1
	string=$2
	echo "$2" | sed -n -e "s/var $1 = \(\"\([^\"]*\)\"\|\(true\)\|\(false\)\)\;/\2\3\4/p"
}

wget -q --spider $WEATHER_URL

if [ $? -eq 0 ]; then
	weather_details=$(curl -s ${WEATHER_URL})
	city_name=$(get_variable "cityName" "$weather_details")
	province_name=$(get_variable "provinceName" "$weather_details")
	city_url=$(get_variable "cityURL" "$weather_details")
	is_warning=$(get_variable "isWarning" "$weather_details")
	is_watch=$(get_variable "isWatch" "$weather_details")
	is_statement=$(get_variable "isStatement" "$weather_details")
	temperature=$(get_variable "obTemperature" "$weather_details")
	condition=$(get_variable "obCondition" "$weather_details")
	wind_direction=$(get_variable "obWindDir" "$weather_details")
	wind_speed=$(get_variable "obWindSpeed" "$weather_details")
	wind_gust=$(get_variable "obWindGust" "$weather_details")
	wind_chill=$(get_variable "obWindChill" "$weather_details")
	humidex=$(get_variable "obHumidex" "$weather_details")
else
	echo "$fa_prefix$no_internet$fa_suffix $spacer"
	exit 0
fi

if [ "$1" = "--url" ]; then
	google-chrome-stable "$city_url"
	exit 0
fi

case "$condition" in
	"Cloudy") weather_symbol="";;
	"Mostly Cloudy")
		hour=$(date "+%H")
		if [ $hour -ge $SUN_TIME_START -a $hour -le $SUN_TIME_END ]; then
			weather_symbol=""
		elif [ $hour -ge $AMBIG_TIME_START -a $hour -le $AMBIG_TIME_END ]; then
			weather_symbol=""
		else
			weather_symbol=""
		fi
	;;
	"Partly Cloudy")
		hour=$(date "+%H")
		if [ $hour -ge $SUN_TIME_START -a $hour -le $SUN_TIME_END ]; then
			weather_symbol=""
		elif [ $hour -ge $AMBIG_TIME_START -a $hour -le $AMBIG_TIME_END ]; then
			weather_symbol=""
		else
			weather_symbol=""
		fi
	;;
	"Sunny"|"Mainly Sunny") weather_symbol="";;
	"Light Snow"|"Light Snowshower") weather_symbol="";;
	"Blowing Snow"|"Drifting Snow") weather_symbol="";;
	"Ice Crystals") weather_symbol="";;
	"Haze") weather_symbol="";;
	"Hail") weather_symbol="";;
	"Thunderstorm") weather_symbol="";;
	"Lightning") weather_symbol="";;
	"Freezing precipitation") weather_symbol="";;
	"Heavy precipitation") weather_symbol="";;
	"Tornado"|"Funnel Cloud") weather_symbol="";;
	"") weather_symbol="";;
	*) weather_symbol="";;
esac

if [ $temperature -ge $TEMPERATURE_HOT_THRESHOLD ]; then
	temperature_prefix="<fc=#E06C75>"
	temperature_suffix="</fc>"
elif [ $temperature -le $TEMPERATURE_COLD_THRESHOLD ]; then
	temperature_prefix="<fc=#61AFEF>"
	temperature_suffix="</fc>"
else
	temperature_prefix=""
	temperature_suffix=""
fi

echo "$fa_prefix$weather_symbol$fa_suffix $temperature_prefix$temperature$temperature_suffix°C"

exit 0

