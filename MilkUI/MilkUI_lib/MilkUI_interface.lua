msg = "狗逼星哥已载入, 版本 2.3, 更新于 27-08-2016."

DEFAULT_CHAT_FRAME:AddMessage("|cffffff78MilkUI:|r "..msg, r or 0.5, g or 0.75, b or 1)


--reload命令简化
SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

--脱战回收内存
local F = CreateFrame("Frame")
   F:RegisterEvent("PLAYER_REGEN_ENABLED")
   F:SetScript("OnEvent", function() _G.collectgarbage("collect") end)
--屏蔽错误红字
-- UIErrorsFrame:SetAlpha(0)

--显示大地图坐标
WorldMapButton:HookScript("OnUpdate", function(self)
   if not self.coordText then
      self.coordText = WorldMapFrameCloseButton:CreateFontString(nil, "OVERLAY", "GameFontGreen")
      self.coordText:SetPoint("BOTTOM", self, "BOTTOM", 0, 6)
   end
   local px, py = GetPlayerMapPosition("player")
   local x, y = GetCursorPosition()
   local width, height, scale = self:GetWidth(), self:GetHeight(), self:GetEffectiveScale()
   local centerX, centerY = self:GetCenter()
   x, y = (x/scale - (centerX - (width/2))) / width, (centerY + (height/2) - y/scale) / height
   if px == 0 and py == 0 and (x > 1 or y > 1 or x < 0 or y < 0) then
      self.coordText:SetText("")
   elseif px == 0 and py == 0 then
      self.coordText:SetText(format("当前: %d, %d", x*100, y*100))
   elseif x > 1 or y > 1 or x < 0 or y < 0 then
      self.coordText:SetText(format("玩家: %d, %d", px*100, py*100))
   else
      self.coordText:SetText(format("玩家: %d, %d 当前: %d, %d", px*100, py*100, x*100, y*100))
   end
end)
--右上角小地图显示当前坐标
MinimapCluster:SetScript("OnUpdate", function()
   local px, py = GetPlayerMapPosition("player")
   local zone = GetMinimapZoneText()
   if px == 0 and py == 0 then
      MinimapZoneText:SetText(zone)
   else
      MinimapZoneText:SetText((format("(%d,%d)", px*100, py*100))..zone)
   end
end)

MinimapCluster:HookScript("OnEvent", function(self, event, ...)
   if event == "ZONE_CHANGED_NEW_AREA" and not WorldMapFrame:IsShown() then
      SetMapToCurrentZone()
   end
end)
WorldMapFrame:HookScript("OnHide", SetMapToCurrentZone)

MiniMapWorldMapButton:Hide()
MinimapZoneTextButton:SetScript("OnClick", function()
   if ACTIVE_CHAT_EDIT_BOX then
      ACTIVE_CHAT_EDIT_BOX:Insert("我在 "..MinimapZoneText:GetText())
   else
      ToggleFrame(WorldMapFrame)
   end
end)

MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, y)
   if y > 0 then
      MinimapZoomIn:Click()
   else
      MinimapZoomOut:Click()
   end
end)

Minimap:SetMovable(true)
Minimap:SetClampedToScreen(true)
Minimap:SetScript("OnMouseDown", function(self)
   if IsShiftKeyDown() then
      self:ClearAllPoints()
      self:StartMoving()
   end
end)
Minimap:HookScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)



--法术ID及释放者、物品ID
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
   local id = select(11,UnitBuff(...))
   local caster = select(8,UnitBuff(...)) and UnitName(select(8,UnitBuff(...)))
   self:AddLine(id and ' ')
   self:AddDoubleLine(id, caster)
   self:Show()
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
   local id = select(11,UnitDebuff(...))
   local caster = select(8,UnitDebuff(...)) and UnitName(select(8,UnitDebuff(...)))
   self:AddLine(id and ' ')
   self:AddDoubleLine(id, caster)
   self:Show()
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
   local id = select(11,UnitAura(...))
   local caster = select(8,UnitAura(...)) and UnitName(select(8,UnitAura(...)))
   self:AddLine(id and ' ')
   self:AddDoubleLine(id, caster)
   self:Show()
end)

hooksecurefunc("SetItemRef", function(link)
   if link then
      local _, id = strsplit(":", link)
      ItemRefTooltip:AddLine(id and ' ')
      ItemRefTooltip:AddLine(id)
      ItemRefTooltip:Show()
   end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
   if self.GetSpell then
      local _, _, id = self:GetSpell()
      self:AddLine(id and ' ')
      self:AddLine(id)
      self:Show()
   end
end)

GameTooltip:HookScript("OnTooltipSetItem", function(self)
   if self.GetItem then
      local _, id = strsplit(":", select(2,self:GetItem()))
      self:AddLine(id and ' ')
      self:AddLine(id)
      self:Show()
   end
end)


-- --[在头部、披风栏添加显示切换按键]
-- local checkbox = {}

-- local function createCheckbox(slotName)
--    if not checkbox[slotName] then
--       local cb = CreateFrame("CheckButton", nil, _G[slotName])
--       cb:SetSize(20, 20)
--       cb:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
--       cb:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
--       cb:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
--       cb:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]])
--       cb:SetDisabledCheckedTexture([[Interface\Buttons\UI-CheckBox-Check-Disabled]])
--       cb:SetPoint("BOTTOMRIGHT", _G[slotName], "BOTTOMRIGHT", 5, -5)
--       checkbox[slotName] = cb
--    end
-- end

-- createCheckbox("CharacterHeadSlot")
-- createCheckbox("CharacterBackSlot")
-- checkbox["CharacterHeadSlot"]:SetChecked(ShowingHelm())
-- checkbox["CharacterBackSlot"]:SetChecked(ShowingCloak())
-- checkbox["CharacterHeadSlot"]:SetScript("OnClick", function() ShowHelm(not ShowingHelm()) end)
-- checkbox["CharacterBackSlot"]:SetScript("OnClick", function() ShowCloak(not ShowingCloak()) end)



