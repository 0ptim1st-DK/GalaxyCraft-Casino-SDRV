--|============================|
--|         OpenCasino.        |
--|       Упрощенная версия    |
--|    Баланс: 5000 эм.        |
--|     Разрешение: 220x64     |
--|         2024               |
--|============================|
local component = require("component")
local computer = require("computer")
local event = require("event")
local term = require("term")
local shell = require("shell")
local fs = require("filesystem")
local unicode = require("unicode")
local serial = require("serialization")
local g = component.gpu

-- ============================================
-- ============ БИБЛИОТЕКА SKY ================
-- ============================================
local Sky = {}
local back = 0xffffff

function Sky.Mid(w,y,text)
    local _,n = string.gsub(text, "&","")
    local l = unicode.len(text) - n * 2
    local x = (w / 2) - (l / 2)
    Sky.text(x, y, text)
end

function Sky.MidL(w,y,text)
    w = 26
    local _,n = string.gsub(text, "&","")
    local l = unicode.len(text) - n * 2
    local x = (w / 2) - (l / 2) + 2
    Sky.text(x, y, text)
end

function Sky.MidR(w,y,text)
    local _,n = string.gsub(text, "&","")
    local l = unicode.len(text) - n * 2
    local x = (w / 2) - (l / 2) + 14
    Sky.text(x, y, text)
end

function Sky.ClearL(h)
    g.fill(3,2,26,h-2,' ')
end

function Sky.ClearR(w,h)
    g.fill(31,2,w-32,h-2,' ')
end

function Sky.logo(name,col1,col2,w,h)
    term.clear()
    g.setBackground(0x000000)
    g.setForeground(col2)
    for i = 1, w do
        g.set(i,1,"=")
        g.set(i,h,"=")
    end
    for i = 1, h do
        g.set(1, i, "||")
        g.set(29, i, "||")
        g.set(w-1, i, "||")
    end
    Sky.text(w/2 - unicode.len("[ " .. name .. " ]")/2 + 14, 1, "[ " .. name .. " ]")
    g.set(w-42, h, "[ Автор: SkyDrive_ - Проект: McSkill ]")
    g.setForeground(col1)
    g.set(w/2+1 - unicode.len(name)/2 + 14, 1, name)
    g.set(w-40, h, "Автор: SkyDrive_ - Проект: McSkill")
end

function Sky.setColor(index)
    if (index ~= "r") then back = g.getForeground() end
    if (index == "0") then g.setForeground(0x333333) end
    if (index == "1") then g.setForeground(0x0000ff) end
    if (index == "2") then g.setForeground(0x00ff00) end
    if (index == "3") then g.setForeground(0x24b3a7) end
    if (index == "4") then g.setForeground(0xff0000) end
    if (index == "5") then g.setForeground(0x8b00ff) end
    if (index == "6") then g.setForeground(0xffa500) end
    if (index == "7") then g.setForeground(0xbbbbbb) end
    if (index == "8") then g.setForeground(0x808080) end
    if (index == "9") then g.setForeground(0x0000ff) end
    if (index == "a") then g.setForeground(0x66ff66) end
    if (index == "b") then g.setForeground(0x00ffff) end
    if (index == "c") then g.setForeground(0xff6347) end
    if (index == "d") then g.setForeground(0xff00ff) end
    if (index == "e") then g.setForeground(0xffff00) end
    if (index == "f") then g.setForeground(0xffffff) end
    if (index == "g") then g.setForeground(0x00ff00) end
    if (index == "r") then g.setForeground(back) end
end

function Sky.text(x,y,text)
    local n = 1
    for i = 1, unicode.len(text) do
        if unicode.sub(text, i,i) == "&" then
            Sky.setColor(unicode.sub(text, i + 1, i + 1))
        elseif unicode.sub(text, i - 1, i - 1) ~= "&" then
            g.set(x+n,y, unicode.sub(text, i,i))
            n = n + 1
        end
    end
end

