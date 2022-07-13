import type { Principal } from '@dfinity/principal';
export interface Character {
  'max_stamina' : number,
  'max_mana' : number,
  'intelligent' : number,
  'character_id' : string,
  'luck' : number,
  'name' : string,
  'current_stamina' : number,
  'level' : bigint,
  'current_morale' : number,
  'level_up_exp' : number,
  'character_class' : string,
  'current_exp' : number,
  'strength' : number,
  'current_mana' : number,
  'max_hp' : number,
  'current_hp' : number,
  'max_morale' : number,
  'vitality' : number,
}
export interface Character_Quest_Item {
  'character_id' : string,
  'list_quest_item' : Array<string>,
}
export interface Character_take_Opton {
  'char_max_morale' : number,
  'char_curr_mana' : number,
  'char_curr_morale' : number,
  'character_id' : string,
  'char_max_mana' : number,
  'option_id' : string,
  'pickup_time' : Time,
  'char_max_hp' : number,
  'char_curr_hp' : number,
  'char_max_stamina' : number,
  'char_curr_stamina' : number,
}
export type Error = { 'CharacterQuestItemNotFound' : null } |
  { 'QuestNameAlready' : null } |
  { 'QuestNotFound' : null } |
  { 'CharacterNameAlready' : null } |
  { 'QuestItemNameAlready' : null } |
  { 'NotFound' : null } |
  { 'MaterialNotFound' : null } |
  { 'ChooseOptionNotFound' : null } |
  { 'QuestItemNotFound' : null } |
  { 'EventNotFound' : null } |
  { 'OptionNotFound' : null } |
  { 'RequiteItemNotFound' : null } |
  { 'CharacterNotFound' : null } |
  { 'CannotChoose' : null };
export interface Event {
  'quest_id' : string,
  'destiFloation_name' : string,
  'description' : string,
  'location_name' : string,
  'event_id' : string,
}
export interface Options {
  'gain_morale' : number,
  'risk_chance' : number,
  'loss_other' : string,
  'loss_stamina' : number,
  'gain_stamina' : number,
  'gain_hp' : number,
  'gain_by_luck' : string,
  'gain_exp' : number,
  'lucky_chance' : number,
  'description' : string,
  'loss_morale' : number,
  'loss_mana' : number,
  'loss_hp' : number,
  'option_id' : string,
  'gain_mana' : number,
  'require_item' : [] | [Array<string>],
  'event_id' : [] | [string],
  'gain_other' : string,
  'risk_lost' : string,
}
export interface Quest {
  'quest_id' : string,
  'description' : [] | [string],
  'image' : [] | [string],
  'price' : number,
  'quest_name' : string,
}
export interface Quest_Item {
  'strengh_require' : number,
  'name' : string,
  'quest_item_id' : string,
  'images' : [] | [string],
}
export interface Quest_Item_for_Quest {
  'quest_id' : string,
  'quest_item_for_quest_id' : string,
  'quest_item_id' : string,
}
export type Result = { 'ok' : null } |
  { 'err' : Error };
export type Result_1 = { 'ok' : Array<Character_take_Opton> } |
  { 'err' : Error };
export type Result_2 = { 'ok' : Character_Quest_Item } |
  { 'err' : Error };
export type Result_3 = { 'ok' : bigint } |
  { 'err' : Error };
export type Time = bigint;
export interface _SERVICE {
  'clear_data' : () => Promise<Result>,
  'count_Material' : (arg_0: string) => Promise<Result_3>,
  'createCharacter' : (
      arg_0: string,
      arg_1: string,
      arg_2: bigint,
      arg_3: number,
      arg_4: number,
      arg_5: number,
      arg_6: number,
      arg_7: number,
      arg_8: number,
      arg_9: number,
      arg_10: number,
      arg_11: number,
      arg_12: number,
      arg_13: number,
      arg_14: number,
      arg_15: number,
      arg_16: number,
    ) => Promise<Result>,
  'createCharacterTakeOptions' : (
      arg_0: string,
      arg_1: string,
      arg_2: Time,
      arg_3: number,
      arg_4: number,
      arg_5: number,
      arg_6: number,
      arg_7: number,
      arg_8: number,
      arg_9: number,
      arg_10: number,
    ) => Promise<Result>,
  'createCharacter_Quest_Item' : (
      arg_0: string,
      arg_1: Array<string>,
    ) => Promise<Result>,
  'createEvent' : (
      arg_0: string,
      arg_1: string,
      arg_2: string,
      arg_3: string,
    ) => Promise<Result>,
  'createMaterial' : (
      arg_0: string,
      arg_1: string,
      arg_2: [] | [string],
      arg_3: bigint,
    ) => Promise<Result>,
  'createOption' : (
      arg_0: string,
      arg_1: [] | [string],
      arg_2: [] | [Array<string>],
      arg_3: number,
      arg_4: number,
      arg_5: number,
      arg_6: number,
      arg_7: number,
      arg_8: string,
      arg_9: string,
      arg_10: number,
      arg_11: number,
      arg_12: number,
      arg_13: number,
      arg_14: number,
      arg_15: number,
      arg_16: string,
      arg_17: string,
    ) => Promise<Result>,
  'createQuest' : (
      arg_0: string,
      arg_1: number,
      arg_2: [] | [string],
      arg_3: [] | [string],
    ) => Promise<Result>,
  'createQuestItem' : (
      arg_0: string,
      arg_1: number,
      arg_2: [] | [string],
    ) => Promise<Result>,
  'createQuestItemforQuest' : (arg_0: string, arg_1: string) => Promise<Result>,
  'inforCharacter' : (arg_0: string) => Promise<[] | [Character]>,
  'inforCharacterQuestItem' : (arg_0: string) => Promise<Result_2>,
  'init_data' : () => Promise<Result>,
  'listCharacterTakeOption' : (arg_0: string) => Promise<Result_1>,
  'listEvent' : () => Promise<Array<Event>>,
  'listOptions' : () => Promise<Array<Options>>,
  'listQuest' : () => Promise<Array<Quest>>,
  'listQuestItem' : () => Promise<Array<Quest_Item>>,
  'listQuestItemforQuest' : () => Promise<Array<Quest_Item_for_Quest>>,
  'pos1_to_pos2' : (arg_0: string, arg_1: string) => Promise<Result>,
  'pos2_to_pos3' : (arg_0: string, arg_1: string) => Promise<Result>,
  'pos3_to_pos4' : (arg_0: string, arg_1: string) => Promise<Result>,
  'pos4_to_pos5' : (arg_0: string, arg_1: string) => Promise<Result>,
  'pos5_to_pos6' : (arg_0: string, arg_1: string) => Promise<Result>,
  'randomNat' : () => Promise<bigint>,
  'random_probability' : (arg_0: number) => Promise<boolean>,
  'updateCharacter' : (
      arg_0: string,
      arg_1: string,
      arg_2: string,
      arg_3: bigint,
      arg_4: number,
      arg_5: number,
      arg_6: number,
      arg_7: number,
      arg_8: number,
      arg_9: number,
      arg_10: number,
      arg_11: number,
      arg_12: number,
      arg_13: number,
      arg_14: number,
      arg_15: number,
      arg_16: number,
      arg_17: number,
    ) => Promise<Result>,
  'updateCharacter_Quest_Item' : (
      arg_0: string,
      arg_1: Array<string>,
    ) => Promise<Result>,
}
