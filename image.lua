--|============================|
--|     Image Library          |
--|     For OpenCasino         |
--|     Адаптировано 2024      |
--|============================|

local image = {}
local g = require("component").gpu

local function drawSprite(x, y, data, colors)
    for row = 1, #data do
        for col = 1, #data[row] do
            local char = data[row][col]
            if char ~= " " then
                local colorIndex = colors[row][col] or 1
                g.setForeground(colorIndex)
                g.set(x + col - 1, y + row - 1, char)
            end
        end
    end
end

local COLORS = {
    RED = 0xFF0000,
    GREEN = 0x00FF00,
    BLUE = 0x0000FF,
    YELLOW = 0xFFFF00,
    ORANGE = 0xFFA500,
    PURPLE = 0x8B00FF,
    PINK = 0xFF69B4,
    BROWN = 0x8B4513,
    WHITE = 0xFFFFFF,
    BLACK = 0x000000,
    GOLD = 0xFFD700,
    SILVER = 0xC0C0C0,
    CHERRY_RED = 0xCC0000,
    MEAT_PINK = 0xFF6B6B,
    CHEESE_YELLOW = 0xFFD700,
    DIAMOND_BLUE = 0x00BFFF,
    SEVEN_RED = 0xFF0000,
    PICKAXE_GRAY = 0x808080,
    APPLE_RED = 0xFF3333,
    POKEBALL_RED = 0xFF0000,
    POKEBALL_WHITE = 0xFFFFFF,
    POKEBALL_BLACK = 0x333333,
    ORANGE_FRUIT = 0xFF8C00,
}

function image.cherry(x, y)
    local data = {
        {" ", "█", "█", "█", " ", " "},
        {"█", "█", "█", "█", "█", " "},
        {"█", "█", "█", "█", "█", "█"},
        {" ", "█", "█", "█", "█", "█"},
        {" ", " ", "█", "█", "█", " "},
    }
    local colors = {
        {0, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, 0, 0},
        {COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, 0},
        {COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED},
        {0, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED},
        {0, 0, COLORS.CHERRY_RED, COLORS.CHERRY_RED, COLORS.CHERRY_RED, 0},
    }
    drawSprite(x, y, data, colors)
    g.setForeground(0x00AA00)
    g.set(x + 3, y - 1, "|")
    g.set(x + 2, y - 2, "/")
end

function image.seven(x, y)
    g.setForeground(COLORS.SEVEN_RED)
    g.set(x, y, "█████")
    g.set(x, y + 1, "   █ ")
    g.set(x, y + 2, "  █  ")
    g.set(x, y + 3, " █   ")
    g.set(x, y + 4, "█████")
    g.setForeground(0xFF6666)
    g.set(x + 1, y, "██")
    g.set(x + 3, y + 4, "██")
end

function image.diamond(x, y)
    local data = {
        {" ", " ", "█", " ", " "},
        {" ", "█", "█", "█", " "},
        {"█", "█", "█", "█", "█"},
        {" ", "█", "█", "█", " "},
        {" ", " ", "█", " ", " "},
    }
    local colors = {
        {0, 0, COLORS.DIAMOND_BLUE, 0, 0},
        {0, COLORS.DIAMOND_BLUE, 0x66CCFF, COLORS.DIAMOND_BLUE, 0},
        {COLORS.DIAMOND_BLUE, 0x66CCFF, 0xFFFFFF, 0x66CCFF, COLORS.DIAMOND_BLUE},
        {0, COLORS.DIAMOND_BLUE, 0x66CCFF, COLORS.DIAMOND_BLUE, 0},
        {0, 0, COLORS.DIAMOND_BLUE, 0, 0},
    }
    drawSprite(x, y, data, colors)
end

function image.orange(x, y)
    local data = {
        {" ", "█", "█", "█", " "},
        {"█", "█", "█", "█", "█"},
        {"█", "█", " ", "█", "█"},
        {"█", "█", "█", "█", "█"},
        {" ", "█", "█", "█", " "},
    }
    local colors = {
        {0, COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT, 0},
        {COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT, 0xFFAA33, COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT},
        {COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT, 0, COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT},
        {COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT, 0xFFAA33, COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT},
        {0, COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT, COLORS.ORANGE_FRUIT, 0},
    }
    drawSprite(x, y, data, colors)
    g.setForeground(0x00AA00)
    g.set(x + 2, y - 1, "*")
end

function image.pickaxe(x, y)
    g.setForeground(COLORS.PICKAXE_GRAY)
    g.set(x + 2, y, "█")
    g.set(x + 1, y + 1, "███")
    g.set(x, y + 2, "█████")
    g.set(x + 1, y + 3, "█ █")
    g.set(x + 2, y + 4, "█")
    g.setForeground(0x8B6914)
    g.set(x + 2, y + 5, "█")
    g.set(x + 2, y + 6, "█")
