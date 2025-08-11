local T, C, L = unpack(ViksUI)
if C.tooltip.enable ~= true or C.tooltip.item_count ~= true then return end

----------------------------------------------------------------------------------------
--	Item count in bags and bank(by Tukz)
----------------------------------------------------------------------------------------
local function OnTooltipSetItem(self, data)
	if self ~= GameTooltip or self:IsForbidden() then return end
	local num
	if T.Classic and not T.Mists then
		local _, link = self:GetItem()
		num = C_Item.GetItemCount(link, true)
	else
		num = C_Item.GetItemCount(data.id, true)
	end

	if num > 1 then
		self:AddLine("|cffffffff"..L_TOOLTIP_ITEM_COUNT.." "..num.."|r")
	end
end

if T.Classic and not T.Mists then
	GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
else
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
end
