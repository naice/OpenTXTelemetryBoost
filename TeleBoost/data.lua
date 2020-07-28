local function getTelemetryId(n)
	local field = getFieldInfo(n)
	return field and field.id or -1
end

local function getTelemetryUnit(n)
	local field = getFieldInfo(n)
	return (field and field.unit <= 10) and field.unit or 0
end

local data = {
	isTelemetryAvailable = false,
	rxBatt_id = getTelemetryId("RxBt") > -1 and getTelemetryId("RxBt") or getTelemetryId("BtRx"),
	rxBatt = 0,
	rssi = 0,
	rssiLow =0,
	rssiCrit=0,
}

return data, getTelemetryId, getTelemetryUnit