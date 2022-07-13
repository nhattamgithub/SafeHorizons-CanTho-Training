import Time "mo:base/Time";

module {
    public type Error = {
        #QuestItemNameAlready;
        #QuestNameAlready;
        #CharacterNameAlready;
        #QuestNotFound;
        #QuestItemNotFound;
        #EventNotFound;
        #ChooseOptionNotFound;
        #CannotChoose;
        #OptionNotFound;
        #RequiteItemNotFound;
        #CharacterNotFound;
        #MaterialNotFound;
        #CharacterQuestItemNotFound;
        #NotFound;
    };

    public type User = {
        user_id : Text;
        username : Text;
        password : Text;
    };

    public type Inventory = {
        id : Text;
        name : Text;
        size : Float;
    };

    public type Character = {
        character_id : Text;
        name : Text;
        character_class : Text;
        level : Nat;
        current_exp: Float;
        level_up_exp: Float;
        current_stamina: Float;
        max_stamina : Float;
        current_morale : Float;
        max_morale : Float;
        current_hp : Float;
        max_hp : Float;
        current_mana : Float;
        max_mana : Float;
        strength: Float;
        vitality: Float;
        intelligent: Float;
        luck : Float;
    };

    public type CharacterClass = {
        class_id : Text;
        class_name : Text;
        special_ability: Text;
        description: Text;
    };

    public type Character_take_Opton = {
        character_id : Text;
        option_id : Text;
        pickup_time : Time.Time;
        char_curr_mana : Float;
        char_max_mana : Float;
        char_curr_stamina : Float;
        char_max_stamina : Float;
        char_curr_morale : Float;
        char_max_morale : Float;
        char_curr_hp : Float;
        char_max_hp : Float;

    };

    public type Quest = {
        quest_id : Text;
        quest_name : Text;
        price : Float;
        description : ?Text;
        image : ?Text;
    };

    public type Quest_Item = {
        quest_item_id : Text;
        name: Text;
        strengh_require : Float;
        images : ?Text;
    };

    public type Quest_Item_for_Quest = {
        quest_item_for_quest_id : Text;
        quest_item_id : Text;
        quest_id : Text;
    };


    public type Gear ={
        id : Text;
        name : Text;
        description: Text;
        image : Text;
    };

    public type GearClass = {
        id : Text;
        class_name : Text;
        description : Text;
        main_stat : Float;
    };

    public type GearRarity = {
        id : Text;
        rarity_name : Text;
        description : Text;
        main_stat : Float;
    };
    
    public type Substat = {
        id : Text;
        substat : Float;
        description : Text;
    };

    public type Item = {
        id : Float;
        name : Text;
        description : Text;
    };

    public type Event = {
        event_id : Text;
        quest_id : Text;
        description : Text;
        location_name : Text;
        destiFloation_name : Text;
    };

    public type Options = {
        option_id : Text;
        description : Text;
        event_id : ?Text;
        require_item : ?[Text];
        loss_stamina : Float;
        loss_morale : Float;
        loss_hp : Float;
        loss_mana : Float;
        risk_chance : Float;
        risk_lost : Text;
        loss_other : Text;
        gain_stamina : Float;
        gain_morale : Float;
        gain_hp :Float;
        gain_mana : Float;
        gain_exp: Float;
        lucky_chance : Float;
        gain_by_luck : Text;
        gain_other : Text;
    };



    public type DetailLoss = {
        id : Text;
        description : Text;
        stat_loss : Float;
    };

    public type DetailGain = {
        id : Text;
        description : Text;
        stat_gain : Float;
    };

    public type Material = {
        id : Text;
        name : Text;
        description : ?Text;
        quantity: Nat;
    };

    public type Character_Quest_Item  = {
        character_id: Text;
        list_quest_item: [Text];
    };
}

