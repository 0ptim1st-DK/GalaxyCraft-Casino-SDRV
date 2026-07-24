--|============================|
--|         OpenCasino.        |
--|       Автор: SkyDrive_     |
--|   Адаптировано под GitHub  |
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

-- Загрузка библиотек с вашего GitHub
if not fs.exists("/lib/Sky.lua") then
    shell.execute("wget https://raw.githubusercontent.com/0ptim1st-DK/GalaxyCraft-Casino-SDRV/main/sky.lua /lib/Sky.lua")
end
if not fs.exists("/lib/image.lua") then
    shell.execute("wget https://raw.githubusercontent.com/0ptim1st-DK/GalaxyCraft-Casino-SDRV/main/image.lua /lib/image.lua")
end

local Sky = require("Sky")
local image = require("image")
local g = component.gpu
event.shouldInterrupt = function () return false end

--------------------Настройки--------------------
local WIGHT = 146
local HEIGHT = 42
local AUTOEXIT = 30
local COLOR1 = 0x00ffff
local COLOR2 = 0x0000ff
local TONE = 600
local RED = 0
local CHAT_NAME = "§8[§2OpenCasino§8]: "
local STAVKA = 10
local MAX_STAVKA = 500
-------------------------------------------------

print("\nИнициализация...")
os.sleep(2)
print("Запуск программы...")
os.sleep(2)

local mid = (WIGHT - 32) / 2 + 32
local images = {"cherry", "seven", "diamond", "orange", "pickaxe", "cheese", "pokeball", "meat", "apple"}
local login = false
local summa = 0
local timer = 0
local smile = false
local summa_money
local stavka = STAVKA

if component.isAvailable("chat_box") then
    component.chat_box.setName("§6G§7")
end

local maxW, maxH = g.getResolution()
if WIGHT > maxW then WIGHT = maxW end
if HEIGHT > maxH then HEIGHT = maxH end

g.setResolution(WIGHT, HEIGHT)
Sky.logo("OpenCasino", COLOR1, COLOR2, WIGHT, HEIGHT)

function Wins(win1, win2, win3)
    if win1 == 1 and win2 == 1 and win3 == 1 then return 15
    elseif win1 == 2 and win2 == 2 and win3 == 2 then return 100
    elseif win1 == 3 and win2 == 3 and win3 == 3 then return 40
    elseif win1 == 4 and win2 == 4 and win3 == 4 then return 20
    elseif win1 == 5 and win2 == 5 and win3 == 5 then return 12
    elseif win1 == 6 and win2 == 6 and win3 == 6 then return 17
    elseif win1 == 7 and win2 == 7 and win3 == 7 then return 10
    elseif win1 == 8 and win2 == 8 and win3 == 8 then return 25
    elseif win1 == 9 and win2 == 9 and win3 == 9 then return 30
    elseif win1 == win2 or win2 == win3 then return 2
    elseif win1 == win3 then return 1
    else return 0
    end
end

function money_all()
    local file
    local money_path = shell.getWorkingDirectory() .. "/moneyCasino"
    if fs.exists(money_path) then
        file = io.open(money_path, "r")
        local text = file:read(9999999)
        file:close()
        local object = serial.unserialize(text)
        summa_money = {object[1] or 0, object[2] or 0}
        return summa_money[1], summa_money[2]
    else
        file = io.open(money_path, "w")
        file:write("{0,0}")
        file:close()
        summa_money = {0,0}
        return 0,0
    end
end

function Login(w,h,nick)
    if w and h and w >= 7 and w <= 24 and h >= 37 and h <= 39 then
        if not login then
            computer.addUser(nick)
            login = true
            g.fill(31,2,WIGHT-32,HEIGHT-2,' ')
            g.setForeground(COLOR2)
            Sky.MidL(WIGHT,28,"Добро пожаловать")
            Sky.MidL(WIGHT,31,"Ваш баланс:")
            g.setForeground(COLOR1)
            Sky.MidL(WIGHT,29,nick)
            Sky.MidL(WIGHT,32, "[ " .. Sky.Money(nick) .. " ]")
            Sky.Button(7,37,18,3,COLOR1,COLOR2,"    Выход    ")
            stavka = STAVKA
            Game()
            computer.beep(TONE, 0.05)
        else
            Exit()
        end
    end
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

