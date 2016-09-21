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
local NPC_ID = 800003
 
function On_Gossip(event, plr, unit)
-- Menus
plr:GossipMenuAddItem(0, "Edite", 0, 1)
plr:GossipMenuAddItem(0, "Edite", 0, 2)
plr:GossipMenuAddItem(0, "Edite", 0, 3)
plr:GossipMenuAddItem(0, "Edite", 0, 4)
plr:GossipMenuAddItem(0, "Edite", 0, 5)
plr:GossipMenuAddItem(0, "Edite", 0, 6)
plr:GossipSendMenu(1, unit)
end
 
function On_Select(event, player, unit, sender, intid, code)
-- Custom messages
 

if (intid == 1) then
player:SendBroadcastMessage("#rules")
end
 

if (intid == 2) then
player:SendBroadcastMessage("Edite")
end
 

if (intid == 3) then
player:SendBroadcastMessage("Edite")
end


if (intid == 4) then
player:SendBroadcastMessage("Edite")
end


if (intid == 5) then
player:SendBroadcastMessage("Edite")
end


if (intid == 6) then
player:SendBroadcastMessage("Edite")
end
 
        player:GossipComplete()
end
RegisterCreatureGossipEvent(NPC_ID, 1, On_Gossip)
RegisterCreatureGossipEvent(NPC_ID, 2, On_Select)