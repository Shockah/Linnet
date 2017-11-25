--[[
	RollMessage
	(raider -> master)

	Properties:
	* loot: table -- Loot instance
	* type: string -- roll type
]]

local selfAddonName = "Linnet"
local Addon = _G[selfAddonName]
local S = LibStub:GetLibrary("ShockahUtils")

local prototype = {}
Addon.RollMessage = {}
local Class = Addon.RollMessage

function Class:New(loot, type)
	local obj = S:Clone(prototype)
	obj.loot = loot
	obj.type = type
	return obj
end

function prototype:Send()
	local lootMethod, masterLooterPartyID, masterLooterRaidID = GetLootMethod()
	if lootMethod == "master" and masterLooterPartyID ~= 0 and masterLooterRaidID then
		local target, targetRealm = UnitName("raid"..masterLooterRaidID)
		if targetRealm then
			target = target.."-"..targetRealm
		end

		Addon:SendCompressedCommMessage("Roll", {
			lootID = self.loot.lootID,
			type = self.type,
		}, "WHISPER", target)
	end
end

function Class:Handle(message, distribution, sender)
	local loot = Addon.lootHistory:Get(message.lootID)
	if not loot then
		return
	end

	sender = S:GetPlayerNameWithRealm(sender)
	local roll = loot:GetRollForPlayer(sender)
	roll:SetType(message.type)
	roll:SendRoll(loot)

	if Addon.PendingFrame.frame:IsVisible() then
		for _, lootFrame in pairs(Addon.PendingFrame.frame.itemFrames) do
			if lootFrame:IsVisible() then
				lootFrame:UpdateButtonAppearance()
			end
		end
	end
end