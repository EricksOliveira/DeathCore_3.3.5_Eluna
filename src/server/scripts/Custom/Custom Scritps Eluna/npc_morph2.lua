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
local NPC_ID = 999995 
 
function Morph_Gossip(event, plr, unit)
	plr:GossipMenuAddItem(0 ,"Worgen" , 0 , 1000 , 0)
	plr:GossipMenuAddItem(0, "Humano", 0, 1001, 0)
	plr:GossipMenuAddItem(0, "humana", 0, 1002, 0)
	plr:GossipMenuAddItem(0, "Night Elf", 0, 1003, 0)
	plr:GossipMenuAddItem(0, "Gnomo Macho", 0, 1004, 0)
	plr:GossipMenuAddItem(0, "Gnomo Femea", 0, 1005, 0)
	plr:GossipMenuAddItem(0, "Draenai Mulher", 0, 1006, 0)
	plr:GossipMenuAddItem(0, "Broken Macho", 0, 1014, 0)
	plr:GossipMenuAddItem(0, "Panda Monk", 0, 1015, 0)
	plr:GossipMenuAddItem(0, "Blood Elf Macho", 0, 1007, 0)
	plr:GossipMenuAddItem(0, "Blood Elf Femea", 0, 1008, 0)
	plr:GossipMenuAddItem(0, "Taurem Macho", 0, 1009, 0)
	plr:GossipMenuAddItem(0, "Taurem Femea", 0, 1010, 0)
	plr:GossipMenuAddItem(0, "Orca Femea", 0, 1011, 0)
	plr:GossipMenuAddItem(0, "Globin Macho", 0, 1012, 0)
	plr:GossipMenuAddItem(0, "Globin Femea", 0, 1013, 0)
	plr:GossipSendMenu(1, unit)
end
 
function Morph_Event(event, plr, unit, arg2, intid)
		if(intid == 1001) then
			plr:SetDisplayId(19723)
		elseif(intid == 1000) then
			plr:SetDisplayId(11181) 
		elseif(intid == 1002) then
			plr:SetDisplayId(19724) 
		elseif(intid == 1003) then
			plr:SetDisplayId(20318) 
		elseif(intid == 1004) then
			plr:SetDisplayId(20580) 
		elseif(intid == 1005) then
			plr:SetDisplayId(20320)
		elseif(intid == 1006) then
			plr:SetDisplayId(20323) 
		elseif(intid == 1007) then
			plr:SetDisplayId(20370) 
		elseif(intid == 1008) then
			plr:SetDisplayId(20369) 
		elseif(intid == 1009) then
			plr:SetDisplayId(20319) 
		elseif(intid == 1010) then
			plr:SetDisplayId(20584) 
		elseif(intid == 1011) then
			plr:SetDisplayId(20316) 
		elseif(intid == 1012) then
			plr:SetDisplayId(20582) 
		elseif(intid == 1013) then
			plr:SetDisplayId(20583) 
		elseif(intid == 1014) then
			plr:SetDisplayId(21105) 
		elseif(intid == 1015) then
			plr:SetDisplayId(30414) 
		end
		plr:RemoveItem(29434, 5)
		plr:SendAreaTriggerMessage("|cff00ff00 Voce foi transformado!")
end
 
RegisterCreatureGossipEvent(NPC_ID, 1, Morph_Gossip)
RegisterCreatureGossipEvent(NPC_ID, 2, Morph_Event)