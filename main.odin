package main

import "core:strings"
import rl "vendor:raylib"

main :: proc() {
	config := Config {
		fps_target        = 30,
		screen_width      = 1000,
		screen_height     = 1000,
		font_size         = 25,
		tile_colors       = [2]rl.Color{rl.BROWN, rl.BEIGE},
		tile_border_color = rl.DARKBROWN,
	}

	tiles := build_tiles(config)
	defer delete(tiles)

	rl.InitWindow(config.screen_width, config.screen_height, "Chess")
	defer rl.CloseWindow()

	rl.SetExitKey(.KEY_NULL)
	rl.SetTargetFPS(config.fps_target)

	font := rl.LoadFontEx("resources/Jost-400-Book.ttf", i32(config.font_size), nil, 0)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()

		for tile in tiles {
			rl.DrawRectangleRec(tile.rectangle, tile.color)
			rl.DrawRectangleLines(
				i32(tile.rectangle.x),
				i32(tile.rectangle.y),
				i32(tile.rectangle.width),
				i32(tile.rectangle.height),
				config.tile_border_color,
			)

			// a8\x00 for top left tile from white perspective
			rf_string := string([]byte{u8(tile.file) + 97, u8(tile.rank) + 48, 0})
			rl.DrawTextEx(
				font,
				strings.unsafe_string_to_cstring(rf_string),
				rl.Vector2{tile.rectangle.x + 2, tile.rectangle.y + 1},
				f32(config.font_size),
				1,
				tile.alt_color,
			)
		}

		rl.ClearBackground(rl.RAYWHITE)
	}
}

