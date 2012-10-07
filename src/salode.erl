-module(salode).
-compile(export_all).
-author("akalenuk@gmail.com").

save(Key, Value) ->
    Dir = ling:trim_from_last(Key, "/"),
    filelib:ensure_dir(Dir),
    ok = file:write_file(Key, term_to_binary(Value)).

load(Key) ->
    {ok, Bin} = file:read_file(Key),
    binary_to_term(Bin).

delete("") ->
    ok;
delete(Key) ->
    file:delete(Key),
    Cleanup = fun(CleanupFun, Dir) ->
        case file:del_dir(Dir) of
            ok -> CleanupFun(CleanupFun, ling:trim_from_last( ling:part(Dir, 1, -2), "/") );
            _ -> ok
        end
    end,
    Cleanup(Cleanup, ling:trim_from_last(Key, "/")).

keys() ->
    keys(".").
keys(Path) ->
    {ok, Files} = file:list_dir(Path),
    ling:flatten([
        begin
            {ok, FileInfo} = file:read_file_info(Path ++ "/" ++ FileOrDirectory),
            case element(3, FileInfo) of
                regular ->
                    Path ++ "/" ++ FileOrDirectory;
                directory ->
                    keys(Path ++ "/" ++ FileOrDirectory);
                _ ->
                    []
            end
        end
        || FileOrDirectory <- Files
    ]).


test() ->
    T = [[],{},{2, "the text"},[3,{the_atom}]],
    save("dir/subdir/file", T),
    [
        load("dir/subdir/file") == T,
        keys("dir") == ["dir/subdir/file"],
        delete("dir/subdir/file") == ok
    ].
