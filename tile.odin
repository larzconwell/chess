package main

import rl "vendor:raylib"

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

build_tiles :: proc(config: Config, size: i32) -> []Tile {
	rows :: 8
	columns :: 8
	tile_width := f32(size / columns)
	tile_height := f32(size / rows)
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

