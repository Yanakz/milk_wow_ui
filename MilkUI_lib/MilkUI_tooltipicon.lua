hooksecurefunc("SetItemRef", function(link, text, button)
	local icon
	local type, id = string.match(link, "^([a-z]+):(%d+)")
	if( type == "item" ) then
		icon = select(10, GetItemInfo(link))
	elseif( type == "spell" or type == "enchant" ) then
		icon = select(3, GetSpellInfo(id))
	elseif( type == "achievement" ) then
		icon = select(10, GetAchievementInfo(id))
	end	
	
	if( not icon ) then
		ItemRefTooltipTexture10:Hide()

		ItemRefTooltipTextLeft1:ClearAllPoints()
		ItemRefTooltipTextLeft1:SetPoint("TOPLEFT", ItemRefTooltip, "TOPLEFT", 8, -10)

		ItemRefTooltipTextLeft2:ClearAllPoints()
		ItemRefTooltipTextLeft2:SetPoint("TOPLEFT", ItemRefTooltipTextLeft1, "BOTTOMLEFT", 0, -2)
		return
	end

	ItemRefTooltipTexture10:ClearAllPoints()
	ItemRefTooltipTexture10:SetPoint("TOPLEFT", ItemRefTooltip, "TOPLEFT", 8, -7)
	ItemRefTooltipTexture10:SetTexture(icon)
	ItemRefTooltipTexture10:SetHeight(30)
	ItemRefTooltipTexture10:SetWidth(30)
	ItemRefTooltipTexture10:Show()
	
	ItemRefTooltipTextLeft1:ClearAllPoints()
	ItemRefTooltipTextLeft1:SetPoint("TOPLEFT", ItemRefTooltipTexture10, "TOPLEFT", 35, -2)

	ItemRefTooltipTextLeft2:ClearAllPoints()
	ItemRefTooltipTextLeft2:SetPoint("TOPLEFT", ItemRefTooltip, "TOPLEFT", 8, -40)
	
	local textRight = ItemRefTooltipTextLeft1:GetRight()
	local closeLeft = ItemRefCloseButton:GetLeft()
	
	if( closeLeft <= textRight ) then
		ItemRefTooltip:SetWidth(ItemRefTooltip:GetWidth() + (textRight - closeLeft))
	end
end)