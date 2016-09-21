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

-- Include sc_default
require "base/sc_default"

local TimeMorph = {}

TimeMorph.Settings = {
    Name = "|CFF1CB619[Sistema Morph ]|r",
    NpcActive = true,
    NpcEntry = 60000,
    ItemActive = true,
    ItemEntry = 900030,
    MorphTime = 60,
};

-- Icon, Name, DisplayID, Scale
TimeMorph.Displays = {
    [1] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Kael Sunstrider", 20023, 0.3 },
    [2] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Maiev Shadowsong", 20628, 0.7 },
    [3] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Rexxar Champion of the Horde ", 20918, 0.5 },
    [4] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Archmond", 18292, 0.03 },
    [5] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Lady Sinestra", 21401, 0.2 },
    [6] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Champion Sunstrike", 17261, 1 },
    [7] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Champion Swiftblade", 17260, 1 },
    [8] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Illidan Storimrage", 21135, 0.3 },
    [9] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Al'ar", 18945, 0.2 },
};

function TimeMorph.OnGossipHello(event, player, unit)
    if player:GetLuaCooldown(3) == 0 then
        player:GossipSetText(string.format("Bem vindo %s ao %s\n\nMorph durara |CFFFF0000%s|r segundos", player:GetName(), TimeMorph.Settings.Name, TimeMorph.Settings.MorphTime))
        for i, v in ipairs(TimeMorph.Displays) do
            player:GossipMenuAddItem(0, ""..v[1]..""..v[2].."", i, 1)
        end
    else
        player:GossipSetText(string.format("Bem vindo %s ao %s\n\nVocê está com uma Morph, precisa remover da Morph (deMorph) para usar outra Morph", player:GetName(), TimeMorph.Settings.Name))
        player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-15:0|tDeMorph ", 0, 2)
        player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_Spy:30:30:-15:0|tFechar Menu", 0, 3)
    end
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function TimeMorph.OnGossipSelect(event, player, unit, sender, intid, code)

    if (intid == 1) then
        local Icon, Name, DisplayID, Scale = table.unpack(TimeMorph.Displays[sender])
        player:SetDisplayId(DisplayID)
        player:SetScale(Scale)
        player:SetLuaCooldown(TimeMorph.Settings.MorphTime, 3)
        player:RegisterEvent(TimeMorph.CooldownCheck, 1000, player:GetLuaCooldown(3))
        player:SendBroadcastMessage(string.format("%s Está usando Morph, Sua Morph desaparecera em %s segundos!", TimeMorph.Settings.Name, player:GetLuaCooldown(3)))
        player:PlaySoundToPlayer(888)
        player:GossipClearMenu()
        TimeMorph.OnGossipHello(event, player, unit)
    elseif (intid == 2) then
        player:DeMorph()
        player:SetScale(1)
        player:SetLuaCooldown(0, 3)
        player:RemoveEvents()
        player:SendBroadcastMessage(string.format("%s Morph removida", TimeMorph.Settings.Name))
        player:GossipClearMenu()
        TimeMorph.OnGossipHello(event, player, unit)
    elseif (intid == 3) then
        player:GossipComplete()
    end
end

function TimeMorph.CooldownCheck(event, delay, repeats, player)
    if player:GetLuaCooldown(3) == 0 then
        player:DeMorph()
        player:SetScale(1)
        player:PlaySoundToPlayer(1435)
        player:RemoveEvents()
        player:SendBroadcastMessage(string.format("%s Morph removida", TimeMorph.Settings.Name))
    elseif player:GetLuaCooldown(3) <= 10 then
        player:SendBroadcastMessage(string.format("%s Morph sera removida em %s segundos!", TimeMorph.Settings.Name, player:GetLuaCooldown(3)))
    end
end

function TimeMorph.OnElunaReload(event)
    for _, v in pairs(GetPlayersInWorld()) do
        v:DeMorph()
        v:SetLuaCooldown(0, 3)
        v:SetScale(1)
    end
end

function TimeMorph.OnLogout(event, player)
    player:DeMorph()
    player:SetLuaCooldown(0, 3)
    player:SetScale(1)
end

if TimeMorph.Settings.NpcActive == false and TimeMorph.Settings.ItemActive == false then
   
end

if TimeMorph.Settings.NpcActive == true then
    RegisterCreatureGossipEvent(TimeMorph.Settings.NpcEntry, 1, TimeMorph.OnGossipHello)
    RegisterCreatureGossipEvent(TimeMorph.Settings.NpcEntry, 2, TimeMorph.OnGossipSelect)

   
end

if TimeMorph.Settings.ItemActive == true then
    RegisterItemGossipEvent(TimeMorph.Settings.ItemEntry, 1, TimeMorph.OnGossipHello)
    RegisterItemGossipEvent(TimeMorph.Settings.ItemEntry, 2, TimeMorph.OnGossipSelect)

   
end

RegisterPlayerEvent(4, TimeMorph.OnLogout)
RegisterServerEvent(16, TimeMorph.OnElunaReload)