end

function image.cheese(x, y)
    local data = {
        {" ", "█", "█", "█", " "},
        {"█", "█", "█", "█", "█"},
        {"█", "█", " ", "█", "█"},
        {"█", "█", "█", "█", "█"},
        {" ", "█", "█", "█", " "},
    }
    local colors = {
        {0, COLORS.CHEESE_YELLOW, COLORS.CHEESE_YELLOW, COLORS.CHEESE_YELLOW, 0},
        {COLORS.CHEESE_YELLOW, 0xFFFF66, COLORS.CHEESE_YELLOW, 0xFFFF66, COLORS.CHEESE_YELLOW},
        {COLORS.CHEESE_YELLOW, COLORS.CHEESE_YELLOW, 0, COLORS.CHEESE_YELLOW, COLORS.CHEESE_YELLOW},
        {COLORS.CHEESE_YELLOW, 0xFFFF66, COLORS.CHEESE_YELLOW, 0xFFFF66, COLORS.CHEESE_YELLOW},
        {0, COLORS.CHEESE_YELLOW, COLORS.CHEESE_YELLOW, COLORS.CHEESE_YELLOW, 0},
    }
    drawSprite(x, y, data, colors)
end

function image.pokeball(x, y)
    local data = {
        {" ", "█", "█", "█", " "},
        {"█", "█", "█", "█", "█"},
        {"█", "█", " ", "█", "█"},
        {"█", "█", "█", "█", "█"},
        {" ", "█", "█", "█", " "},
    }
    local colors = {
        {0, COLORS.POKEBALL_RED, COLORS.POKEBALL_RED, COLORS.POKEBALL_RED, 0},
        {COLORS.POKEBALL_RED, COLORS.POKEBALL_RED, COLORS.POKEBALL_WHITE, COLORS.POKEBALL_RED, COLORS.POKEBALL_RED},
        {COLORS.POKEBALL_RED, COLORS.POKEBALL_WHITE, COLORS.POKEBALL_BLACK, COLORS.POKEBALL_WHITE, COLORS.POKEBALL_RED},
        {COLORS.POKEBALL_WHITE, COLORS.POKEBALL_WHITE, COLORS.POKEBALL_RED, COLORS.POKEBALL_WHITE, COLORS.POKEBALL_WHITE},
        {0, COLORS.POKEBALL_WHITE, COLORS.POKEBALL_WHITE, COLORS.POKEBALL_WHITE, 0},
    }
    drawSprite(x, y, data, colors)
end

function image.meat(x, y)
    local data = {
        {" ", "█", "█", " ", " "},
        {"█", "█", "█", "█", " "},
        {"█", "█", "█", "█", "█"},
        {" ", "█", "█", "█", "█"},
        {" ", " ", "█", "█", " "},
    }
    local colors = {
        {0, COLORS.MEAT_PINK, COLORS.MEAT_PINK, 0, 0},
        {COLORS.MEAT_PINK, 0xFF9999, COLORS.MEAT_PINK, COLORS.MEAT_PINK, 0},
        {COLORS.MEAT_PINK, COLORS.MEAT_PINK, 0xFF9999, COLORS.MEAT_PINK, COLORS.MEAT_PINK},
        {0, COLORS.MEAT_PINK, COLORS.MEAT_PINK, 0xFF9999, COLORS.MEAT_PINK},
        {0, 0, COLORS.MEAT_PINK, COLORS.MEAT_PINK, 0},
    }
    drawSprite(x, y, data, colors)
    g.setForeground(0xFFFFFF)
    g.set(x + 1, y + 1, "█")
    g.set(x + 3, y + 3, "█")
end

function image.apple(x, y)
    local data = {
        {" ", "█", "█", "█", " "},
        {"█", "█", "█", "█", "█"},
        {"█", "█", " ", "█", "█"},
        {"█", "█", "█", "█", "█"},
        {" ", "█", "█", "█", " "},
    }
    local colors = {
        {0, COLORS.APPLE_RED, COLORS.APPLE_RED, COLORS.APPLE_RED, 0},
        {COLORS.APPLE_RED, 0xFF6666, COLORS.APPLE_RED, 0xFF6666, COLORS.APPLE_RED},
        {COLORS.APPLE_RED, COLORS.APPLE_RED, 0, COLORS.APPLE_RED, COLORS.APPLE_RED},
        {COLORS.APPLE_RED, 0xFF6666, COLORS.APPLE_RED, 0xFF6666, COLORS.APPLE_RED},
        {0, COLORS.APPLE_RED, COLORS.APPLE_RED, COLORS.APPLE_RED, 0},
    }
    drawSprite(x, y, data, colors)
    g.setForeground(0x00AA00)
    g.set(x + 2, y - 1, "*")
    g.set(x + 3, y - 2, "`")
end

return image
