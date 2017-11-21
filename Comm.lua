local selfAddonName = "Linnet"
local Self = _G[selfAddonName]
local SelfDB = _G[selfAddonName.."DB"]
local S = LibStub:GetLibrary("ShockahUtils")

local libS = LibStub:GetLibrary("AceSerializer-3.0")
local libC = LibStub:GetLibrary("LibCompress")
local libCE = libC:GetAddonEncodeTable()

local nextCommMessageID = 1

function Self:OnCommReceived(prefix, data, distribution, sender)
	local one = libCE:Decode(data)
	sender = S:GetPlayerNameWithRealm(sender)

	local two, message = libC:Decompress(one)
	if not two then
		self:DebugPrint("OnCommReceived: Error decompressing: "..message)
		return
	end

	local success, final = libS:Deserialize(two)
	if not success then
		self:DebugPrint("OnCommReceived: Error deserializing: "..final)
		return
	end

	if sender == S:GetPlayerNameWithRealm() then
		return
	end
	self:OnDecompressedCommReceived(final.Type, final.Body, distribution, sender)
end

function Self:OnCommDecompressedReceived(type, obj, distribution, sender)
	if type == "Loot" then
		self:HandleRawLootMessage(obj)
	end
end

function Self:SendCompressedCommMessage(type, obj, distribution, target)
	local message = {}
	message.Type = type
	message.ID = nextCommMessageID
	message.Body = obj

	local one = libS:Serialize(message)
	local two = libC:CompressHuffman(one)
	local final = libCE:Encode(two)

	nextCommMessageID = nextCommMessageID + 1
	self:SendCommMessage(self.Settings.AceCommPrefix, final, distribution, target, "NORMAL")
end