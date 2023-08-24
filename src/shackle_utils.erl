-module(shackle_utils).

-compile(inline).
-compile({inline_size, 512}).

%% public
-export([
    ets_options/0,
    info_msg/3,
    lookup/3,
    random/1,
    random_element/1,
    warning_msg/3
]).

%% public
-spec ets_options() ->
  list().

-ifdef(DECENTRALIZED_COUNTERS).

ets_options() -> [
      named_table,
      public,
      {write_concurrency, true},
      {decentralized_counters, true}
  ].

-else.

ets_options() -> [
      named_table,
      public,
      {write_concurrency, true}
  ].

-endif.

-spec info_msg(shackle_pool:name(), string(), [term()]) ->
    ok.

info_msg(Pool, Format, Data) ->
    error_logger:info_msg("[~p] " ++ Format, [Pool | Data]).

-spec lookup(atom(), [{atom(), term()}], term()) ->
    term().

lookup(Key, List, Default) ->
    case lists:keyfind(Key, 1, List) of
        false -> Default;
        {_, Value} -> Value
    end.

-spec random(pos_integer()) ->
    non_neg_integer().

random(1) -> 1;
random(N) ->
    rand:uniform(N).

-spec random_element([term()]) ->
    term().

random_element([X]) ->
    X;
random_element([_|_] = List) ->
    T = list_to_tuple(List),
    element(random(tuple_size(T)), T).

-spec warning_msg(shackle_pool:name(), string(), [term()]) ->
    ok.

warning_msg(Pool, Format, Data) ->
    error_logger:warning_msg("[~p] " ++ Format, [Pool | Data]).
