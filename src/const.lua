WINDOW_WIDTH = 2560
WINDOW_HEIGHT = 1600

VIRTUAL_WIDTH = 1920
VIRTUAL_HEIGHT = 1080

TILE_SIZE = 64

MAP_WIDTH = VIRTUAL_WIDTH / TILE_SIZE - 2
MAP_HEIGHT = math.floor(VIRTUAL_HEIGHT / TILE_SIZE) - 2

MAP_RENDER_OFFSET_X = (VIRTUAL_WIDTH - (MAP_WIDTH * TILE_SIZE)) / 2
MAP_RENDER_OFFSET_Y = (VIRTUAL_HEIGHT - (MAP_HEIGHT * TILE_SIZE)) / 2



