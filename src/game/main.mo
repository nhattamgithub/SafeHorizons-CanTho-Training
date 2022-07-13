import Array "mo:base/Array";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat8 "mo:base/Nat8";
import Random "mo:base/Random";
import Result "mo:base/Result";
import State "../game_models/State";
import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";
import Types "../game_models/Types";
import Time "mo:base/Time";
import Debug "mo:base/Debug";

import AsyncSource "mo:uuid/async/SourceV4";
import UUID "mo:uuid/UUID";

actor {
    var state : State.State  = State.empty();

    var length_id : Float = 4;

    // private func createId(): async Text {
    //     var res : Text = "";
    //     var characters : Text = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    //     var size = Text.size(characters);
    //     var characters_array : [Char] = [];
    //     for (i in characters.chars()){
    //         characters_array := Array.append(characters_array, [i]);
    //     };
    //     for (i in Iter.range(0, length_id-1)){
    //         var n : Nat8 = await randomFloat();
    //         res := res # Char.toText(characters_array[Float8.toFloat(n)%size]);
    //     };
    //     return res;
    // };

    public func randomNat() : async Nat {
        var b : Blob = await Random.blob();
        return Nat8.toNat(Random.byteFrom(b));
    };
    private func createId() : async Text {
        var ae  = AsyncSource.Source();
        var id = await ae.new();
        UUID.toText(id);
    };

    //Create Quest Item
    public func createQuestItem(name: Text, strengh_require: Float, image : ?Text) : async Result.Result<(), Types.Error>{
        var id = await createId();
        while (state.quest_items.get(id) != null){
            var id = await createId();
        };

        for (v in state.quest_items.vals()){
            if (v.name == name){
                return #err(#QuestItemNameAlready);
            };
        };
        var new_quest_item : Types.Quest_Item = {
            quest_item_id = id;
            name = name;
            strengh_require = strengh_require;
            images = image;
        };
        var createQuestItem = state.quest_items.put(id, new_quest_item);
        #ok();
    };

    public func createQuest(quest_name : Text, price : Float, description : ?Text, images : ?Text): async Result.Result<(), Types.Error> {
        var id = await createId();
        while (state.quests.get(id) != null){
            var id = await createId();
        };

        for (v in state.quests.vals()){
            if (v.quest_name == quest_name){
                return #err(#QuestNameAlready);
            };
        };
        var new_quest : Types.Quest = {
            quest_id = id;
            quest_name = quest_name;
            price = price;
            description = description;
            image = images;
        };
        var createQuest = state.quests.put(id, new_quest);
        #ok();
    };

    public func createQuestItemforQuest(quest_item_name: Text, quest_id_name: Text): async Result.Result<(), Types.Error>{
        var id = await createId();
        while (state.quest_item_for_quests.get(id) != null){
            var id = await createId();
        };

        //check FK
        // if (state.quest_items.get(quest_item_id) == null){
        //     return #err(#QuestItemNotFound);
        // }
        // else if (state.quests.get(quest_id) == null){
        //     return #err(#QuestNotFound);
        // };

        //find quest item
        var quest_item_id : Text = "";
        var quest_id : Text = "";
        label l_quest_item for (v in state.quest_items.vals()){
            if (quest_item_name == v.name){
                quest_item_id := v.quest_item_id;
                break l_quest_item;
            };
        };

        label l_quest for (v in state.quests.vals()){
            if (quest_id_name == v.quest_name){
                quest_id := v.quest_id;
                break l_quest;
            };
        };




        var new_quest_item_for_quest : Types.Quest_Item_for_Quest = {
            quest_item_for_quest_id = id;
            quest_item_id = quest_item_id;
            quest_id = quest_id;
        };
        var create_quest_item_for_quest = state.quest_item_for_quests.put(id, new_quest_item_for_quest);
        #ok();
    };

    public func createCharacter(name: Text, character_class: Text, level: Nat, current_exp: Float,
        level_up: Float, current_stamina: Float, max_stamina: Float, current_morale: Float, max_morale: Float,
        current_hp: Float, max_hp: Float, current_mana: Float, max_mana: Float, strength: Float,
        vitality: Float, intelligent: Float, luck: Float) : async Result.Result<(), Types.Error> {

        var id = await createId();
        while (state.characters.get(id) != null){
            var id = await createId();
        };

        for (v in state.characters.vals()){
            if (v.name == name) {
                return #err(#CharacterNameAlready);
            };
        };

        var new_character : Types.Character = {
            character_id = id;
            name = name;
            character_class = character_class;
            level = level;
            current_exp = current_exp;
            level_up_exp = level_up; 
            current_stamina = current_stamina;
            max_stamina = max_stamina;
            current_morale = current_morale;
            max_morale = max_morale;
            current_hp = current_hp;
            max_hp = max_hp;
            current_mana = current_mana;
            max_mana = max_mana;
            strength = strength;
            vitality = vitality;
            intelligent = intelligent;
            luck = luck;
        };
        var creatCharacter = state.characters.put(id, new_character);

        let create_material = await createMaterial(id, "seed/wood", null, 10);
        #ok();
    };

    public func createMaterial(id: Text, name: Text, description: ?Text, quantity: Nat) : async Result.Result<(), Types.Error>{
        //id material = id character
        let new_material : Types.Material = {
            id = id;
            name = name;
            description = description;
            quantity = quantity;
        };
        let create_material = state.materials.put(id, new_material);
        #ok();
    };

    public func createCharacter_Quest_Item(name: Text, list: [Text]) : async Result.Result<(), Types.Error> {
        //find id character
        let character_id = find_id_character_with_name(name);
        switch (character_id) {
            case null return #err(#CharacterNotFound);
            case (?v) {
                var id_list : [Text] = [];
                for (v in list.vals()){
                    let id_quest = find_id_quest_item_with_name(v);
                    label l switch (id_quest) {
                        case null break l;
                        case (?value) {
                            id_list := Array.append(id_list, [value]);
                        };
                    };
                };
                let new : Types.Character_Quest_Item = {
                    character_id = v;
                    list_quest_item = id_list;
                };

                let create = state.character_quest_items.put(v, new);
                #ok();
            };
        };
    };

    public func updateCharacter_Quest_Item(id: Text, list: [Text]) : async Result.Result<(), Types.Error>{
        let find_id = state.character_quest_items.get(id);

        switch (find_id) {
            case null return #err(#NotFound);
            case (?v) {
                let new : Types.Character_Quest_Item = {
                    character_id = id;
                    list_quest_item = list;
                };
                let create = state.character_quest_items.put(id, new);
                #ok();
            };
        };
    };

    public func createEvent(quest_id_name: Text, description: Text, location_name: Text,
        destiFloation_name: Text) : async Result.Result<(), Types.Error> {

        var id = await createId();
        while (state.events.get(id) != null){
            var id = await createId();
        };

        //find quest id
        var quest_id : Text= "";
        label l for (v in state.quests.vals()){
            if (v.quest_name == quest_id_name){
                quest_id := v.quest_id;
                break l;
            };
        };

        var new_event : Types.Event = {
            event_id = id;
            quest_id = quest_id;
            description = description; 
            location_name = location_name;
            destiFloation_name = destiFloation_name;
        };
        var create_event = state.events.put(id, new_event);
        #ok();
    };

    public func createOption(description: Text, event_id_location_name : ?Text, require_item: ?[Text],
        loss_stamina: Float, loss_morale: Float, loss_hp: Float, loss_mana: Float,
        risk_chance : Float, risk_lost: Text, loss_other: Text, gain_stamina: Float,
        gain_morale : Float, gain_hp: Float, gain_mana: Float, gain_exp: Float, lucky_chance: Float,
        gain_by_luck: Text, gain_other: Text) : async Result.Result<(), Types.Error> {

        var id = await createId();
        while (state.quest_items.get(id) != null){
            var id = await createId();
        };

        // //check FK
        // if (state.events.get(event_id) == null){
        //     return #err(#EventNotFound);
        // };

        //find event id
        var event_id : ?Text = null;
        label l for (v in state.events.vals()){
            if (?v.location_name == event_id_location_name){
                event_id := ?v.event_id;
                break l;
            };
        };

        //find require item id
        var require_item_id : [Text] = [];
        label l switch (require_item) {
            case null break l;
            case (?require_item) {
                //find id
                for (v in require_item.vals()){
                    var find = find_id_quest_item_with_name(v);
                    label ll switch (find) {
                        case null break ll;
                        case (?v) {
                            require_item_id := Array.append(require_item_id, [v]);
                        };
                    };
                };
            };
        };
        
        var new_option : Types.Options = {
            option_id = id;
            description = description;
            event_id = event_id;
            require_item = ?require_item_id;
            loss_stamina = loss_stamina;
            loss_morale = loss_morale;
            loss_hp = loss_hp;
            loss_mana = loss_mana;
            risk_chance = risk_chance;
            risk_lost = risk_lost;
            loss_other = loss_other;
            gain_stamina = gain_stamina;
            gain_morale = gain_morale;
            gain_hp = gain_hp;
            gain_mana = gain_mana;
            gain_exp = gain_exp;
            lucky_chance = lucky_chance;
            gain_by_luck = gain_by_luck;
            gain_other = gain_other;
        };
        var create_option = state.options.put(id, new_option);
        #ok();
    };

    public func init_data() :  async Result.Result<(), Types.Error>{
        //Quest_item_for_quest
        //Quest Item
        ignore await createQuestItem("Knife", 0.5, null);
        ignore await createQuestItem("Medicine", 0.5, null);
        ignore await createQuestItem("Climbing stick", 1, null);
        ignore await createQuestItem("Bicycle", 5, null);
        ignore await createQuestItem("Tent", 3, null);
        ignore await createQuestItem("Clothes", 2, null);
        ignore await createQuestItem("Camera", 1.5, null);
        ignore await createQuestItem("Food x?", 0.5, null);
        ignore await createQuestItem("Water", 0.5, null);
        ignore await createQuestItem("Rope & Hook", 1, null);
        ignore await createQuestItem("Infatable Boat & paddle", 4, null);
        ignore await createQuestItem("Saw", 0.5, null);
        ignore await createQuestItem("Antidote", 0.5, null);
        
        //Quest
        ignore await createQuest("Jungle Tour", 0, null, null);

        //Character
        ignore await createCharacter("Test_Trekker", "Trekker", 1, 0, 100, 7, 7, 6, 6,
        6, 6, 3, 3, 6, 0, 0, 0);

        //Event
        ignore await createEvent("Jungle Tour", "Dense Bushes a blocking your way", "Position 1", "Position 2");
        ignore await createEvent("Jungle Tour", "You meet a waterfall", "Position 2", "Position 3");
        ignore await createEvent("Jungle Tour", "You encouter a herd of monkeys", "Position 3", "Position 4");
        ignore await createEvent("Jungle Tour", "You arrive at camping spot", "Position 4", "Position 5");
        ignore await createEvent("Jungle Tour", "You encounters a large tree blocking the way", "Position 5", "Position 6");

        //Option
        ignore await createOption("Start Jungle Tour", null, null, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 10, 0, "", "");
        ignore await createOption("Cut the bushes to open the way with a Knife", ?"Position 1", ?["Knife", "Saw"], 2, 1, 1, 0, 0, "", "", 0, 0, 0, 0, 10, 0, "", "");
        ignore await createOption("Try to make your way through the bushes without chopping them down", ?"Position 1", null, 1, 2, 2, 0, 0.6, "seed/wood", "", 0, 0, 0, 0, 10, 0.1, "seed/wood", "");
        ignore await createOption("Follow the cliffs to climb up the waterfall", ?"Position 2", null, 2, 1, 2, 0, 0.6, "seed/wood", "", 0, 0, 0, 0, 10, 0.2, "seed/wood", "");
        ignore await createOption("Use Robes and hooks to climb up the waterfall", ?"Position 2", ?["Rope & Hook"], 3, 0, 2, 0, 0.4, "seed/wood", "", 0, 0, 0, 0, 10, 0.1, "seed/wood", "");
        ignore await createOption("Give them some food", ?"Position 3", ?["Food x?"], 1, 1, 1, 0, 0.3, "seed/wood", "", 0, 0, 0, 0, 15, 0.5, "seed/wood", "");
        ignore await createOption("Ignore and find the way to pass through them", ?"Position 3", null, 2, 2, 2, 0, 0.7, "", "", 0, 0, 0, 0, 5, 0, "", "");
        ignore await createOption("Take a rest", ?"Position 4", null, 0, 0, 0, 0, 0, "", "8 hours for waiting", 2, 2, 0, 0, 5, 0, "", "");
        ignore await createOption("Cook", ?"Position 4", ?["Food x?"], 0, 0, 0, 0, 0, "", "-1 food", 0, 0, 2, 0, 0, 0, "", "");
        ignore await createOption("Continue", ?"Position 4", null, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 10, 0, "", "");
        ignore await createOption("Save", ?"Position 4", null, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 5, 0, "", "");
        ignore await createOption("Use a knife to cut branches to open the way", ?"Position 5", ?["Knife", "Saw"], 3, 2, 1, 0, 0, "", "", 0, 0, 0, 0, 0, 0.7, "seed/wood", "");
        ignore await createOption("Find another way to go", ?"Position 5", null, 1, 1, 0, 0, 0.8, "Go back to Event_id = 03", "", 0, 0, 0, 0, 0, 0.1, "seed/wood", "");
       
        //Quest item for quest
        ignore await createQuestItemforQuest("Knife", "Jungle Tour");
        ignore await createQuestItemforQuest("Food x?", "Jungle Tour");
        ignore await createQuestItemforQuest("Rope & Hook", "Jungle Tour");
        ignore await createQuestItemforQuest("Saw", "Jungle Tour");
       
        #ok();
    };

    public func listQuestItem() : async [Types.Quest_Item] {
        var l : [Types.Quest_Item] = [];
        for (v in state.quest_items.vals()){
            l := Array.append(l, [v]);
        };
        return l;
    }; 
    public func listQuest() : async [Types.Quest] {
        var l : [Types.Quest] = [];
        for (v in state.quests.vals()){
            l := Array.append(l, [v]);
        };
        return l;
    };
    // public func listCharacter() : async [Types.Character] {
    //     var l : [Types.Character] = [];
    //     for (v in state.characters.vals()){
    //         l := Array.append(l, [v]);
    //     };
    //     return l;
    // };

    public func inforCharacter(character_name: Text) : async ?Types.Character {
        let character_id = find_id_character_with_name(character_name);
        switch (character_id) {
            case null return null;
            case (?v) {
                let infor = state.characters.get(v);
                switch (infor){
                    case null return null;
                    case (?infor_val) {
                        return ?infor_val;
                    };
                };
            };
        };
    };

    public func inforCharacterQuestItem(character_id: Text) : async Result.Result<Types.Character_Quest_Item, Types.Error> {
        let check = state.character_quest_items.get(character_id);

        switch (check) {
            case null return #err(#CharacterQuestItemNotFound);
            case (?v) #ok(v);
        };
    };

    public func updateCharacter(id : Text, character_name: Text, character_class: Text, level: Nat, current_exp: Float,
        level_up_exp: Float, current_stamina: Float, max_stamina: Float, current_morale: Float, max_morale: Float,
        current_hp: Float, max_hp: Float, current_mana: Float, max_mana: Float, strength: Float, vitality: Float,
        intelligent: Float, luck: Float) : async Result.Result<(), Types.Error>{
            
            let new_char : Types.Character = {
                character_id = id;
                name = character_name;
                character_class = character_class;
                level = level;
                current_exp = current_exp;
                level_up_exp = level_up_exp;
                current_stamina = current_stamina;
                max_stamina = max_stamina;
                current_morale = current_morale;
                max_morale = max_morale;
                current_hp = current_hp;
                max_hp = max_hp;
                current_mana = current_mana;
                max_mana = max_mana;
                strength = strength;
                vitality = vitality;
                intelligent = intelligent;
                luck = luck;
            };

            let create_char = state.characters.put(id, new_char);
            #ok();
    };

    public func listEvent() : async [Types.Event] {
        var l : [Types.Event] = [];
        for (v in state.events.vals()){
            l := Array.append(l, [v]);
        };
        return l;
    };
    public func listOptions() : async [Types.Options] {
        var l : [Types.Options] = [];
        for (v in state.options.vals()){
            l := Array.append(l, [v]);
        };
        return l;
    };
    public func listQuestItemforQuest() : async [Types.Quest_Item_for_Quest] {
        var l : [Types.Quest_Item_for_Quest] = [];
        for (v in state.quest_item_for_quests.vals()){
            l := Array.append(l, [v]);
        };
        return l;
    }; 
    public func listCharacterTakeOption(character_name: Text) : async Result.Result<([Types.Character_take_Opton]), Types.Error> {
       let id = find_id_character_with_name(character_name);

       switch (id) {
            case null #err(#CharacterNotFound);
            case (?id) {
                var l : [Types.Character_take_Opton] = [];
                for (v in state.character_take_options.vals()){
                    if (v.character_id == id){
                        l := Array.append(l, [v]);
                    };
                };
                #ok(l);
            };
        };
    };

    public func count_Material(character_name: Text): async Result.Result<Nat, Types.Error>{
        //find character id
        var character_id : ?Text = find_id_character_with_name(character_name);

        switch (character_id) {
            case null return #err(#CharacterNotFound);
            case (?character_id){
                var material : ?Types.Material = state.materials.get(character_id);
                switch (material) {
                    case null return #err(#MaterialNotFound);
                    case (?v) return #ok(v.quantity);
                };
            };
        };
    };


    //create Character take Option
    public func createCharacterTakeOptions(character_id: Text, option_id : Text, pickup_time: Time.Time,
        char_curr_mana: Float, char_max_mana: Float, char_curr_stamina: Float, char_max_stamina: Float,
        char_curr_morale: Float, char_max_morale: Float, char_curr_hp: Float, char_max_hp: Float) : async Result.Result<(), Types.Error> {
        
        //create ID
        var id = await createId();
        while (state.quest_items.get(id) != null){
            var id = await createId();
        };


        var new : Types.Character_take_Opton = {
            character_id = character_id;
            option_id = option_id;
            pickup_time = pickup_time;
            char_curr_mana = char_curr_mana;
            char_max_mana = char_max_mana;
            char_curr_stamina = char_curr_stamina;
            char_max_stamina = char_max_stamina;
            char_curr_morale = char_curr_morale;
            char_max_morale = char_max_morale;
            char_curr_hp = char_curr_hp;
            char_max_hp = char_max_hp;
        };

        var create_character_take_option = state.character_take_options.put(id, new);
        #ok();
    };

    //Play trip
    // //Position 1 to Position 2
    // public func pos_to_pos(character_name: Text, location_name: Text, choose: Text) : async Result.Result<(), Types.Error> {
    //     //find character
    //     var character_id : Text = "";
    //     label character_val for (v in state.characters.vals()){
    //         if (v.name == character_name){
    //             character_id := v.character_id;
    //             break character_val;
    //         };
    //     };
    //     //find event with location name
    //     var event_id : Text = "";
    //     label event_val for (v in state.events.vals()){
    //         if (v.location_name == location_name) {
    //             event_id := v.event_id;
    //             break event_val;
    //         };
    //     };

    //     //find id option
    //     var option_id : Text = "";
    //     label option_val for (v in state.options.vals()){
    //         if (v.description == choose){
    //             option_id := v.option_id;
    //             break option_val;
    //         };
    //     };
    //     //check choose
    //     //choose not found
    //     if (option_id == ""){
    //         return #err(#ChooseOptionNotFound);
    //     };
    //     //cannot choose
    //     label l for (v in state.options.vals()){
    //         if (v.description == choose) {
    //             if (v.event_id != ?event_id){
    //                 return #err(#CannotChoose);
    //             };
    //         };
    //     };

    //     var choose_option = state.options.get(option_id);
    //     var list_quest_item : [Text] = []; //vat pham mang theo

    //     for (v in state.quest_item_for_quests.vals()){
    //         list_quest_item := Array.append(list_quest_item, [v.quest_item_id])
    //     };
        
    //     switch (choose_option) {
    //         case null return #err(#OptionNotFound);
    //         case(?v){
    //             //check require 
    //             var require_item : ?[Text] = v.require_item;
    //             label l switch (require_item) {
    //                 case null break l;
    //                 case (?require_item){
    //                     for (i in require_item.vals()){
    //                         label l_switch switch (Array.find(list_quest_item, func (x: Text) : Bool {x == i})){
    //                             case null return #err(#RequiteItemNotFound);
    //                             case (?value) break l_switch;
    //                         };
    //                     };
    //                 };
    //             };

    //             //
    //             var character = state.characters.get(character_id);
    //             switch (character){
    //                 case null #err(#CharacterNotFound);
    //                 case (?character_val) {

    //                     let new_character : Types.Character = {
    //                         character_id = character_id;
    //                         name = character_val.name;
    //                         character_class = character_val.character_class;
    //                         level = character_val.level;
    //                         current_exp = character_val.current_exp + v.gain_exp;
    //                         level_up_exp = character_val.level_up_exp;
    //                         current_stamina = character_val.current_stamina - v.loss_stamina;
    //                         max_stamina = character_val.max_stamina;
    //                         current_morale = character_val.current_morale - v.loss_morale;
    //                         max_morale = character_val.max_morale;
    //                         current_hp = character_val.current_hp - v.loss_hp;
    //                         max_hp = character_val.max_hp;
    //                         current_mana = character_val.current_mana;
    //                         max_mana = character_val.max_mana - v.loss_mana;
    //                         strength = character_val.strength;
    //                         vitality = character_val.vitality;
    //                         intelligent = character_val.intelligent;
    //                         luck = character_val.luck;
    //                     };

    //                     var update_char = state.characters.put(character_id, new_character);

    //                     // if (v.loss_stamina != null){
    //                     //    character_val.current_stamina := character_val.current_stamina - v.loss_stamina;
    //                     // }
    //                     // else if (v.loss_morale != null){
    //                     //     character_val.current_morale -= v.loss_morale;
    //                     // }
    //                     // else if (v.loss_hp != null){
    //                     //     character_val.current_hp := charracter_val.current_hp - v.loss_hp;
    //                     // };
    //                     #ok();
    //                 };
    //             };
    //         };
    //     };
    // };

    private func find_id_quest_item_with_name(name : Text) : ?Text {
        var id : ?Text = null;
        label l for (v in state.quest_items.vals()){
            if (v.name == name){
                id := ?v.quest_item_id;
                break l;
            };
        };
        return id;
    };

    private func find_id_character_with_name(name : Text) : ?Text {
        var id : ?Text = null;
        label l for (v in state.characters.vals()){
            if (v.name == name){
                id := ?v.character_id;
                break l;
            };
        };
        return id;
    };

    //random with probability
    public func random_probability(p: Float): async Bool{ // true -> risk; false -> not risk
        if (p == 0){
            return false;
        };
        let n : Nat = await randomNat();
        if ((n%100) < Float.toInt(p*100)){
            return true;
        };
        return false;
    };

    //Position 1 to Position 2
    public func pos1_to_pos2(character_name: Text, choose: Text) : async Result.Result<(), Types.Error> {
        //location
        let location_name : Text = "Position 1";

        //find character
        var character_id : Text = "";
        label character_val for (v in state.characters.vals()){
            if (v.name == character_name){
                character_id := v.character_id;
                break character_val;
            };
        };

        //find event with location name
        var event_id : Text = "";
        label event_val for (v in state.events.vals()){
            if (v.location_name == location_name) {
                event_id := v.event_id;
                break event_val;
            };
        };

        //find id option
        var option_id : Text = "";
        label option_val for (v in state.options.vals()){
            if (v.description == choose){
                option_id := v.option_id;
                break option_val;
            };
        };
        //check choose
        //choose not found
        if (option_id == ""){
            return #err(#ChooseOptionNotFound);
        };

        //cannot choose
        label l for (v in state.options.vals()){
            if (v.description == choose) {
                if (v.event_id != ?event_id){
                    return #err(#CannotChoose);
                };
            };
        };

        var choose_option = state.options.get(option_id);

        var list_quest_item : [Text] = []; //vat pham character mang theo
        let char_quest = state.character_quest_items.get(character_id);

        switch (char_quest) {
            case null return #err(#CharacterQuestItemNotFound);
            case (?v) {
                list_quest_item := v.list_quest_item;
            };
        };

        switch (choose_option) {
            case null return #err(#OptionNotFound);
            case(?v){
                // //check require 
                var require_item : ?[Text] = v.require_item;
                label l switch (require_item) {
                    case null break l;
                    case (?require_item){
                        for (i in require_item.vals()){
                            label l_switch switch (Array.find(list_quest_item, func (x: Text) : Bool {x == i})){
                                case null return #err(#RequiteItemNotFound);
                                case (?value) break l_switch;
                            };
                        };
                    };
                };

                //
                var character = state.characters.get(character_id);
                switch (character){
                    case null #err(#CharacterNotFound);
                    case (?character_val) {
                        //check risk chance
                        let check_risk : Bool = await random_probability(v.risk_chance);
                        let check_lucky : Bool = await random_probability(v.lucky_chance);
                        var seed_wood_quanlity : Int = 0;
                        if (check_risk == true){
                            seed_wood_quanlity -= 1;
                        };
                        if (check_lucky == true){
                            seed_wood_quanlity += 1;
                        };
                        var find_material : ?Types.Material = state.materials.get(character_id);
                        label s switch (find_material){
                            case null break s;
                            case (?v) {
                                let new_material : Types.Material = {
                                    id = character_id;
                                    name = v.name;
                                    description = v.description;
                                    quantity = Int.abs(v.quantity+seed_wood_quanlity);
                                };

                                let update_material = state.materials.put(character_id, new_material);
                            };
                        };
                        let new_character : Types.Character = {
                            character_id = character_id;
                            name = character_val.name;
                            character_class = character_val.character_class;
                            level = character_val.level;
                            current_exp = character_val.current_exp + v.gain_exp;
                            level_up_exp = character_val.level_up_exp;
                            current_stamina = character_val.current_stamina - v.loss_stamina;
                            max_stamina = character_val.max_stamina;
                            current_morale = character_val.current_morale - v.loss_morale;
                            max_morale = character_val.max_morale;
                            current_hp = character_val.current_hp - v.loss_hp;
                            max_hp = character_val.max_hp;
                            current_mana = character_val.current_mana;
                            max_mana = character_val.max_mana - v.loss_mana;
                            strength = character_val.strength;
                            vitality = character_val.vitality;
                            intelligent = character_val.intelligent;
                            luck = character_val.luck;
                        };

                        var update_char = state.characters.put(character_id, new_character);

                        //create Character take option
                        let crt = createCharacterTakeOptions(character_id, option_id, Time.now(), new_character.current_mana, new_character.max_mana,
                                new_character.current_stamina, new_character.max_mana, new_character.current_morale, new_character.max_morale,
                                new_character.current_hp, new_character.max_hp);
                        #ok();
                    };
                };
            };
        };
    };

    public func clear_data() : async Result.Result<(), Types.Error> {
        state := State.empty();
        #ok();
    };

    //Position 2 to Position 3
    public func pos2_to_pos3(character_name: Text, choose: Text) : async Result.Result<(), Types.Error> {
        //location
        let location_name : Text = "Position 2";

        //find character
        var character_id : Text = "";
        label character_val for (v in state.characters.vals()){
            if (v.name == character_name){
                character_id := v.character_id;
                break character_val;
            };
        };

        //find event with location name
        var event_id : Text = "";
        label event_val for (v in state.events.vals()){
            if (v.location_name == location_name) {
                event_id := v.event_id;
                break event_val;
            };
        };

        //find id option
        var option_id : Text = "";
        label option_val for (v in state.options.vals()){
            if (v.description == choose){
                option_id := v.option_id;
                break option_val;
            };
        };
        //check choose
        //choose not found
        if (option_id == ""){
            return #err(#ChooseOptionNotFound);
        };

        //cannot choose
        label l for (v in state.options.vals()){
            if (v.description == choose) {
                if (v.event_id != ?event_id){
                    return #err(#CannotChoose);
                };
            };
        };

        var choose_option = state.options.get(option_id);

        var list_quest_item : [Text] = []; //vat pham character mang theo
        let char_quest = state.character_quest_items.get(character_id);

        switch (char_quest) {
            case null return #err(#CharacterQuestItemNotFound);
            case (?v) {
                list_quest_item := v.list_quest_item;
            };
        };
        
        switch (choose_option) {
            case null return #err(#OptionNotFound);
            case(?v){
                //check require 
                var require_item : ?[Text] = v.require_item;
                label l switch (require_item) {
                    case null break l;
                    case (?require_item){
                        for (i in require_item.vals()){
                            label l_switch switch (Array.find(list_quest_item, func (x: Text) : Bool {x == i})){
                                case null return #err(#RequiteItemNotFound);
                                case (?value) break l_switch;
                            };
                        };
                    };
                };

                //
                var character = state.characters.get(character_id);
                switch (character){
                    case null #err(#CharacterNotFound);
                    case (?character_val) {
                        //check risk chance
                        let check_risk : Bool = await random_probability(v.risk_chance);
                        let check_lucky : Bool = await random_probability(v.lucky_chance);
                        var seed_wood_quanlity : Int = 0;
                        if (check_risk == true){
                            seed_wood_quanlity -= 1;
                        };
                        if (check_lucky == true){
                            seed_wood_quanlity += 1;
                        };
                        var find_material : ?Types.Material = state.materials.get(character_id);
                        label s switch (find_material){
                            case null break s;
                            case (?v) {
                                let new_material : Types.Material = {
                                    id = character_id;
                                    name = v.name;
                                    description = v.description;
                                    quantity = Int.abs(v.quantity+seed_wood_quanlity);
                                };

                                let update_material = state.materials.put(character_id, new_material);
                            };
                        };
                        let new_character : Types.Character = {
                            character_id = character_id;
                            name = character_val.name;
                            character_class = character_val.character_class;
                            level = character_val.level;
                            current_exp = character_val.current_exp + v.gain_exp;
                            level_up_exp = character_val.level_up_exp;
                            current_stamina = character_val.current_stamina - v.loss_stamina;
                            max_stamina = character_val.max_stamina;
                            current_morale = character_val.current_morale - v.loss_morale;
                            max_morale = character_val.max_morale;
                            current_hp = character_val.current_hp - v.loss_hp;
                            max_hp = character_val.max_hp;
                            current_mana = character_val.current_mana;
                            max_mana = character_val.max_mana - v.loss_mana;
                            strength = character_val.strength;
                            vitality = character_val.vitality;
                            intelligent = character_val.intelligent;
                            luck = character_val.luck;
                        };

                        var update_char = state.characters.put(character_id, new_character);
                        //create Character take option
                        let crt = createCharacterTakeOptions(character_id, option_id, Time.now(), new_character.current_mana, new_character.max_mana,
                                new_character.current_stamina, new_character.max_mana, new_character.current_morale, new_character.max_morale,
                                new_character.current_hp, new_character.max_hp);
                        #ok();
                    };
                };
            };
        };
    };

    // Position 3 to Position 4
    public func pos3_to_pos4(character_name: Text, choose: Text) : async Result.Result<(), Types.Error> {
        let location_name : Text = "Position 3";
        //find character
        var character_id : Text = "";
        label character_val for (v in state.characters.vals()){
            if (v.name == character_name){
                character_id := v.character_id;
                break character_val;
            };
        };

        //find event with location name
        var event_id : Text = "";
        label event_val for (v in state.events.vals()){
            if (v.location_name == location_name) {
                event_id := v.event_id;
                break event_val;
            };
        };


        var list_quest_item : [Text] = []; //vat pham character mang theo
        let char_quest = state.character_quest_items.get(character_id);

        switch (char_quest) {
            case null return #err(#CharacterQuestItemNotFound);
            case (?v) {
                list_quest_item := v.list_quest_item;
            };
        };

        //find id option
        var option_id : Text = "";
        label option_val for (v in state.options.vals()){
            if (v.description == choose){
                option_id := v.option_id;
                break option_val;
            };
        };
        //check choose
        //choose not found
        if (option_id == ""){
            return #err(#ChooseOptionNotFound);
        };

        var choose_option = state.options.get(option_id);

        switch (choose_option) {
            case null return #err(#ChooseOptionNotFound);
            case (?choose){
                //find character
                 //find character
                let find_character = state.characters.get(character_id);
                switch (find_character) {
                    case null #err(#CharacterNotFound);
                    case (?character) {
                        switch (choose.description) {
                            case "Give them some food" {
                                let check_risk : Bool = await random_probability(0.3);
                                let check_lucky : Bool = await random_probability(0.5);
                                var seed_wood_quanlity : Int = 0;
                                if (check_risk == true){
                                    seed_wood_quanlity -= 1;
                                };
                                if (check_lucky == true){
                                    seed_wood_quanlity += 1;
                                };
                                var find_material : ?Types.Material = state.materials.get(character_id);
                                label s switch (find_material){
                                    case null break s;
                                    case (?v) {
                                        let new_material : Types.Material = {
                                            id = character_id;
                                            name = v.name;
                                            description = v.description;
                                            quantity = Int.abs(v.quantity+seed_wood_quanlity);
                                        };

                                        let update_material = state.materials.put(character_id, new_material);
                                    };
                                };

                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp+15,
                                character.level_up_exp, character.current_stamina-1, character.max_stamina, character.current_morale-1,
                                character.max_morale, character.current_hp-1, character.max_hp, character.current_mana, 
                                character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                            };
                            case "Ignore and find the way to pass through them" {
                                let check_risk : Bool = await random_probability(0.7);
                                var char_cur_morale : Float = character.current_morale;
                                var char_cur_hp : Float = character.current_hp;
                                if (check_risk == true){
                                    char_cur_morale -= 2;
                                    char_cur_hp -= 2;
                                };

                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp+5,
                                character.level_up_exp, character.current_stamina, character.max_stamina, char_cur_morale,
                                character.max_morale, char_cur_hp, character.max_hp, character.current_mana, 
                                character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                            };
                            case (_) #err(#OptionNotFound);
                        };
                    };
                };
                
            };
        };
    };

    //Position 4 to Position 5
    public func pos4_to_pos5(character_name: Text, choose: Text) : async Result.Result<(), Types.Error> {
        let location_name : Text = "Position 4";

        //find character
        var character_id : Text = "";
        label character_val for (v in state.characters.vals()){
            if (v.name == character_name){
                character_id := v.character_id;
                break character_val;
            };
        };

        //find event with location name
        var event_id : Text = "";
        label event_val for (v in state.events.vals()){
            if (v.location_name == location_name) {
                event_id := v.event_id;
                break event_val;
            };
        };


        var list_quest_item : [Text] = []; //vat pham character mang theo
        let char_quest = state.character_quest_items.get(character_id);

        switch (char_quest) {
            case null return #err(#CharacterQuestItemNotFound);
            case (?v) {
                list_quest_item := v.list_quest_item;
            };
        };

        //find id option
        var option_id : Text = "";
        label option_val for (v in state.options.vals()){
            if (v.description == choose){
                option_id := v.option_id;
                break option_val;
            };
        };
        //check choose
        //choose not found
        if (option_id == ""){
            return #err(#ChooseOptionNotFound);
        };

        var choose_option = state.options.get(option_id);

        switch (choose_option) {
            case null return #err(#ChooseOptionNotFound);
            case (?choose){
                //find character
                let find_character = state.characters.get(character_id);
                switch (find_character) {
                    case null #err(#CharacterNotFound);
                    case (?character) {
                        switch (choose.description) {
                            case "Take a rest" {
                                // let now : Time.Time = Time.now();
                                // let wait_time : Time.Time = now + 1_000_000_0000;
                                // while (Time.now() != wait_time){};
                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp,
                                    character.level_up_exp, character.current_stamina+2, character.max_stamina, character.current_morale+2,
                                    character.max_morale, character.current_hp, character.max_hp, character.current_mana, 
                                    character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                            };
                            case "Cook" {
                                //check require
                                var require_item : ?[Text] = choose.require_item;
                                label l switch (require_item) {
                                    case null break l;
                                    case (?require_item){
                                        for (i in require_item.vals()){
                                            label l_switch switch (Array.find(list_quest_item, func (x: Text) : Bool {x == i})){
                                                case null return #err(#RequiteItemNotFound);
                                                case (?value) break l_switch;
                                            };
                                        };
                                    };
                                };

                                //-1 food
                                var f = state.character_quest_items.get(character_id);
                                label l switch (f) {
                                    case null break l;
                                    case (?v) {
                                        var list_item : [Text] = Array.filter(v.list_quest_item, func (x : Text) : Bool {x != "Food x?"});
                                        let update = updateCharacter_Quest_Item(character_id, list_item);
                                    };
                                };

                                //
                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp,
                                    character.level_up_exp, character.current_stamina, character.max_stamina, character.current_morale,
                                    character.max_morale, character.current_hp+2, character.max_hp, character.current_mana, 
                                    character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                                
                            };
                            case "Continue" {
                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp+10,
                                    character.level_up_exp, character.current_stamina, character.max_stamina, character.current_morale,
                                    character.max_morale, character.current_hp, character.max_hp, character.current_mana, 
                                    character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                            };
                            case "Save" {
                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp+5,
                                    character.level_up_exp, character.current_stamina, character.max_stamina, character.current_morale,
                                    character.max_morale, character.current_hp, character.max_hp, character.current_mana, 
                                    character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                            };
                            case (_) #err(#OptionNotFound);
                        };
                    };
                };
            };
        };
    };

    //Position 5 to Position 6
    public func pos5_to_pos6(character_name: Text, choose: Text) : async Result.Result<(), Types.Error> {
        let location_name : Text = "Position 5";

        //find character
        var character_id : Text = "";
        label character_val for (v in state.characters.vals()){
            if (v.name == character_name){
                character_id := v.character_id;
                break character_val;
            };
        };

        //find event with location name
        var event_id : Text = "";
        label event_val for (v in state.events.vals()){
            if (v.location_name == location_name) {
                event_id := v.event_id;
                break event_val;
            };
        };


        var list_quest_item : [Text] = []; //vat pham character mang theo
        let char_quest = state.character_quest_items.get(character_id);

        switch (char_quest) {
            case null return #err(#CharacterQuestItemNotFound);
            case (?v) {
                list_quest_item := v.list_quest_item;
            };
        };

        //find id option
        var option_id : Text = "";
        label option_val for (v in state.options.vals()){
            if (v.description == choose){
                option_id := v.option_id;
                break option_val;
            };
        };
        //check choose
        //choose not found
        if (option_id == ""){
            return #err(#ChooseOptionNotFound);
        };

        var choose_option = state.options.get(option_id);

        switch (choose_option) {
            case null return #err(#ChooseOptionNotFound);
            case (?choose){
                //find character
                let find_character = state.characters.get(character_id);
                switch (find_character) {
                    case null #err(#CharacterNotFound);
                    case (?character) {
                        switch (choose.description) {
                            case "Use a knife to cut branches to open the way" {
                                //check require
                                var require_item : ?[Text] = choose.require_item;
                                label l switch (require_item) {
                                    case null break l;
                                    case (?require_item){
                                        for (i in require_item.vals()){
                                            label l_switch switch (Array.find(list_quest_item, func (x: Text) : Bool {x == i})){
                                                case null return #err(#RequiteItemNotFound);
                                                case (?value) break l_switch;
                                            };
                                        };
                                    };
                                };

                                //check lucky
                                let check_lucky : Bool = await random_probability(0.7);
                                var seed_wood_quanlity : Int = 0;
                                if (check_lucky == true){
                                    seed_wood_quanlity += 1;
                                };
                                var find_material : ?Types.Material = state.materials.get(character_id);
                                label s switch (find_material){
                                    case null break s;
                                    case (?v) {
                                        let new_material : Types.Material = {
                                            id = character_id;
                                            name = v.name;
                                            description = v.description;
                                            quantity = Int.abs(v.quantity+seed_wood_quanlity);
                                        };

                                        let update_material = state.materials.put(character_id, new_material);
                                    };
                                };

                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp,
                                    character.level_up_exp, character.current_stamina-3, character.max_stamina, character.current_morale-2,
                                    character.max_morale, character.current_hp-1, character.max_hp, character.current_mana, 
                                    character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                                
                            };
                            case "Find another way to go" {
                                //check risk
                                let check_risk : Bool = await random_probability(0.8);
                                let check_lucky : Bool = await random_probability(0.1);
                                var seed_wood_quanlity : Int = 0;
                                if (check_risk == true){
                                    return #ok(); //go to Event ID = 3;
                                };
                                if (check_lucky == true) {
                                    seed_wood_quanlity += 1;
                                };
                                var find_material : ?Types.Material = state.materials.get(character_id);
                                label s switch (find_material){
                                    case null break s;
                                    case (?v) {
                                        let new_material : Types.Material = {
                                            id = character_id;
                                            name = v.name;
                                            description = v.description;
                                            quantity = Int.abs(v.quantity+seed_wood_quanlity);
                                        };

                                        let update_material = state.materials.put(character_id, new_material);
                                    };
                                };

                                let update = updateCharacter(character_id, character_name, character.character_class, character.level, character.current_exp,
                                    character.level_up_exp, character.current_stamina-1, character.max_stamina, character.current_morale-1,
                                    character.max_morale, character.current_hp, character.max_hp, character.current_mana, 
                                    character.max_mana, character.strength, character.vitality, character.intelligent, character.luck);
                                #ok();
                            };
                            case (_) #err(#OptionNotFound);
                        };
                    };
                };
            };
        };
    };
}
