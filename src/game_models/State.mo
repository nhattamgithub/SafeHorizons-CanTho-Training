import Principal "mo:base/Principal";
import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";

import Types "Types";

module {
  private type Map<K,V> = TrieMap.TrieMap<K,V>;
  public type State = {
    users : Map<Text,Types.User>;
    inventories : Map<Text, Types.Inventory>;

    num_character : Nat32;
    characters : Map<Text, Types.Character>;
    character_classes : Map<Text, Types.Character_Class>;
    //special_abilities : Map<Text, Types.Special_Ability>;
    
    quests : Map<Text, Types.Quest>;
    events : Map<Text, Types.Event>;
	  options : Map<Text, Types.Option>;
    charactertakeoptions : Map<Text, Types.Character_Take_Option>;
    questitems : Map<Text, Types.Quest_Item>;
    charactercarryingquestitems : Map<Text, Types.Character_Carrying_QuestItem>;
	  questitemforquests : Map<Text, Types.Quest_Item_For_Quest>;

    materials : Map<Text, Types.Material>;
    charactercollectmaterials : Map<Text, Types.Character_Collect_Material>;


    gears : Map<Text, Types.Gear>;
    gear_classes : Map<Text, Types.Gear_Class>;
    gear_rarities : Map<Text, Types.Gear_Rarity>;
    substats : Map<Text, Types.Substat>;
  };


  public func empty() : State {
    {
      users = TrieMap.TrieMap<Text,Types.User>(Text.equal,Text.hash);
      inventories = TrieMap.TrieMap<Text,Types.Inventory>(Text.equal,Text.hash);

      num_character = 0;
      characters = TrieMap.TrieMap<Text,Types.Character>(Text.equal,Text.hash);
      character_classes = TrieMap.TrieMap<Text,Types.Character_Class>(Text.equal,Text.hash);
      //special_abilities = TrieMap.TrieMap<Text,Types.Special_Ability>(Text.equal,Text.hash);
      
      quests = TrieMap.TrieMap<Text,Types.Quest>(Text.equal,Text.hash);
      events = TrieMap.TrieMap<Text,Types.Event>(Text.equal,Text.hash);
	    options = TrieMap.TrieMap<Text,Types.Option>(Text.equal,Text.hash);
      charactertakeoptions = TrieMap.TrieMap<Text,Types.Character_Take_Option>(Text.equal,Text.hash);
      questitems = TrieMap.TrieMap<Text,Types.Quest_Item>(Text.equal,Text.hash);
      charactercarryingquestitems = TrieMap.TrieMap<Text,Types.Character_Carrying_QuestItem>(Text.equal,Text.hash);
	    questitemforquests = TrieMap.TrieMap<Text,Types.Quest_Item_For_Quest>(Text.equal,Text.hash);

      materials = TrieMap.TrieMap<Text,Types.Material>(Text.equal,Text.hash);
      charactercollectmaterials = TrieMap.TrieMap<Text,Types.Character_Collect_Material>(Text.equal,Text.hash);

      gears = TrieMap.TrieMap<Text,Types.Gear>(Text.equal,Text.hash);
      gear_classes = TrieMap.TrieMap<Text,Types.Gear_Class>(Text.equal,Text.hash);
      gear_rarities = TrieMap.TrieMap<Text,Types.Gear_Rarity>(Text.equal,Text.hash);
      substats = TrieMap.TrieMap<Text,Types.Substat>(Text.equal,Text.hash);
    };
  };

  public func inc_charid(S: State) : State {
    {
      users = S.users;
      inventories = S.inventories;

      num_character = S.num_character + 1;
      characters = S.characters;
      character_classes = S.character_classes;
      
      quests = S.quests;
      events = S.events;
      options = S.options;
      charactertakeoptions = S.charactertakeoptions;
      questitems = S.questitems;
      charactercarryingquestitems = S.charactercarryingquestitems;
      questitemforquests = S.questitemforquests;

      materials = S.materials;
      charactercollectmaterials = S.charactercollectmaterials;

      gears = S.gears;
      gear_classes = S.gear_classes;
      gear_rarities = S.gear_rarities;
      substats = S.substats;
    }
  };
}