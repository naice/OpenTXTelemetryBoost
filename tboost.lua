local VERSION = "1.7.2"
local FILE_PATH = "/SCRIPTS/TELEMETRY/TeleBoost/"
local ENV = "tx"

local data, getTelemetryId, getTelemetryUnit = loadScript(FILE_PATH .. "data.lua", ENV)()
collectgarbage()

local function updateVBatSensors(rxBatt)
    for i = 2, 6 do
        local value = (rxBatt / i) * 10
        setTelemetryValue(0xffff-i, 4, 4, value, UNIT_VOLTS, 1, "vb"..i.."s")
    end
end

local function background()
	local gpsTemp
	data.rssi, data.rssiLow, data.rssiCrit = getRSSI()
	if data.rssi > 0 then
        data.isTelemetryAvailable = true
	else
		data.isTelemetryAvailable = false
    end

    if not data.isTelemetryAvailable then
        return
    end

    data.rxBatt = getValue(data.rxBatt_id)

    if data.rxBatt > 0 then
        updateVBatSensors(data.rxBatt)
    end
end

local function run(event)
	return 0
end

return { run = run, background = background }