function Sky.Button(x,y,w,h,col1,col2,text)
    g.setForeground(col1)
    g.set(x + w/2 - unicode.len(text)/2, y+h/2, text)
    g.setForeground(col2)
    for i = 1, w-2 do
        g.set(x+i,y,"─")
        g.set(x+i,y+h-1,"─")
    end
    for i = 1, h-2 do
        g.set(x,y+i,"│")
        g.set(x+w-1,y+i,"│")
    end
    g.set(x,y,"┌")
    g.set(x+w-1,y,"┐")
    g.set(x,y+h-1,"└")
    g.set(x+w-1,y+h-1,"┘")
end

-- ============================================
-- ============ БИБЛИОТЕКА ИЗОБРАЖЕНИЙ ========
-- ============================================
local Images = {}

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

-- ===== АЛМАЗ (заглушка) =====
function Images.diamond(x, y)
    g.setForeground(0x00BFFF)
    g.set(x, y, "АЛМАЗ")
end

-- ===== ВИШНЯ (заглушка) =====
function Images.cherry(x, y)
    g.setForeground(0xFF0000)
    g.set(x, y, "ВИШНЯ")
end

-- ===== ЯБЛОКО (заглушка) =====
function Images.apple(x, y)
    g.setForeground(0x00FF00)
    g.set(x, y, "ЯБЛОКО")
end

-- ===== БАНАН (заглушка) =====
function Images.banana(x, y)
    g.setForeground(0xFFFF00)
    g.set(x, y, "БАНАН")
end

-- ===== АПЕЛЬСИН (заглушка) =====
function Images.orange(x, y)
    g.setForeground(0xFFA500)
    g.set(x, y, "АПЕЛЬСИН")
end

-- ===== СЕМЁРКА (заглушка) =====
function Images.seven(x, y)
    g.setForeground(0xFF0000)
    g.set(x, y, "СЕМЁРКА")
end

-- ===== ПОДКОВА (заглушка) =====
function Images.horseshoe(x, y)
    g.setForeground(0xC0C0C0)
    g.set(x, y, "ПОДКОВА")
end

-- ===== КЛЕВЕР (заглушка) =====
function Images.clover(x, y)
    g.setForeground(0x00CC00)
    g.set(x, y, "КЛЕВЕР")
end

-- ===== МОНЕТА (заглушка) =====
function Images.coin(x, y)
    g.setForeground(0xFFD700)
    g.set(x, y, "МОНЕТА")
end

-- ============================================
-- ============ ОСНОВНАЯ ПРОГРАММА ============
-- ============================================

event.shouldInterrupt = function () return false end

--------------------Настройки--------------------
local WIGHT = 220
local HEIGHT = 64
local AUTOEXIT = 30
local COLOR1 = 0x00ffff
local COLOR2 = 0x0000ff
local TONE = 600
local RED = 0
local CHAT_NAME = "§8[§2OpenCasino§8]: "
local STAVKA = 10
local MAX_STAVKA = 500
local START_BALANCE = 5000
-------------------------------------------------

print("\n=== OpenCasino ===")
print("Инициализация...")
os.sleep(1)

local mid = (WIGHT - 32) / 2 + 32
local image_list = {"diamond", "cherry", "apple", "banana", "orange", "seven", "horseshoe", "clover", "coin"}
local timer = 0
local smile = false
local balance = START_BALANCE
local stavka = STAVKA
local game_active = false
local in_game = false

if component.isAvailable("chat_box") then
    component.chat_box.setName("§6G§7")
end

local maxW, maxH = g.getResolution()
if WIGHT > maxW then WIGHT = maxW end
if HEIGHT > maxH then HEIGHT = maxH end

g.setResolution(WIGHT, HEIGHT)

-- ============================================
-- ============ ГЛАВНОЕ МЕНЮ ==================
-- ============================================
function MainMenu()
    term.clear()
    g.setBackground(0x000000)
    Sky.logo("OpenCasino", COLOR1, COLOR2, WIGHT, HEIGHT)
    
    g.setForeground(COLOR1)
    Sky.Mid(WIGHT, 10, "Добро пожаловать в OpenCasino!")
    Sky.Mid(WIGHT, 12, "Испытай свою удачу!")
    
    g.setForeground(COLOR2)
    Sky.Mid(WIGHT, 15, "Три семёрки - Джекпот x100!")
    Sky.Mid(WIGHT, 16, "Три алмаза - x40!")
    Sky.Mid(WIGHT, 17, "И много других выигрышей!")
    
    g.setForeground(COLOR1)
    Sky.Mid(WIGHT, 20, "Ваш стартовый баланс: " .. balance .. " эм.")
    
    Sky.Button(mid - 20, 30, 40, 4, COLOR1, COLOR2, "  Войти в игру  ")
    
    g.setForeground(0x666666)
    Sky.Mid(WIGHT, 38, "Нажмите на кнопку, чтобы начать")
    
    in_game = false
