import Array "mo:base/Array";
import Char "mo:base/Char";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat32 "mo:base/Nat32";
import Principal "mo:base/Principal";
import Random "mo:base/Random";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Time "mo:base/Time";

import State "../game_models/State";
import Types "../game_models/Types";

actor {
  var state : State.State = State.empty() ; 

  var bag : Types.Bag = {
    material_amount = [];
    items = [];
    capacity = 0;
  };

  //Create Database-------------------------------------------------------------------------------------
  public func Init() : async () {
    //user
    ignore await create_User({username="Tester"; psswd="111"; confirm="111"});

    //character class
    ignore await create_CharacterClass({base_stamina=7; base_intelligent=0; base_hp=6; base_strength=6; description=""; base_luck=0; base_mana=3; base_vitality=0; class_name="Trekker"; base_morale=6});
    // ignore await create_CharacterClass({base_stamina=5; base_intelligent=0; base_hp=5; base_strength=0; description=""; base_luck=0; base_mana=5; base_vitality=0; class_name="Medic"; base_morale=7});

    //character
    let finduser = await find_Username("Tester");
    switch(finduser) {
      case null {
        return;
      };
      case (?u) {
        ignore create_Character({character_name="Test Trekker"; character_class_name="Trekker"; user_id=u.id});
      };
    };

    //quest
    ignore await create_Quest({name="Jungle Tour"; price=0; description=""; image=""});

    //events
    ignore await create_Event({description=""; questname="Jungle Tour"; location_name="Position 0"; destination_name="Position 1"});
    ignore await create_Event({description="Dense Bushes a blocking your way"; questname="Jungle Tour"; location_name="Position 1"; destination_name="Position 2"});
    ignore await create_Event({description="You met a waterfall"; questname="Jungle Tour"; location_name="Position 2"; destination_name="Position 3"});
    ignore await create_Event({description="You encouter a herd of monkeys"; questname="Jungle Tour"; location_name="Position 3"; destination_name="Position 4"});
    ignore await create_Event({description="You arrive at camping spoty"; questname="Jungle Tour"; location_name="Position 4"; destination_name="Position 5"});
    ignore await create_Event({description="You encounters a large tree blocking the way"; questname="Jungle Tour"; location_name="Position 5"; destination_name="Position 6"});
    ignore await create_Event({description="There is a river near the path"; questname="Jungle Tour"; location_name="Position 6"; destination_name="Position 7"});

    

    //options
    ignore create_Option({gain_morale=0; risk_chance=0; loss_stamina=0; gain_stamina=0; gain_hp=0; gain_by_luck="Seed/Wood"; lost_other=""; gain_exp=10; lucky_chance=1; description="Start Jungle Tour"; loss_morale=0; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 0"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost=""});

    ignore create_Option({gain_morale=0; risk_chance=0; loss_stamina=2; gain_stamina=0; gain_hp=0; gain_by_luck=""; lost_other=""; gain_exp=10; lucky_chance=0; description="Cut the bushes to open the way with a Knife"; loss_morale=1; loss_mana=0; loss_hp=1; gain_mana=0; location_name="Position 1"; questname="Jungle Tour"; require_item=["Knife","Saw"]; gain_other=""; risk_lost=""});
    ignore create_Option({gain_morale=0; risk_chance=0.6; loss_stamina=1; gain_stamina=0; gain_hp=0; gain_by_luck="Seed/Wood"; lost_other=""; gain_exp=10; lucky_chance=0.1; description="Try to make your way through the bushes without chopping them down"; loss_morale=2; loss_mana=0; loss_hp=2; gain_mana=0; location_name="Position 1"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost="Seed/Wood"});

    ignore create_Option({gain_morale=0; risk_chance=0.6; loss_stamina=2; gain_stamina=0; gain_hp=0; gain_by_luck="Seed/Wood"; lost_other=""; gain_exp=10; lucky_chance=0.2; description="Follow the cliffs to climb up the waterfall"; loss_morale=1; loss_mana=0; loss_hp=2; gain_mana=0; location_name="Position 2"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost="Seed/Wood"});
    ignore create_Option({gain_morale=0; risk_chance=0.4; loss_stamina=3; gain_stamina=0; gain_hp=0; gain_by_luck="Seed/Wood"; lost_other=""; gain_exp=10; lucky_chance=0.1; description="Use Crapple Hook to climb up the waterfall"; loss_morale=0; loss_mana=0; loss_hp=2; gain_mana=0; location_name="Position 2"; questname="Jungle Tour"; require_item=["Crapple Hook"]; gain_other=""; risk_lost="Seed/Wood"});

    ignore create_Option({gain_morale=0; risk_chance=0.3; loss_stamina=1; gain_stamina=0; gain_hp=0; gain_by_luck="Seed/Wood"; lost_other=""; gain_exp=15; lucky_chance=0.5; description="Give them some food"; loss_morale=1; loss_mana=0; loss_hp=1; gain_mana=0; location_name="Position 3"; questname="Jungle Tour"; require_item=["Food"]; gain_other=""; risk_lost="Seed/Wood"});
    ignore create_Option({gain_morale=0; risk_chance=0.7; loss_stamina=2; gain_stamina=0; gain_hp=0; gain_by_luck=""; lost_other=""; gain_exp=5; lucky_chance=0; description="Ignore and find the way to pass through them"; loss_morale=0; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 3"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost=""});

    ignore create_Option({gain_morale=2; risk_chance=0; loss_stamina=0; gain_stamina=2; gain_hp=0; gain_by_luck=""; lost_other="8 hours for waiting"; gain_exp=0; lucky_chance=0; description="Take a rest"; loss_morale=0; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 4"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost=""});
    ignore create_Option({gain_morale=0; risk_chance=0; loss_stamina=0; gain_stamina=0; gain_hp=2; gain_by_luck=""; lost_other="-1 food"; gain_exp=0; lucky_chance=0; description="Cook"; loss_morale=0; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 4"; questname="Jungle Tour"; require_item=["Food"]; gain_other=""; risk_lost=""});
    ignore create_Option({gain_morale=0; risk_chance=0; loss_stamina=0; gain_stamina=0; gain_hp=0; gain_by_luck=""; lost_other=""; gain_exp=10; lucky_chance=0; description="Continue"; loss_morale=0; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 4"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost=""});
    ignore create_Option({gain_morale=0; risk_chance=0; loss_stamina=0; gain_stamina=0; gain_hp=0; gain_by_luck=""; lost_other=""; gain_exp=5; lucky_chance=0; description="Save"; loss_morale=0; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 4"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost=""});

    ignore create_Option({gain_morale=0; risk_chance=0; loss_stamina=3; gain_stamina=0; gain_hp=0; gain_by_luck="Seed/Wood"; lost_other=""; gain_exp=0; lucky_chance=0.7; description="Use a knife to cut branches to open the way"; loss_morale=2; loss_mana=0; loss_hp=1; gain_mana=0; location_name="Position 5"; questname="Jungle Tour"; require_item=["Knife","Saw"]; gain_other=""; risk_lost=""});
    ignore create_Option({gain_morale=0; risk_chance=0.8; loss_stamina=1; gain_stamina=0; gain_hp=0; gain_by_luck="Seed/Wood"; lost_other=""; gain_exp=0; lucky_chance=0.1; description="Find another way to go"; loss_morale=1; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 5"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost="Position 3"});

    ignore create_Option({gain_morale=0; risk_chance=0.4; loss_stamina=2; gain_stamina=0; gain_hp=0; gain_by_luck=""; lost_other=""; gain_exp=10; lucky_chance=0; description="Use inflatable boat to go through the river"; loss_morale=0; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 6"; questname="Jungle Tour"; require_item=["Knife","Saw"]; gain_other=""; risk_lost="Seed/Wood"});
    ignore create_Option({gain_morale=0; risk_chance=0.7; loss_stamina=1; gain_stamina=0; gain_hp=0; gain_by_luck=""; lost_other=""; gain_exp=10; lucky_chance=0; description="Continue to move along the river-bankn"; loss_morale=1; loss_mana=0; loss_hp=0; gain_mana=0; location_name="Position 6"; questname="Jungle Tour"; require_item=[]; gain_other=""; risk_lost=""}); //xu ly vu mat moi thu

    //materials
    ignore await create_Material({name="Seed"; description=""});
    ignore await create_Material({name="Wood"; description=""});

    //quest items
    ignore await create_QuestItem({name="Knife"; image=""; strength_required=0.5});
    ignore await create_QuestItem({name="Medicine"; image=""; strength_required=0.5});
    ignore await create_QuestItem({name="Climbing stick"; image=""; strength_required=1});
    ignore await create_QuestItem({name="Bicycle"; image=""; strength_required=5});
    ignore await create_QuestItem({name="Tent"; image=""; strength_required=3});
    ignore await create_QuestItem({name="Clothes"; image=""; strength_required=2});
    ignore await create_QuestItem({name="Camera"; image=""; strength_required=1.5});
    ignore await create_QuestItem({name="Food"; image=""; strength_required=0.5});
    ignore await create_QuestItem({name="Water"; image=""; strength_required=0.5});
    ignore await create_QuestItem({name="Crapple Hook"; image=""; strength_required=1});
    ignore await create_QuestItem({name="Inflatable Boat & paddle"; image=""; strength_required=4});
    ignore await create_QuestItem({name="Saw"; image=""; strength_required=0.5});
    ignore await create_QuestItem({name="Antidote"; image=""; strength_required=0.5});

    //Quest Item For Quest
    ignore create_Quest_Item_For_Quest({questname="Jungle Tour"; quest_itemname="Knife"});
    ignore create_Quest_Item_For_Quest({questname="Jungle Tour"; quest_itemname="Food"});
    ignore create_Quest_Item_For_Quest({questname="Jungle Tour"; quest_itemname="Crapple Hook"});
    ignore create_Quest_Item_For_Quest({questname="Jungle Tour"; quest_itemname="Saw"});
    ignore create_Quest_Item_For_Quest({questname="Jungle Tour"; quest_itemname="Inflatable Boat & paddle"});
    return;
  };

  // UI--------------------------------------------------------------------------------
  public func UI_Character_Info(charname : Text) : async Result.Result<Types.Character_Info, Types.Error> {
    let findchar = await find_Charname(charname);
    switch(findchar) {
      case null {
        #err(#CharacterNotFound);
      };
      case (?c) {
        let info : Types.Character_Info = {
          curr_hp = c.current_hp;
          curr_mana = c.current_mana;
          curr_stamina = c.current_stamina;
          curr_morale = c.current_morale;
        };
        #ok(info);
      };
    };
  };

  public func UI_Bag(charname: Text) : async Result.Result<Types.Bag, Types.Error> {
    let findchar = await find_Charname(charname);
    switch(findchar) {
      case null {
        #err(#CharacterNotFound);
      };
      case (?c) {
        //ham lay material cua nv
        let getmaterials : [Types.Material_Amount] = get_Character_Materials(c.id);
        //ham lay item cua nv
        let getitems : [Types.Quest_Item_Info] = get_Character_QuestItems(c.id);
        //ham lay tong strength cua tat ca cac item
        let getcapacity = get_Capacity(c.id);
        //tao bien kieu tui, luu tat ca ca ham tren, tra ve
        let newBag : Types.Bag = {
          material_amount = getmaterials;
          items = getitems;
          capacity = getcapacity;
        };
        #ok(newBag);
      };
    };    
  };

  public func UI_Character_Take_Option(cto: Types.Character_Take_Option_Creation) : async Result.Result<Types.Event_withOp, Types.Error> {
    let findcharacterkey = await find_Charkey(cto.charactername);
    let findoptionkey = await find_Optionkey(cto.description);

    let findcharacter = state.characters.get(findcharacterkey);
    switch(findcharacter) {
      case null {
        #err(#CharacterNotFound);
      };
      case (?char) { 
        if (char.status == "Dead") {
          return #err(#CharacterisDead);
        };

        let findoption = state.options.get(findoptionkey);
        switch(findoption) {
          case null {
            #err(#OptionNotFound);
          };
          case (?op) {
            let event_op = await get_Eventid_fromOptionid(findoptionkey);
            let location = await get_Location_fromEventid(event_op);
            if (location == "Position 0" or char.status == event_op) {
              let checkquestitemisrequired = await check_QuestItemisRequired(findoptionkey);
              if (checkquestitemisrequired == false) {
                return #err(#NotQuestItemIsRequired);
              };
              return await create_CharacterTakeOption(char.id, findoptionkey, event_op);
            };
            #err(#InvalidOption);
          };
        };
      };
    };
  };

  public func UI_Character_Carrying_QuestItems(c_qi : Types.Character_Carrying_QuestItem_Creation) : async Result.Result<(), Types.Error>{
    let findcharacter = await find_Charname(c_qi.charactername);
    switch(findcharacter) {
      case null {
        #err(#CharacterNotFound);
      };
      case (?c) {
        if (c.status == "Dead" or c.status != "Idle") {
          return #err(#BagOutOfSpace);
        };

        let findquestitem = await find_QuestItemkey(c_qi.questitem);
        switch(findquestitem) {
          case null {
            #err(#QuestItemNotFound);
          };
          case (?qi) {
            let checkccq = check_CarryingQuestItem(c.id,qi);
            if (checkccq == true) {
              return #err(#AlreadyExists);
            };

            let checkstrength = await check_StrengthRequire(c.id, qi);
            if (checkstrength == false) {
              return #err(#LimitedStrength);
            };

            var id = await random_id();
            var find = state.charactercarryingquestitems.get(id);
            while (find != null) {
              id := await random_id();
              find := state.charactercarryingquestitems.get(id);
            };

            let newCharactercarryingitem : Types.Character_Carrying_QuestItem = {
              characterid = c.id;
              questitemid = qi;
            };

            let created = state.charactercarryingquestitems.put(id, newCharactercarryingitem);
            #ok(());
          };
        };
      };
    };
  };

  public func UI_Quest_Info() : async [Types.Quest_Info] {
    var list_quest : [Types.Quest_Info] = [];
    for (q in state.quests.entries()) {
      var items : [Text] = []; 
      for (qifq in state.questitemforquests.vals()) {
        if (qifq.questid == q.0) {
          let finditem = state.questitems.get(qifq.quest_itemid);
          switch(finditem) {
            case null {
              ();
            };
            case (?qi) {
              items := Array.append(items, [qi.name]);
            };
          };
        };
      };
      let newInfo : Types.Quest_Info = {
        name = q.1.name;
        price = q.1.price;
        description = q.1.description;
        required_item = items;
      };
      list_quest := Array.append(list_quest, [newInfo]);
    };
    list_quest;
  };

  // create, read, delete User---------------------------------------------------------
  public shared(msg)  func create_User(u: Types.User_Creation) : async Result.Result<(), Types.Error> {
    let callerid = msg.caller;

    // if (Principal.toText(callerid) == "2vxsx-fae") {
    //     return #err(#NotAuthorized);
    // };

    if (u.psswd != u.confirm) {
      return #err(#IncorrectPassword);
    };

    // check username
    let findname = await find_Username(u.username);
    switch(findname) {
      case null {
        // random id for user
        var u_id = await random_id();
        var finduser = state.users.get(u_id);
        while (finduser != null) {
          u_id := await random_id();
          finduser := state.users.get(u_id);
        };

        let newUser : Types.User = {
          id = u_id;
          username = u.username;
          password = u.psswd;
        };
        let created = state.users.put(u_id, newUser);
        #ok(());
      };
      case (?user) {
        #err(#UserAlreadyExists);
      };
    };    
  };


  // public query func read_User(u_id: Text) : async Result.Result<Types.User, Types.Error> {
  //   let result = state.users.get(u_id);
  //   Result.fromOption(result, #UserNotFound);
  // };

  // public shared(msg) func delete_User(u_id: Text) : async Result.Result<(), Types.Error> {
  //   let callerid = msg.caller;

  //   let finduser = state.users.get(u_id);
  //   switch(finduser) {
  //     case null {
  //       #err(#UserNotFound);
  //     };
  //     case (?v) {
  //       let deleteUser = state.users.remove(v.id);
  //       #ok(());
  //     };
  //   };
  // };

  //create, read, update, change status, delete  Character--------------------------------------------------------------------
  public shared(msg) func create_Character(c : Types.Character_Creation) : async Result.Result<(), Types.Error> {

    let finduser = state.users.get(c.user_id);
    switch(finduser) {
      case null {
        #err(#UserNotFound);
      };
      case (?u) {  
        let findcharacterclass = await find_Classname(c.character_class_name);
        switch(findcharacterclass) {
          case null {
            #err(#CharacterClassNotFound);
          };
          case (?v) { 
            let findchar = await find_Charname(c.character_name);
            switch(findchar) {
              case null {
                  var characterid = u.id # Nat32.toText(state.num_character);

                  let findcharacter = state.characters.get(characterid);
                  if (findcharacter != null) {
                    return #err(#CharacterAlreadyExists);
                  }; 
                  
                  let newCharacter : Types.Character = {
                  id = characterid;
                  name = c.character_name;
                  level = 1;
                  current_Exp = 0;
                  lvlup_Exp = 100;
                  status = "Idle";

                  current_hp = v.base_hp;
                  max_hp = v.base_hp;
                  current_mana = v.base_mana;
                  max_mana = v.base_mana;
                  current_stamina = v.base_stamina;
                  max_stamina = v.base_stamina;
                  current_morale = v.base_morale;
                  max_morale = v.base_morale;

                  strength = v.base_strength;
                  intelligent = v.base_intelligent;
                  vitality = v.base_vitality;
                  luck = v.base_luck;

                  //belong to
                  class_name = v.class_name;

                  //participate
                  current_questid = "";
                };
                let created = state.characters.put(characterid, newCharacter);
                state := State.inc_charid(state);
                #ok(());
              };
              case (?char) {
                #err(#CharacterAlreadyExists);
              };
            };
          };
        }; 
      };
    };
  };


  // public query func read_Character(c_id: Text) : async Result.Result<Types.Character, Types.Error> {
  //   let result = state.characters.get(c_id);
  //   Result.fromOption(result, #CharacterNotFound);
  // };

  // private func update_Character(c: Types.Character) : async Result.Result<(), Types.Error> {
  //   let result = state.characters.get(c.id);
  //   switch(result) {
  //     case null {
  //       #err(#CharacterNotFound);
  //     };
  //     case (?v) {
  //       let updateCharacter = state.characters.replace(v.id, c);
  //       #ok(());
  //     };
  //   };
  // };

  private func change_StatusOfCharacter(id: Text, s: Text) : async Result.Result<(), Types.Error> {
    let findcharacter = state.characters.get(id);
    switch(findcharacter) {
      case null {
        #err(#CharacterNotFound);
      };
      case (?c) {
        let char : Types.Character = {
          id = c.id;
          name = c.name;
          class_name = c.class_name;
          level = c.level;
          current_Exp = c.current_Exp;
          lvlup_Exp = c.lvlup_Exp;
          status = s;

          current_hp = c.current_hp;
          max_hp = c.max_hp;
          current_mana = c.current_mana;
          max_mana = c.max_mana;
          current_stamina = c.current_stamina;
          max_stamina = c.max_stamina;
          current_morale = c.current_morale;
          max_morale = c.max_morale;

          strength = c.strength;
          intelligent = c.intelligent;
          vitality = c.vitality;
          luck = c.luck;

          current_questid = c.current_questid;
        };
        let updated = state.characters.replace(c.id, char);
        #ok(());
      };
    };
  };

  // public func delete_Character(c_id: Text) : async Result.Result<(), Types.Error> {
  //   let result = state.characters.get(c_id);
  //   switch(result) {
  //     case null {
  //       #err(#CharacterNotFound);
  //     };
  //     case (?v) {
  //       let deleteCharacter = state.characters.remove(c_id);
  //       #ok(());
  //     };
  //   };
  // };

  //create, read, update, delete Character Class--------------------------------------------------------------  
  private  func create_CharacterClass(c: Types.Character_Class) : async Result.Result<(), Types.Error> {
    let find_classname = await find_Classname(c.class_name);
    switch(find_classname) {
      case null {
        var c_id = await random_id();
        var findcharacterclass = state.character_classes.get(c_id);
        while (findcharacterclass != null) {
          c_id := await random_id();
          findcharacterclass := state.character_classes.get(c_id);
        };

        let newCharacterClass : Types.Character_Class = {
          class_name = c.class_name;
          description = c.description;

          base_mana = c.base_mana;
          base_stamina = c.base_stamina;
          base_morale = c.base_morale;
          base_hp = c.base_hp;

          base_strength = c.base_strength;
          base_intelligent = c.base_intelligent;
          base_vitality = c. base_vitality;
          base_luck = c.base_luck;
        };
        let created = state.character_classes.put(c_id, newCharacterClass);
        #ok(());
      };
      case (?cl) {
        #err(#CharacterClassAlreadyExists);
      };
    };    
  };


  // public query func read_characterClass(id : Text) : async Result.Result<Types.Character_Class, Types.Error> {
  //   let result = state.character_classes.get(id);
  //   Result.fromOption(result, #CharacterClassNotFound);
  // };

  // public func update_characterClass(id: Text, c : Types.Character_Class) : async Result.Result<(), Types.Error> {
  //   let result = state.character_classes.get(id);
  //   switch(result) {
  //     case null {
  //       #err(#CharacterClassNotFound);
  //     };
  //     case (?v) {
  //       let updateCharacterClass = state.character_classes.replace(id, c);
  //       #ok(());
  //     };
  //   };
  // };

  // public func delete_characterClass(id: Text) : async Result.Result<(), Types.Error> {
  //   let result = state.character_classes.get(id);
  //   switch(result) {
  //     case null {
  //       #err(#CharacterClassNotFound);
  //     };
  //     case (?v) {
  //       let deleteCharacterClass = state.character_classes.remove(id);
  //       #ok(());
  //     };
  //   };
  // };

  // create, collect, make lost, make gain material--------------------------------------------------------------------------------------
  private func create_Material(m: Types.Material) : async Result.Result<(), Types.Error> {
    let findmaterial = await find_Materialname(m.name);
    switch(findmaterial) {
      case null {
        var materialid = await random_id();
        var find = state.materials.get(materialid);
        while (find != null) {
          materialid := await random_id();
          find := state.materials.get(materialid);
        };

        let created= state.materials.put(materialid, m);
        #ok(());
      };
      case (?ma) {
        #err(#AlreadyExists);
      };
    };
  };

  private func create_Character_Collect_Material(charid: Text, ma_id: Text, amount_modifier: Int) : async Result.Result<(), Types.Error> {
    let findccm = await find_CollectMaterialkey(charid, ma_id);
    switch(findccm) {
      case null {
        if (amount_modifier > 0) {
          var id = await random_id();
          var find = state.charactercollectmaterials.get(id);
          while (find != null) {
            id := await random_id();
            find := state.charactercollectmaterials.get(id);
          };

          let newCharacterColMat : Types.Character_Collect_Material = {
            characterid = charid;
            materialid = ma_id;
            amount = Int.max(amount_modifier, 0);
          };

          let created = state.charactercollectmaterials.put(id, newCharacterColMat);
        };
        #ok(());
      };
      case (?v) {
        let findcharcolmat = state.charactercollectmaterials.get(v);
        switch(findcharcolmat) {
          case null {
            #err(#NotFound);
          };
          case (?ccm) {
            let update_amount = ccm.amount + amount_modifier;
            if (update_amount <= 0 ) {
              let deleted = state.charactercollectmaterials.remove(v);
            } else {
              let updateCharacterColMat : Types.Character_Collect_Material = {
                characterid = charid;
                materialid = ma_id;
                amount = Int.max(update_amount, 0);
              }; 
              let updated = state.charactercollectmaterials.replace(v,updateCharacterColMat);
            };
            #ok(());
          };
        };
      };
    };    
  };

  private func make_Character_lostMaterial(charid: Text, materials: Text) : async () {
    let list = Text.split(materials, #text "/");
    for ( m in list) {
      let findmaterial = await find_Materialkey_fromName(m);
      if ( findmaterial != "") {
        let lost_amount = await rand(1,5);
        ignore await create_Character_Collect_Material(charid, findmaterial, - lost_amount);
      };
    };
    ();
  };

  private func make_Character_gainMaterial(charid: Text, materials: Text) : async () {
    let list = Text.split(materials, #text "/");
    for ( m in list) {
      let findmaterial = await find_Materialkey_fromName(m);
      if ( findmaterial != "") {
        let gain_amount = await rand(1,5);
        ignore await create_Character_Collect_Material(charid, findmaterial, gain_amount);
      };
    };
    ();
  };

  // create quest--------------------------------------------------------------------------------------
  private func create_Quest(q: Types.Quest) : async Result.Result<(), Types.Error> {
    let findquest = await find_Questkey(q.name);
    switch(findquest) {
      case null {
        var q_id = await random_id();
        var find= state.quests.get(q_id);
        while (find != null) {
          q_id := await random_id();
          find := state.quests.get(q_id);
        };

        let created = state.quests.put(q_id, q);
        #ok(());
      };
      case (?qk) {
        #err(#QuestAlreadyExists);
      };
    };
  };

  //create event---------------------------------------------------------------------------------
  private func create_Event(e : Types.Event_Creation) : async Result.Result<(), Types.Error> {
    let findquest = await find_Questkey(e.questname);

    switch(findquest) {
      case null {
        #err(#QuestNotFound);
      };
      case (?qk) {
        let findevent = await find_Eventkey(qk, e.location_name);
        switch(findevent) {
          case null {
            var eventid = await random_id();
            var find= state.events.get(eventid);
            while (find != null) {
              eventid := await random_id();
              find := state.events.get(eventid);
            };

            let newEvent : Types.Event = {
              questid = qk;
              description = e.description;
              location_name = e.location_name;
              destination_name = e.destination_name;
            };

            let created = state.events.put(eventid,newEvent);
            #ok(());
          };
          case (?ek) {
            #err(#EventAlreadyExists);
          };
        };
      };
    } ;   
  };

  //create, take option--------------------------------------------------------------------------------------
  private func create_Option(op : Types.Option_Creation) : async Result.Result<(), Types.Error> {
    let findquest = await find_Questkey(op.questname);
    switch(findquest) {
      case null {
        #err(#QuestNotFound);
      };
      case (?qk) {
        let findevent = await find_Eventkey(qk, op.location_name);
        switch(findevent) {
          case null {
            #err(#EventNotFound);
          };
          case (?ek) {
            let checkoption = check_OptionwithDesc(op.description);
            if (checkoption == true) {
              return #err(#OptionAlreadyExists);
            };

            var optionid = await random_id();
            var findoption = state.options.get(optionid);
            while (findoption != null) {
              optionid := await random_id();
              findoption := state.options.get(optionid);
            };

            let newOption : Types.Option = {
              eventid = ek;
              description = op.description;
              require_item = op.require_item;
              loss_stamina = op.loss_stamina;
              loss_morale = op.loss_morale;
              loss_hp = op.loss_hp;
              loss_mana = op.loss_mana;
              risk_chance = op.risk_chance;
              risk_lost = op.risk_lost;
              lost_other = op.lost_other;
              gain_stamina = op.gain_stamina;
              gain_morale = op.gain_morale;
              gain_hp = op.gain_hp;
              gain_mana = op.gain_mana;
              gain_exp = op.gain_exp;
              lucky_chance = op.lucky_chance;
              gain_by_luck = op.gain_by_luck;
              gain_other = op.gain_other;
            };

            let created = state.options.put(optionid, newOption);
            #ok(());
          };
        };
      };
    };
  };

  private func create_CharacterTakeOption(charid: Text, opid: Text, eventid: Text) : async Result.Result<Types.Event_withOp, Types.Error> {
    let findevent = state.events.get(eventid);
    switch(findevent) {
      case null {
        #err(#NotFound);
      };
      case (?e) {
        var destination_name = e.destination_name;

        let findchar = state.characters.get(charid);
        switch(findchar) {
          case null {
            #err(#NotFound);
          };
          case (?ch) {
            var result = "";

            let findoption = state.options.get(opid);
            switch(findoption) {
              case null {
                return #err(#NotFound);
              };
              case (?op) {

                //update character attributes 
                let updatechar : Types.Character = {
                  id = ch.id;
                  name = ch.name;
                  class_name = ch.class_name;
                  level = ch.level;
                  current_Exp = ch.current_Exp;
                  lvlup_Exp = ch.lvlup_Exp;
                  status = ch.status;

                  current_hp = Float.min(Float.max((ch.current_hp-op.loss_hp)+op.gain_hp , 0.0) , ch.max_hp);
                  max_hp = ch.max_hp;
                  current_mana = Float.min(Float.max((ch.current_mana-op.loss_mana)+op.gain_mana , 0.0) , ch.max_mana);
                  max_mana = ch.max_mana;
                  current_stamina = Float.min(Float.max((ch.current_stamina-op.loss_stamina)+op.gain_stamina , 0.0) , ch.max_stamina);
                  max_stamina = ch.max_stamina;
                  current_morale = Float.min(Float.max((ch.current_morale-op.loss_morale)+op.gain_morale , 0.0) , ch.max_morale);
                  max_morale = ch.max_morale;

                  strength = ch.strength;
                  intelligent = ch.intelligent;
                  vitality = ch.vitality;
                  luck = ch.luck;

                  current_questid = ch.current_questid;
                };

                let updatedChar = state.characters.replace(ch.id, updatechar);

                // check risk, lucky
                let random_percent = await float_rand(0,1);
                result := Float.toText(random_percent);
                if (random_percent > 0 and random_percent <= op.risk_chance) {
                  let risk = op.risk_lost;
                  if (Text.contains(risk, #text "/") == true) {
                    await make_Character_lostMaterial(charid, op.risk_lost);
                    result := result # " You lost some " # op.risk_lost # ".";
                  };
                  if (Text.contains(risk, #text "Position") == true) {
                    destination_name := op.risk_lost;
                    result := result # " You went back to " # op.risk_lost # ".";
                  };
                };
                if (random_percent > op.risk_chance and random_percent <= (op.risk_chance+op.lucky_chance)) {
                  let luck = op.gain_by_luck;
                  if (Text.contains(luck,#text "/") == true) {
                    await make_Character_gainMaterial(charid, op.gain_by_luck);
                    result := result # " You gain some " # op.gain_by_luck # ".";
                  };
                };

                // create Character Take Option
                var ctoid = await random_id();
                var findcto = state.charactertakeoptions.get(ctoid);
                while (findcto != null) {
                  ctoid := await random_id();
                  findcto := state.charactertakeoptions.get(ctoid);
                };
                let newChatakeop : Types.Character_Take_Option = {
                  characterid = ch.id;
                  optionid = opid;
                  pickuptime = Time.now();
                  char_current_hp = updatechar.current_hp;
                  char_max_hp = updatechar.max_hp;
                  char_current_mana = updatechar.current_mana;
                  char_max_mana = updatechar.max_mana;
                  char_current_stamina = updatechar.current_stamina;
                  char_max_stamina = updatechar.max_stamina;
                  char_current_morale = updatechar.current_morale;
                  char_max_morale = updatechar.max_morale;
                };

                let created = state.charactertakeoptions.put(ctoid, newChatakeop);

                if (updatechar.current_hp == 0 or updatechar.current_morale == 0 or updatechar.current_stamina == 0) {
                  ignore await change_StatusOfCharacter(updatechar.id, "Dead");
                  return #err(#CharacterisDead);
                };
              };
            };


            // get next event
            let next_event = await find_Eventkey(e.questid, destination_name);
            switch(next_event) {
              case null {
                ignore await change_StatusOfCharacter(ch.id, "Idle");
                return #err(#QuestIsCompleted);
              };
              case (?ne) {
                ignore await change_StatusOfCharacter(ch.id, ne);
                let event = await get_Desc_fromEventid(ne);
                let list_op = await get_OptionDesc(ne);
                let desc_eventop : Types.Event_withOp = {
                  result_desc = result;
                  event_desc = event;
                  option_desc = list_op;
                };
                return #ok(desc_eventop);
              };
            };
          };
        };
      };
    };
  };

  
  //create quest items---------------------------------------------------------------------------------
  private func create_QuestItem(i : Types.Quest_Item) : async Result.Result<(), Types.Error> {
    let findquestitem = await find_QuestItemkey(i.name);
    switch(findquestitem) {
      case null {
        var itemid = await random_id();
        var finditem = state.questitems.get(itemid);
        while (finditem != null) {
          itemid := await random_id();
          finditem := state.questitems.get(itemid);
        };

        let created = state.questitems.put(itemid, i);
        #ok(());
      };
      case (?v) {
        #err(#QuestItemAlreadyExists);
      };
    };
  };

  //create Quest item for quest---------------------------------------------------------------------------
  private func create_Quest_Item_For_Quest(qi: Types.Quest_Item_For_Quest_Creation) : async Result.Result<(), Types.Error> {
    let findquest = await find_Questkey(qi.questname);

    switch(findquest) {
      case null {
        #err(#QuestNotFound);
      };
      case (?q) {
        let findquestitem = await find_QuestItemkey(qi.quest_itemname);
        switch(findquestitem) {
          case null {
            #err(#QuestItemNotFound);
          };
          case (?i) {
            let checkqifq = check_QuestItemForQuest(q,i);
            if (checkqifq == true) {
              return #err(#AlreadyExists);
            };

            var id = await random_id();
            var find = state.events.get(id);
            while (find != null) {
              id := await random_id();
              find := state.events.get(id);
            };

            let newQuestitemforquest : Types.Quest_Item_For_Quest = {
              questid = q;
              quest_itemid = i;
            };

            let created = state.questitemforquests.put(id, newQuestitemforquest);
            #ok(());
          };
        };
      };
    };
  };


  //lists--------------------------------------------------------------------------------------------------
  public query func show_users() : async [Types.User] {
    var list_user : [Types.User] = [];
    for (val in state.users.vals()) {
      list_user := Array.append(list_user, [val]);
    };
    list_user;
  };

  public query func show_characters() : async [Types.Character] {
    var list_character : [Types.Character] = [];
    for (val in state.characters.vals()) {
      list_character := Array.append(list_character, [val]);
    };
    list_character;
  };

  public query func show_character_classes() : async [Types.Character_Class] {
    var list_characterclass : [Types.Character_Class] = [];
    for (val in state.character_classes.vals()) {
      list_characterclass := Array.append(list_characterclass, [val]);
    };
    list_characterclass;
  };

  public query func show_materials() : async [Types.Material] {
    var list_materials : [Types.Material] = [];
    for (val in state.materials.vals()) {
      list_materials := Array.append(list_materials, [val]);
    };
    list_materials;
  };

  public query func show_charactercollectmaterials() : async [Types.Character_Collect_Material] {
    var list: [Types.Character_Collect_Material] = [];
    for (val in state.charactercollectmaterials.vals()) {
      list := Array.append(list, [val]);
    };
    list;
  };

  public query func show_quests() : async [Types.Quest] {
    var list_quests : [Types.Quest] = [];
    for (val in state.quests.vals()) {
      list_quests := Array.append(list_quests, [val]);
    };
    list_quests;
  };

  public query func show_events() : async [Types.Event] {
    var list_events : [Types.Event] = [];
    for (val in state.events.vals()) {
      list_events := Array.append(list_events, [val]);
    };
    list_events;
  };

  public query func show_options() : async [Types.Option] {
    var list_options : [Types.Option] = [];
    for (val in state.options.vals()) {
      list_options := Array.append(list_options, [val]);
    };
    list_options;
  };
  
  public query func show_questitems() : async [Types.Quest_Item] {
    var list_questitems : [Types.Quest_Item] = [];
    for (val in state.questitems.vals()) {
      list_questitems := Array.append(list_questitems, [val]);
    };
    list_questitems;
  };

public query func show_charactercarryingquestitems() : async [Types.Character_Carrying_QuestItem] {
    var list : [Types.Character_Carrying_QuestItem] = [];
    for (val in state.charactercarryingquestitems.vals()) {
      list := Array.append(list, [val]);
    };
    list;
  };

  public query func show_questitemforquests() : async [Types.Quest_Item_For_Quest] {
    var list_questitemforquests : [Types.Quest_Item_For_Quest] = [];
    for (val in state.questitemforquests.vals()) {
      list_questitemforquests := Array.append(list_questitemforquests, [val]);
    };
    list_questitemforquests;
  };  
  
  
  
  //find funcs------------------------------------------------------------------------------------------
  private func find_Username(name : Text) : async ?Types.User {
    for (u in state.users.vals()){
      if (u.username == name) {
        return ?u;
      };
    };
    return null;
  };

  private func find_Classname(name : Text) : async ?Types.Character_Class {
    for (c in state.character_classes.vals()){
      if (c.class_name == name) {
        return ?c;
      };
    };
    return null;
  };

  private func find_Charname(name : Text) : async ?Types.Character {
    for (c in state.characters.vals()){
      if (c.name == name) {
        return ?c;
      };
    };
    return null;
  };

  private func find_Charkey(name: Text) : async Text {
    for (c in state.characters.entries()){
      let k = c.0;
      let v = c.1;
      if (v.name == name) {
        return k;
      };
    };
    return "";
  };

  private func find_Materialname(name: Text) : async ?Types.Material {
    for (m in state.materials.vals()){
      if (m.name == name) {
        return ?m;
      };
    };
    return null;
  };

  private func find_Materialname_fromkey(id: Text) : async Text {
    for (m in state.materials.entries()){
      if (m.0 == id) {
        return m.1.name;
      };
    };
    return "";
  };

  private func find_Materialkey_fromName(name: Text) : async Text {
    for (m in state.materials.entries()) {
      if (m.1.name == name) {
        return m.0;
      };
    };
    return "";
  };

  private func find_CollectMaterialkey(charid: Text, materialid: Text) : async ?Text {
    for (m in state.charactercollectmaterials.entries()) {
      if (m.1.characterid == charid and m.1.materialid == materialid) {
        return ?m.0;
      };
    };
    return null;
  };

  private func find_Questname(name : Text) : async ?Types.Quest {
    for (q in state.quests.vals()){
      if (q.name == name) {
        return ?q;
      };
    };
    return null;
  };

  private func find_Questkey(name: Text) : async ?Text {
    for (i in state.quests.entries()){
      let k = i.0;
      let v = i.1;
      if (v.name == name) {
        return ?k;
      };
    };
    return null;
  };

  private func find_Event(questid: Text, locationname: Text) : async ?Types.Event {
    for (e in state.events.vals()){
      if (e.questid == questid and e.location_name == locationname) {
        return ?e;
      };
    };
    return null;
  };

  private func find_Eventkey(questid: Text, locationname: Text) : async ?Text {
    for (i in state.events.entries()){
      let k = i.0;
      let v = i.1;
      if (v.questid == questid and v.location_name == locationname) {
        return ?k;
      };
    };
    return null;
  };

  private func find_QuestItemname(name : Text) : async ?Types.Quest_Item {
    for (q in state.questitems.vals()){
      if (q.name == name) {
        return ?q;
      };
    };
    return null;
  };

  private func find_QuestItemkey(name: Text) : async ?Text {
    for (i in state.questitems.entries()){
      let k = i.0;
      let v = i.1;
      if (v.name == name) {
        return ?k;
      };
    };
    return null;
  };

  private func find_Optionkey(des: Text) : async Text {
    for (i in state.options.entries()){
      let k = i.0;
      let v = i.1;
      if (v.description == des) {
        return k;
      };
    };
    return "";
  };

  //check func------------------------------------------------------------------------------
  private func check_OptionwithDesc(description : Text) : Bool {
    for (op in state.options.vals()) {
      if (op.description == description) {
        return true;
      };
    };
    false;
  };  

  private func check_QuestItemForQuest(questid: Text, itemid: Text) : Bool {
    for (q in state.questitemforquests.entries()) {
      let k = q.0;
      let v = q.1;
      if (v.questid == questid and v.quest_itemid == itemid) {
        return true;
      };
    };
    false;
  };

  private func check_CarryingQuestItem(charid: Text, itemid: Text) : Bool {
    for (q in state.charactercarryingquestitems.entries()) {
      let k = q.0;
      let v = q.1;
      if (v.characterid == charid and v.questitemid == itemid) {
        return true;
      };
    };
    false;
  };
  private func check_StrengthRequire(charid: Text, itemid: Text) :  async Bool {
    let findchar = state.characters.get(charid);
    switch(findchar) {
      case null {
        false;
      };
      case (?char) {
        let finditem = state.questitems.get(itemid);
        switch(finditem) {
          case null {
            false;
          };
          case (?item) {
            var sum_strength = get_SumStrengthRequire();
            sum_strength += item.strength_required;

            if (sum_strength > char.strength) {
              return false;
            };
            true;
          };
        };
      };
    };
  };

  private func check_QuestItemisRequired(opid : Text) : async Bool {
    let findoption = state.options.get(opid);
    switch(findoption) {
      case null {
        return false;
      };
      case (?op) {
        if (op.require_item == []) {
          return true;
        };

        for (re_item in state.charactercarryingquestitems.vals()) {
          for (item in Array.vals(op.require_item)) {
            let finditem= await find_QuestItemkey(item);
            switch(finditem) {
              case null {
                return false;
              };
              case (?i) {
                if (i==re_item.questitemid) {
                  return true;
                };
              };
            };
          };
        };
        return false;
      };
    };
  };


  //get func------------------------------------------------------------------------------


  private func get_Eventid_fromOptionid(opid: Text) : async Text {
    let findoption = state.options.get(opid);
    switch(findoption) {
      case null {
        "";
      };
      case (?op) {
        op.eventid;
      };
    };
  };

  private func get_Location_fromEventid(e_id: Text) : async Text {
    let findevent = state.events.get(e_id);
    switch(findevent) {
      case null {
        "";
      };
      case (?e) {
        e.location_name;
      };
    };
  };

  private func get_Desc_fromEventid(e_id: Text) : async Text {
    let findevent = state.events.get(e_id);
    switch(findevent) {
      case null {
        "";
      };
      case (?e) {
        e.description;
      };
    };
  };

  private func get_OptionDesc(e_id: Text) : async [Text] {
    let findevent = state.events.get(e_id);
    switch(findevent) {
      case null {
        [];
      };
      case (?e) {
        var list : [Text] = [];
        for (op in state.options.vals()) {
          if (op.eventid == e_id) {
            list := Array.append(list, [op.description]);
          };
        };
        list;
      };
    };
  };

  private func get_SumStrengthRequire() : Float {
    var sum_strength : Float = 0;
    for (i in state.charactercarryingquestitems.vals()) {
      let finditem = state.questitems.get(i.questitemid);
      switch(finditem) {
        case null {
          ();
        };
        case (?item) {
          sum_strength += item.strength_required;
        };
      };
    };
    sum_strength;
  };  

  private func get_Character_Materials(charid: Text) : [Types.Material_Amount] {
    var list : [Types.Material_Amount] = [];
    for (i in state.charactercollectmaterials.vals()) {
      if (charid == i.characterid) {
        let findmaterial = state.materials.get(i.materialid);
        switch(findmaterial) {
          case null {
            ();
          };
          case (?m) {
            let newma : Types.Material_Amount = {
              materialname = m.name;
              description = m.description;
              amount = i.amount;
            };
            list := Array.append(list, [newma]);
          };
        };
      };
    };
    list;
  };

  private func get_Capacity(charid: Text) : Float {
    var result : Float = 0;
    for (i in state.charactercarryingquestitems.vals()) {
      if (charid == i.characterid) {
        let finditem = state.questitems.get(i.questitemid);
        switch(finditem) {
          case null {
            ();
          };
          case (?qi) {
            result += qi.strength_required;
          };
        };
      };
    };
    result;
  };

  private func get_Character_QuestItems(charid: Text) : [Types.Quest_Item_Info] {
    var list : [Types.Quest_Item_Info] = [];
    for (i in state.charactercarryingquestitems.vals()) {
      if (charid == i.characterid) {
        let finditem = state.questitems.get(i.questitemid);
        switch(finditem) {
          case null {
            list := list;
          };
          case (?qi) {
            let newqi : Types.Quest_Item_Info = {
              questitemname = qi.name;
              strength_required = qi.strength_required;
            };
            list := Array.append(list, [newqi]);
          };
        };
      };
    };
    list;
  };

  //other funcs----------------------------------------------------------------------------

  private func rand(from: Nat, to: Nat) : async Nat {
    let x = await Random.blob();
    (Random.rangeFrom(7, x)%(to-from+1))+from;
  };
  private func float_rand(from: Int, to: Int) :  async Float {
    let x = await Random.blob();
    let a : Int = (Random.rangeFrom(7, x)%((to - 1) - from + 1)) + from;
    let b : Int = (Random.rangeFrom(7, x)%(99 + 1)) + 0;
    Float.fromInt(a) + Float.fromInt(b)*0.01;
  };

  private func random_id() : async Text {
    var id = "";
    while (id.size() != 3) {
      let rand_num = Nat32.fromNat(await rand(65,90));
      id := id # Char.toText(Char.fromNat32(rand_num));
    };
    id;    
  };



}