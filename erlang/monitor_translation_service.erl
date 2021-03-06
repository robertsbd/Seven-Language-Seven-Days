% question 1 day 3 monitoring process

-module(monitor_translation_service).
-export([loop/0]).

loop() ->
    process_flag(trap_exit, true),
    receive
	new ->
	    io:format("Creating and monitoring translation process.~n"),
	    register(translator, spawn_link(fun translate_service:loop/0)),
	    loop();

	{'EXIT', From, Reason} ->
	    io:format("translator process ~p exited with reason ~p.", [From, Reason]), 
      	    io:format(" Restarting. ~n"),
	    self() ! new,
	    loop()
end.

