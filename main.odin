package main

import rl "vendor:raylib"

Config :: struct {
	screen_width:  i32,
	screen_height: i32,
	fps_target:    i32,
}

main :: proc() {
	config := Config {
		screen_width  = 1000,
		screen_height = 1000,
		fps_target    = 30,
	}

	rl.InitWindow(config.screen_width, config.screen_height, "Chess")
	defer rl.CloseWindow()

	rl.SetExitKey(.KEY_NULL)
	rl.SetTargetFPS(config.fps_target)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.RAYWHITE)
	}
}

