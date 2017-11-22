--[[
	Roll

	Properties:
	* player: string -- player name with realm
	* type: string -- "2-set"/"4-set"/"Major"/"Minor"/"Off-spec"/"Transmog"/"Warforged"/"Pass"
	* value: int -- roll value (1-100)
]]

local selfAddonName = "Linnet"
local Addon = _G[selfAddonName]
local S = LibStub:GetLibrary("ShockahUtils")

local prototype = {}
Addon.Roll = {}
local Class = Addon.Roll

function Class:New(player, type, value)
	local obj = S:Clone(prototype)
	obj.player = player or S:GetPlayerNameWithRealm(UnitName("player"))
	obj.type = type
	obj.value = value
	return obj
end