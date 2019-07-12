-module(shackle_status).
-include("shackle_internal.hrl").

-compile(inline).
-compile({inline_size, 512}).

-export([
    active/2,
    delete/1,
    disable/2,
    enable/2,
    init/0,
    new/2
]).

%% public
-ifdef(ATOMICS).

-spec active(pool_name(), server_index()) ->
    boolean().

active(PoolName, ServerIndex) ->
    case persistent_term:get(PoolName, undefined) of
        undefined ->
            false;
        Counters ->
            boolean(counters:get(Counters, ServerIndex))
    end.

-spec delete(pool_name()) ->
    ok.

delete(PoolName) ->
    persistent_term:erase(PoolName),
    ok.

-spec disable(pool_name(), server_index()) ->
    ok.

disable(PoolName, ServerIndex) ->
    case persistent_term:get(PoolName, undefined) of
        undefined ->
            ok;
        Counters ->
            counters:sub(Counters, ServerIndex, 1)
    end.

-spec enable(pool_name(), server_index()) ->
    ok.

enable(PoolName, ServerIndex) ->
    case persistent_term:get(PoolName, undefined) of
        undefined ->
            ok;
        Counters ->
            counters:add(Counters, ServerIndex, 1)
    end.

-spec init() ->
    ok.

init() ->
    ok.

-spec new(pool_name(), pool_size()) ->
    ok.

new(PoolName, PoolSize) ->
    Counters = counters:new(PoolSize, []),
    persistent_term:put(PoolName, Counters).

-else.

-spec active(pool_name(), server_index()) ->
    boolean().

active(PoolName, ServerIndex) ->
    try
        Bit = ets:lookup_element(?ETS_TABLE_STATUS, PoolName, ServerIndex + 1),
        boolean(Bit)
    catch
        error:badarg ->
            false
    end.

-spec delete(pool_name()) ->
    ok.

delete(PoolName) ->
    ets:delete(?ETS_TABLE_STATUS, PoolName),
    ok.

-spec disable(pool_name(), server_index()) ->
    ok.

disable(PoolName, ServerIndex) ->
    try
        ets:update_counter(?ETS_TABLE_STATUS, PoolName, {ServerIndex + 1, -1}),
        ok
    catch
        error:badard ->
            ok
    end.

-spec enable(pool_name(), server_index()) ->
    ok.

enable(PoolName, ServerIndex) ->
    try
        ets:update_counter(?ETS_TABLE_STATUS, PoolName, {ServerIndex + 1, 1}),
        ok
    catch
        error:badard ->
            ok
    end.

-spec init() ->
    ok.

init() ->
    ets:new(?ETS_TABLE_STATUS, [
        named_table,
        public,
        {write_concurrency, true}
    ]),
    ok.

-spec new(pool_name(), pool_size()) ->
    ok.

new(PoolName, PoolSize) ->
    Init = [0 || _ <- lists:seq(1, PoolSize)],
    KeyValue = list_to_tuple([PoolName] ++ Init),
    true = ets:insert(?ETS_TABLE_STATUS, [KeyValue]),
    ok.

-endif.

%% private
boolean(0) ->
    false;
boolean(1) ->
    true.
