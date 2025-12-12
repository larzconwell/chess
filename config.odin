package main

import rl "vendor:raylib"

Config :: struct {
	fps_target:        i32,
	screen_width:      i32,
	screen_height:     i32,
	font_size:         int,
	tile_colors:       [2]rl.Color,
	tile_border_color: rl.Color,
}

