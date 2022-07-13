import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";
import Types "Types";

module {
    public type State = {
        quest_items : TrieMap.TrieMap<Text, Types.Quest_Item>;
        quests : TrieMap.TrieMap<Text, Types.Quest>;
        quest_item_for_quests : TrieMap.TrieMap<Text, Types.Quest_Item_for_Quest>;
        characters : TrieMap.TrieMap<Text, Types.Character>; 
        events : TrieMap.TrieMap<Text, Types.Event>; 
        options : TrieMap.TrieMap<Text, Types.Options>;
        character_take_options : TrieMap.TrieMap<Text, Types.Character_take_Opton>;
        materials : TrieMap.TrieMap<Text, Types.Material>;
        character_quest_items: TrieMap.TrieMap<Text, Types.Character_Quest_Item>;
    };

    public func empty() : State {
        {
            quest_items = TrieMap.TrieMap<Text, Types.Quest_Item>(Text.equal, Text.hash);
            quests = TrieMap.TrieMap<Text, Types.Quest>(Text.equal, Text.hash);
            quest_item_for_quests = TrieMap.TrieMap<Text, Types.Quest_Item_for_Quest>(Text.equal, Text.hash);
            characters = TrieMap.TrieMap<Text, Types.Character>(Text.equal, Text.hash);
            events = TrieMap.TrieMap<Text, Types.Event>(Text.equal, Text.hash); 
            options = TrieMap.TrieMap<Text, Types.Options>(Text.equal, Text.hash); 
            character_take_options = TrieMap.TrieMap<Text, Types.Character_take_Opton>(Text.equal, Text.hash); 
            materials = TrieMap.TrieMap<Text, Types.Material>(Text.equal, Text.hash); 
            character_quest_items = TrieMap.TrieMap<Text, Types.Character_Quest_Item>(Text.equal, Text.hash);
        };
    };
}