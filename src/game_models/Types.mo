module {
  // User and User related___________________________________________
  public type User = {
    id: Text;
    name: Text;
    psswd: Text;
    number_of_characters: Nat;
    active_caller: ?Principal;
  };

  public type Inventory = {
    id: Text;             // same id with user id
    name: Text;
    size: Nat;
  };
  
  
  // Character and Character related_________________________________
  public type Character = {
      name: Text;
      lvl: Nat;
      classname: Text;
      cur_exp: Nat;
      next_exp: Nat;
      status: Text;

      cur_hp: Float;
      max_hp: Float;

      cur_mp: Float;
      max_mp: Float;

      cur_sta: Float;
      max_sta: Float;

      cur_morale: Float;
      max_morale: Float;

      str: Float;
      int: Float;
      vit: Float;
      lck: Float;

      ///////
      //////
  };


  // Character Class and Character Class related__________________________
  public type Character_Class = {
    name: Text;
    //specialid: [?Text]; // unkown useage as now
    description: Text;

    base_hp: Float;
    base_mp: Float;
    base_sta: Float;
    base_morale: Float;

    base_str: Float;
    base_vit: Float;
    base_int: Float;
    base_lck: Float;

  };

  // public type Special_Ability = { // unkown useage as now
  //   id: Text;
  //   name: Text;
  //   description: Text;
  //   required_mana: Nat;
  // };
  
  // Quest and Quest related_________________________________________
  public type Quest = {
    name: Text;
    price: Nat; 
    description: Text;
    image: Text;
  };


  public type Event = {
    questid: Text;
    description: Text;
    location_name: Text;
    destination_name: Text;
  };

  public type Option = {
    eventid: Text;
    description: Text;
    required_item: [Text];
    loss_sta: Float;
    loss_morale: Float;
    loss_hp: Float;
    loss_mp: Float;
    risk_chance: Float;
    risk_lost: Text;
    loss_other: Text;
    gain_sta: Float;
    gain_morale: Float;
    gain_hp: Float;
    gain_mp: Float;
    gain_exp: Nat;
    lucky_chance: Float;
    gain_by_luck: Text;
    gain_other: Text;
  };

  public type ChartakeOption = {
    charid: Text;
    optionid: Text;
    pickup_time: Int;
    char_cur_mp: Float;
    char_max_mp: Float;
    char_cur_sta: Float;
    char_max_sta: Float;
    char_cur_morale: Float;
    char_max_morale: Float;
    char_cur_hp: Float;
    char_max_hp: Float;
  };

	
  // Item____________________________________________________________
  public type Item = {
    name: Text;
    required_str: Float;
    image: Text;
  };

  public type ItemforQuest = {
    itemid: Text;
    questid: Text;
  };

  public type CharcarryingItem = {
    characterid: Text;
    itemid: Text;
  };
  
  // Material________________________________________________________
  public type Material = {
    name: Text;
    description: Text;
  };

  public type CharcollectMaterial = {
    characterid: Text;
    materialid: Text;
    amount: Int;
  };
  

  // Gear and Gear related___________________________________________
  public type CharwearingGear = {
    gearid: Text;
    classid: Text;
    lvl: Nat;
    rarityid: Text;
    substatid: [?Substat_Roll];
  };

  public type Gear = {
    id: Text;
    name: Text;
    description: Text;
    image: Text;
  };

  public type Gear_Class = {
    id: Text;
    name: Text;
    description: Text;
    max_lvl: Nat;
    main_stat: Effect;
  };

  public type Gear_Rarity = {
    id: Text;
    name: Text;
    description: Text;
    box_color: Text;
  };


  public type Substat_Roll = {
    substatid: Text;
    roll_value: Float;
  };

  public type Substat = {
    id: Text;
    description: Text; 
    sub_stat: Range_Effect;
  };

  public type Effect = {
    target: Text;
    amount: Int;
  };

  public type Range_Effect = {
    target: Text;
    from: Nat;
    to: Nat;
  };


  // other types________________________________________________________


  public type User_Creation = {
    username: Text;
    psswd: Text;
    re_psswd: Text;
  };

  public type User_Login = {
    username: Text;
    psswd: Text;
  };

  public type Character_Creation = {
    name: Text;
    classname: Text;
    userid: Text;
  };

  public type Character_Quick_Info = {
    name: Text;
    cur_hp: Float;
    max_hp: Float;
    cur_mp: Float;
    max_mp: Float;
    cur_sta: Float;
    max_sta: Float;
    cur_morale: Float;
    max_morale: Float;
    cur_exp: Nat;
    next_exp: Nat;
  };

  public type Event_Creation = {
    questname: Text;
    description: Text;
    location_name: Text;
    destination_name: Text;
  };

  public type Option_Creation = {
    questname: Text;
    location_name: Text;
    description: Text;
    required_item: Text;
    loss_sta: Float;
    loss_morale: Float;
    loss_hp: Float;
    loss_mp: Float;
    risk_chance: Float;
    risk_lost: Text;
    loss_other: Text;
    gain_sta: Float;
    gain_morale: Float;
    gain_hp: Float;
    gain_mp: Float;
    gain_exp: Nat;
    lucky_chance: Float;
    gain_by_luck: Text;
    gain_other: Text;
  };

  public type ChartakeOption_Creation = {
    charactername: Text;
    optionname: Text;
  };

  public type ItemforQuest_Creation = {
    itemname: Text;
    questname: Text;
  };

  public type CharcarryingItem_Creation = {
    charactername: Text;
    itemname: Text;
  };

  public type EventwithOptions_Info = {
    result: Text;
    nextevent:Text;
    options: [Text];
  };

  public type MaterialwithAmount_Info = {
    name: Text;
    description: Text;
    amount: Int;
  };


  public type QuestRequirements_Info = {
    questname: Text;
    price: Nat;
    required_items: [Text]; 
    starttext: Text;
  };

  public type CharacterBag = {
    item_capacity: Float;
    items: [Item];
    materials: [MaterialwithAmount_Info];
  };


  public type Error = {
    #AlreadyExists;
    #CharacterNotFound;
    #ClassNotFound;
    #NotAuthorized;
    #IncorectPassword;
    #NameAlreadyUsed;
    #AlreadyUsed;
    #UserNotFound;
    #QuestNotFound;
    #EventNotFound;
    #ItemNotFound;
    #OptionNotFound;
    #CharacterIsDead;
    #QuestIsFinished;
    #MaterialNotFound;
    #CharacterNotAvailable;
    #BagOutOfSpace;
    #NotMeetRequirement;
    #None;
  };
}