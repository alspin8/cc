local reactor = peripheral.wrap("right")
local monitor = peripheral.wrap("left")
local max_energy_stored = 10000000
local max_fuel_stored = reactor.getFuelAmountMax()
local energy, fuel, on
local backgroundColor = colors.black

local screen_size = {}

-- Bargraph class
Bargraph = {val = 0, max = 0, x = 0, y = 0, height = 0, width = 0, color = 0}

function Bargraph.__init__(val, max, x, y, height, width, color)
    local self = {val = val, max = max, x = x, y = y, height = height, width = width, color = (color or colors.white)}
    setmetatable (self, {__index=Bargraph})
    self.scale = val/max
    self:draw(self, self.val)
    return self
end

function Bargraph:draw(self, val)
    if val ~= nil then
        self.scale = val/self.max
    end
    paintutils.drawBox( (self.x + self.width), (self.y + self.height), self.x, self.y, colors.white)
    paintutils.drawFilledBox(((self.x + self.width) - 1), ((self.y + self.height) - 1), (self.x + 1), (((self.y + self.height) - 1) - math.floor(self.scale*self.height) + 2), self.color)

end
-- end Bargraph class

-- Button class
Button = {screen = nil, texte = "", x = 0, y = 0, height = 0, width = 0, color = 0}

function Button.__init__(screen, texte, x, y, height, width, color)
    local self = {screen = screen, texte = texte, x = x, y = y, height = height, width = width, color = (color or colors.white)}
    setmetatable (self, {__index=Bargraph})
    self:draw(self, self.color)
    return self
end

function Button:draw(self, color)
    paintutils.drawBox((self.x + self.width), (self.y + self.height), self.x, self.y, colors.white)
    -- paintutils.drawFilledBox(((self.x + self.width) - 1), ((self.y + self.height) - 1), (self.x + 1), ((self.y + self.height) - 1), color)
    -- self.screen.setCursorPosition((self.x + self.width), (self.y + self.height))
    -- self.screen.write(self.texte)

end
-- end Button class

local function get_reactor_info(name)
    if name == "fuel-stored" then
        return reactor.getFuelAmount()
    elseif name == "energy-stored" then
        return reactor.getEnergyStored()
    elseif name == "energy-produced" then
        return reactor.getEnergyProducedLastTick()
    elseif name == "waste-amount" then
        return reactor.getWasteAmount()
    elseif name == "temperature" then
        return reactor.getTemperature()
    else
        return 0
    end
end

local function clear()
    for k = 1, screen_size.width do
        for j = 1, screen_size.height do
            paintutils.drawPixel(k, j, backgroundColor)
        end
    end
end

local function init()
    screen_size["width"] = 29
    screen_size["height"] = 19
    term.redirect(monitor)
    clear()
    energy = Bargraph.__init__(get_reactor_info("energy-stored"), max_energy_stored, 2, 2, 11, 5, colors.green)
    fuel = Bargraph.__init__(get_reactor_info("fuel-stored"), max_fuel_stored, 11, 2, 11, 5, colors.green)
    on = Button.__init__(monitor,"On", 20, 2, 3, 5, colors.red)
    -- off = Button.__init__(monitor,"Off", 9, 15, 3, 5, colors.green)
    -- term.redirect(term.native())
    -- print(fuel.val)
    -- print(fuel.max)
    -- print(fuel.scale)
    -- term.redirect(monitor)
end

local function on()
    reactor.setActive(true)
end

local function off()
    reactor.setActive(false)
end

local function isActive()
    return reactor.getActive()
end

-- function draw_button(trig, texte, x, y, height, width)
    
-- end

local function affichage()
    clear()
    energy:draw(energy, get_reactor_info("energy-stored"))
    fuel:draw(fuel, get_reactor_info("fuel-stored")+1000)
end

local function start_loop()
    init()
    while true do    
        affichage() 
        sleep(1)
    end
end

start_loop()

