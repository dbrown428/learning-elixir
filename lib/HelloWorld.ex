defmodule HelloWorld do
    defmodule Greetings do
        def something() do
            IO.puts ">> HelloWorld.Greetings.Something!"
        end
    end

    defmodule Goodbyes do
        def ciao() do
            IO.puts ">> HelloWorld.Goodbyes.Ciao!"
        end
    end

    def doodle() do
        IO.puts ">> HelloWorld.Doodle!"
    end
end
