add_background "espresso"
add_back_button "espresso" [translate "espresso"]
add_de1_variable "espresso" 2480 120 -text "" -font $::font_setting_heading -fill $::color_text -anchor "e" -textvariable { $::settings(profile_title) }

proc get_target_pressure {} { return $::de1(goal_pressure) }
set ::espresso_pressure_meter [meter new -x [rescale_x_skin 480] -y [rescale_y_skin 200] -width [rescale_x_skin 750] -minvalue 0.0 -maxvalue 12.0 -get_meter_value pressure -get_target_value get_target_pressure -tick_frequency 1.0 -label_frequency 1 -needle_color $::color_pressure -label_color $::color_grey_text -tick_color $::color_background -contexts "espresso" -title [translate "Pressure"] -units "bar"]
add_de1_variable "espresso" -100 -100 -text "" -textvariable {[$::espresso_pressure_meter update]} 

proc get_target_flow {} {
	if { $::de1(substate) == 4 || $::de1(substate) == 5 } {
		return $::de1(goal_flow) 
	}
	return 0
}
set ::espresso_flow_meter [meter new -x [rescale_x_skin 1330] -y [rescale_y_skin 200] -width [rescale_x_skin 750] -minvalue 0.0 -maxvalue 5.0 -get_meter_value waterflow -get_target_value get_target_flow -tick_frequency 0.5 -label_frequency 1 -needle_color $::color_flow -label_color $::color_grey_text -tick_color $::color_background -contexts "espresso" -title [translate "Flow rate"] -units "mL/s"]
add_de1_variable "espresso" -100 -100 -text "" -textvariable {[$::espresso_flow_meter update]} 

proc get_target_temperature {} { return $::de1(goal_temperature) }
set ::espresso_temperature_meter [meter new -x [rescale_x_skin 80] -y [rescale_y_skin 780] -width [rescale_x_skin 500] -minvalue 80.0 -maxvalue 100.0 -get_meter_value water_mix_temperature -get_target_value get_target_temperature -tick_frequency 1 -label_frequency 5 -needle_color $::color_temperature -label_color $::color_grey_text -tick_color $::color_background -contexts "espresso" -title [translate "Water temperature"] -units [return_html_temperature_units]]
add_de1_variable "espresso" -100 -100 -text "" -textvariable {[$::espresso_temperature_meter update]} 

proc get_target_weight {} {
	if {$::settings(settings_profile_type) == "settings_2c" } {
		return $::settings(final_desired_shot_volume_advanced)
	} else {
		return $::settings(final_desired_shot_volume)
	} 
}

proc get_weight {} {
	if {$::settings(scale_bluetooth_address) != "" && $::de1(scale_weight) != ""} {
		return $::de1(scale_weight)
	}

	if {$::settings(settings_profile_type) == "settings_2c" } {
		return [expr {$::de1(preinfusion_volume) + $::de1(pour_volume)}]
	} else {
		return $::de1(pour_volume)
	}
}

set ::espresso_weight_meter [meter new -x [rescale_x_skin 1980] -y [rescale_y_skin 780] -width [rescale_x_skin 500] -minvalue 0.0 -maxvalue 50.0 -get_meter_value get_weight -get_target_value get_target_weight -tick_frequency 5 -label_frequency 10 -needle_color $::color_yield -label_color $::color_grey_text -tick_color $::color_background -contexts "espresso" -title [translate "Yield"] -units "g"]
add_de1_variable "espresso" -100 -100 -text "" -textvariable {[$::espresso_weight_meter update]} 

create_action_button "espresso" 1280 1020 $::symbol_hand $::font_action_button $::color_action_button_stop $::color_action_button_text {say [translate "stop"] $::settings(sound_button_in); start_idle } "fullscreen"

# timer on stop button
# TODO: rounded ends (need to draw a circle at each endpoint)
# TODO: create a reusable function (or add as an option to create_action_button?)
add_de1_variable "espresso" 1300 1090 -text "" -font $::font_setting_heading -fill $::color_action_button_text -anchor "ne" -textvariable {[espresso_elapsed_timer]}
add_de1_text "espresso" 1310 1090 -text [translate "s"] -font $::font_setting_heading -fill $::color_action_button_text -anchor "nw"
.can create arc [rescale_x_skin 1100] [rescale_y_skin 840] [rescale_x_skin 1460] [rescale_y_skin 1200] -start 90 -extent 0 -style arc -width [rescale_x_skin 15] -outline $::color_action_button_text -tag "espresso_timer"
add_visual_items_to_contexts "espresso" "espresso_timer"

proc update_espresso_timer {} {
	if {$::timers(espresso_start) == 0} {
		set duration 0.0
	} elseif {$::timers(espresso_stop) == 0} {
		set duration [expr {[clock milliseconds] - $::timers(espresso_start)}]
	} else {
		set duration [expr {$::timers(espresso_stop) - $::timers(espresso_start)}]
	}
	set angle [expr $duration / 1000.0 / 60.0 * -360.0]
	.can itemconfigure "espresso_timer"	-extent $angle
}
add_de1_variable "espresso" -100 -100 -text "" -textvariable {[update_espresso_timer]} 