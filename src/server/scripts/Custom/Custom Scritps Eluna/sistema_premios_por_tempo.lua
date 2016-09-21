--
-- Copyright (C) 2013-2016 DeathCore <http://www.noffearrdeathproject.net/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

-- Functions
local Reward = 1 -- 1 for Item reward, 2 for Gold reward, 3 for Level reward
local ItemReward = 44115 -- item id
local ItemRewardAmount = 1 -- item amount
local MoneyReward = 50000 -- Money in copper
local MaxLvl = 80 -- maxlevel, so it dosnt give above ur max lvl cap
local Lvlgain = 1 -- Amount of levels to recieve
local Timer = 1800000 -- 1800000 = 30 minutes timer between rewards
 
local function Player_Onlinetime(event, delay, calls, player)
        if(player:IsAFK() == true)then
                player:SendAreaTriggerMessage("Você foi alternado como AFK as recompensas não seram adicionadas.")
        else
                if(Reward == 1)then
                        player:AddItem(ItemReward, ItemRewardAmount)
                elseif(Reward == 2)then
                        player:ModifyMoney(MoneyReward)
                elseif(Reward == 3)then
                        if(player:GetLevel() == MaxLvl)then
 
                        else
                                player:GiveLevel(player:GetLevel()+Lvlgain)
                        end
                end
                player:SendAreaTriggerMessage("Você está jogando a 30 minutos, recebera uma recompensa.")
        end
end
 
local function OnLine(event, player)
        player:RegisterEvent(Player_Onlinetime, Timer, 0)
end
 
RegisterPlayerEvent(3, OnLine)