local T, C, L = unpack(ViksUI)
if C.quest.quest_auto_button ~= true or C_AddOns.IsAddOnLoaded("ExtraQuestButton") then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete item is to go at www.wowhead.com, search for a item.
--	Example: Seaforium Bombs -> http://www.wowhead.com/item=46847
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.ABItems = {
    -- Daily/Weekly Quests
    -- Cooking Dailies
    33837,	-- Cooking Pot (Kaliri Stew)
    33851,	-- Cooking Pot (Spiritual Soup)
    33852,	-- Cooking Pot (Demon Broiled Surprise)
    -- Fishing Dailies
    -- 35313,	-- Bloated Barbed Gill Trout (taken care of in OpenItems.lua filter list)
    -- Other
    32971,	-- Water Bucket (Hallow's End)
    33306,	-- Ram Racing Reins (Brewfest)
    34833,	-- Unlit Torches (Midsummer)
    34862,	-- Practice Torches (Midsummer)
}