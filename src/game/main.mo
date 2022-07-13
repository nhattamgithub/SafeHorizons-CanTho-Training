import Array "mo:base/Array";
import TrieMap "mo:base/TrieMap";
import Result "mo:base/Result";
import Time "mo:base/Time";
import Hash "mo:base/Hash";
import Random "mo:base/Random";
import Iter "mo:base/Iter";

import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Float "mo:base/Float";

import Principal "mo:base/Principal";

import State "../game_models/State";
import Types "../game_models/Types"


actor Game {
  var state: State.State = State.empty();

  // DATA-ORIENTED TYPE
  type User = Types.User;  
  type Character = Types.Character;
  type Character_Class = Types.Character_Class;
  type Quest = Types.Quest;
  type Event = Types.Event;
  type Option = Types.Option;
  type ChartakeOption = Types.ChartakeOption;
  type ItemforQuest = Types.ItemforQuest;
  type CharcarryingItem = Types.CharcarryingItem;
  type Item = Types.Item;
  type Material = Types.Material;
  type CharcollectMaterial = Types.CharcollectMaterial;

  // UI-ORIENTED TYPES
  type User_Creation = Types.User_Creation;
  type Character_Creation = Types.Character_Creation;
  type Event_Creation = Types.Event_Creation;
  type Option_Creation = Types.Option_Creation;
  type ChartakeOption_Creation = Types.ChartakeOption_Creation;
  type ItemforQuest_Creation = Types.ItemforQuest_Creation;
  type CharcarryingItem_Creation = Types.CharcarryingItem_Creation;


  type User_Login = Types.User_Login;
  type Character_Quick_Info = Types.Character_Quick_Info;
  type QuestRequirements_Info = Types.QuestRequirements_Info;
  type EventwithOptions_Info = Types.EventwithOptions_Info;
  type MaterialwithAmount_Info = Types.MaterialwithAmount_Info;
  type CharacterBag = Types.CharacterBag;

  type Error = Types.Error;

  let idsize = 3;


  // INITALIZE DATABASE______________________________________________________________
  public func INIT() : async () {
    //Classes
    ignore createCharacter_Class({base_int=0; base_lck=0; base_sta=7; base_str=6; base_vit=0; base_hp=6; base_mp=3; name="Trekker"; description="Trekker, a person who goes Backpacking"; base_morale=6});

    //Users
    ignore await createUser({username="tester";psswd="1234";re_psswd="1234"});
    ignore await loginUser({username="tester";psswd="1234"});
    let u = await findUser_withName("tester");
    
    //Characters
    switch (u)
    {
      case null
      {
        ();
      };
      case (?v)
      {
        ignore createCharacter({name="Test Trekker";classname="Trekker";userid=v.id});
      }
    };


    //Quests
    ignore await createQuest({name="Jungle Tour";price=0;description="Beginner Tour.";image=""});

    //Events
    ignore await createEvent({questname="Jungle Tour";description="";location_name="Position0";destination_name="Position1"});
    ignore await createEvent({questname="Jungle Tour";description="Dense bushes are blocking your way.";location_name="Position1";destination_name="Position2"});
    ignore await createEvent({questname="Jungle Tour";description="You met a waterfall.";location_name="Position2";destination_name="Position3"});
    ignore await createEvent({questname="Jungle Tour";description="You encountered a bunch of monkeys.";location_name="Position3";destination_name="Position4"});
    ignore await createEvent({questname="Jungle Tour";description="You Arrive at camping spot.";location_name="Position4";destination_name="Position5"});
    ignore await createEvent({questname="Jungle Tour";description="You encountered a large tree blocking your way.";location_name="Position5";destination_name="Position6"});
    ignore await createEvent({questname="Jungle Tour";description="There is a river near the path.";location_name="Position6";destination_name="Position7"});
    
    //Items
    ignore await createItem({name="Knife";required_str=0.5;image=""});
    ignore await createItem({name="Medicine";required_str=0.5;image=""});
    ignore await createItem({name="Climbing Stick";required_str=1;image=""});
    ignore await createItem({name="Bicycle";required_str=5;image=""});
    ignore await createItem({name="Tent";required_str=3;image=""});
    ignore await createItem({name="Clothes";required_str=2;image=""});
    ignore await createItem({name="Camera";required_str=1.5;image=""});
    ignore await createItem({name="Food";required_str=0.5;image=""});
    ignore await createItem({name="Water";required_str=0.5;image=""});
    ignore await createItem({name="Grapple Hook";required_str=1;image=""});
    ignore await createItem({name="Inflatable Boat & Paddle";required_str=4;image=""});
    ignore await createItem({name="Saw";required_str=0.5;image=""});
    ignore await createItem({name="Antitode";required_str=0.5;image=""});


    //Options
    ignore createOption({questname="Jungle Tour";location_name="Position0";description="Start Jungle Tour";required_item="";loss_sta=0;loss_mp=0;loss_morale=0;loss_hp=0;risk_chance=0;risk_lost="";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=0;lucky_chance=1.0;gain_by_luck="Seed/Wood";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position1";description="Cut the bushes to open the way with a Knife or a Saw.";required_item="Knife,Saw";loss_sta=2;loss_mp=0;loss_morale=1;loss_hp=1;risk_chance=0;risk_lost="";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=10;lucky_chance=0;gain_by_luck="";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position1";description="Try to make your way through the bushes without chopping them down.";required_item="";loss_sta=1;loss_mp=0;loss_morale=2;loss_hp=2;risk_chance=0.6;risk_lost="Seed/Wood";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=10;lucky_chance=0.1;gain_by_luck="Seed/Wood";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position2";description="Follow the cliffs to climb up the waterfall.";required_item="";loss_sta=2;loss_mp=0;loss_morale=1;loss_hp=2;risk_chance=0.6;risk_lost="Seed/Wood";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=10;lucky_chance=0.2;gain_by_luck="Seed/Wood";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position2";description="Use Robes and hooks to climb up the waterfall.";required_item="Grapple Hook";loss_sta=3;loss_mp=0;loss_morale=0;loss_hp=2;risk_chance=0.4;risk_lost="Seed/Wood";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=10;lucky_chance=0.1;gain_by_luck="Seed/Wood";gain_other=""});
    
    ignore createOption({questname="Jungle Tour";location_name="Position3";description="Give them some foods.";required_item="Food";loss_sta=1;loss_mp=0;loss_morale=1;loss_hp=1;risk_chance=0.3;risk_lost="Seed/Wood";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=15;lucky_chance=0.5;gain_by_luck="Seed/Wood";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position3";description="Ignore and find a way to pass through them.";required_item="";loss_sta=2;loss_mp=0;loss_morale=0;loss_hp=0;risk_chance=0.7;risk_lost="-2 morale,hp";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=5;lucky_chance=0;gain_by_luck="";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position4";description="Take a rest.";required_item="";loss_sta=0;loss_mp=0;loss_morale=0;loss_hp=0;risk_chance=0;risk_lost="";loss_other="8 hours waiting";gain_sta=2;gain_mp=0;gain_morale=2;gain_hp=0;gain_exp=0;lucky_chance=0;gain_by_luck="";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position4";description="Cook something.";required_item="Food";loss_sta=0;loss_mp=0;loss_morale=0;loss_hp=0;risk_chance=0;risk_lost="";loss_other="Food";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=2;gain_exp=0;lucky_chance=0;gain_by_luck="";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position4";description="Continue";required_item="";loss_sta=0;loss_mp=0;loss_morale=0;loss_hp=0;risk_chance=0;risk_lost="";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=10;lucky_chance=0;gain_by_luck="";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position4";description="Save";required_item="";loss_sta=0;loss_mp=0;loss_morale=0;loss_hp=0;risk_chance=0;risk_lost="";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=5;lucky_chance=0;gain_by_luck="";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position5";description="Use something sharp to cut branches to open the way.";required_item="Knife,Saw";loss_sta=3;loss_mp=0;loss_morale=2;loss_hp=1;risk_chance=0;risk_lost="";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=0;lucky_chance=0.7;gain_by_luck="Seed/Wood";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position5";description="Find another way to go.";required_item="";loss_sta=1;loss_mp=0;loss_morale=1;loss_hp=0;risk_chance=0.8;risk_lost="Position3";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=0;lucky_chance=0.1;gain_by_luck="Seed/Wood";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position6";description="Use inflatable boat to go through the river.";required_item="Inflatable Boat & Paddle";loss_sta=2;loss_mp=0;loss_morale=0;loss_hp=0;risk_chance=0.4;risk_lost="Seed/wood";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=10;lucky_chance=0;gain_by_luck="";gain_other=""});

    ignore createOption({questname="Jungle Tour";location_name="Position6";description="Continue to move along the river-bank.";required_item="";loss_sta=1;loss_mp=0;loss_morale=1;loss_hp=0;risk_chance=0.7;risk_lost="Bag";loss_other="";gain_sta=0;gain_mp=0;gain_morale=0;gain_hp=0;gain_exp=10;lucky_chance=0;gain_by_luck="";gain_other=""});

    // Items for Quest
    ignore createItemforQuest({itemname="Knife";questname="Jungle Tour"});
    ignore createItemforQuest({itemname="Food";questname="Jungle Tour"});
    ignore createItemforQuest({itemname="Grapple Hook";questname="Jungle Tour"});
    ignore createItemforQuest({itemname="Saw";questname="Jungle Tour"});
    ignore createItemforQuest({itemname="Inflatable Boat & Paddle";questname="Jungle Tour"});
    
    //Material
    ignore createMaterial({name="Seed";description="Seed is used for gardening."});
    ignore createMaterial({name="Wood";description="Wood is used for structure building."});

    
    ();
  };
  

  // User functions__________________________________________________________________
  public shared(msg) func createUser(u: User_Creation) : async Result.Result<(),Error> {
    let callerid = msg.caller;
    //Reject Anonymous Identity 
    // if (Principal.toText(callerid) == "2vxsx-fae")
    // {
    //     return #err(#NotAuthorized);
    // };

    if (u.psswd != u.re_psswd)
    {
      return #err(#IncorectPassword);
    };

    let findname = await findUser_withName(u.username);
    if (findname != null)
    {
      return #err(#NameAlreadyUsed);
    };

    var userid = await randomID(idsize);
    var char = state.users.get(userid);
    while (char != null)
    {
      userid := await randomID(idsize);
      char := state.users.get(userid);
    };
    
    let x : User = {
        id = userid;
        name = u.username;
        psswd = u.psswd;
        number_of_characters = 0;
        active_caller = null;
    };
    let createduser = state.users.put(userid,x);
    #ok();


  };

  public shared(msg) func loginUser(u: User_Login) : async Result.Result<(),Error> {
    let callerid = msg.caller;
    //Reject Anonymous Identity 
    // if (Principal.toText(callerid) == "2vxsx-fae")
    // {
    //     return #err(#NotAuthorized);
    // };

    let finduser = await findUser_withName(u.username);
    switch (finduser)
    {
      case null 
      {
        #err(#UserNotFound);
      };
      case (? v) 
      {
        if (v.psswd != u.psswd)
        {
          return #err(#IncorectPassword);
        };
        let x = {
          id = v.id;
          name = v.name;
          psswd = v.psswd;
          number_of_characters = v.number_of_characters;
          active_caller = ?callerid;
        };
        let updateduser = state.users.replace(v.id,x);
        #ok();
      };
    };
  };


  public shared(msg) func logoutUser(id: Text): async Result.Result<(),Error> {
    let callerid = msg.caller;
    let user = state.users.get(id);

    switch (user)
    {
      case null
      {
        #err(#UserNotFound);
      };
      case (? v)
      {
        if (?callerid == v.active_caller)
        {
          let x = {
            id = v.id;
            name = v.name;
            psswd = v.psswd;
            number_of_characters = v.number_of_characters;
            active_caller = null;
          };
          let updateduser = state.users.replace(v.id,x);
          return #ok();
        };
        #err(#NotAuthorized);
      };
    }
  };

  // public query func readUser(id: Text) : async Result.Result<User,Error> {
  //   let result = state.users.get(id);
  //   Result.fromOption(result,#CharacterNotFound);
  // };

  // public shared(msg) func deleteUser(id: Text) : async Result.Result<(),Error> {
  //   let callerid = msg.caller;
  //   let userid = state.users.get(id);
  //   switch (userid)
  //   {
  //     case null
  //     {
  //       #err(#UserNotFound);
  //     };
  //     case (? v)
  //     {
  //       if (?callerid == v.active_caller)
  //       {
  //         let deleteduser = state.users.remove(v.id);
  //         return #ok();
  //       };
  //       #err(#NotAuthorized);
  //     };
  //   }
  // };


  public query func showUsers() : async [User] {
    var C : [User] = [];
        for (c in state.users.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };


  // Character functions_____________________________________________________________
  public shared(msg) func createCharacter(Creation: Character_Creation) : async Result.Result<(),Error> {
    let callerid = msg.caller;
    let clssid = await findClass_withName(Creation.classname);
    let user = state.users.get(Creation.userid);

    switch (clssid)
    {
      case null
      {
        #err(#ClassNotFound);
      };
      case (? v)
      {
        switch (user)
        {
          case null {
            #err(#UserNotFound);
          };
          case (? u)
          {
            if (u.active_caller != ?callerid)
            {
              return #err(#NotAuthorized);
            };
            let findchar = await findChar_withName(Creation.name);
            switch (findchar)
            {
              case (? z)
              {
                #err(#NameAlreadyUsed);
              };
              case null
              {
                let id = u.id # "CH" # Nat.toText(u.number_of_characters+1);
                let x : Character = {
                  name = Creation.name;
                  lvl = 1;
                  classname = v.name;
                  cur_exp = 0;
                  next_exp = 100;
                  status = "idle";

                  cur_hp = v.base_hp;
                  max_hp = v.base_hp;
                  cur_mp = v.base_mp;
                  max_mp = v.base_mp;
                  cur_sta = v.base_sta;
                  max_sta = v.base_sta;
                  cur_morale = v.base_morale;
                  max_morale = v.base_morale;

                  str = v.base_str;
                  vit = v.base_vit;
                  int = v.base_int;
                  lck = v.base_lck;

                };
                let y : User = {
                  id = u.id;
                  name = u.name;
                  psswd = u.psswd;
                  number_of_characters = (u.number_of_characters + 1);
                  active_caller = null;
                };
                let updateduser = state.users.replace(y.id,y);
                let createdcharacter = state.characters.put(id,x);

                #ok();
              };
            };
          };
        };
      };
    };
  };


  public func UI_quitQuest(charactername: Text) : async Result.Result<(),Error> {
    let charkey = await getCharKey(charactername);
    switch (charkey)
    {
      case null
      {
        #err(#CharacterNotFound);
      };
      case (? ck)
      {
        let char = state.characters.get(ck);
        switch (char)
        {
          case null
          {
            #err(#None);
          };
          case (?c)
          {
            let x : Character = {
              name = c.name;
              lvl = c.lvl;
              classname = c.classname;
              cur_exp = c.cur_exp;
              next_exp = c.next_exp;
              status = "idle";

              cur_hp = c.cur_hp;
              max_hp = c.max_hp;

              cur_mp = c.cur_mp;
              max_mp = c.max_mp;

              cur_sta = c.cur_sta;
              max_sta = c.max_sta;

              cur_morale = c.cur_morale;
              max_morale = c.max_morale;

              str = c.str;
              int = c.int;
              vit = c.vit;
              lck = c.lck;
            };
            let updatedchar = state.characters.replace(ck,x);
            #ok();
          };
        };
      };
    };
  };

  // public query func readCharacter(id: Text) : async Result.Result<Character,Error> {
  //   let result = state.characters.get(id);
  //   Result.fromOption(result,#CharacterNotFound);
  // };

  // public func deleteCharacter(id: Text) : async Result.Result<(),Error> {
  //   let char = state.characters.get(id);
  //   switch (char)
  //   {
  //     case null
  //     {
  //       #err(#CharacterNotFound);
  //     };
  //     case (? v)
  //     {
  //       let updatedchar = state.characters.remove(id);
  //       #ok();
  //     };
  //   };
  // };

  private func changeCharacterStatus(charid: Text,newstatus: Text): async () {
    let char = state.characters.get(charid);
    switch (char)
    {
      case null
      {
        ();
      };
      case (? u)
      {
        let ch : Character = {
        name = u.name;
        lvl = u.lvl;
        classname = u.classname;
        cur_exp = u.cur_exp;
        next_exp = u.next_exp;
        status = newstatus;

        cur_hp = u.cur_hp;
        max_hp = u.max_hp;

        cur_mp = u.cur_mp;
        max_mp = u.max_mp;

        cur_sta = u.cur_sta;
        max_sta = u.max_sta;

        cur_morale = u.cur_morale;
        max_morale = u.max_morale;

        str = u.str;
        int = u.int;
        vit = u.vit;
        lck = u.lck;
      };
      let updatedchar = state.characters.replace(charid,ch);
      ();
      };
    }
    
  };

  public func UI_CharacterQuickInfo(charactername: Text): async Result.Result<Character_Quick_Info,Error> {
    let char = await findChar_withName(charactername);
    switch (char)
    {
      case null
      {
        #err(#CharacterNotFound);
      };
      case (? v)
      {
        let x : Character_Quick_Info = {
          name = v.name;
          cur_hp = v.cur_hp;
          max_hp = v.max_hp;
          cur_mp = v.cur_mp;
          max_mp = v.max_mp;
          cur_sta = v.cur_sta;
          max_sta = v.max_sta;
          cur_morale = v.cur_morale;
          max_morale = v.max_morale;
          cur_exp = v.cur_exp;
          next_exp = v.next_exp;
        };
        #ok(x);
      };
    };
  };

  public query func showCharacters() : async [Character] {
    var C : [Character] = [];
        for (c in state.characters.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  

  // Chacracter Class functions______________________________________________________
  private func createCharacter_Class(c: Character_Class) : async Result.Result<(),Error>  {
    let findclass = await findClass_withName(c.name);
    switch (findclass)
    {
      case (? v)
      {
        #err(#NameAlreadyUsed);
      };
      case null
      {
        var classid = await randomID(idsize);
        var clss = state.character_classes.get(classid);
        while (clss != null)
        {
          classid := await randomID(idsize);
          clss := state.character_classes.get(classid);
        };
        let createdclass = state.character_classes.put(classid,c);
        #ok();
      };
    };
  };

  // public query func readCharacter_Class(id: Text) : async Result.Result<Character_Class,Error> {
  //   let result = state.character_classes.get(id);
  //   Result.fromOption(result,#ClassNotFound);
  // };


  // private func updateCharacter_Class({id: Text; c: Character_Class}) : async Result.Result<(),Error> {
  //   let clss = state.character_classes.get(id);
  //   switch (clss)
  //   {
  //     case null
  //     {
  //       #err(#ClassNotFound);
  //     };
  //     case (? v)
  //     {
  //       let updatedclass = state.character_classes.replace(id,c);
  //       #ok();
  //     };
  //   }
  // };

  // private func deleteCharacter_Class(id: Text) : async Result.Result<(),Error> {
  //   let clss = state.character_classes.get(id);
  //   switch (clss)
  //   {
  //     case null
  //     {
  //       #err(#ClassNotFound);
  //     };
  //     case (? v)
  //     {
  //       let deletedclass = state.character_classes.remove(id);
  //       #ok();
  //     };
  //   };
  // };

  public query func showCharacter_Classes() : async [Character_Class] {
    var C : [Character_Class] = [];
        for (c in state.character_classes.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  // Quest_______________________________________________________________________
  private func createQuest(q: Quest) : async Result.Result<(),Error> {
    let findquest = await findQuest_withName(q.name);
    switch (findquest)
    {
      case (? v)
      {
        #err(#NameAlreadyUsed);
      };
      case null
      {
        var questid = await randomID(idsize);
        var quest = state.quests.get(questid);
        while (quest != null)
        {
          questid := await randomID(idsize);
          quest := state.quests.get(questid);
        };
        let createdquest = state.quests.put(questid,q);
        #ok();
      };
    };
  };


  public query func showQuests() : async [Quest] {
    var C : [Quest] = [];
        for (c in state.quests.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  // Event functions_____________________________________________________________
  private func createEvent(e: Event_Creation): async Result.Result<(),Error> {
    let questkey = await getQuestKey(e.questname);
    switch (questkey)
    {
      case null
      {
        #err(#QuestNotFound);
      };
      case (?qk)
      {
        let findevent = await findEvent_withQuestLocation(qk,e.location_name);
        switch (findevent)
        {
          case (? v)
          {
            #err(#AlreadyUsed);
          };
          case null
          {
            var eventid = await randomID(idsize);
            var event = state.events.get(eventid);
            while (event != null)
            {
              eventid := await randomID(idsize);
              event := state.events.get(eventid);
            };
            let x : Event = {
              questid = qk;
              description = e.description;
              location_name = e.location_name;
              destination_name = e.destination_name;
            };
            let createdquest = state.events.put(eventid,x);
            #ok();
          };
        };
      };
    }

  };

  private func isStartQuestEvent(eventkey: Text): Bool {
    let event = state.events.get(eventkey);
    switch (event)
    {
      case null
      {
        false;
      };
      case (? v)
      {
        if (v.location_name == "Position0")
        {
          return true;
        };
        return false;
      };
    };
  };

  public query func showEvents() : async [Event] {
    var C : [Event] = [];
        for (c in state.events.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };


  //Option functions_____________________________________________________________
  private func createOption(o: Option_Creation) : async Result.Result<(),Error> {
    let questkey = await getQuestKey(o.questname);
    switch (questkey)
    {
      case null
      {
        #err(#QuestNotFound);
      };
      case (?qk)
      {
        let eventKey = await getEventKey(qk,o.location_name);
        switch (eventKey)
        {
          case null
          {
            #err(#EventNotFound);
          };
          case (?ek)
          {
            var optionid = await randomID(idsize);
            var option = state.options.get(optionid);
            while (option != null)
            {
              optionid := await randomID(idsize);
              option := state.options.get(optionid);
            };
            
            let findoption = await findOption_withDescription(o.description);
            switch (findoption)
            {
              case (? v)
              {
                #err(#AlreadyExists);
              };
              case null
              {
                var itemlist : [Text] = [];
                if (o.required_item != "")
                {
                  // var items = o.required_item;
                  // if (Text.contains(o.required_item,#text ",") == false)
                  // {
                  //   items := items # ",";
                  // };
            
                  for (e in Text.split(o.required_item,#text ","))
                  {
                    let itemkey = await getItemKey(e);
                    switch (itemkey)
                    {
                      case null
                      {
                        ();
                      };
                      case (? u)
                      {
                        itemlist := Array.append(itemlist, [u])
                      };
                    };
                  };
                };
                let x : Option = {
                  eventid = ek;
                  description = o.description;
                  required_item = itemlist;
                  loss_sta = o.loss_sta;
                  loss_morale = o.loss_morale;
                  loss_hp = o.loss_hp;
                  loss_mp = o.loss_mp;
                  risk_chance = o.risk_chance;
                  risk_lost = o.risk_lost;
                  loss_other = o.loss_other;
                  gain_sta = o.gain_sta;
                  gain_morale = o.gain_morale;
                  gain_hp = o.gain_hp;
                  gain_mp = o.gain_mp;
                  gain_exp = o.gain_exp;
                  lucky_chance = o.lucky_chance;
                  gain_by_luck = o.gain_by_luck;
                  gain_other = o.gain_other;
                };
                let createdoption = state.options.put(optionid,x);
                #ok();

              };
            };            
          };
        };
      };
    };
  };


  public query func showOptions() : async [Option] {
    var C : [Option] = [];
        for (c in state.options.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  private func showTextOptionsforCharacter(nexteventkey: Text) : async [Text] {
    var C : [Text] = [];
        for (c in state.options.vals())
        {
            if (c.eventid == nexteventkey)
            {
              C := Array.append(C,[c.description]);
            }; 
        };
        C;
  };
  


  // Character take Option functions_____________________________________________
  public func UI_CharactertakeOption(o: ChartakeOption_Creation):  async Result.Result<EventwithOptions_Info,Error> {
    let findoption = await getOptionKey(o.optionname);
    let findchar = await getCharKey(o.charactername);

    switch (findoption)
    {
      case null
      {
        #err(#OptionNotFound);
      };
      case (? ok)
      {
        switch (findchar)
        {
          case null
          {
            #err(#CharacterNotFound);
          };
          case (? ck)
          {
            let option_eventkey = getEventKey_fromOptionKey(ok);
            let char_eventkey = getEventKey_fromCharKey(ck);
            if (char_eventkey == "dead")
            {
              return #err(#CharacterIsDead);
            }
            else if (option_eventkey == char_eventkey or isStartQuestEvent(option_eventkey) == true)
            {
              return await createChartakeOption(ck,ok,option_eventkey); 
            };
            #err(#OptionNotFound);
          };
        };
      };
    };
  };

  private func createChartakeOption(charkey: Text,optionkey: Text,fromeventkey: Text) : async Result.Result<EventwithOptions_Info,Error> {
    let fromevent = state.events.get(fromeventkey);
    let char = state.characters.get(charkey);

    switch (fromevent)
    {
      case null
      {
        #err(#None);
      };
      case (? v)
      {
        var destination_name = v.destination_name;
        switch (char)
        {
          case null
          {
            #err(#None);
          };
          case (? u)
          {

            var result = "";
            let option = state.options.get(optionkey);
            switch (option)
            {
              case null
              {
                return #err(#None);
              };  
              case (? o)
              {
                //// check if the character has one of the required item if the option has it.
                if (o.required_item.size() != 0)
                {
                  var flag = false;
                  label checkcci for (i in o.required_item.vals())
                  { 
                    let x : CharcarryingItem = {
                      characterid = charkey;
                      itemid = i;
                    };
                    let ischarcarryingitem = await isCharcarryingItem(x);
                    if (ischarcarryingitem == true)
                    {
                      flag := true;
                      break checkcci; // break the valid labeled loop.
                    };
                  };
                  if (flag == false)
                  {
                    return #err(#NotMeetRequirement);
                  };
                };
                

                //// make option affects on character.
                let ch : Character = {
                  name = u.name;
                  lvl = u.lvl;
                  classname = u.classname;
                  cur_exp = u.cur_exp + o.gain_exp;
                  next_exp = u.next_exp;
                  status = u.status;

                  cur_hp = Float.min(Float.max(u.cur_hp - o.loss_hp + o.gain_hp,0.0),u.max_hp);
                  max_hp = u.max_hp;

                  cur_mp =  Float.min(Float.max(u.cur_mp - o.loss_mp + o.gain_mp,0.0),u.max_mp);
                  max_mp = u.max_mp;

                  cur_sta = Float.min(Float.max(u.cur_sta - o.loss_sta + o.gain_sta,0.0),u.max_sta);
                  max_sta = u.max_sta;

                  cur_morale = Float.min(Float.max(u.cur_morale - o.loss_morale + o.gain_morale,0.0),u.max_sta);
                  max_morale = u.max_morale;

                  str = u.str;
                  int = u.int;
                  vit = u.vit;
                  lck = u.lck;
                };
                let updatedchar = state.characters.replace(charkey,ch);


                //// check risk for the character.
                let chance = await floatrand(0,1);
                if ( chance > 0 and chance <= o.risk_chance )
                {
                  if (Text.contains(o.risk_lost,#text "Bag") == true)
                  {
                    await makeCharlossAllMaterials(charkey);
                    result := "Unfortunately, it seems like you lost all from your ";
                  };
                  if (Text.contains(o.risk_lost,#text "/") == true)
                  {
                    await makeCharlossMaterials(charkey,o.risk_lost);
                    result := "Unfortunately, it seems like you lost some ";
                  };
                  if (Text.contains(o.risk_lost,#text "Position") == true)
                  {
                    destination_name := o.risk_lost;
                    result := "Unfortunately, it seems like you went back to ";
                  };
                  result := result # o.risk_lost # ".";
                }
                else if ( chance > o.risk_chance and chance <= (o.risk_chance + o.lucky_chance) )
                {
                  if (Text.contains(o.gain_by_luck,#text "/") == true)
                  {
                    await makeChargainMaterials(charkey,o.gain_by_luck);
                    result := "Luckily, you collected some ";
                  };

                  result :=  result # o.gain_by_luck # ".";
                }
                else 
                {
                  result := "";
                };


                //// create Char_take_Option to the database.
                var ctoid = await randomID(idsize);
                var cto = state.charstakeoptions.get(ctoid);
                while (cto != null)
                {
                  ctoid := await randomID(idsize);
                  cto := state.charstakeoptions.get(ctoid);
                };
                let x : ChartakeOption = {
                  charid = charkey;
                  optionid = optionkey;
                  pickup_time = Time.now();
                  char_cur_mp = ch.cur_mp;
                  char_max_mp = ch.max_mp;
                  char_cur_sta = ch.cur_sta;
                  char_max_sta = ch.max_sta;
                  char_cur_morale = ch.cur_morale;
                  char_max_morale = ch.max_morale;
                  char_cur_hp = ch.cur_hp;
                  char_max_hp = ch.max_hp;
                };
                let createdchartakeoption = state.charstakeoptions.put(ctoid,x);

                //// if hp == 0, character is dead and cant continue the quest.
                if (ch.cur_hp == 0 or ch.cur_sta == 0 or ch.cur_morale == 0)
                {
                  await changeCharacterStatus(charkey,"dead");
                  return #err(#CharacterIsDead);
                };
                //// CHECK IF THE CHARACTER CAN LEVELUP================================================
              };
            };

            //// check if nextevent is exist.
            //// If not this mean the quest is completed, otherwise get the next event for the character to choose.
            let nexteventkey = await getEventKey(v.questid, destination_name);
            switch (nexteventkey)
            {
              case null // when null, it mean character has completed the quest
              {
                await changeCharacterStatus(charkey,"idle");
                let ewo : EventwithOptions_Info = {
                      result = result;
                      nextevent = "Quest is finished";
                      options = [];
                    };
                    return #ok(ewo);

              };
              case (? z)
              {                   
                await changeCharacterStatus(charkey,z);
                let nextevent = state.events.get(z);
                switch (nextevent)
                {
                  case null
                  {
                    #err(#None);
                  };
                  case (? e)
                  {
                    let ewo : EventwithOptions_Info = {
                      result = result;
                      nextevent = e.description;
                      options = await showTextOptionsforCharacter(z);
                    };
                    return #ok(ewo);
                  };
                };               
              };
            }
          };
        };
      };
    };
  };

  public query func showCharstakeOptions() : async [ChartakeOption] {
    var C : [ChartakeOption] = [];
        for (c in state.charstakeoptions.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };




  // Quest Item functions________________________________________________________
  private func createItem(i: Item) : async Result.Result<(),Error> {
    let finditem = await findItem_withName(i.name);
    switch (finditem)
    {
      case (? v)
      {
        #err(#NameAlreadyUsed);
      };
      case null
      {
        var itemid = await randomID(idsize);
        var item = state.items.get(itemid);
        while (item != null)
        {
          itemid := await randomID(idsize);
          item := state.items.get(itemid);
        };
        let createditem = state.items.put(itemid,i);
        #ok();
      };
    };
  };

  public query func showItems(): async [Item] {
    var C : [Item] = [];
        for (c in state.items.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  // Quest Item for Quest functions_______________________________________________
  private func createItemforQuest(i: ItemforQuest_Creation) : async Result.Result<(),Error> {
    let itemkey = await getItemKey(i.itemname);
    switch (itemkey)
    {
      case null
      {
        #err(#ItemNotFound);
      };
      case (?ik)
      {
        let questKey = await getQuestKey(i.questname);
        switch (questKey)
        {
          case null
          {
            #err(#QuestNotFound);
          };
          case (?qk)
          {
            var ifqid = await randomID(idsize);
            var ifq = state.itemsforquests.get(ifqid);
            while (ifq != null)
            {
              ifqid := await randomID(idsize);
              ifq := state.itemsforquests.get(ifqid);
            };

            let x : ItemforQuest = {
                itemid = ik;
                questid = qk;
            };
            let finditemforquest = await findItemforQuest(x);
            if (finditemforquest == true)
            {
              return #err(#AlreadyExists);
            };
            let createdifq = state.itemsforquests.put(ifqid,x);
            
            #ok();
          };
        };
      };
    };
  };

  public query func UI_QuestRequirements(): async [QuestRequirements_Info] {
    var quesstrequirements_list : [QuestRequirements_Info] = [];
    for (e in state.quests.entries())
    {
      let questkey = e.0;
      let quest = e.1;
      var itemlist : [Text] = [];
      for (i in state.itemsforquests.vals())
      {
        if (i.questid == questkey)
        {
          let item = state.items.get(i.itemid);
          switch item
          {
            case null
            {
              ();
            };
            case (? v)
            {
              itemlist := Array.append(itemlist,[v.name]);
            };
          };
        };
      };
      let x : QuestRequirements_Info = {
        questname = quest.name;
        price = quest.price;
        required_items = itemlist;
        starttext = "Start " # quest.name;
      };
      quesstrequirements_list := Array.append(quesstrequirements_list,[x]);
    };
    quesstrequirements_list;
  };


  public query func showItemsforQuests(): async [ItemforQuest] {
    var C : [ItemforQuest] = [];
        for (c in state.itemsforquests.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  // Character carrying Item functions___________________________________________
  public func createCharcarryingItem(c: CharcarryingItem_Creation): async Result.Result<(),Error> {
    let findchar = await getCharKey(c.charactername);
    let finditem = await getItemKey(c.itemname);
    switch (findchar)
    {
      case null
      {
        #err(#CharacterNotFound);
      };
      case (? ck)
      {
        let char = state.characters.get(ck);
        var char_strengh : Float = 0;
        switch (char)
        {
          case null
          {
            ();
          };
          case (? c)
          {
            char_strengh := c.str;
            if (c.status != "idle")
            {
              return #err(#CharacterNotAvailable);
            };
          };
        };


        switch (finditem)
        {
          case null
          {
            #err(#ItemNotFound);
          };
          case (? ik)
          {
            let item = state.items.get(ik);
            let capacity = await getCharacterItemCapacity(ck);
            switch (item)
            {
              case null
              {
                ();
              };
              case (? i)
              {
                if ((i.required_str+capacity) > char_strengh)
                {
                  return #err(#BagOutOfSpace);
                };
              };
            };


            var cciid = await randomID(idsize);
            var cci = state.charscarryingitems.get(cciid);
            while (cci != null)
            {
              cciid := await randomID(idsize);
              cci := state.charscarryingitems.get(cciid);
            };

            let x : CharcarryingItem = {
              characterid = ck;
              itemid = ik;
            };

            let ischarcarryingitem = await isCharcarryingItem(x);
            if (ischarcarryingitem == true)
            {
              return #err(#AlreadyExists); // character cannot carrying two same item?
            };

            let updatedcci = state.charscarryingitems.put(cciid,x);
            #ok();
          };
        };
      };
    };
  };


  private func getCharacterItemCapacity(charkey: Text): async Float {
    var capacity : Float = 0;
    for (c in state.charscarryingitems.vals())
    {
      if (c.characterid == charkey)
      {
        let item = state.items.get(c.itemid);
        switch (item)
        {
          case null
          {
            ();
          };
          case (? i)
          {
            capacity := capacity + i.required_str;
          };
        };
      }
    };
    capacity;
  }; 

  public query func showCharscarryingItems(): async [CharcarryingItem] {
    var C : [CharcarryingItem] = [];
        for (c in state.charscarryingitems.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  // Material function___________________________________________________________
  private func createMaterial(m: Material) : async Result.Result<(),Error> {
    let findmaterial = await findMaterial_withName(m.name);
    switch (findmaterial)
    {
      case (? v)
      {
        #err(#NameAlreadyUsed);
      };
      case null
      {
        var materialid = await randomID(idsize);
        var material = state.materials.get(materialid);
        while (material != null)
        {
          materialid := await randomID(idsize);
          material := state.materials.get(materialid);
        };
        let createdmaterial = state.materials.put(materialid,m);
        #ok();
      };
    };
  };

  public query func showMaterials(): async [Material] {
    var C : [Material] = [];
        for (c in state.materials.vals())
        {
            C := Array.append(C,[c]);
        };
        C;
  };

  // Character collect Material functions________________________________________
  public func UI_CharacterBag(charactername: Text): async Result.Result<CharacterBag,Error> {
    let charkey = await getCharKey(charactername);
    switch (charkey)
    {
      case null
      {
        #err(#CharacterNotFound);
      };
      case (? ck)
      {
        var materiallist : [MaterialwithAmount_Info] = [];
        for (i in state.charscollectmaterials.vals())
        {
          if (i.characterid == ck)
          {
            let material = state.materials.get(i.materialid);
            switch (material)
            {
              case null
              {
                return #err(#MaterialNotFound);
              };
              case (? m)
              {
                let x : MaterialwithAmount_Info = {
                  name = m.name;
                  description = m.description;
                  amount = i.amount;
                };
                materiallist := Array.append(materiallist,[x]);
              };
            };
          };
        };

        var itemlist : [Item] = [];
        for (i in state.charscarryingitems.vals())
        {
          if (i.characterid == ck)
          {
            let item = state.items.get(i.itemid);
            switch (item)
            {
              case null
              {
                return #err(#ItemNotFound);
              };
              case (? i)
              {
                itemlist := Array.append(itemlist,[i]);
              };
            };
          };
        };

        let capacity = await getCharacterItemCapacity(ck);

        let result : CharacterBag = {
          item_capacity = capacity;
          items = itemlist;
          materials = materiallist;
        };

        #ok(result);
      };
    }
    
  };

  private func createCharcollectMaterial(charkey: Text,materialkey: Text, amount_modifier: Int): async Result.Result<(),Error>  {
    let find = await getCharcollectMaterialKey(charkey,materialkey);
    switch (find)
    {
      case null
      {
        if (amount_modifier > 0)
        {
          var ccmid = await randomID(idsize);
          var ccm = state.charscollectmaterials.get(ccmid);
          while (ccm != null)
          {
            ccmid := await randomID(idsize);
            ccm := state.charscollectmaterials.get(ccmid);
          };

          let x : CharcollectMaterial = {
            characterid = charkey;
            materialid = materialkey;
            amount = Int.max(0,amount_modifier);
          };
          let createdcharcollectmaterial = state.charscollectmaterials.put(ccmid,x);
        };
        #ok();
      };
      case (? id)
      {
        let ccm = state.charscollectmaterials.get(id);
        switch (ccm)
        {
          case null
          {
            #err(#None);
          };
          case (? v)
          {
            if (Int.max(0,v.amount+amount_modifier) == 0)
            {
              let deletedcharcollectmaterial = state.charscollectmaterials.remove(id);
            }
            else
            {
              let x : CharcollectMaterial = {
                characterid = charkey;
                materialid = materialkey;
                amount = Int.max(0,v.amount+amount_modifier);
              };
              let updatedcharcollectmaterial = state.charscollectmaterials.replace(id,x);
            };
            #ok();
          };
        };
      };
    }
  };

  private func makeCharlossAllMaterials(charkey: Text) : async () {
    for (i in state.charscollectmaterials.vals())
    {
      if (i.characterid == charkey)
      {
        let ccm = await getCharcollectMaterialKey(i.characterid,i.materialid);
        switch (ccm)
        {
          case null
          {
            ()
          };
          case (? ccmid)
          {
            let deletedccm = state.charscollectmaterials.remove(ccmid);
          };
        };
      };
    };
  };

  private func makeCharlossMaterials(charkey: Text,materials: Text) : async () {
    for (i in Text.split(materials,#text "/"))
    {
      let material = await getMaterialKey(i);
      switch (material)
      {
        case null
        {
          ();
        };
        case (? materialkey)
        {
          let modifier : Int = await rand(1,10);
          ignore await createCharcollectMaterial(charkey,materialkey,-modifier);
          ();
        };
      }
    };
  };

  private func makeChargainMaterials(charkey: Text,materials: Text) : async () {
    for (i in Text.split(materials,#text "/"))
    {
      let material = await getMaterialKey(i);
      switch (material)
      {
        case null
        {
          ();
        };
        case (? materialkey)
        {
          let modifier : Int = await rand(1,10);
          ignore await createCharcollectMaterial(charkey,materialkey,+modifier);
          ();
        };
      }
    };
  };

  public query func showCharscollectMaterials(): async [CharcollectMaterial] {
    var C : [CharcollectMaterial] = [];
    for (c in state.charscollectmaterials.vals())
    {
        C := Array.append(C,[c]);
    };
    C;
  };

  // Utils_______________________________________________________________________
  private func rand(from:Nat, to: Nat) : async Nat {
      let x = await Random.blob();
      return (Random.rangeFrom(8,x)%(to - from+1))+from;

  };

  private func floatrand(from: Nat,to: Nat) : async Float {
    let x = await Random.blob();
    let y : Int = (Random.rangeFrom(8,x)%((to-1) - from+1))+from;
    let z : Int = (Random.rangeFrom(8,x)%(99 - 0+1))+0;
    return (Float.fromInt(y) + 0.01*Float.fromInt(z));
  };

  private func randomID(idsize: Nat) : async Text {
    var result = "";
    var counter = 1;
    while (counter <= idsize)
    {
      let value = Nat32.fromNat(await rand(65,90));
      result := result # Char.toText(Char.fromNat32(value));
      counter+=1;
    };
    result;
  };


  //// find type functions
  private func findUser_withName(name: Text) : async ?User {
    for (u in state.users.vals())
    {
      if (u.name == name)
      {
          return ?u;
      };
    };
    null;
  };

  private func findClass_withName(name: Text): async ?Character_Class {
    for (c in state.character_classes.vals())
    {
      if (c.name == name)
      {
          return ?c;
      };
    };
    null;
  };

  private func findChar_withName(name: Text): async ?Character {
    for (c in state.characters.vals())
    {
      if (c.name == name)
      {
          return ?c;
      };
    };
    null;
  };

  private func findQuest_withName(name: Text): async ?Quest {
    for (q in state.quests.vals())
    {
      if (q.name == name)
      {
          return ?q;
      };
    };
    null;
  };

  private func findItem_withName(name: Text): async ?Item {
    for (i in state.items.vals())
    {
      if (i.name == name)
      {
          return ?i;
      };
    };
    null;
  };

  private func findMaterial_withName(name: Text): async ?Material {
    for (m in state.materials.vals())
    {
      if (m.name == name)
      {
          return ?m;
      };
    };
    null;
  };

  private func findEvent_withQuestLocation(questid: Text,locationname: Text): async ?Event {
    for (e in state.events.vals())
    {
      if (e.questid == questid  and e.location_name == locationname)
      {
        return ?e;
      };
    };
    null;
  };

  private func findOption_withDescription(description: Text): async ?Option {
    for (o in state.options.vals())
    {
      if (o.description == description)
      {
        return ?o;
      };
    };
    null;
  };

  private func findItemforQuest(i: ItemforQuest): async Bool {
    for (e in state.itemsforquests.vals())
    {
      if (e == i)
      {
        return true;
      };
    };
    false;
  };


  private func isCharcarryingItem(c: CharcarryingItem): async Bool {
    for (e in state.charscarryingitems.vals())
    {
      if (e == c)
      {
        return true;
      };
    };
    false;
  };



  //// get key functions_____________________________
  private func getCharKey(name: Text): async ?Text {
    for (c in state.characters.entries())
    {
      let k = c.0;
      let v = c.1;
      if (v.name == name)
      {
          return ?k;
      };
    };
    null;
  };

  private func getQuestKey(name: Text): async ?Text {
    for (e in state.quests.entries())
    {
      let k = e.0;
      let v = e.1;
      if (v.name == name)
      {
          return ?k;
      };
    };
    null;
  };

  private func getEventKey(questid: Text,locationname: Text): async ?Text {
    for (e in state.events.entries())
    {
      let k = e.0;
      let v = e.1;
      if (v.questid == questid  and v.location_name == locationname)
      {
          return ?k;
      };
    };
    null;
  };


  private func getOptionKey(des: Text): async ?Text {
    for (o in state.options.entries())
    {
      let k = o.0;
      let v = o.1;
      if (v.description == des)
      {
          return ?k;
      };
    };
    null;
  };

  private func getItemKey(name: Text) : async ?Text {
    for (i in state.items.entries())
    {
      let k=i.0;
      let v=i.1;
      if (v.name == name)
      {
        return ?k;
      };
    };
    null;
  };

  private func getMaterialKey(name: Text) : async ?Text {
    for (m in state.materials.entries())
    {
      let k=m.0;
      let v=m.1;
      if (v.name == name)
      {
        return ?k;
      };
    };
    null;
  };


  private func getCharcollectMaterialKey(characterid: Text, materialid: Text): async ?Text {
    for (e in state.charscollectmaterials.entries())
    {
      let k=e.0;
      let v=e.1;
      if (v.characterid == characterid and v.materialid == materialid)
      {
        return ?k;
      };
    };
    null;
  };


  
  private func getEventKey_fromOptionKey(optionkey: Text): Text {
    let option = state.options.get(optionkey);
    switch (option)
    {
      case null
      {
        "";
      };
      case (? v)
      {
        v.eventid;
      };
    };
  };
  
  private func getEventKey_fromCharKey(charkey: Text) : Text {
    let char = state.characters.get(charkey);
    switch (char)
    {
      case null
      {
        "";
      };
      case (? v)
      {
        v.status;
      };
    }
  };


  
}