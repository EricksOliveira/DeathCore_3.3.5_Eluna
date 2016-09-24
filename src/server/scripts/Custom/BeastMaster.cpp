//Fixed by Ac-Web Community
//Modified by Marcus
//Updated by Quadral
//Tradução by Ericks Oliveira
//original script created by ??
#include "ScriptMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GameEventMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Unit.h"
#include "GameObject.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "InstanceScript.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "Chat.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Pet.h"

#define GOSSIP_ITEM_STABLE "Stable"
#define GOSSIP_ITEM_NEWPET "Novo PET"
#define GOSSIP_ITEM_BOAR "Javali"
#define GOSSIP_ITEM_SERPENT "Serpente"
#define GOSSIP_ITEM_SCRAB "Scrab"
#define GOSSIP_ITEM_LION "Leão"
#define GOSSIP_ITEM_WOLF "Lobo"
#define GOSSIP_ITEM_RAVAGER "Ravenger"

#define GOSSIP_ITEM_UNTRAINEPET "Restart Pet"

class Npc_Beastmaster : public CreatureScript
{
public:
	Npc_Beastmaster() : CreatureScript("Npc_Beastmaster") { }

	void CreatePet(Player *player, Creature * m_creature, uint32 entry) {

		if (player->getClass() != CLASS_HUNTER) {
			m_creature->Whisper("Você não é um Hunter!", LANG_UNIVERSAL, player, false);
			player->PlayerTalkClass->SendCloseGossip();
			return;
		}

		if (player->GetPet()) {
			m_creature->Whisper("Primeiro você deve soltar o seu animal de estimação!", LANG_UNIVERSAL, player, false);;
			player->PlayerTalkClass->SendCloseGossip();
			return;
		}

		Creature *creatureTarget = m_creature->SummonCreature(entry, player->GetPositionX(), player->GetPositionY() + 2, player->GetPositionZ(), player->GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 500);
		if (!creatureTarget) return;

		Pet* pet = player->CreateTamedPetFrom(creatureTarget, 0);
		if (!pet)
			return;

		// kill original creature
		creatureTarget->setDeathState(JUST_DIED);
		creatureTarget->RemoveCorpse();
		creatureTarget->SetHealth(0);                       // just for nice GM-mode view

		pet->SetPower(POWER_HAPPINESS, 1048000);

		//pet->SetUInt32Value(UNIT_FIELD_PETEXPERIENCE,0);
		//pet->SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32((Trinity::XP::xp_to_level(70))/4));

		// prepare visual effect for levelup
		pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel() - 1);
		pet->GetMap()->AddToMap(pet->ToCreature());

