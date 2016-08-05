local MAJOR, MINOR = "ShockahUtils", 1
local ShockahUtils = LibStub:NewLibrary(MAJOR, MINOR)

if not ShockahUtils then
	return
end

------------------------------
-- debug
------------------------------

function ShockahUtils:Dump(prefix, message)
	if type(message) == "table" then
		print(prefix..":")
		self:DumpTable(message, 1)
	else
		print(prefix..": "..tostring(message))
	end
end

function ShockahUtils:DumpTable(table, indent)
	if not indent then
		indent = 0
	end
	for k, v in pairs(table) do
		formatting = string.rep("  ", indent)..k..": "
		if type(v) == "table" then
			print(formatting)
			self:Dump(v, indent + 1)
		elseif type(v) == 'boolean' then
			print(formatting..tostring(v))      
		else
			print(formatting..v)
		end
	end
end

------------------------------
-- tables
------------------------------

function ShockahUtils:Count(table)
	local count = 0
	for _, _ in pairs(table) do
		count = count + 1
	end
	return count
end

function ShockahUtils:KeyOf(table, value)
	for k, v in pairs(table) do
		if v == value then
			return k
		end
	end
	return nil
end

function ShockahUtils:Contains(table, value)
	return self:KeyOf(table, value) ~= nil
end

------------------------------
-- items
------------------------------

function ShockahUtils:ParseItemLink(link)
	local linkParts = { string.find(itemLink, "|?c?f?f?(%x*)|?H?(.*?)|?h?%[?([^%[%]]*)%]?|?h?|?r?") }
	local itemStringParts = { strsplit(":", linkParts[2]) }
	return {
		color = linkParts[1],
		ID = itemStringParts[2],
		enchant = itemStringParts[3],
		gems = {
			itemStringParts[4],
			itemStringParts[5],
			itemStringParts[6],
			itemStringParts[7]
		},
		suffix = itemStringParts[8],
		unique = itemStringParts[9],
		linkLevel = itemStringParts[10],
		specialization = itemStringParts[11],
		reforge = itemStringParts[12],
		bonuses = {
			itemStringParts[13],
			itemStringParts[14]
		}
		name = linkParts[3]
	}
end

------------------------------
-- players
------------------------------

function ShockahUtils:GetPlayerNameWithRealm(player)
	player = player or GetUnitName("player", true)
	return string.find(player, "-") and player or player.."-"..GetRealmName()
end

function ShockahUtils:GetPlayerNameWithOptionalRealm(player)
	player = player or GetUnitName("player", true)
	return string.gsub(player, "%-"..GetRealmName(), "")
end

------------------------------
-- chatbox
------------------------------

function ShockahUtils:FindActiveChatEditbox()
	for i = 1, 10 do
		local frame = _G["ChatFrame"..i.."EditBox"]
		if frame and frame:IsVisible() then
			return frame
		end
	end
	return nil
end

function ShockahUtils:InsertInChatEditbox(text)
	local chatEditbox = self:FindActiveChatEditbox()
	if chatEditbox then
		chatEditbox:Insert(text)
	end
end