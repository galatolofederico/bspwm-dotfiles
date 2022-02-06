#!/bin/sh
# Polywins (multihead branch)
# Adapted from: https://github.com/tam-carre/polywins/tree/multihead

# SETTINGS {{{ ---


active_text_color="#FFFFFF"
active_underline="false"
active_underline_color="#FFFFFF"
inactive_text_color="#969696"
inactive_underline="false"
inactive_underline_color="#969696"
separator="·"
show="window_class" # options: window_title, window_class, window_classname
char_limit=20 # useful with window_title
char_case="normal" # options: normal, upper, lower
add_spaces="true"

# --- }}}



# Multi-monitor setup
read monitor_width monitor_height monitor_x monitor_y <<EOF
	$(xrandr --query |
	sed -e 's/ primary//' |
	awk -v m=$MONITOR -F'[ x+]' '{if ($1 ~ m) {print $3" "$4" "$5" "$6}}')
EOF
monitor_x_right=$(($monitor_x+$monitor_width))
monitor_y_bottom=$(($monitor_y+$monitor_height))

# Setup
actv_win_left="%{F$active_text_color}"
actv_win_right="%{F-}"
inactv_win_left="%{F$inactive_text_color}"
inactv_win_right="%{F-}"

if [ $active_underline = "true" ]; then
	actv_win_left="${actv_win_left}%{+u}%{u$active_underline_color}"
	actv_win_right="%{-u}${actv_win_right}"
fi

if [ $inactive_underline = "true" ]; then
	inactv_win_left="${inactv_win_left}%{+u}%{u$inactive_underline_color}"
	inactv_win_right="%{-u}${inactv_win_right}"
fi

active_workspace=$(wmctrl -d | awk '/\*/ {print $1}')
active_window=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print "0x0"substr($5,3)}')

# On-click actions
case "$1" in
raise)
	wmctrl -ia "$2"
	;;
close)
	wmctrl -ic "$2"
	;;
slop_resize)
	wmctrl -ia "$2"
	wmctrl -ir "$2" -e "0,$(slop | awk -F'[x+]' '{print $3","$4","$1","$2}')"
	;;
esac

if [ -n "$2" ]; then exit; fi


# Generating the window list
window_list=$(wmctrl -lxG | awk -vORS="" -vOFS="" \
	\
	-v active_workspace="$active_workspace" \
	-v active_window="$active_window" \
	\
	-v active_left="$actv_win_left" \
	-v active_right="$actv_win_right" \
	-v inactive_left="$inactv_win_left" \
	-v inactive_right="$inactv_win_right" \
	\
	-v separator="$separator" \
	-v show="$show" \
	-v c_case="$char_case" \
	-v char_limit="$char_limit" \
	-v add_spaces="$add_spaces" \
	-v on_click="$0" \
	\
	-v monitor_x="$monitor_x" \
	-v monitor_y="$monitor_y" \
	-v monitor_x_right="$monitor_x_right" \
	-v monitor_y_bottom="$monitor_y_bottom" \
	\
	'{
	if ($2 != active_workspace && $2 != "-1") { next }
	if ($7 ~ "polybar" || $7 ~ "yad") { next }

    # not sure it i will need something like that in a multi-monitor setup
	#if ($3 < monitor_x || $4 < monitor_y) { next }
	#if ($3 > monitor_x_right || $4 > monitor_y_bottom) { next }

	if (show == "window_class") {
		lastitem=split($7,classname_and_class,".")
		displayed_name = classname_and_class[lastitem]
	}
	else if (show == "window_classname") {
		split($7,classname_and_class,".")
		displayed_name = classname_and_class[1]
	}
	else if (show == "window_title") {
		# format window title from wmctrl output
		title = ""
		for (i = 9; i <= NF; i++) {
			title = title $i
			if (i != NF) { title = title " "}
		}
		displayed_name = title
	}

	if      (c_case == "lower") { displayed_name = tolower(displayed_name) }
	else if (c_case == "upper") { displayed_name = toupper(displayed_name) }

	if (length(displayed_name) > char_limit) {
		displayed_name = substr(displayed_name,1,char_limit)"…"
	}

	if (add_spaces == "true") { displayed_name = " "displayed_name" " }

	if ($1 == active_window) {
		displayed_name=active_left displayed_name active_right
	}
	else {
		displayed_name=inactive_left displayed_name inactive_right
	}

	if (non_first == "") { non_first = "true" } else {
		print separator # only on non-first items
	}

	print "%{A1:"on_click" raise "$1":}"
	print "%{A2:"on_click" close "$1":}"
	print "%{A3:"on_click" slop_resize "$1":}"
	print displayed_name
	print "%{A}%{A}%{A}%{A}%{A}"
	}')

echo "$window_list"