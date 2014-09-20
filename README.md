ling
====

Erlang list-string routines.

    % common
    split("dirt and dirty things. <dirt href='dirtydirt'>!", "dirt") == [""," and ","y things. <", " href='","y","'>!"],

    join([""," and ","y things. <", " href='","y","'>!"], "icecream") == "icecream and icecreamy things. <icecream href='icecreamyicecream'>!",

    clean("dirt and dirty things. <dirt href='dirtydirt'>!", "dirt") == " and y things. < href='y'>!",

    replace("dirt and dirty things. <dirt href='dirtydirt'>!", "dirt", "icecream") == "icecream and icecreamy things. <icecream href='icecreamyicecream'>!",

    replace_a_lot("dirt and dirty things. <dirt href='dirtydirt'>!", [
        {"dirt", "icecream"},
        {"and", "but"},
        {"thing", "stuff"},
        {"href", "src"}
    ]) == "icecream but icecreamy stuffs. <icecream src='icecreamyicecream'>!",
        
    same_set(["1","2","3"], ["3","1","2"]) == true,
    same_set(["1","2","3"], ["3","2"]) == false,
    same_set(["1","2","3"], ["3","2","2"]) == false,

    starts_with("Longword", "Long") == true,
    starts_with("Longword", "ord") == false,
    ends_with("Longword", "word") == true,
    ends_with("Longword", "ong") == false,

    trim("\tsome text  ") == "some text",
    trim("\tsome text  ", " t") == "\tsome tex",

    part("1234567890", 2, -2) == "23456789",
    part("1234567890", 2, 5) == "2345",
    part("1234567890", -5, -1) == "67890",
    part("1234567890", 3, 3) == "3",
    part("1234567890", -15, 15) == "1234567890",
    part("1234567890", 15, -15) == "",

    flatten(["1",["2","3"],"4",[["5",["6",["7","8"]]],"9"],"0"]) == ["1","2","3","4","5","6","7","8","9","0"],

    % rare
    replace_in_brackets("dirt and dirty things. <dirt href='dirtydirt'>!", "dirt", "icecream", "<>") == "dirt and dirty things. <icecream href='icecreamyicecream'>!",

    replace_out_brackets("dirt and dirty things. <dirt href='dirtydirt'>!", "dirt", "icecream", "<>") == "icecream and icecreamy things. <dirt href='dirtydirt'>!",

    trim_to_first("dirt and dirty things. <dirt href='dirtydirt'>!", "<") == "<dirt href='dirtydirt'>!",

    trim_from_last("dirt and dirty things. <dirt href='dirtydirt'>!", "<") == "dirt and dirty things. <",
 
    do_with_tokens("Here: http://synrc.com!", fun a_href/1, [" ", ",", "?", "!"]) == "Here: <a href='http://synrc.com'>http://synrc.com</a>!"
