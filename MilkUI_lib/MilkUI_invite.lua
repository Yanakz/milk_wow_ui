-- EasyGInv adds an "Invite To Guild" button to popup menus (like as when you right-click a person's name in chat) to make it easier to add someone as a friend.
-- Full credit goes to RIOKOU (Mannoroth) who made the "EasyAddFriend" addon, which is what Ezoteriqe has used here and changed.

local EasyGInv = CreateFrame("Frame","EasyGInvFrame")
EasyGInv:SetScript("OnEvent", function() hooksecurefunc("UnitPopup_ShowMenu", EasyGInvCheck) end)
EasyGInv:RegisterEvent("PLAYER_LOGIN")

local PopupUnits = {"PARTY", "PLAYER", "RAID_PLAYER", "RAID", "FRIEND", "TEAM", "CHAT_ROSTER", "TARGET", "FOCUS"}



local ToontoInvite

local EasyGInvButtonInfo = {
text = "邀请此狗逼入会",
value = "EZ_GINV",
func = function() GuildInvite(ToontoInvite) end,
notCheckable = 1,
}
 
local CancelButtonInfo = {
	text = "取消",
	value = "CANCEL",
	notCheckable = 1
}

function EasyGInvCheck()
    if CanGuildInvite() then        
        local PossibleButton = getglobal("DropDownList1Button"..(DropDownList1.numButtons)-1)
        if PossibleButton["value"] ~= "EZ_GINV" then                                    -- is there not already an "Invite To Guild" button on it?
                                
            local GoodUnit = false
            for i=1, #PopupUnits do    
            if OPEN_DROPDOWNMENUS[1]["which"] == PopupUnits[i] then
                GoodUnit = true;
                ToontoInvite=UIDROPDOWNMENU_OPEN_MENU.name.."-"..UIDROPDOWNMENU_OPEN_MENU.server;
                end
            end
                                                        
            if UIDROPDOWNMENU_OPEN_MENU["unit"] == "target" and ((not UnitIsPlayer("target"))) then
                GoodUnit = false                                        -- make sure the unit isn't an npc or enemy player
            end
            
            if GoodUnit then                                            -- is the unit of the popup one that we want to use? (e.g. not vehicles, npcs, or enemy players)
                    -- ToontoInvite = GetUnitName(UIDROPDOWNMENU_OPEN_MENU["unit"], true);
                    CreateEasyGInvButton()                                    -- Add the button
            end
        end
    end
end


function CreateEasyGInvButton()
			
		-- we have decided to actually make the frame, we are going to place it above the "Cancel" button
		local CancelButtonFrame = getglobal("DropDownList1Button"..DropDownList1.numButtons)
		CancelButtonFrame:Hide() 									-- hide the "Cancel" button
		DropDownList1.numButtons = DropDownList1.numButtons - 1		-- make the DropDownMenu API think the "Cancel" button never existed
		UIDropDownMenu_AddButton(EasyGInvButtonInfo)				-- create our "Add Friend" button, it gets put where the cancel button used to be
		UIDropDownMenu_AddButton(CancelButtonInfo)					-- create a new cancel button after our "Add Friend" button
	
end

 
