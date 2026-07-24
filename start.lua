-- start.lua - Полный запускатор OpenCasino
local shell = require("shell")
local fs = require("filesystem")
local internet = require("internet")

print("=== OpenCasino Launcher ===")
print("Очистка старых файлов...")

-- Удаляем старые файлы (принудительно)
local files_to_remove = {
    "/tmp/opencasino.lua",
    "/tmp/oc.lua",
    "/lib/Sky.lua",
    "/lib/image.lua",
    shell.getWorkingDirectory() .. "/LogoCasino.lua",
}

for _, file in ipairs(files_to_remove) do
    if fs.exists(file) then
        fs.remove(file)
        print("  Удалено: " .. file)
    end
end

print("Загрузка OpenCasino...")

-- Скачиваем файл принудительно
local url = "https://raw.githubusercontent.com/0ptim1st-DK/GalaxyCraft-Casino-SDRV/main/OpenCasino.lua"
local response = internet.request(url)
local data = ""
for chunk in response do
    data = data .. chunk
end

local file = io.open("/tmp/opencasino.lua", "w")
file:write(data)
file:close()

print("Файл загружен!")
print("Запуск...")
os.sleep(1)

-- Запускаем
dofile("/tmp/opencasino.lua")
