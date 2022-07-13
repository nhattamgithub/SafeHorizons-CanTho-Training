export const idlFactory = ({ IDL }) => {
  const Material_Amount = IDL.Record({
    'description' : IDL.Text,
    'amount' : IDL.Int,
    'materialname' : IDL.Text,
  });
  const Quest_Item_Info = IDL.Record({
    'strength_required' : IDL.Float64,
    'questitemname' : IDL.Text,
  });
  const Bag = IDL.Record({
    'material_amount' : IDL.Vec(Material_Amount),
    'items' : IDL.Vec(Quest_Item_Info),
    'capacity' : IDL.Float64,
  });
  const Error = IDL.Variant({
    'UserAlreadyExists' : IDL.Null,
    'CharacterAlreadyExists' : IDL.Null,
    'CharacterisDead' : IDL.Null,
    'Invalid' : IDL.Null,
    'BagOutOfSpace' : IDL.Null,
    'QuestIsCompleted' : IDL.Null,
    'QuestItemAlreadyExists' : IDL.Null,
    'IncorrectPassword' : IDL.Null,
    'QuestNotFound' : IDL.Null,
    'CharacterClassAlreadyExists' : IDL.Null,
    'NotFound' : IDL.Null,
    'OptionAlreadyExists' : IDL.Null,
    'NotQuestItemIsRequired' : IDL.Null,
    'InvalidOption' : IDL.Null,
    'NotAuthorized' : IDL.Null,
    'MaterialNotFound' : IDL.Null,
    'QuestItemNotFound' : IDL.Null,
    'AlreadyExists' : IDL.Null,
    'EventNotFound' : IDL.Null,
    'OptionNotFound' : IDL.Null,
    'EventAlreadyExists' : IDL.Null,
    'LimitedStrength' : IDL.Null,
    'CharacterNotFound' : IDL.Null,
    'CharacterClassNotFound' : IDL.Null,
    'UserNotFound' : IDL.Null,
    'QuestAlreadyExists' : IDL.Null,
  });
  const Result_3 = IDL.Variant({ 'ok' : Bag, 'err' : Error });
  const Character_Carrying_QuestItem_Creation = IDL.Record({
    'charactername' : IDL.Text,
    'questitem' : IDL.Text,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : Error });
  const Character_Info = IDL.Record({
    'curr_stamina' : IDL.Float64,
    'curr_morale' : IDL.Float64,
    'curr_hp' : IDL.Float64,
    'curr_mana' : IDL.Float64,
  });
  const Result_2 = IDL.Variant({ 'ok' : Character_Info, 'err' : Error });
  const Character_Take_Option_Creation = IDL.Record({
    'charactername' : IDL.Text,
    'description' : IDL.Text,
  });
  const Event_withOp = IDL.Record({
    'option_desc' : IDL.Vec(IDL.Text),
    'result_desc' : IDL.Text,
    'event_desc' : IDL.Text,
  });
  const Result_1 = IDL.Variant({ 'ok' : Event_withOp, 'err' : Error });
  const Quest_Info = IDL.Record({
    'required_item' : IDL.Vec(IDL.Text),
    'name' : IDL.Text,
    'description' : IDL.Text,
    'price' : IDL.Float64,
  });
  const Character_Creation = IDL.Record({
    'character_name' : IDL.Text,
    'user_id' : IDL.Text,
    'character_class_name' : IDL.Text,
  });
  const User_Creation = IDL.Record({
    'confirm' : IDL.Text,
    'username' : IDL.Text,
    'psswd' : IDL.Text,
  });
  const Character_Class = IDL.Record({
    'base_stamina' : IDL.Float64,
    'base_intelligent' : IDL.Float64,
    'base_hp' : IDL.Float64,
    'base_strength' : IDL.Float64,
    'description' : IDL.Text,
    'base_luck' : IDL.Float64,
    'base_mana' : IDL.Float64,
    'base_vitality' : IDL.Float64,
    'class_name' : IDL.Text,
    'base_morale' : IDL.Float64,
  });
  const Character_Carrying_QuestItem = IDL.Record({
    'questitemid' : IDL.Text,
    'characterid' : IDL.Text,
  });
  const Character_Collect_Material = IDL.Record({
    'materialid' : IDL.Text,
    'characterid' : IDL.Text,
    'amount' : IDL.Int,
  });
  const Character = IDL.Record({
    'id' : IDL.Text,
    'status' : IDL.Text,
    'max_stamina' : IDL.Float64,
    'max_mana' : IDL.Float64,
    'intelligent' : IDL.Float64,
    'luck' : IDL.Float64,
    'name' : IDL.Text,
    'current_stamina' : IDL.Float64,
    'lvlup_Exp' : IDL.Int,
    'level' : IDL.Int,
    'current_morale' : IDL.Float64,
    'current_Exp' : IDL.Int,
    'strength' : IDL.Float64,
    'class_name' : IDL.Text,
    'current_mana' : IDL.Float64,
    'max_hp' : IDL.Float64,
    'current_hp' : IDL.Float64,
    'current_questid' : IDL.Text,
    'max_morale' : IDL.Float64,
    'vitality' : IDL.Float64,
  });
  const Event = IDL.Record({
    'description' : IDL.Text,
    'questid' : IDL.Text,
    'location_name' : IDL.Text,
    'destination_name' : IDL.Text,
  });
  const Material = IDL.Record({ 'name' : IDL.Text, 'description' : IDL.Text });
  const Option = IDL.Record({
    'eventid' : IDL.Text,
    'gain_morale' : IDL.Float64,
    'risk_chance' : IDL.Float64,
    'loss_stamina' : IDL.Float64,
    'gain_stamina' : IDL.Float64,
    'gain_hp' : IDL.Float64,
    'gain_by_luck' : IDL.Text,
    'lost_other' : IDL.Text,
    'gain_exp' : IDL.Int,
    'lucky_chance' : IDL.Float64,
    'description' : IDL.Text,
    'loss_morale' : IDL.Float64,
    'loss_mana' : IDL.Float64,
    'loss_hp' : IDL.Float64,
    'gain_mana' : IDL.Float64,
    'require_item' : IDL.Vec(IDL.Text),
    'gain_other' : IDL.Text,
    'risk_lost' : IDL.Text,
  });
  const Quest_Item_For_Quest = IDL.Record({
    'questid' : IDL.Text,
    'quest_itemid' : IDL.Text,
  });
  const Quest_Item = IDL.Record({
    'strength_required' : IDL.Float64,
    'name' : IDL.Text,
    'image' : IDL.Text,
  });
  const Quest = IDL.Record({
    'name' : IDL.Text,
    'description' : IDL.Text,
    'image' : IDL.Text,
    'price' : IDL.Float64,
  });
  const User = IDL.Record({
    'id' : IDL.Text,
    'username' : IDL.Text,
    'password' : IDL.Text,
  });
  return IDL.Service({
    'Init' : IDL.Func([], [], []),
    'UI_Bag' : IDL.Func([IDL.Text], [Result_3], []),
    'UI_Character_Carrying_QuestItems' : IDL.Func(
        [Character_Carrying_QuestItem_Creation],
        [Result],
        [],
      ),
    'UI_Character_Info' : IDL.Func([IDL.Text], [Result_2], []),
    'UI_Character_Take_Option' : IDL.Func(
        [Character_Take_Option_Creation],
        [Result_1],
        [],
      ),
    'UI_Quest_Info' : IDL.Func([], [IDL.Vec(Quest_Info)], []),
    'create_Character' : IDL.Func([Character_Creation], [Result], []),
    'create_User' : IDL.Func([User_Creation], [Result], []),
    'show_character_classes' : IDL.Func(
        [],
        [IDL.Vec(Character_Class)],
        ['query'],
      ),
    'show_charactercarryingquestitems' : IDL.Func(
        [],
        [IDL.Vec(Character_Carrying_QuestItem)],
        ['query'],
      ),
    'show_charactercollectmaterials' : IDL.Func(
        [],
        [IDL.Vec(Character_Collect_Material)],
        ['query'],
      ),
    'show_characters' : IDL.Func([], [IDL.Vec(Character)], ['query']),
    'show_events' : IDL.Func([], [IDL.Vec(Event)], ['query']),
    'show_materials' : IDL.Func([], [IDL.Vec(Material)], ['query']),
    'show_options' : IDL.Func([], [IDL.Vec(Option)], ['query']),
    'show_questitemforquests' : IDL.Func(
        [],
        [IDL.Vec(Quest_Item_For_Quest)],
        ['query'],
      ),
    'show_questitems' : IDL.Func([], [IDL.Vec(Quest_Item)], ['query']),
    'show_quests' : IDL.Func([], [IDL.Vec(Quest)], ['query']),
    'show_users' : IDL.Func([], [IDL.Vec(User)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
