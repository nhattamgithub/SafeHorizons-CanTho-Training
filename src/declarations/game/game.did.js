export const idlFactory = ({ IDL }) => {
  const MaterialwithAmount_Info = IDL.Record({
    'name' : IDL.Text,
    'description' : IDL.Text,
    'amount' : IDL.Int,
  });
  const Item__1 = IDL.Record({
    'name' : IDL.Text,
    'required_str' : IDL.Float64,
    'image' : IDL.Text,
  });
  const CharacterBag = IDL.Record({
    'item_capacity' : IDL.Float64,
    'materials' : IDL.Vec(MaterialwithAmount_Info),
    'items' : IDL.Vec(Item__1),
  });
  const Error = IDL.Variant({
    'NotMeetRequirement' : IDL.Null,
    'BagOutOfSpace' : IDL.Null,
    'None' : IDL.Null,
    'CharacterIsDead' : IDL.Null,
    'ItemNotFound' : IDL.Null,
    'QuestNotFound' : IDL.Null,
    'ClassNotFound' : IDL.Null,
    'NotAuthorized' : IDL.Null,
    'MaterialNotFound' : IDL.Null,
    'IncorectPassword' : IDL.Null,
    'AlreadyExists' : IDL.Null,
    'QuestIsFinished' : IDL.Null,
    'EventNotFound' : IDL.Null,
    'OptionNotFound' : IDL.Null,
    'NameAlreadyUsed' : IDL.Null,
    'CharacterNotFound' : IDL.Null,
    'CharacterNotAvailable' : IDL.Null,
    'UserNotFound' : IDL.Null,
    'AlreadyUsed' : IDL.Null,
  });
  const Result_3 = IDL.Variant({ 'ok' : CharacterBag, 'err' : Error });
  const Character_Quick_Info = IDL.Record({
    'next_exp' : IDL.Nat,
    'cur_hp' : IDL.Float64,
    'cur_mp' : IDL.Float64,
    'name' : IDL.Text,
    'cur_morale' : IDL.Float64,
    'max_hp' : IDL.Float64,
    'max_mp' : IDL.Float64,
    'cur_exp' : IDL.Nat,
    'cur_sta' : IDL.Float64,
    'max_sta' : IDL.Float64,
    'max_morale' : IDL.Float64,
  });
  const Result_2 = IDL.Variant({ 'ok' : Character_Quick_Info, 'err' : Error });
  const ChartakeOption_Creation = IDL.Record({
    'charactername' : IDL.Text,
    'optionname' : IDL.Text,
  });
  const EventwithOptions_Info = IDL.Record({
    'result' : IDL.Text,
    'nextevent' : IDL.Text,
    'options' : IDL.Vec(IDL.Text),
  });
  const Result_1 = IDL.Variant({ 'ok' : EventwithOptions_Info, 'err' : Error });
  const QuestRequirements_Info = IDL.Record({
    'starttext' : IDL.Text,
    'required_items' : IDL.Vec(IDL.Text),
    'questname' : IDL.Text,
    'price' : IDL.Nat,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : Error });
  const Character_Creation = IDL.Record({
    'userid' : IDL.Text,
    'name' : IDL.Text,
    'classname' : IDL.Text,
  });
  const CharcarryingItem_Creation = IDL.Record({
    'charactername' : IDL.Text,
    'itemname' : IDL.Text,
  });
  const User_Creation = IDL.Record({
    'username' : IDL.Text,
    're_psswd' : IDL.Text,
    'psswd' : IDL.Text,
  });
  const User_Login = IDL.Record({ 'username' : IDL.Text, 'psswd' : IDL.Text });
  const Character_Class = IDL.Record({
    'base_int' : IDL.Float64,
    'base_lck' : IDL.Float64,
    'base_sta' : IDL.Float64,
    'base_str' : IDL.Float64,
    'base_vit' : IDL.Float64,
    'base_hp' : IDL.Float64,
    'base_mp' : IDL.Float64,
    'name' : IDL.Text,
    'description' : IDL.Text,
    'base_morale' : IDL.Float64,
  });
  const Character = IDL.Record({
    'next_exp' : IDL.Nat,
    'int' : IDL.Float64,
    'lck' : IDL.Float64,
    'lvl' : IDL.Nat,
    'str' : IDL.Float64,
    'vit' : IDL.Float64,
    'status' : IDL.Text,
    'cur_hp' : IDL.Float64,
    'cur_mp' : IDL.Float64,
    'name' : IDL.Text,
    'cur_morale' : IDL.Float64,
    'max_hp' : IDL.Float64,
    'max_mp' : IDL.Float64,
    'cur_exp' : IDL.Nat,
    'cur_sta' : IDL.Float64,
    'max_sta' : IDL.Float64,
    'max_morale' : IDL.Float64,
    'classname' : IDL.Text,
  });
  const CharcarryingItem = IDL.Record({
    'itemid' : IDL.Text,
    'characterid' : IDL.Text,
  });
  const CharcollectMaterial = IDL.Record({
    'materialid' : IDL.Text,
    'characterid' : IDL.Text,
    'amount' : IDL.Int,
  });
  const ChartakeOption = IDL.Record({
    'char_cur_hp' : IDL.Float64,
    'char_cur_mp' : IDL.Float64,
    'char_max_morale' : IDL.Float64,
    'optionid' : IDL.Text,
    'pickup_time' : IDL.Int,
    'char_max_hp' : IDL.Float64,
    'char_max_mp' : IDL.Float64,
    'char_cur_sta' : IDL.Float64,
    'char_max_sta' : IDL.Float64,
    'char_cur_morale' : IDL.Float64,
    'charid' : IDL.Text,
  });
  const Event = IDL.Record({
    'description' : IDL.Text,
    'questid' : IDL.Text,
    'location_name' : IDL.Text,
    'destination_name' : IDL.Text,
  });
  const Item = IDL.Record({
    'name' : IDL.Text,
    'required_str' : IDL.Float64,
    'image' : IDL.Text,
  });
  const ItemforQuest = IDL.Record({
    'itemid' : IDL.Text,
    'questid' : IDL.Text,
  });
  const Material = IDL.Record({ 'name' : IDL.Text, 'description' : IDL.Text });
  const Option = IDL.Record({
    'eventid' : IDL.Text,
    'gain_morale' : IDL.Float64,
    'risk_chance' : IDL.Float64,
    'required_item' : IDL.Vec(IDL.Text),
    'loss_other' : IDL.Text,
    'gain_hp' : IDL.Float64,
    'gain_mp' : IDL.Float64,
    'gain_by_luck' : IDL.Text,
    'gain_exp' : IDL.Nat,
    'gain_sta' : IDL.Float64,
    'lucky_chance' : IDL.Float64,
    'description' : IDL.Text,
    'loss_morale' : IDL.Float64,
    'loss_hp' : IDL.Float64,
    'loss_mp' : IDL.Float64,
    'loss_sta' : IDL.Float64,
    'gain_other' : IDL.Text,
    'risk_lost' : IDL.Text,
  });
  const Quest = IDL.Record({
    'name' : IDL.Text,
    'description' : IDL.Text,
    'image' : IDL.Text,
    'price' : IDL.Nat,
  });
  const User = IDL.Record({
    'id' : IDL.Text,
    'number_of_characters' : IDL.Nat,
    'active_caller' : IDL.Opt(IDL.Principal),
    'name' : IDL.Text,
    'psswd' : IDL.Text,
  });
  return IDL.Service({
    'INIT' : IDL.Func([], [], []),
    'UI_CharacterBag' : IDL.Func([IDL.Text], [Result_3], []),
    'UI_CharacterQuickInfo' : IDL.Func([IDL.Text], [Result_2], []),
    'UI_CharactertakeOption' : IDL.Func(
        [ChartakeOption_Creation],
        [Result_1],
        [],
      ),
    'UI_QuestRequirements' : IDL.Func(
        [],
        [IDL.Vec(QuestRequirements_Info)],
        ['query'],
      ),
    'UI_quitQuest' : IDL.Func([IDL.Text], [Result], []),
    'createCharacter' : IDL.Func([Character_Creation], [Result], []),
    'createCharcarryingItem' : IDL.Func(
        [CharcarryingItem_Creation],
        [Result],
        [],
      ),
    'createUser' : IDL.Func([User_Creation], [Result], []),
    'loginUser' : IDL.Func([User_Login], [Result], []),
    'logoutUser' : IDL.Func([IDL.Text], [Result], []),
    'showCharacter_Classes' : IDL.Func(
        [],
        [IDL.Vec(Character_Class)],
        ['query'],
      ),
    'showCharacters' : IDL.Func([], [IDL.Vec(Character)], ['query']),
    'showCharscarryingItems' : IDL.Func(
        [],
        [IDL.Vec(CharcarryingItem)],
        ['query'],
      ),
    'showCharscollectMaterials' : IDL.Func(
        [],
        [IDL.Vec(CharcollectMaterial)],
        ['query'],
      ),
    'showCharstakeOptions' : IDL.Func([], [IDL.Vec(ChartakeOption)], ['query']),
    'showEvents' : IDL.Func([], [IDL.Vec(Event)], ['query']),
    'showItems' : IDL.Func([], [IDL.Vec(Item)], ['query']),
    'showItemsforQuests' : IDL.Func([], [IDL.Vec(ItemforQuest)], ['query']),
    'showMaterials' : IDL.Func([], [IDL.Vec(Material)], ['query']),
    'showOptions' : IDL.Func([], [IDL.Vec(Option)], ['query']),
    'showQuests' : IDL.Func([], [IDL.Vec(Quest)], ['query']),
    'showUsers' : IDL.Func([], [IDL.Vec(User)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
