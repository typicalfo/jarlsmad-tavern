import { Agent } from "@convex-dev/agent";
import { components } from "./_generated/api";
import { venice, veniceModels, veniceEmbedding } from "./venice_provider";
import { AGENTS } from "./agent_values";

// Dungeon Master - The All-Father overseeing the entire game world
export const dungeonMasterAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.DUNGEON_MASTER.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 5,
  maxRetries: 3,
});

// Inn Keeper - Safe havens for recovery and lore
export const innKeeperAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.INN_KEEPER.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Tavern Master - Social hubs for interactions and intrigue
export const tavernMasterAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.TAVERN_MASTER.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Generic NPC - Versatile filler characters for world immersion
export const genericNpcAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.GENERIC_NPC.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 2,
  maxRetries: 2,
});

// Mob Agent - Handles enemy groups and wildlife threats
export const mobAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.MOB_AGENT.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 4,
  maxRetries: 3,
});

// Faction Jarl Leader - Political leaders driving major quests
export const factionJarlLeaderAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.FACTION_JARL_LEADER.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 4,
  maxRetries: 3,
});

// Merchant Trader - Economy and trade-based interactions
export const merchantTraderAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.MERCHANT_TRADER.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Blacksmith Crafter - Item creation and enhancement
export const blacksmithCrafterAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.BLACKSMITH_CRAFTER.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Seer Oracle - Mystical guidance and prophecy
export const seerOracleAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.SEER_ORACLE.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Ship Captain Navigator - Travel and exploration management
export const shipCaptainNavigatorAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.SHIP_CAPTAIN_NAVIGATOR.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Healer Priest - Divine interactions and healing services
export const healerPriestAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.HEALER_PRIEST.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Guard Sentinel - Order maintenance and security
export const guardSentinelAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.GUARD_SENTINEL.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Scholar Librarian - Knowledge dispensing and lore access
export const scholarLibrarianAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.SCHOLAR_LIBRARIAN.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Assassin Spy - Covert operations and stealth missions
export const assassinSpyAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.ASSASSIN_SPY.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 4,
  maxRetries: 3,
});

// Event Herald - Global event management and announcements
export const eventHeraldAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.EVENT_HERALD.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 4,
  maxRetries: 3,
});

// Beastmaster Companion Handler - Animal companions and hybrid threats
export const beastmasterCompanionHandlerAgent = new Agent(components.agent, {
  chat: venice.chat(veniceModels.uncensored),
  instructions: AGENTS.BEASTMASTER_COMPANION_HANDLER.instructions,
  tools: {},
  textEmbedding: venice.embedding(veniceEmbedding.small),
  maxSteps: 3,
  maxRetries: 2,
});

// Export all agents for use throughout the application
export const jarlsmadAgents = {
  dungeonMaster: dungeonMasterAgent,
  innKeeper: innKeeperAgent,
  tavernMaster: tavernMasterAgent,
  genericNpc: genericNpcAgent,
  mob: mobAgent,
  factionJarlLeader: factionJarlLeaderAgent,
  merchantTrader: merchantTraderAgent,
  blacksmithCrafter: blacksmithCrafterAgent,
  seerOracle: seerOracleAgent,
  shipCaptainNavigator: shipCaptainNavigatorAgent,
  healerPriest: healerPriestAgent,
  guardSentinel: guardSentinelAgent,
  scholarLibrarian: scholarLibrarianAgent,
  assassinSpy: assassinSpyAgent,
  eventHerald: eventHeraldAgent,
  beastmasterCompanionHandler: beastmasterCompanionHandlerAgent,
} as const;