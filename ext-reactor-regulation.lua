local function init()
    local reactor = peripheral.wrap("right")
    local max_energy_stored = 10000000
    local energy_stored = 0
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

local function run()
    init()
    while true do
        energy_stored = reactor.getEnergyStored()
        if ((energy_stored <= 0.2*max_energy_stored) and not(isActive())) then
            on()
        elseif ((energy_stored >= 0.9*max_energy_stored) and isActive()) do
            off()
        end
        sleep(1)
    end
end

run()