function Game()
    Sky.Button(mid-30,37,6,3,COLOR1,COLOR2, "-10$")
    Sky.Button(mid-23,37,5,3,COLOR1,COLOR2, "-5$")
    Sky.Button(mid-17,37,5,3,COLOR1,COLOR2, "-1$")
    Sky.Button(mid-11,37,20,3,COLOR1,COLOR2, "Ставка " .. STAVKA .. "$")
    Sky.Button(mid+10,37,5,3,COLOR1,COLOR2, "+1$")
    Sky.Button(mid+16,37,5,3,COLOR1,COLOR2, "+5$")
    Sky.Button(mid+22,37,6,3,COLOR1,COLOR2, "+10$")
    g.setForeground(COLOR1)
    Sky.MidR(WIGHT,3, "Инфа о выигрышах:")
    Sky.MidR(WIGHT,5, "Выигрыш = ставка * на бонус")
    Sky.MidR(WIGHT,7, "Если 2 одинаковых предмета по краям - Бонус = х1")
    Sky.MidR(WIGHT,8, "Если 2 одинаковых предмета рядом - Бонус = х2")
    g.setForeground(COLOR2)
    Sky.MidR(WIGHT,10, "Три покебола - Бонус = х10")
    Sky.MidR(WIGHT,11, "Три кирки - Бонус = х12")
    Sky.MidR(WIGHT,12, "Три вишенки - Бонус = х15")
    Sky.MidR(WIGHT,13, "Три сыра - Бонус = х17")
    Sky.MidR(WIGHT,14, "Три апельсинчика - Бонус = х20")
    Sky.MidR(WIGHT,15, "Три окорочка - Бонус = х25")
    Sky.MidR(WIGHT,16, "Три яблочка - Бонус = х30")
    Sky.MidR(WIGHT,17, "Три алмаза - Бонус = х40")
    Sky.MidR(WIGHT,18, "Три семёрки - Бонус = х100")
    g.setForeground(COLOR1)
    Sky.MidR(WIGHT,20, "Минимальная ставка: 1$")
    Sky.MidR(WIGHT,21, "Максимальная ставка: " .. MAX_STAVKA .. "$")
    local x, y = mid - 30, 24
    for i = 1, 3 do
        Image(images[math.random(1,#images)], x, y)
        x = x + 20
    end
end

function Image(pic, x, y)
    if pic == "cherry" then image.cherry(x, y)
    elseif pic == "seven" then image.seven(x, y)
    elseif pic == "diamond" then image.diamond(x, y)
    elseif pic == "orange" then image.orange(x, y)
    elseif pic == "pickaxe" then image.pickaxe(x, y)
    elseif pic == "cheese" then image.cheese(x, y)
    elseif pic == "pokeball" then image.pokeball(x, y)
    elseif pic == "meat" then image.meat(x, y)
    elseif pic == "apple" then image.apple(x, y)
    end
end

function check_rand(rand)
    if rand == #images then return 1
    else return rand + 1
    end
end

function Table(rand1, rand2, rand3)
    local win = {}
    for i = 1, 60 do
        if i <= 20 then
            Image(images[rand1], mid-30, 24)
            Image(images[rand1], mid-10, 24)
            Image(images[rand1], mid+10, 24)
            win[1] = rand1
            rand1 = check_rand(rand1)
        elseif i <= 40 then
            Image(images[rand2], mid-10, 24)
            Image(images[rand2], mid+10, 24)
            win[2] = rand2
            rand2 = check_rand(rand2)
        elseif i <= 60 then
            Image(images[rand3], mid+10, 24)
            win[3] = rand3
            rand3 = check_rand(rand3)
        end
        os.sleep(0.05)
    end
    return win[1], win[2], win[3]
end

function Start(w, h, nick, stavka)
    if Sky.checkMoney(nick, stavka) then
        computer.beep(TONE, 0.05)
        local file = io.open(shell.getWorkingDirectory() .. "/moneyCasino", "w")
        summa_money[1] = summa_money[1] + stavka
        file:write("{" .. summa_money[1] .. "," .. summa_money[2] .. "}")
        file:close()
        g.setForeground(COLOR1)
        Sky.MidL(WIGHT,11, summa_money[1] .. " эм.")
        Sky.MidL(WIGHT,35,"      Идёт игра...      ")
        Sky.MidL(WIGHT,32, " [ " .. Sky.Money(nick) .. " ] ")
        Sky.MidR(WIGHT,35, "                    Крутим на " .. stavka .. "$                    ")
        local rand1 = math.random(1, #images)
        local rand2 = math.random(1, #images)
        local rand3 = math.random(1, #images)
        local bonus = Wins(Table(rand1, rand2, rand3))
        g.setForeground(COLOR1)
        if bonus ~= 0 then
            local winAmount = stavka * bonus
            Sky.com("money give " .. nick .. " " .. winAmount)
            Sky.MidR(WIGHT,35,"Бонус ставки = x" .. bonus .. "  Вы выиграли: " .. winAmount .. "$")
            local file = io.open(shell.getWorkingDirectory() .. "/moneyCasino", "w")
            summa_money[2] = summa_money[2] + winAmount
            file:write("{" .. summa_money[1] .. "," .. summa_money[2] .. "}")
            file:close()
            Sky.MidL(WIGHT,14, summa_money[2] .. " эм.")
            Sky.MidL(WIGHT,32, "[ " .. Sky.Money(nick) .. " ]")
            Say(bonus, nick, winAmount)
            if bonus >= 10 then
                component.redstone.setOutput(RED, 15)
                os.sleep(1)
                component.redstone.setOutput(RED, 0)
            end
        else
            Sky.MidR(WIGHT,35, "                    Бонус ставки = x0  Вы проиграли                    ")
        end
    else
        Sky.MidR(WIGHT,35, "                             Недостаточно средств                             ")
    end
end

function Rules()
    g.setForeground(COLOR2)
    Sky.MidL(WIGHT,5,"==========================")
    Sky.MidL(WIGHT,9,"==========================")
    Sky.MidL(WIGHT,12,"==========================")
    Sky.MidL(WIGHT,15,"==========================")
    Sky.MidL(WIGHT,10, "Всего потрачено:")
    Sky.MidL(WIGHT,13, "Всего выиграно:")
    g.setForeground(COLOR1)
    Sky.MidL(WIGHT,3, "Общая инфа:")
    Sky.MidL(WIGHT,6, "Вы играете на свой")
    Sky.MidL(WIGHT,7, "страх и риск")
    Sky.MidL(WIGHT,8, "Эмы не возвращаются")
    local money_in, money_out = money_all()
    Sky.MidL(WIGHT,11, money_in .. " эм.")
    Sky.MidL(WIGHT,14, money_out .. " эм.")
    Sky.Button(7,37,18,3,COLOR1,COLOR2, "Залогиниться")
end

function Exit()
    login = false
    g.fill(3,2,26,HEIGHT-2,' ')
    g.fill(31,2,WIGHT-32,HEIGHT-2,' ')
    Rules()
    -- Логотип заменен на простой текст
    g.setForeground(0xFFD700)
    g.set(mid - 25, 7, "OpenCasino")
    g.setForeground(COLOR1)
    image.cherry(mid - 30, 24)
    image.apple(mid - 10, 24)
    image.meat(mid + 10, 24)
    local users = computer.users()
    for i = 1, #users do
        computer.removeUser(users[i])
    end
end

function Say(bonus, nick, stavka)
    local msg = CHAT_NAME .. "§5" .. nick .. " §aВыиграл §5" .. stavka .. " эм. "
    if bonus == 15 then msg = msg .. "(3 вишни!)"
    elseif bonus == 100 then msg = msg .. "(ДЖЕКПОТ! 3 семёрки!)"
    elseif bonus == 40 then msg = msg .. "(3 алмаза!)"
    elseif bonus == 20 then msg = msg .. "(3 апельсина!)"
    elseif bonus == 12 then msg = msg .. "(3 кирки!)"
    elseif bonus == 17 then msg = msg .. "(3 сыра!)"
    elseif bonus == 10 then msg = msg .. "(3 покебола!)"
    elseif bonus == 25 then msg = msg .. "(3 окорочка!)"
    elseif bonus == 30 then msg = msg .. "(3 яблока!)"
    end
    if component.isAvailable("chat_box") then
        component.chat_box.say(msg)
    end
end

function getStavka(w, h)
    if w >= mid-30 and w <= mid-25 and h >= 37 and h <= 39 then
        stavka = stavka - 10
    elseif w >= mid-23 and w <= mid-19 and h >= 37 and h <= 39 then
        stavka = stavka - 5
    elseif w >= mid-17 and w <= mid-13 and h >= 37 and h <= 39 then
        stavka = stavka - 1
    elseif w >= mid+10 and w <= mid+14 and h >= 37 and h <= 39 then
        stavka = stavka + 1
    elseif w >= mid+16 and w <= mid+20 and h >= 37 and h <= 39 then
        stavka = stavka + 5
    elseif w >= mid+22 and w <= mid+27 and h >= 37 and h <= 39 then
        stavka = stavka + 10
    else
        return
    end
    if stavka > MAX_STAVKA then
        stavka = MAX_STAVKA
    elseif stavka < 1 then
        stavka = 1
    end
    g.setForeground(COLOR1)
    Sky.MidR(WIGHT,38,"  Ставка " .. stavka .. "$  ")
end

Exit()

while true do
    local e, _, w, h, _, nick = event.pull(1, "touch")
    if e == "touch" then
        Login(w, h, nick)
        if login then
            getStavka(w, h)
            if w >= mid-11 and w <= mid+8 and h >= 37 and h <= 39 then
                Start(w, h, nick, stavka)
            end
        end
        timer = AUTOEXIT
    end
    if login then
        autoExit()
        if timer == 0 then
            Exit()
        end
    end
end
