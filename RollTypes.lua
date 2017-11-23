local selfAddonName = "Linnet"
local Addon = _G[selfAddonName]
local S = LibStub:GetLibrary("ShockahUtils")

local prototype = {}
Addon.rollTypes = {}
Addon.orderedRollTypes = {}

local texturesPath = "Interface\\AddOns\\"..selfAddonName.."\\Textures"
local rollTypes = {
	{
		type = "2-set",
		description = "The item either gives you a 2-set or it's your 1st set piece.",
		icon = texturesPath.."\\Roll-2set",
		shouldRoll = true,
		button = true,
	},
	{
		type = "4-set",
		description = "The item either gives you a 4-set or it's your 3rd set piece.",
		icon = texturesPath.."\\Roll-4set",
		shouldRoll = true,
		button = true,
	},
	{
		type = "Major",
		description = "The item gives you a major boost (either item level or a much better effect) for the current spec.",
		icon = texturesPath.."\\Roll-Major",
		shouldRoll = true,
		button = true,
	},
	{
		type = "Minor",
		description = "The item is an upgrade for the current spec.",
		icon = texturesPath.."\\Roll-Minor",
		shouldRoll = true,
		button = true,
	},
	{
		type = "Off-spec",
		description = "The item is an upgrade for another spec.",
		icon = texturesPath.."\\Roll-Offspec",
		shouldRoll = true,
		button = true,
	},
	{
		type = "Transmog",
		description = "The item has an appearance you didn't unlock yet.",
		icon = texturesPath.."\\Roll-Transmog",
		shouldRoll = true,
		button = true,
	},
	{
		type = "Warforged",
		description = "The base item isn't an upgrade, but you want to try your luck at getting a better warforged/titanforged bonus.",
		icon = texturesPath.."\\Roll-Warforged",
		shouldRoll = true,
		button = true,
	},
	{
		type = "Disenchant",
		icon = texturesPath.."\\Roll-Disenchant",
		shouldRoll = false,
		button = true,
	},
	{
		type = "Pass",
		icon = texturesPath.."\\Roll-Pass",
		shouldRoll = false,
		button = true,
	},
	{
		type = "Pending",
		icon = texturesPath.."\\Roll-Pending",
		shouldRoll = false,
		button = false,
	},
}

function prototype:AddToTooltip(rolls)
	GameTooltip:AddLine(self.type, 1.0, 1.0, 1.0)
	if self.description then
		GameTooltip:AddLine(self.description, 0.8, 0.8, 0.8, true)
	end

	if not S:IsEmpty(rolls) then
		GameTooltip:AddLine("")
		
		for _, roll in pairs(rolls) do
			roll:AddToTooltip()
		end
	end
end

for index, rollType in pairs(rollTypes) do
	rollType.index = index
	rollType = S:CloneInto(prototype, rollType)
	Addon.rollTypes[rollType.type] = rollType
	Addon.orderedRollTypes[index] = rollType
end