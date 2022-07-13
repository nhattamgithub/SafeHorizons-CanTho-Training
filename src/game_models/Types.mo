module {

  //User and related-----------------
  public type User = {
    id : Text;
    username : Text;
    password : Text;
  };
  public type Inventory = {
    id : Text;              // giong voi id cua user
    inventory_name : Text;
    size : Int; 
  };

  //Character and related------------
  public type Character = {
    id : Text;
    name : Text;
    class_name : Text;
    level : Int;
    current_Exp : Int;
    lvlup_Exp : Int;
    status : Text;

    current_hp : Float;
    max_hp : Float;
    current_mana : Float;
    max_mana : Float;
    current_stamina : Float;
    max_stamina : Float;
    current_morale : Float;
    max_morale : Float;

    strength : Float;
    intelligent : Float;
    vitality : Float;
    luck : Float;

    //participate
    current_questid : Text;
  };

  public type Character_Class = {
    class_name : Text;
    //special_abilityid : [?Text];
    description : Text;

    base_mana : Float;
    base_stamina : Float;
    base_morale : Float;
    base_hp : Float;

    base_strength : Float;
    base_intelligent : Float;
    base_vitality : Float;
    base_luck : Float;
  };

  // public type Special_Ability = {
  //   id : Text;
  //   name : Text;
  //   description : Text;
  //   required_mana : ?Nat;
  // };

  //Material------------------------
  public type Material = {
    name : Text;
    description : Text;
  };

  public type Character_Collect_Material = {
    characterid : Text;
    materialid : Text;
    amount : Int;
  };

  //Quest and related---------------
  public type Quest = {
    name : Text;
    price : Float;
    description : Text;
    image : Text;
  };

  public type Quest_Info = {
    name : Text;
    price : Float;
    description : Text;
    required_item : [Text];
  };

  public type Quest_Item_For_Quest = {
    questid : Text;
    quest_itemid : Text;
  };

  public type Quest_Item = {
    name : Text;
    strength_required : Float;
    image : Text;    
  };

  public type Character_Carrying_QuestItem = {
    characterid : Text;
    questitemid : Text;
  };

  public type Event = {
    questid : Text;
    description : Text;
    location_name : Text;
    destination_name : Text;   
  };

  public type Option = {
    eventid : Text;
    description : Text;
    require_item : [Text];
    loss_stamina : Float;
    loss_morale : Float;
    loss_hp : Float;
    loss_mana : Float;
    risk_chance : Float;
    risk_lost : Text;
    lost_other : Text;
    gain_stamina : Float;
    gain_morale : Float;
    gain_hp : Float;
    gain_mana : Float;
    gain_exp : Int;
    lucky_chance : Float;
    gain_by_luck : Text;
    gain_other : Text;
  };

  public type Character_Take_Option = {
    characterid : Text;
    optionid : Text;
    pickuptime : Int;
    char_current_hp : Float;
    char_max_hp : Float;
    char_current_mana : Float;
    char_max_mana : Float;
    char_current_stamina : Float;
    char_max_stamina : Float;
    char_current_morale : Float;
    char_max_morale : Float;
  };

  //Gear and related----------------
  public type Gear = {
    id : Text;
    gear_name : Text;
    description : Text;
    image : Text;

    level : Nat; 

    gear_classid : Text;
    gear_rarityid : Text;
    substatid : [?Substat_Roll]; 
  };
  public type Gear_Class = {
    id : Text;
    class_name : Text;
    description : Text;
    main_stat : Stat;

    max_level : Nat;
  };
  public type Gear_Rarity = {
    id : Text;
    rarity_name : Text;
    description : Text;
    box_color : Text;
  };
  public type Substat = {
    id : Text;
    description : Text;
    substat : ?Range_Stat;
  };

  public type Substat_Roll = {
    substatid : Text;
    roll_value : Nat;
  };

  //Other methods---------------
  public type User_Creation = {
    username : Text;
    psswd : Text;
    confirm : Text;
  };  

  public type Character_Creation = {
    user_id : Text;
    character_name : Text;
    character_class_name : Text;
  };

  public type Event_Creation = {
    questname : Text;
    description : Text;
    location_name : Text;
    destination_name : Text;   
  };

  public type Character_Carrying_QuestItem_Creation = {
    charactername : Text;
    questitem : Text;
  };

  public type Quest_Item_For_Quest_Creation = {
    questname : Text;
    quest_itemname : Text;
  };

  public type Option_Creation = {
    questname : Text;
    location_name : Text;
    description : Text;
    require_item : [Text];
    loss_stamina : Float;
    loss_morale : Float;
    loss_hp : Float;
    loss_mana : Float;
    risk_chance : Float;
    risk_lost : Text;
    lost_other : Text;
    gain_stamina : Float;
    gain_morale : Float;
    gain_hp : Float;
    gain_mana : Float;
    gain_exp : Int;
    lucky_chance : Float;
    gain_by_luck : Text;
    gain_other : Text;
  };

  public type Character_Take_Option_Creation = {
    charactername : Text;
    description : Text;
  };

  public type Character_Info = {
    curr_hp : Float;
    curr_mana : Float;
    curr_stamina : Float;
    curr_morale : Float;
  };

  public type Event_withOp = {
    result_desc : Text;
    event_desc : Text;
    option_desc : [Text];
  };

  public type Bag = {
    material_amount : [Material_Amount];
    items : [Quest_Item_Info];
    capacity : Float;
  };

  public type Material_Amount = {
    materialname : Text;
    description : Text;
    amount : Int;
  };

  public type Quest_Item_Info = {
    questitemname : Text;
    strength_required : Float;
  };

  public type Stat = {
    target : Text;
    amount : Int;
  };

  public type Range_Stat = {
    target : Text;
    from : Nat;
    to : Nat;
  };

  public type Error = {
    #IncorrectPassword;
    #NotAuthorized;
    #UserNotFound;
    #UserAlreadyExists;

    #CharacterNotFound;
    #CharacterAlreadyExists;
    #CharacterisDead;

    #CharacterClassNotFound;
    #CharacterClassAlreadyExists;

    #MaterialNotFound;

    #QuestNotFound;
	  #QuestAlreadyExists;
	
	  #QuestItemNotFound;
	  #QuestItemAlreadyExists;

    #EventNotFound;
    #EventAlreadyExists;

    #OptionNotFound;
    #OptionAlreadyExists;

    #NotFound;
    #Invalid;
    #AlreadyExists;

    #LimitedStrength;
    #BagOutOfSpace;
    #NotQuestItemIsRequired;

    #InvalidOption;
    #QuestIsCompleted;
  };
}