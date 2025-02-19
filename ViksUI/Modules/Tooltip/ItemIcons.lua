local T, C, L = unpack(ViksUI)
if C.tooltip.enable ~= true or C.tooltip.item_icon ~= true then return end

----------------------------------------------------------------------------------------
--	Adds item icons to tooltips(Tipachu by Tuller)
----------------------------------------------------------------------------------------
local function setTooltipIcon(self, icon)
	local title = icon and _G[self:GetName().."TextLeft1"]
	local text = title and title:GetText()
	if title and text and not text:find("|T"..icon) then
		title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 20, text)
	end
end

local whiteTooltip = {
	[GameTooltip] = true,
	[ItemRefTooltip] = true,
	[ItemRefShoppingTooltip1] = true,
	[ItemRefShoppingTooltip2] = true,
	[ShoppingTooltip1] = true,
	[ShoppingTooltip2] = true,
}

if T.Classic then
	local function newTooltipHooker(method, func)
		return function(tooltip)
			local modified = false

			tooltip:HookScript("OnTooltipCleared", function()
				modified = false
			end)

			tooltip:HookScript(method, function(self, ...)
				if not modified then
					modified = true
					func(self, ...)
				end
			end)
		end
	end

	local hookItem = newTooltipHooker("OnTooltipSetItem", function(self)
		local _, link = self:GetItem()
		if link then
			setTooltipIcon(self, GetItemIcon(link))
		end
	end)

	local hookSpell = newTooltipHooker("OnTooltipSetSpell", function(self)
		local _, id = self:GetSpell()
		if id then
			setTooltipIcon(self, select(3, GetSpellInfo(id)))
		end
	end)

	for tooltip in pairs(whiteTooltip) do
		hookItem(tooltip)
		hookSpell(tooltip)
	end
else
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(self, data)
		if whiteTooltip[self] and not self:IsForbidden() then
			if data and data.id then
				setTooltipIcon(self, GetItemIcon(data.id))
			end
		end
	end)

	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self, data)
		if whiteTooltip[self] and not self:IsForbidden() then
			if data and data.id then
				setTooltipIcon(self, select(3, GetSpellInfo(data.id)))
			end
		end
	end)

	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(self, data)
		if whiteTooltip[self] and not self:IsForbidden() then
			local lineData = data.lines and data.lines[1]
			local tooltipType = lineData and lineData.tooltipType
			if not tooltipType then return end

			if tooltipType == 0 then -- item
				setTooltipIcon(self, GetItemIcon(lineData.tooltipID))
			elseif tooltipType == 1 then -- spell
				setTooltipIcon(self, select(3, GetSpellInfo(lineData.tooltipID)))
			end
		end
	end)
end