end

-- ============================================
-- ============ ИГРОВОЙ ЭКРАН =================
-- ============================================
function Game()
    g.fill(31,2,WIGHT-32,HEIGHT-2,' ')
    
    g.setForeground(COLOR1)
    Sky.MidR(WIGHT,3, "Инфа о выигрышах:")
    Sky.MidR(WIGHT,5, "Выигрыш = ставка * на бонус")
    Sky.MidR(WIGHT,7, "Если 2 одинаковых предмета по краям - Бонус = х1")
    Sky.MidR(WIGHT,8, "Если 2 одинаковых предмета рядом - Бонус = х2")
    g.setForeground(COLOR2)
    Sky.MidR(WIGHT,10, "Три клевера - Бонус = х10")
    Sky.MidR(WIGHT,11, "Три банана - Бонус = х12")
    Sky.MidR(WIGHT,12, "Три вишни - Бонус = х15")
    Sky.MidR(WIGHT,13, "Три апельсина - Бонус = х17")
    Sky.MidR(WIGHT,14, "Три подковы - Бонус = х20")
    Sky.MidR(WIGHT,15, "Три монеты - Бонус = х25")
    Sky.MidR(WIGHT,16, "Три яблока - Бонус = х30")
    Sky.MidR(WIGHT,17, "Три алмаза - Бонус = х40")
    Sky.MidR(WIGHT,18, "Три семёрки - Бонус = х100")
    g.setForeground(COLOR1)
    Sky.MidR(WIGHT,20, "Минимальная ставка: 1$")
    Sky.MidR(WIGHT,21, "Максимальная ставка: " .. MAX_STAVKA .. "$")
    
    g.setForeground(COLOR2)
    Sky.MidL(WIGHT,28, "Ваш баланс:")
    g.setForeground(COLOR1)
    Sky.MidL(WIGHT,30, "[ " .. balance .. " эм. ]")
    
    Sky.Button(7, 37, 18, 3, COLOR1, COLOR2, "  Выйти  ")
    
    Sky.Button(mid-30, 37, 6, 3, COLOR1, COLOR2, "-10$")
    Sky.Button(mid-23, 37, 5, 3, COLOR1, COLOR2, "-5$")
    Sky.Button(mid-17, 37, 5, 3, COLOR1, COLOR2, "-1$")
    Sky.Button(mid-11, 37, 20, 3, COLOR1, COLOR2, "Играть!")
    Sky.Button(mid+10, 37, 5, 3, COLOR1, COLOR2, "+1$")
    Sky.Button(mid+16, 37, 5, 3, COLOR1, COLOR2, "+5$")
    Sky.Button(mid+22, 37, 6, 3, COLOR1, COLOR2, "+10$")
    
    g.setForeground(COLOR1)
    Sky.MidR(WIGHT,38,"  Ставка " .. stavka .. "$  ")
    
    local frame_x = mid - 74
    local frame_y = 18
    local frame_w = 140
    local frame_h = 26
    
    g.setForeground(COLOR2)
    for i = 0, frame_w do
        g.set(frame_x + i, frame_y, "─")
        g.set(frame_x + i, frame_y + frame_h, "─")
    end
    for i = 0, frame_h do
        g.set(frame_x, frame_y + i, "│")
        g.set(frame_x + frame_w, frame_y + i, "│")
    end
    g.set(frame_x, frame_y, "┌")
    g.set(frame_x + frame_w, frame_y, "┐")
    g.set(frame_x, frame_y + frame_h, "└")
    g.set(frame_x + frame_w, frame_y + frame_h, "┘")
    
    g.setForeground(COLOR1)
    local slot_text = " СЛОТЫ "
    local slot_x = frame_x + (frame_w / 2) - (unicode.len(slot_text) / 2)
    g.set(slot_x, frame_y, slot_text)
    
    local step = 48
    local x, y = frame_x + 6, frame_y + 4
    for i = 1, 3 do
        DrawImage(image_list[math.random(1,#image_list)], x, y)
        x = x + step
    end
    
    in_game = true
    timer = AUTOEXIT
end

function DrawImage(pic, x, y)
    if pic == "diamond" then Images.diamond(x, y)
    elseif pic == "cherry" then Images.cherry(x, y)
    elseif pic == "apple" then Images.apple(x, y)
    elseif pic == "banana" then Images.banana(x, y)
    elseif pic == "orange" then Images.orange(x, y)
    elseif pic == "seven" then Images.seven(x, y)
    elseif pic == "horseshoe" then Images.horseshoe(x, y)
    elseif pic == "clover" then Images.clover(x, y)
    elseif pic == "coin" then Images.coin(x, y)
    end
end

function check_rand(rand)
    if rand == #image_list then return 1
    else return rand + 1
    end
end

function Table(rand1, rand2, rand3)
    local win = {}
    for i = 1, 60 do
        if i <= 20 then
            DrawImage(image_list[rand1], mid-30, 24)
            DrawImage(image_list[rand1], mid-10, 24)
            DrawImage(image_list[rand1], mid+10, 24)
            win[1] = rand1
            rand1 = check_rand(rand1)
        elseif i <= 40 then
            DrawImage(image_list[rand2], mid-10, 24)
            DrawImage(image_list[rand2], mid+10, 24)
            win[2] = rand2
            rand2 = check_rand(rand2)
        elseif i <= 60 then
            DrawImage(image_list[rand3], mid+10, 24)
            win[3] = rand3
            rand3 = check_rand(rand3)
        end
        os.sleep(0.05)
    end
    return win[1], win[2], win[3]
end

function Wins(win1, win2, win3)
    if win1 == 1 and win2 == 1 and win3 == 1 then return 40
    elseif win1 == 2 and win2 == 2 and win3 == 2 then return 15
    elseif win1 == 3 and win2 == 3 and win3 == 3 then return 30
    elseif win1 == 4 and win2 == 4 and win3 == 4 then return 12
    elseif win1 == 5 and win2 == 5 and win3 == 5 then return 17
    elseif win1 == 6 and win2 == 6 and win3 == 6 then return 100
    elseif win1 == 7 and win2 == 7 and win3 == 7 then return 20
    elseif win1 == 8 and win2 == 8 and win3 == 8 then return 10
    elseif win1 == 9 and win2 == 9 and win3 == 9 then return 25
    elseif win1 == win2 or win2 == win3 then return 2
    elseif win1 == win3 then return 1
    else return 0
    end
end

function Start()
    if game_active then return end
    if balance < stavka then
        g.setForeground(COLOR1)
        Sky.MidR(WIGHT,35, "Недостаточно средств! Баланс: " .. balance .. "$")
        computer.beep(400, 0.3)
        return
    end
    
    game_active = true
    computer.beep(TONE, 0.05)
    
    balance = balance - stavka
    
    g.setForeground(COLOR1)
    Sky.MidL(WIGHT,11, "Идет игра...")
    Sky.MidR(WIGHT,35, "Крутим на " .. stavka .. "$")
    Sky.MidL(WIGHT,30, "[ " .. balance .. " эм. ]")
    
    local rand1 = math.random(1, #image_list)
    local rand2 = math.random(1, #image_list)
    local rand3 = math.random(1, #image_list)
    local bonus = Wins(Table(rand1, rand2, rand3))
    
    g.setForeground(COLOR1)
    if bonus ~= 0 then
        local winAmount = stavka * bonus
        balance = balance + winAmount
        Sky.MidR(WIGHT,35, "Бонус x" .. bonus .. "! Выиграно: " .. winAmount .. "$")
        Sky.MidL(WIGHT,30, "[ " .. balance .. " эм. ]")
        
        if bonus >= 10 then
            component.redstone.setOutput(RED, 15)
            os.sleep(0.5)
            component.redstone.setOutput(RED, 0)
        end
        
        if component.isAvailable("chat_box") then
            local msg = CHAT_NAME .. "§aВыиграно §5" .. winAmount .. " эм. "
            if bonus == 40 then msg = msg .. "(3 алмаза!)"
            elseif bonus == 15 then msg = msg .. "(3 вишни!)"
            elseif bonus == 30 then msg = msg .. "(3 яблока!)"
            elseif bonus == 12 then msg = msg .. "(3 банана!)"
            elseif bonus == 17 then msg = msg .. "(3 апельсина!)"
            elseif bonus == 100 then msg = msg .. "(ДЖЕКПОТ! 3 семёрки!)"
            elseif bonus == 20 then msg = msg .. "(3 подковы!)"
            elseif bonus == 10 then msg = msg .. "(3 клевера!)"
            elseif bonus == 25 then msg = msg .. "(3 монеты!)"
            end
            component.chat_box.say(msg)
        end
    else
        Sky.MidR(WIGHT,35, "Бонус x0 - Проигрыш!")
    end
    
    os.sleep(1)
    game_active = false
    timer = AUTOEXIT
    Game()
end

function getStavka(w, h)
    if w >= mid-30 and w <= mid-25 and h >= 37 and h <= 39 then
        stavka = math.max(1, stavka - 10)
    elseif w >= mid-23 and w <= mid-19 and h >= 37 and h <= 39 then
        stavka = math.max(1, stavka - 5)
    elseif w >= mid-17 and w <= mid-13 and h >= 37 and h <= 39 then
        stavka = math.max(1, stavka - 1)
    elseif w >= mid+10 and w <= mid+14 and h >= 37 and h <= 39 then
        stavka = math.min(MAX_STAVKA, stavka + 1)
    elseif w >= mid+16 and w <= mid+20 and h >= 37 and h <= 39 then
        stavka = math.min(MAX_STAVKA, stavka + 5)
    elseif w >= mid+22 and w <= mid+27 and h >= 37 and h <= 39 then
        stavka = math.min(MAX_STAVKA, stavka + 10)
    else
        return
    end
    g.setForeground(COLOR1)
    Sky.MidR(WIGHT,38,"  Ставка " .. stavka .. "$  ")
end

function autoExit()
    timer = timer - 1
    g.setForeground(COLOR2)
    Sky.MidL(WIGHT,35, "Авто выход через:  ")
    g.setForeground(COLOR1)
    g.set(24, 35, tostring(timer) .. " ")
    if smile then
        Sky.MidL(WIGHT,26, "__(^o^)__")
        smile = false
    else
        Sky.MidL(WIGHT,26, " \\(^o^)/ ")
        smile = true
    end
end

-- ============================================
-- ============ ЗАПУСК ========================
-- ============================================

MainMenu()

while true do
    local e, _, w, h, _, nick = event.pull(0.5, "touch")
    
    if in_game then
        timer = timer - 0.5
        
        if timer > 0 then
            g.setForeground(COLOR1)
            if smile then
                Sky.MidL(WIGHT, 26, "__(^o^)__")
            else
                Sky.MidL(WIGHT, 26, " \\(^o^)/ ")
            end
            smile = not smile
            
            g.setForeground(COLOR2)
            Sky.MidL(WIGHT, 35, "Авто выход через:  ")
            g.setForeground(COLOR1)
            g.set(24, 35, string.format("%2d", math.ceil(timer)) .. " ")
        end
        
        if timer <= 0 then
            computer.beep(400, 0.2)
            MainMenu()
        end
    end
    
    if e == "touch" then
        if not in_game then
            if w >= mid - 20 and w <= mid + 20 and h >= 30 and h <= 34 then
                computer.beep(TONE, 0.05)
                Game()
            end
        else
            if w >= 7 and w <= 25 and h >= 37 and h <= 40 then
                computer.beep(TONE, 0.05)
                MainMenu()
            end
            
            getStavka(w, h)
            
            if w >= mid-11 and w <= mid+8 and h >= 37 and h <= 39 then
                Start()
            end
            
            timer = AUTOEXIT
        end
    end
end
