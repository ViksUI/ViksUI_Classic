local T, C, L = unpack(ViksUI)
if C.quest.quest_auto_button ~= true or IsAddOnLoaded("ExtraQuestButton") then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
}