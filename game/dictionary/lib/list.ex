defmodule Lists do
    
    def len( [] ), do: 0
    def len([ _head| tail]), do: 1 + len(tail)

    def sum( [] ), do: 0
    def sum( [h|t] ), do: h + sum(t)

    def double( [] ), do: []
    def double( [head|tail] ), do: [head*2 | double(tail) ] 

    def square( [] ), do: []
    def square( [ head| tail] ), do: [ head*head | square(tail) ]

    def sum_pairs( [] ), do: []
    def sum_pairs( [h1, h2 | t] ), do: [h1 + h2 | sum_pairs(t) ]

    def map( [], _func ), do: []
    def map( [h|t], func ) do 
        [ func.(h) | map(t, func) ]
    end
end