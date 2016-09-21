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
local C = {
        [1] = {"|TInterface\\icons\\INV_Sword_27.png:20|t Warrior", "660000"}, -- Warrior
        [2] = {"|TInterface\\icons\\INV_Hammer_01.png:20|t Paladin", "FF0099"}, -- Paladin
        [3] = {"|TInterface\\icons\\INV_Weapon_Bow_07.png:20|t Hunter", "CC6611"}, -- Hunter
        [4] = {"|TInterface\\icons\\INV_ThrowingKnife_04.png:20|t Rogue", "CCFF00"}, -- Rogue
        [5] = {"|TInterface\\icons\\INV_Staff_30.png:20|t Priest", "FFFFFF"}, -- Priest
        [6] = {"|TInterface\\icons\\Spell_Deathknight_ClassIcon.png:20|t Death Knight", "4D4D51"}, -- Deathknight
        [7] = {"|TInterface\\icons\\inv_jewelry_talisman_04.png:20|t Shaman", "0000CC"}, -- Shaman
        [8] = {"|TInterface\\icons\\INV_Staff_13.png:20|t Mage", "33FFFF"}, -- Mage
        [9] = {"|TInterface\\ICONS/Spell_Nature_FaerieFire.png:20|t Warlock", "660099"}, -- Warlock
        [11] = {"|TInterface\\icons\\Ability_Druid_Maul.png:20|t Druid", "FF6600"} -- Druid
};

function newplayer(event, player, lang) 
  player:SendBroadcastMessage("[ |cFFCC0066DeathCore |cffffff00] - |cffffffffBem Vindo a nossa familia")
end  
  
RegisterPlayerEvent(30, newplayer)