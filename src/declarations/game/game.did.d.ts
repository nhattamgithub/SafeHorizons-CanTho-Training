import type { Principal } from '@dfinity/principal';
export interface Bag {
  'material_amount' : Array<Material_Amount>,
  'items' : Array<Quest_Item_Info>,
  'capacity' : number,
}
export interface Character {
  'id' : string,
  'status' : string,
  'max_stamina' : number,
  'max_mana' : number,
  'intelligent' : number,
  'luck' : number,
  'name' : string,
  'current_stamina' : number,
  'lvlup_Exp' : bigint,
  'level' : bigint,
  'current_morale' : number,
  'current_Exp' : bigint,
  'strength' : number,
  'class_name' : string,
  'current_mana' : number,
  'max_hp' : number,
  'current_hp' : number,
  'current_questid' : string,
  'max_morale' : number,
  'vitality' : number,
}
export interface Character_Carrying_QuestItem {
  'questitemid' : string,
  'characterid' : string,
}
export interface Character_Carrying_QuestItem_Creation {
  'charactername' : string,
  'questitem' : string,
}
export interface Character_Class {
  'base_stamina' : number,
  'base_intelligent' : number,
  'base_hp' : number,
  'base_strength' : number,
  'description' : string,
  'base_luck' : number,
  'base_mana' : number,
  'base_vitality' : number,
  'class_name' : string,
  'base_morale' : number,
}
export interface Character_Collect_Material {
  'materialid' : string,
  'characterid' : string,
  'amount' : bigint,
}
export interface Character_Creation {
  'character_name' : string,
  'user_id' : string,
  'character_class_name' : string,
}
export interface Character_Info {
  'curr_stamina' : number,
  'curr_morale' : number,
  'curr_hp' : number,
  'curr_mana' : number,
}
export interface Character_Take_Option_Creation {
  'charactername' : string,
  'description' : string,
}
export type Error = { 'UserAlreadyExists' : null } |
  { 'CharacterAlreadyExists' : null } |
  { 'CharacterisDead' : null } |
  { 'Invalid' : null } |
  { 'BagOutOfSpace' : null } |
  { 'QuestIsCompleted' : null } |
  { 'QuestItemAlreadyExists' : null } |
  { 'IncorrectPassword' : null } |
  { 'QuestNotFound' : null } |
  { 'CharacterClassAlreadyExists' : null } |
  { 'NotFound' : null } |
  { 'OptionAlreadyExists' : null } |
  { 'NotQuestItemIsRequired' : null } |
  { 'InvalidOption' : null } |
  { 'NotAuthorized' : null } |
  { 'MaterialNotFound' : null } |
  { 'QuestItemNotFound' : null } |
  { 'AlreadyExists' : null } |
  { 'EventNotFound' : null } |
  { 'OptionNotFound' : null } |
  { 'EventAlreadyExists' : null } |
  { 'LimitedStrength' : null } |
  { 'CharacterNotFound' : null } |
  { 'CharacterClassNotFound' : null } |
  { 'UserNotFound' : null } |
  { 'QuestAlreadyExists' : null };
export interface Event {
  'description' : string,
  'questid' : string,
  'location_name' : string,
  'destination_name' : string,
}
export interface Event_withOp {
  'option_desc' : Array<string>,
  'result_desc' : string,
  'event_desc' : string,
}
export interface Material { 'name' : string, 'description' : string }
export interface Material_Amount {
  'description' : string,
  'amount' : bigint,
  'materialname' : string,
}
export interface Option {
  'eventid' : string,
  'gain_morale' : number,
  'risk_chance' : number,
  'loss_stamina' : number,
  'gain_stamina' : number,
  'gain_hp' : number,
  'gain_by_luck' : string,
  'lost_other' : string,
  'gain_exp' : bigint,
  'lucky_chance' : number,
  'description' : string,
  'loss_morale' : number,
  'loss_mana' : number,
  'loss_hp' : number,
  'gain_mana' : number,
  'require_item' : Array<string>,
  'gain_other' : string,
  'risk_lost' : string,
}
export interface Quest {
  'name' : string,
  'description' : string,
  'image' : string,
  'price' : number,
}
export interface Quest_Info {
  'required_item' : Array<string>,
  'name' : string,
  'description' : string,
  'price' : number,
}
export interface Quest_Item {
  'strength_required' : number,
  'name' : string,
  'image' : string,
}
export interface Quest_Item_For_Quest {
  'questid' : string,
  'quest_itemid' : string,
}
export interface Quest_Item_Info {
  'strength_required' : number,
  'questitemname' : string,
}
export type Result = { 'ok' : null } |
  { 'err' : Error };
export type Result_1 = { 'ok' : Event_withOp } |
  { 'err' : Error };
export type Result_2 = { 'ok' : Character_Info } |
  { 'err' : Error };
export type Result_3 = { 'ok' : Bag } |
  { 'err' : Error };
export interface User {
  'id' : string,
  'username' : string,
  'password' : string,
}
export interface User_Creation {
  'confirm' : string,
  'username' : string,
  'psswd' : string,
}
export interface _SERVICE {
  'Init' : () => Promise<undefined>,
  'UI_Bag' : (arg_0: string) => Promise<Result_3>,
  'UI_Character_Carrying_QuestItems' : (
      arg_0: Character_Carrying_QuestItem_Creation,
    ) => Promise<Result>,
  'UI_Character_Info' : (arg_0: string) => Promise<Result_2>,
  'UI_Character_Take_Option' : (
      arg_0: Character_Take_Option_Creation,
    ) => Promise<Result_1>,
  'UI_Quest_Info' : () => Promise<Array<Quest_Info>>,
  'create_Character' : (arg_0: Character_Creation) => Promise<Result>,
  'create_User' : (arg_0: User_Creation) => Promise<Result>,
  'show_character_classes' : () => Promise<Array<Character_Class>>,
  'show_charactercarryingquestitems' : () => Promise<
      Array<Character_Carrying_QuestItem>
    >,
  'show_charactercollectmaterials' : () => Promise<
      Array<Character_Collect_Material>
    >,
  'show_characters' : () => Promise<Array<Character>>,
  'show_events' : () => Promise<Array<Event>>,
  'show_materials' : () => Promise<Array<Material>>,
  'show_options' : () => Promise<Array<Option>>,
  'show_questitemforquests' : () => Promise<Array<Quest_Item_For_Quest>>,
  'show_questitems' : () => Promise<Array<Quest_Item>>,
  'show_quests' : () => Promise<Array<Quest>>,
  'show_users' : () => Promise<Array<User>>,
}
