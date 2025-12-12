package main

import "core:fmt"
import rl "vendor:raylib"

Config :: struct {
	screen_width:      i32,
	screen_height:     i32,
	fps_target:        i32,
	tile_colors:       [2]rl.Color,
	tile_border_color: rl.Color,
}

File :: enum {
	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
}

Tile :: struct {
	rectangle: rl.Rectangle,
	color:     rl.Color,
	alt_color: rl.Color,
	rank:      int,
	file:      File,
}

build_tiles :: proc(config: Config) -> []Tile {
	rows :: 8
	columns :: 8
	tile_width := f32(config.screen_width / columns)
	tile_height := f32(config.screen_height / rows)
	colors := config.tile_colors

	tiles := make([]Tile, rows * columns)

	for row in 0 ..< rows {
		rank := rows - row // 8-1 from white perspective

		for column in 0 ..< columns {
			tile := &tiles[row * columns + column]

			tile.rank = rank
			tile.file = File(column)
			tile.rectangle = rl.Rectangle {
				width  = tile_width,
				height = tile_height,
				x      = tile_width * f32(column),
				y      = tile_height * f32(row),
			}

			if row % 2 != 0 {
				tile.color = colors[column % len(colors)]
				tile.alt_color = colors[(column + 1) % len(colors)]
			} else {
				tile.color = colors[(column + 1) % len(colors)]
				tile.alt_color = colors[column % len(colors)]
			}
		}
	}

	return tiles
}

main :: proc() {
	config := Config {
		screen_width      = 1000,
		screen_height     = 1000,
		fps_target        = 30,
		tile_colors       = [2]rl.Color{rl.BROWN, rl.BEIGE},
		tile_border_color = rl.DARKBROWN,
	}

	tiles := build_tiles(config)
	defer delete(tiles)

	rl.InitWindow(config.screen_width, config.screen_height, "Chess")
	defer rl.CloseWindow()

	rl.SetExitKey(.KEY_NULL)
	rl.SetTargetFPS(config.fps_target)

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
			fmt.println(rf_string)
		}

		rl.ClearBackground(rl.RAYWHITE)
	}
}

