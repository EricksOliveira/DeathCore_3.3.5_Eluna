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
local T = {}

local function KilledCreature(event, player, enemy)
    if(not enemy:IsWorldBoss()) then return end -- not world boss, skip
    local pguid, cguid = player:GetGUIDLow(), enemy:GetGUIDLow() -- get guids
   
    local ktime = 0 -- get time (default to 0)
    if(T[pguid] and T[pguid][cguid]) then
        ktime = os.time() - T[pguid][cguid] -- (now - start) = passed time (seconds)
        T[pguid][cguid] = nil -- erase record
    end
       
    local participants
        if(player:IsInGroup()) then
                participants = "E seus amigos (Total: "..player:GetGroup():GetMembersCount().." guys, "
        else
                participants = "Sozinho! ("
        end
   
    SendWorldMessage("|cff000000[Mensagem PVE]|cFFFF0000 |Hplayer:"..player:GetName().."|h["..player:GetName().."]|h Matou ["..enemy:GetName().."] "..participants.."Usou: "..ktime.." Segundos)")
end

local function EnterCombat(event, player, enemy)
    if(not enemy:IsWorldBoss()) then return end -- not world boss, skip saving time etc
    local pguid, cguid = player:GetGUIDLow(), enemy:GetGUIDLow() -- get guids
   
    if(not T[pguid]) then -- if the player doesnt have a table
        T[pguid] = {} -- create a new table for him
    elseif(T[pguid][cguid]) then -- check that we are not already in combat with the creature (already saved a time)
        return -- we are, already a time saved. Stop before saving
    end
    T[pguid][cguid] = os.time() -- save combat start time
end

local function LeaveCombat(event, player)
        if(T[player:GetGUIDLow()]) then
                T[player:GetGUIDLow()] = nil -- erase combat time records
        end
end
 
RegisterPlayerEvent(7, KilledCreature) -- executes when a player kills a creature
RegisterPlayerEvent(33, EnterCombat) -- executes on each player attack attempt (spammy)
RegisterPlayerEvent(34, LeaveCombat) -- executes when a player leaves combat