		// visual effect for levelup
		pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel());


		if (!pet->InitStatsForLevel(player->getLevel()))
			// sLog->outError("Criar Pet Falhou: no init stats for entry %u", entry);

			pet->UpdateAllStats();

		// caster have pet now
		player->SetMinion(pet, true);

		pet->SavePetToDB(PET_SAVE_AS_CURRENT);
		pet->InitTalentForLevel();
		player->PetSpellInitialize();

		//end
		player->PlayerTalkClass->SendCloseGossip();
		m_creature->Whisper("Pet adicionado!", LANG_UNIVERSAL, player, false);;
	}


	bool OnGossipHello(Player *player, Creature * m_creature)
	{

		if (player->getClass() != CLASS_HUNTER)
		{
			m_creature->Whisper("Você não é um Hunter!", LANG_UNIVERSAL, player, false);
			return true;
		}
		player->ADD_GOSSIP_ITEM(4, "Obter um novo PET.", GOSSIP_SENDER_MAIN, 30);
		if (player->CanTameExoticPets())
		{
			player->ADD_GOSSIP_ITEM(4, "Obter um novo PET Exótico.", GOSSIP_SENDER_MAIN, 50);
		}
		player->ADD_GOSSIP_ITEM(2, "Leve-me para o Stable.", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
		player->ADD_GOSSIP_ITEM(6, "Me vende algum alimento para o meu PET de estimação.", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
		player->ADD_GOSSIP_ITEM(5, "Fechar Beastmaster Janela GOSSIP_SENDER_MAIN, 150);
		player->SEND_GOSSIP_MENU(1, m_creature->GetGUID());
		return true;
	}

	bool OnGossipSelect(Player *player, Creature * m_creature, uint32 sender, uint32 action)
	{
		player->PlayerTalkClass->ClearMenus();
		switch (action)
		{

		case 100:
			player->ADD_GOSSIP_ITEM(4, "Obter um novo PET.", GOSSIP_SENDER_MAIN, 30);
			if (player->CanTameExoticPets())
			{
				player->ADD_GOSSIP_ITEM(4, "Obter um novo PET Exótico.", GOSSIP_SENDER_MAIN, 50);
			}
			player->ADD_GOSSIP_ITEM(2, "Leve-me para o Stable.", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
			// player->ADD_GOSSIP_ITEM(6, "Me vende algum alimento para o meu PET de estimação.", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
			player->ADD_GOSSIP_ITEM(5, "Fechar Beastmaster Janela.", GOSSIP_SENDER_MAIN, 150);
			player->SEND_GOSSIP_MENU(1, m_creature->GetGUID());
			break;

		case 150:
			player->CLOSE_GOSSIP_MENU();
			break;
		case 30:
			player->ADD_GOSSIP_ITEM(2, "<- Voltar ao Menu Principal.", GOSSIP_SENDER_MAIN, 100);
			player->ADD_GOSSIP_ITEM(4, "Próxima página. ->", GOSSIP_SENDER_MAIN, 31);
			player->ADD_GOSSIP_ITEM(6, "Morcego.", GOSSIP_SENDER_MAIN, 18);
			player->ADD_GOSSIP_ITEM(6, "Urso.", GOSSIP_SENDER_MAIN, 1);
			player->ADD_GOSSIP_ITEM(6, "Javali.", GOSSIP_SENDER_MAIN, 2);
			player->ADD_GOSSIP_ITEM(6, "Gato.", GOSSIP_SENDER_MAIN, 4);
			player->ADD_GOSSIP_ITEM(6, "Pássaro Carniça.", GOSSIP_SENDER_MAIN, 5);
			player->ADD_GOSSIP_ITEM(6, "Caranguejo.", GOSSIP_SENDER_MAIN, 6);
			player->ADD_GOSSIP_ITEM(6, "crocodilo.", GOSSIP_SENDER_MAIN, 7);
			player->ADD_GOSSIP_ITEM(6, "Dragonhawk.", GOSSIP_SENDER_MAIN, 17);
			player->ADD_GOSSIP_ITEM(6, "Gorila.", GOSSIP_SENDER_MAIN, 8);
			player->ADD_GOSSIP_ITEM(6, "Cão de Caça.", GOSSIP_SENDER_MAIN, 9);
			player->ADD_GOSSIP_ITEM(6, "Hiena.", GOSSIP_SENDER_MAIN, 10);
			player->ADD_GOSSIP_ITEM(6, "Traça.", GOSSIP_SENDER_MAIN, 11);
			player->ADD_GOSSIP_ITEM(6, "Coruja.", GOSSIP_SENDER_MAIN, 12);
			player->SEND_GOSSIP_MENU(1, m_creature->GetGUID());
			break;

		case 31:
			player->ADD_GOSSIP_ITEM(2, "<- Voltar ao Menu Principal.", GOSSIP_SENDER_MAIN, 30);
			player->ADD_GOSSIP_ITEM(4, "<- Página anterior.", GOSSIP_SENDER_MAIN, 30);
			player->ADD_GOSSIP_ITEM(6, "Raptor.", GOSSIP_SENDER_MAIN, 20);
			player->ADD_GOSSIP_ITEM(6, "Ravager.", GOSSIP_SENDER_MAIN, 19);
			player->ADD_GOSSIP_ITEM(6, "Strider.", GOSSIP_SENDER_MAIN, 13);
			player->ADD_GOSSIP_ITEM(6, "Scorpid.", GOSSIP_SENDER_MAIN, 414);
			player->ADD_GOSSIP_ITEM(6, "Aranha.", GOSSIP_SENDER_MAIN, 16);
			player->ADD_GOSSIP_ITEM(6, "Serpente.", GOSSIP_SENDER_MAIN, 21);
			player->ADD_GOSSIP_ITEM(6, "Tartaruga.", GOSSIP_SENDER_MAIN, 15);
			player->ADD_GOSSIP_ITEM(6, "Vespa.", GOSSIP_SENDER_MAIN, 93);
			player->SEND_GOSSIP_MENU(1, m_creature->GetGUID());
			break;

		case 50:
			player->ADD_GOSSIP_ITEM(2, "<- Voltar ao Menu Principal.", GOSSIP_SENDER_MAIN, 100);
			player->ADD_GOSSIP_ITEM(2, "<- Obter um novo Pet Normal.", GOSSIP_SENDER_MAIN, 100);
			player->ADD_GOSSIP_ITEM(6, "Quimera.", GOSSIP_SENDER_MAIN, 51);
			player->ADD_GOSSIP_ITEM(6, "Core Cão de Caça.", GOSSIP_SENDER_MAIN, 52);
			player->ADD_GOSSIP_ITEM(6, "Demossauro.", GOSSIP_SENDER_MAIN, 53);
			player->ADD_GOSSIP_ITEM(6, "Rinoceronte.", GOSSIP_SENDER_MAIN, 54);
			player->ADD_GOSSIP_ITEM(6, "Silithid.", GOSSIP_SENDER_MAIN, 55);
			player->ADD_GOSSIP_ITEM(6, "Minhoca.", GOSSIP_SENDER_MAIN, 56);
			player->ADD_GOSSIP_ITEM(6, "Loque'nahak.", GOSSIP_SENDER_MAIN, 57);
			player->ADD_GOSSIP_ITEM(6, "Skoll.", GOSSIP_SENDER_MAIN, 58);
			player->ADD_GOSSIP_ITEM(6, "Gondria.", GOSSIP_SENDER_MAIN, 59);
			player->SEND_GOSSIP_MENU(1, m_creature->GetGUID());
			break;

		case GOSSIP_OPTION_STABLEPET:
			player->GetSession()->SendStablePet(m_creature->GetGUID());
			break;
		case GOSSIP_OPTION_VENDOR:
			player->GetSession()->SendListInventory(m_creature->GetGUID());
			break;
		case 51: //chimera
			CreatePet(player, m_creature, 21879);
			break;
		case 52: //core hound
			CreatePet(player, m_creature, 21108);
			break;
		case 53: //Devilsaur
			CreatePet(player, m_creature, 20931);
			break;
		case 54: //rhino
			CreatePet(player, m_creature, 30445);
			break;
		case 55: //silithid
			CreatePet(player, m_creature, 5460);
			break;
		case 56: //Worm
			CreatePet(player, m_creature, 30148);
			break;
		case 57: //Loque'nahak
			CreatePet(player, m_creature, 32517);
			break;
		case 58: //Skoll
			CreatePet(player, m_creature, 35189);
			break;
		case 59: //Gondria
			CreatePet(player, m_creature, 33776);
			break;
		case 16: //Spider
			CreatePet(player, m_creature, 2349);
			break;
		case 17: //Dragonhawk
			CreatePet(player, m_creature, 27946);
			break;
		case 18: //Bat
			CreatePet(player, m_creature, 28233);
			break;
		case 19: //Ravager
			CreatePet(player, m_creature, 17199);
			break;
		case 20: //Raptor
			CreatePet(player, m_creature, 14821);
			break;
		case 21: //Serpent
			CreatePet(player, m_creature, 28358);
			break;
		case 1: //bear
			CreatePet(player, m_creature, 29319);
			break;
		case 2: //Boar
			CreatePet(player, m_creature, 29996);
			break;
		case 93: //Bug
			CreatePet(player, m_creature, 28085);
			break;
		case 4: //cat
			CreatePet(player, m_creature, 28097);
			break;
		case 5: //carrion
			CreatePet(player, m_creature, 26838);
			break;
		case 6: //crab
			CreatePet(player, m_creature, 24478);
			break;
		case 7: //crocolisk
			CreatePet(player, m_creature, 1417);
			break;
		case 8: //gorila
			CreatePet(player, m_creature, 28213);
			break;
		case 9: //hound
			CreatePet(player, m_creature, 29452);
			break;
		case 10: //hynea
			CreatePet(player, m_creature, 13036);
			break;
		case 11: //Moth
			CreatePet(player, m_creature, 27421);
			break;
		case 12: //owl
			CreatePet(player, m_creature, 23136);
			break;
		case 13: //strider
			CreatePet(player, m_creature, 22807);
			break;
		case 414: //scorpid
			CreatePet(player, m_creature, 9698);
			break;
		case 15: //turtle
			CreatePet(player, m_creature, 25482);
			break;
		}
		return true;
	}
};

void AddSC_Npc_Beastmaster()
{
	new Npc_Beastmaster();
}
