
--聊天框显示拾取图标
local function AddLootIcons(self, event, message, ...)
   local function Icon(link)
      local texture = GetItemIcon(link)
      return "\124T" .. texture .. ":" .. 12 .. "\124t" .. link
   end
   message = message:gsub("(\124c%x+\124Hitem:.-\124h\124r)", Icon)
   return false, message, ...
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)

--自动贪婪绿色
if(auto_greed==true)  then
   local agog = CreateFrame("Frame", nil, UIParent)
   agog:RegisterEvent("START_LOOT_ROLL")
   agog:SetScript("OnEvent", function(_, _, id)
   if not id then return end
   -- local _, _, _, _, _, canneed = GetLootRollItemInfo(id) --http://wowwiki.wikia.com/wiki/API_GetLootRollItemInfo 
   -- if canneed == 1 then RollOnLoot(id, 1 or 2) end
   local _, _, _, quality, bop, _, _, canDE = GetLootRollItemInfo(id)
   if quality == 2 and not bop then RollOnLoot(id, 1 or 2) end
   end)
end

--找出点小地图的傻逼
Minimap:SetScript("OnMouseUp", function(self, btn)
   if btn == "RightButton" then
      ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "MiniMapTracking", 0, -5)
      PlaySound("igMainMenuOptionCheckBoxOn")
   else
      Minimap_OnClick(self)
   end
end)


--skada内嵌

ChatFrame1Tab:HookScript('OnClick', function(self, button, down)
	if (button == "LeftButton") then
		for i,win in ipairs(Skada:GetWindows()) do
			win:Hide();
			end;
			end;
			end);
ChatFrame2Tab:HookScript('OnClick', function(self, button, down)
	if (button == "LeftButton") then
		for i,win in ipairs(Skada:GetWindows()) do
			win:Hide();
			end;
			end;
			end);
ChatFrame3Tab:HookScript('OnClick', function(self, button, down)
	if (button == "LeftButton") then
		for i,win in ipairs(Skada:GetWindows()) do
			win:Hide();
			end;
			end;
			end);
ChatFrame4Tab:HookScript('OnClick', function(self, button, down)
	if (button == "LeftButton") then
		for i,win in ipairs(Skada:GetWindows()) do
			win:Show();
			end;
			end;
			end);


--副本任务栏自动收起
local autocollapse = CreateFrame("Frame")
autocollapse:RegisterEvent("ZONE_CHANGED_NEW_AREA")
autocollapse:RegisterEvent("PLAYER_ENTERING_WORLD")
autocollapse:SetScript("OnEvent", function(self)
if IsInInstance() then
ObjectiveTrackerFrame.userCollapsed = true
ObjectiveTracker_Collapse()
else
ObjectiveTrackerFrame.userCollapsed = nil
ObjectiveTracker_Expand()
end
end)
