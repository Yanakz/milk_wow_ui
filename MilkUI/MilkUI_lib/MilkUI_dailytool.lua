
--自动卖破烂
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
   local c = 0
   for b=0,4 do
      for s=1,GetContainerNumSlots(b) do
         local l = GetContainerItemLink(b, s)
         if l and string.find(l,"ff9d9d9d") then
            DEFAULT_CHAT_FRAME:AddMessage("卖出 "..l)
        --  if l then
            local p = select(11, GetItemInfo(l))*select(2, GetContainerItemInfo(b, s))
            -- if select(3, GetItemInfo(l))==0 and p>0 then
            UseContainerItem(b, s)
            --    PickupMerchantItem()
               
            c = c+p

            -- end
         end
      end
   end
   if c>0 then
      local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100
      DEFAULT_CHAT_FRAME:AddMessage("卖破烂收入".." |cffffffff"..g.."|cffffc125g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r"..".",255,255,255)
   end
end)
f:RegisterEvent("MERCHANT_SHOW")




--------------------------------------------------

--自动修理
local AutoRepair = true
local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")
g:SetScript("OnEvent", function()
if(AutoRepair==true and CanMerchantRepair()) then 
local cost = GetRepairAllCost()
if cost > 0 then
local money = GetMoney()
if IsInGuild() then
local guildMoney = GetGuildBankWithdrawMoney()
if guildMoney > GetGuildBankMoney() then
guildMoney = GetGuildBankMoney()
end
if guildMoney > cost and CanGuildBankRepair() then
RepairAllItems(1)
print(format("|cfff07100工会修理花费: %.1fg|r", cost * 0.0001))
return
end
end
if money > cost then
RepairAllItems()
print(format("|cffead000修理花费: %.1fg|r", cost * 0.0001))
else
print("Go farm newbie.")
end
end
end
end)

--成就自动截图
local function TakeScreen(delay, func, ...)
local waitTable = {}
local waitFrame = CreateFrame("Frame", "WaitFrame", UIParent)
   waitFrame:SetScript("onUpdate", function (self, elapse)
      local count = #waitTable
      local i = 1
      while (i <= count) do
         local waitRecord = tremove(waitTable, i)
         local d = tremove(waitRecord, 1)
         local f = tremove(waitRecord, 1)
         local p = tremove(waitRecord, 1)
         if (d > elapse) then
            tinsert(waitTable, i, {d-elapse, f, p})
            i = i + 1
         else
            count = count - 1
            f(unpack(p))
         end
      end
   end)
   tinsert(waitTable, {delay, func, {...} })
end
local function OnEvent(...)
   TakeScreen(1, Screenshot)
end
local AchScreen = CreateFrame("Frame")
AchScreen:RegisterEvent("ACHIEVEMENT_EARNED")
AchScreen:SetScript("OnEvent", OnEvent)

