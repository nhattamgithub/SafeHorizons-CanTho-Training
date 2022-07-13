import type { Principal } from '@dfinity/principal';
export interface Character {
  'next_exp' : bigint,
  'int' : number,
  'lck' : number,
  'lvl' : bigint,
  'str' : number,
  'vit' : number,
  'status' : string,
  'cur_hp' : number,
  'cur_mp' : number,
  'name' : string,
  'cur_morale' : number,
  'max_hp' : number,
  'max_mp' : number,
  'cur_exp' : bigint,
  'cur_sta' : number,
  'max_sta' : number,
  'max_morale' : number,
  'classname' : string,
}
export interface CharacterBag {
  'item_capacity' : number,
  'materials' : Array<MaterialwithAmount_Info>,
  'items' : Array<Item__1>,
}
export interface Character_Class {
  'base_int' : number,
  'base_lck' : number,
  'base_sta' : number,
  'base_str' : number,
  'base_vit' : number,
  'base_hp' : number,
  'base_mp' : number,
  'name' : string,
  'description' : string,
  'base_morale' : number,
}
export interface Character_Creation {
  'userid' : string,
  'name' : string,
  'classname' : string,
}
export interface Character_Quick_Info {
  'next_exp' : bigint,
  'cur_hp' : number,
  'cur_mp' : number,
  'name' : string,
  'cur_morale' : number,
  'max_hp' : number,
  'max_mp' : number,
  'cur_exp' : bigint,
  'cur_sta' : number,
  'max_sta' : number,
  'max_morale' : number,
}
export interface CharcarryingItem { 'itemid' : string, 'characterid' : string }
export interface CharcarryingItem_Creation {
  'charactername' : string,
  'itemname' : string,
}
export interface CharcollectMaterial {
  'materialid' : string,
  'characterid' : string,
  'amount' : bigint,
}
export interface ChartakeOption {
  'char_cur_hp' : number,
  'char_cur_mp' : number,
  'char_max_morale' : number,
  'optionid' : string,
  'pickup_time' : bigint,
  'char_max_hp' : number,
  'char_max_mp' : number,
  'char_cur_sta' : number,
  'char_max_sta' : number,
  'char_cur_morale' : number,
  'charid' : string,
}
export interface ChartakeOption_Creation {
  'charactername' : string,
  'optionname' : string,
}
export type Error = { 'NotMeetRequirement' : null } |
  { 'BagOutOfSpace' : null } |
  { 'None' : null } |
  { 'CharacterIsDead' : null } |
  { 'ItemNotFound' : null } |
  { 'QuestNotFound' : null } |
  { 'ClassNotFound' : null } |
  { 'NotAuthorized' : null } |
  { 'MaterialNotFound' : null } |
  { 'IncorectPassword' : null } |
  { 'AlreadyExists' : null } |
  { 'QuestIsFinished' : null } |
  { 'EventNotFound' : null } |
  { 'OptionNotFound' : null } |
  { 'NameAlreadyUsed' : null } |
  { 'CharacterNotFound' : null } |
  { 'CharacterNotAvailable' : null } |
  { 'UserNotFound' : null } |
  { 'AlreadyUsed' : null };
export interface Event {
  'description' : string,
  'questid' : string,
  'location_name' : string,
  'destination_name' : string,
}
export interface EventwithOptions_Info {
  'result' : string,
  'nextevent' : string,
  'options' : Array<string>,
}
export interface Item {
  'name' : string,
  'required_str' : number,
  'image' : string,
}
export interface Item__1 {
  'name' : string,
  'required_str' : number,
  'image' : string,
}
export interface ItemforQuest { 'itemid' : string, 'questid' : string }
export interface Material { 'name' : string, 'description' : string }
export interface MaterialwithAmount_Info {
  'name' : string,
  'description' : string,
  'amount' : bigint,
}
export interface Option {
  'eventid' : string,
  'gain_morale' : number,
  'risk_chance' : number,
  'required_item' : Array<string>,
  'loss_other' : string,
  'gain_hp' : number,
  'gain_mp' : number,
  'gain_by_luck' : string,
  'gain_exp' : bigint,
  'gain_sta' : number,
  'lucky_chance' : number,
  'description' : string,
  'loss_morale' : number,
  'loss_hp' : number,
  'loss_mp' : number,
  'loss_sta' : number,
  'gain_other' : string,
  'risk_lost' : string,
}
export interface Quest {
  'name' : string,
  'description' : string,
  'image' : string,
  'price' : bigint,
}
export interface QuestRequirements_Info {
  'starttext' : string,
  'required_items' : Array<string>,
  'questname' : string,
  'price' : bigint,
}
export type Result = { 'ok' : null } |
  { 'err' : Error };
export type Result_1 = { 'ok' : EventwithOptions_Info } |
  { 'err' : Error };
export type Result_2 = { 'ok' : Character_Quick_Info } |
  { 'err' : Error };
export type Result_3 = { 'ok' : CharacterBag } |
  { 'err' : Error };
export interface User {
  'id' : string,
  'number_of_characters' : bigint,
  'active_caller' : [] | [Principal],
  'name' : string,
  'psswd' : string,
}
export interface User_Creation {
  'username' : string,
  're_psswd' : string,
  'psswd' : string,
}
export interface User_Login { 'username' : string, 'psswd' : string }
export interface _SERVICE {
  'INIT' : () => Promise<undefined>,
  'UI_CharacterBag' : (arg_0: string) => Promise<Result_3>,
  'UI_CharacterQuickInfo' : (arg_0: string) => Promise<Result_2>,
  'UI_CharactertakeOption' : (arg_0: ChartakeOption_Creation) => Promise<
      Result_1
    >,
  'UI_QuestRequirements' : () => Promise<Array<QuestRequirements_Info>>,
  'UI_quitQuest' : (arg_0: string) => Promise<Result>,
  'createCharacter' : (arg_0: Character_Creation) => Promise<Result>,
  'createCharcarryingItem' : (arg_0: CharcarryingItem_Creation) => Promise<
      Result
    >,
  'createUser' : (arg_0: User_Creation) => Promise<Result>,
  'loginUser' : (arg_0: User_Login) => Promise<Result>,
  'logoutUser' : (arg_0: string) => Promise<Result>,
  'showCharacter_Classes' : () => Promise<Array<Character_Class>>,
  'showCharacters' : () => Promise<Array<Character>>,
  'showCharscarryingItems' : () => Promise<Array<CharcarryingItem>>,
  'showCharscollectMaterials' : () => Promise<Array<CharcollectMaterial>>,
  'showCharstakeOptions' : () => Promise<Array<ChartakeOption>>,
  'showEvents' : () => Promise<Array<Event>>,
  'showItems' : () => Promise<Array<Item>>,
  'showItemsforQuests' : () => Promise<Array<ItemforQuest>>,
  'showMaterials' : () => Promise<Array<Material>>,
  'showOptions' : () => Promise<Array<Option>>,
  'showQuests' : () => Promise<Array<Quest>>,
  'showUsers' : () => Promise<Array<User>>,
}
