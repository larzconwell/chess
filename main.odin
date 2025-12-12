package main

import rl "vendor:raylib"

main :: proc() {
	screen_width: i32 = 1000
	screen_height: i32 = 1000
	fps_target: i32 = 30

	rl.InitWindow(screen_width, screen_height, "Chess")
	defer rl.CloseWindow()

	rl.SetExitKey(.KEY_NULL)
	rl.SetTargetFPS(fps_target)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.RAYWHITE)
	}
}

