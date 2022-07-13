import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";
import Types "Types";

module {
  private type Map<K,V> = TrieMap.TrieMap<K,V>;
  public type State = {
    users: Map<Text,Types.User>;
    inventories: Map<Text,Types.Inventory>;

    characters: Map<Text,Types.Character>;
    character_classes: Map<Text,Types.Character_Class>;
    //special_abilities: Map<Text,Types.Special_Ability>;

    quests: Map<Text,Types.Quest>;
    events: Map<Text,Types.Event>;
    options: Map<Text,Types.Option>;
    charstakeoptions: Map<Text,Types.ChartakeOption>;

    items: Map<Text,Types.Item>;
    itemsforquests: Map<Text,Types.ItemforQuest>;
    charscarryingitems: Map<Text,Types.CharcarryingItem>;

    materials: Map<Text,Types.Material>;
    charscollectmaterials: Map<Text, Types.CharcollectMaterial>;

    gears: Map<Text,Types.Gear>;
    gear_classes: Map<Text,Types.Gear_Class>;
    gear_rarities: Map<Text,Types.Gear_Rarity>;
    substats: Map<Text,Types.Substat>;

    
  };

  public func empty(): State {
    {
      users = TrieMap.TrieMap<Text, Types.User>(Text.equal, Text.hash);
      inventories = TrieMap.TrieMap<Text, Types.Inventory>(Text.equal, Text.hash);

      characters = TrieMap.TrieMap<Text, Types.Character>(Text.equal, Text.hash);
      character_classes = TrieMap.TrieMap<Text, Types.Character_Class>(Text.equal, Text.hash);
      //special_abilities = TrieMap.TrieMap<Text, Types.Special_Ability>(Text.equal, Text.hash);

      quests = TrieMap.TrieMap<Text, Types.Quest>(Text.equal, Text.hash);
      events = TrieMap.TrieMap<Text, Types.Event>(Text.equal, Text.hash);
      options = TrieMap.TrieMap<Text, Types.Option>(Text.equal, Text.hash);
      charstakeoptions = TrieMap.TrieMap<Text, Types.ChartakeOption>(Text.equal, Text.hash);
     
      items = TrieMap.TrieMap<Text, Types.Item>(Text.equal, Text.hash);
      itemsforquests = TrieMap.TrieMap<Text, Types.ItemforQuest>(Text.equal, Text.hash);
      charscarryingitems = TrieMap.TrieMap<Text,Types.CharcarryingItem>(Text.equal,Text.hash);

      materials = TrieMap.TrieMap<Text, Types.Material>(Text.equal, Text.hash);
      charscollectmaterials = TrieMap.TrieMap<Text, Types.CharcollectMaterial>(Text.equal, Text.hash);

      gears = TrieMap.TrieMap<Text, Types.Gear>(Text.equal, Text.hash);
      gear_classes = TrieMap.TrieMap<Text, Types.Gear_Class>(Text.equal, Text.hash);
      gear_rarities = TrieMap.TrieMap<Text, Types.Gear_Rarity>(Text.equal, Text.hash);
      substats = TrieMap.TrieMap<Text, Types.Substat>(Text.equal, Text.hash);
    };
  };


}