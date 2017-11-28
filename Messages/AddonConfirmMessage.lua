--[[
	AddonConfirmMessage
	(raider -> master)
]]

local selfAddonName = "Linnet"
local Addon = _G[selfAddonName]
local S = LibStub:GetLibrary("ShockahUtils")

local prototype = {}
local selfMessageType = "AddonConfirm"
Addon[selfMessageType.."Message"] = {}
local Class = Addon[selfMessageType.."Message"]
Addon.Comm.handlers[selfMessageType] = Class

function Class:New(loot, type)
	local obj = S:Clone(prototype)
	return obj
end

function prototype:Send()
	if Addon:IsMasterLooter() then
		return
	end

	local lootMethod, masterLooterPartyID, masterLooterRaidID = GetLootMethod()
	if lootMethod == "master" and masterLooterPartyID ~= 0 and masterLooterRaidID then
		local target, targetRealm = UnitName("raid"..masterLooterRaidID)
		if targetRealm then
			target = target.."-"..targetRealm
		end
		target = S:GetPlayerNameWithOptionalRealm(target)

		Addon:SendCompressedCommMessage(selfMessageType, {
			version = Addon.NumericVersion,
		}, "WHISPER", target)
	end
end

function Class:Handle(message, distribution, sender)
	if not Addon:IsMasterLooter() then
		return
	end

	local loot = Addon.lootHistory:Get(message.lootID)
	if not loot then
		return
	end

	sender = S:GetPlayerNameWithRealm(sender)
	local version = message.version
	-- TODO: do something about the version
end