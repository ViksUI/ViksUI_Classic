local T, C, L = unpack(ViksUI)

----------------------------------------------------------------------------------------
--	Accept invites from guild members or friend list(by ALZA)
----------------------------------------------------------------------------------------
if C.automation.accept_invite == true then
	local function CheckFriend(inviter)
		if C_BattleNet.GetAccountInfoByGUID(inviter) or C_FriendList.IsFriend(inviter) or IsGuildMember(inviter) then
			return true
		end
	end

	local ai = CreateFrame("Frame")
	ai:RegisterEvent("PARTY_INVITE_REQUEST")
	ai:SetScript("OnEvent", function(_, _, name, _, _, _, _, _, inviterGUID)
		if (T.Classic and MiniMapBattlefieldFrame or QueueStatusButton):IsShown() or GetNumGroupMembers() > 0 then return end
		if CheckFriend(inviterGUID) then
			RaidNotice_AddMessage(RaidWarningFrame, L_INFO_INVITE..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
			print(format("|cffffff00"..L_INFO_INVITE..name..".|r"))
			AcceptGroup()
			for i = 1, STATICPOPUP_NUMDIALOGS do
				local frame = _G["StaticPopup"..i]
				if frame:IsVisible() and frame.which == "PARTY_INVITE" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE")
					return
				elseif frame:IsVisible() and frame.which == "PARTY_INVITE_XREALM" then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE_XREALM")
					return
				end
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Auto invite by whisper(by Tukz)
----------------------------------------------------------------------------------------
if T.client == "ruRU" then
	C.automation.invite_keyword = "инв inv +"
end

local list_keyword = {}
for word in gmatch(C.automation.invite_keyword, "%S+") do
	list_keyword[word] = true
end

local autoinvite = CreateFrame("Frame")
autoinvite:RegisterEvent("CHAT_MSG_WHISPER")
autoinvite:RegisterEvent("CHAT_MSG_BN_WHISPER")
autoinvite:SetScript("OnEvent", function(_, event, arg1, arg2, ...)
	if not C.automation.whisper_invite then return end

	if ((not UnitExists("party1") or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player"))) and not (T.Classic and MiniMapBattlefieldFrame or QueueStatusButton):IsShown() then
		for word in pairs(list_keyword) do
			if arg1:lower():match(word) then
				if event == "CHAT_MSG_WHISPER" then
					if not C.automation.invite_known_only or C_FriendList.GetFriendInfo(arg2) then
						if T.Classic then
							InviteUnit(arg2)
						else
							C_PartyInfo.InviteUnit(arg2)
						end
					else
						if IsInGuild() then
							local guid = select(10, ...)
							for i = 1, GetNumGuildMembers() do
								if select(17, GetGuildRosterInfo(i)) == guid then
									if T.Classic then
										InviteUnit(arg2)
									else
										C_PartyInfo.InviteUnit(arg2)
									end
								end
							end
						end
					end
				elseif event == "CHAT_MSG_BN_WHISPER" then
					local bnetIDAccount = select(11, ...)
					local accountInfo = C_BattleNet.GetAccountInfoByID(bnetIDAccount)
					BNInviteFriend(accountInfo.gameAccountInfo.gameAccountID)
				end
			end
		end
	end
end)