do 
   PAPERDOLL_STATCATEGORIES= { 
      [1] = { 
         categoryFrame = "AttributesCategory", 
         stats = { 
            [1] = { stat = "ATTACK_DAMAGE" }, 
            [2] = { stat = "STRENGTH", primary = LE_UNIT_STAT_STRENGTH }, 
            [3] = { stat = "AGILITY", primary = LE_UNIT_STAT_AGILITY }, 
            [4] = { stat = "INTELLECT", primary = LE_UNIT_STAT_INTELLECT }, 
            [5] = { stat = "STAMINA" }, 
            [6] = { stat = "ARMOR" }, 
            [7] = { stat = "ENERGY_REGEN", hideAt = 0 }, 
            [8] = { stat = "RUNE_REGEN", hideAt = 0 }, 
            [9] = { stat = "FOCUS_REGEN", hideAt = 0 }, 
            [10] = { stat = "MANAREGEN", roles =  { "HEALER" } }, 
         }, 
      }, 
      [2] = { 
         categoryFrame = "EnhancementsCategory", 
         stats = { 
            [1] = { stat = "CRITCHANCE", hideAt = 0 }, 
            [2] = { stat = "HASTE", hideAt = 0 }, 
            [3] = { stat = "MASTERY", hideAt = 0 }, 
            [4] = { stat = "VERSATILITY", hideAt = 0 }, 
            [5] = { stat = "LIFESTEAL", hideAt = 0 }, 
            [6] = { stat = "AVOIDANCE", hideAt = 0 }, 
            [7] = { stat = "DODGE", roles =  { "TANK" } }, 
            [8] = { stat = "PARRY", hideAt = 0, roles =  { "TANK" } }, 
            [9] = { stat = "BLOCK", hideAt = 0, roles =  { "TANK" } }, 
         }, 
      }, 
   }; 
   ---修改,若能量值获取不到.就设置为0,就能套用hideAt了 
   PAPERDOLL_STATINFO["ENERGY_REGEN"].updateFunc = function(statFrame, unit) statFrame.numericValue=0; PaperDollFrame_SetEnergyRegen(statFrame, unit); end 
   
   PAPERDOLL_STATINFO["RUNE_REGEN"].updateFunc = function(statFrame, unit) statFrame.numericValue=0; PaperDollFrame_SetRuneRegen(statFrame, unit); end 
   
   PAPERDOLL_STATINFO["FOCUS_REGEN"].updateFunc = function(statFrame, unit) statFrame.numericValue=0; PaperDollFrame_SetFocusRegen(statFrame, unit); end 
   
   --增加移动速度的代码(被暴雪删掉了) 
   PAPERDOLL_STATINFO["MOVESPEED"].updateFunc =  function(statFrame, unit) PaperDollFrame_SetMovementSpeed(statFrame, unit); end 
   

   --根据职业,做一些改动 
   local _,_,classid = UnitClass("player") 
   if (classid==1)then --战士 

   elseif (classid==2)then --圣骑 
   elseif (classid==3)then --猎人 

   elseif (classid==4)then --盗贼 

   elseif (classid==5)then --牧师 
      PAPERDOLL_STATCATEGORIES[1].stats[1].roles={}   --隐藏伤害 
   elseif (classid==6)then --DK 

   elseif (classid==7)then --萨满 
   elseif (classid==8)then --法师,加上回蓝显示 
      PAPERDOLL_STATCATEGORIES[1].stats[1].roles={} 
      table.insert(PAPERDOLL_STATCATEGORIES[1].stats,{ stat = "MANAREGEN" }) 
   elseif (classid==9)then --术士 
      PAPERDOLL_STATCATEGORIES[1].stats[1].roles={}   --隐藏伤害 
   elseif (classid==10)then --武僧 

   elseif (classid==11)then --德鲁伊 

   elseif (classid==12)then --DH 

   end 
   
   --加上移动速度(加最后) 
   table.insert(PAPERDOLL_STATCATEGORIES[1].stats,{ stat = "MOVESPEED" }) 
   
   --关于移动速度代码(不然会出现错乱) 
   local tempstatFrame 
   hooksecurefunc("PaperDollFrame_SetMovementSpeed",function(statFrame, unit) 
      if(tempstatFrame and tempstatFrame~=statFrame)then 
        tempstatFrame:SetScript("OnUpdate",nil); 
      end 
      statFrame:SetScript("OnUpdate", MovementSpeed_OnUpdate); 
      tempstatFrame = statFrame; 
      statFrame:Show(); 
   end) 
end
