--mktip
--~ LoadAddOn("Blizzard_InspectUI")
local PRIMARY_TALENT = SPECIALIZATION.." : "
local SECONDARY_TALENT = TALENT.." : "
local mksetting = {
	showtalent = true,
	Fade = true
}
local myspec


--------------------------------------------------------------
local function GetHexColor(color)
  return ("%.2x%.2x%.2x"):format(color.r*255, color.g*255, color.b*255)
end

local classColors, reactionColors = {}, {}

for class, color in pairs(RAID_CLASS_COLORS) do
  classColors[class] = GetHexColor(RAID_CLASS_COLORS[class])
end

for i = 1, #FACTION_BAR_COLORS do
  reactionColors[i] = GetHexColor(FACTION_BAR_COLORS[i])
end




--------------------------------------------------------------

local function GetTarget(unit)
  if UnitIsUnit(unit, "player") then
    return ("|cffff0000%s|r"):format("<你>")
  elseif UnitIsPlayer(unit, "player")then
    return ("|cff%s%s|r"):format(classColors[select(2, UnitClass(unit))], UnitName(unit))
  elseif UnitReaction(unit, "player") then
    return ("|cff%s%s|r"):format(reactionColors[UnitReaction(unit, "player")], UnitName(unit))
  else
    return ("|cffffffff%s|r"):format(UnitName(unit))
  end
end

--------------------------------------------------------------

local function Gettalent(unit)
    if (not unit) then return end 
		
    if UnitIsUnit(unit,"player") then
	      Specid = GetSpecializationInfo(GetSpecialization())
		elseif UnitIsPlayer(unit,"player") then
		    
		    Specid = GetInspectSpecialization(unit)
				-- DEFAULT_CHAT_FRAME:AddMessage("this guy is "..Specid.." "..unit)
		else
		    return
		end
		return Specid
end

--------------------------------------------------------------

-- locs


local GameTooltip = GameTooltip
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local _, unit = self:GetUnit()
	if (not unit) then return end


	-- local spName = Getspec(unit)
	-- if (spName) then
	--     text = "|cffffffff" .. spName
	-- 		GameTooltip:AddLine(text)
	-- end
  -- NotifyInspect(unit) 
  
	-- if spec and mksetting.showtalent then
	-- 		if tonumber(spec) then	--spec已读取到
	-- 				if tonumber(spec)==0 then		--无专精
	-- 						spec = "|cffffff00"..PRIMARY_TALENT.."|r".."|cff00ff00["..NONE.."]|r"
	-- 			  else							--有专精
	-- 						local _, specName, _, icon = GetSpecializationInfoByID(tonumber(spec))
	-- 						if icon then 			--是否使用icon
	-- 								icon = "|T"..icon..":12:12:0:0:10:10:0:10:0:10|t "
	-- 						else
	-- 								icon = ""
	-- 						end
	-- 				    spec = "|cffffff00"..PRIMARY_TALENT.."|r"..icon.."|cff00ff00["..specName.."]|r"
	-- 			  end
	-- 		else					--spec未读取到
	-- 				spec = "|cffffff00"..PRIMARY_TALENT.."|r".."|cff00ff00"..spec.."|r"
	-- 		end
	-- 	  self:AddLine(spec)
			
  -- end

	if (UnitIsUnit("player", unit .. "target")) then
		self:AddDoubleLine("|cffff6666目标|r",GetTarget(unit.."target") or "Unknown")
	elseif (UnitExists(unit .. "target")) then
		self:AddDoubleLine("|cffff6666目标|r",GetTarget(unit.."target") or "Unknown")
	end


	local unitGuild = GetGuildInfo(unit)
    local text = GameTooltipTextLeft2:GetText()
    if unitGuild and text and text:find("^"..unitGuild) then
      GameTooltipTextLeft2:SetText("<"..text..">")
      GameTooltipTextLeft2:SetTextColor(255/255, 20/255, 200/255)
    end


end)
----------------------------------------------------------------
	GameTooltip:HookScript("OnTooltipCleared", function(self)
		GameTooltip_ClearMoney(self)
		GameTooltip_ClearStatusBars(self)
		-- OnGameTooltipHide()
	end)

--------------------------------------------------------------


hooksecurefunc(GameTooltip, "FadeOut", function(self)
	if (not mksetting.Fade) then
		GameTooltip:Hide();
	end
end)


--------------------------------------------------------------
function GameTooltip_UnitColor(unit)
	local r, g, b
	local reaction = UnitReaction(unit, "player")
	if reaction then
		r = FACTION_BAR_COLORS[reaction].r
		g = FACTION_BAR_COLORS[reaction].g
		b = FACTION_BAR_COLORS[reaction].b
	else
		r = 1.0
		g = 1.0
		b = 1.0
	end
	if UnitIsPlayer(unit) then
		local class = select(2, UnitClass(unit))
		r = RAID_CLASS_COLORS[class].r
		g = RAID_CLASS_COLORS[class].g
		b = RAID_CLASS_COLORS[class].b
	end
	return r, g, b
end

--------------------------------------------------------------

-- -- local myf = CreateFrame("Frame")
-- GameTooltip:SetScript('OnEvent', function(self,event,...)
--     if (event == 'INSPECT_READY') then
-- 				local _, unit = self:GetUnit()
-- 				spec = Gettalent(unit)
-- 				-- DEFAULT_CHAT_FRAME:AddMessage("123")   
-- 		end
-- end)
-- GameTooltip:RegisterEvent("INSPECT_READY")
-- NotifyInspect(0)



