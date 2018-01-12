defmodule GameTest do
    use ExUnit.Case 
    
    alias Hangman.Game
    test "new_game returns structure" do
        game = Game.init_game()        
        assert game.turns_left == 7
        assert game.game_state == :initializing
        assert length(game.letters) > 0 
        assert Enum.join(game.letters) == Enum.join(game.letters) |> String.downcase()
    end

    test "state isn't change for :won :lost game" do
        for state <- [:won, :lost] do
            game = Game.init_game()
            #game = Map.put(game, :game_state, :won)
                |>Map.put(:game_state, state)
            assert { ^game, _ } = Game.make_move(game, "x")
        end    
   end

    # test "state isn't change for :lost game" do
    #     game = Game.init_game()
    #         |>Map.put(:game_state, :lost)
    #     assert { ^game, _ } = Game.make_move(game, "x")
    # end
    
    test "first occurence of letter is not already used" do
        game = Game.init_game()
        {game, _tally} = Game.make_move(game, "x")
        assert game.game_state != :already_used
    end

    test "second occurence of letter is not already used" do
        game = Game.init_game()
        {game, _tally} = Game.make_move(game, "x")
        assert game.game_state != :already_used
        {game, _tally} = Game.make_move(game, "x")
        assert game.game_state == :already_used
    end

    test "a good guess is recognized" do
        game = Game.init_game("wibble")
        {game, _tally} = Game.make_move(game, "w")
        assert game.game_state == :good_guess
        assert game.turns_left == 7
    end

    test "a guesses word is a won game" do
        game = Game.init_game("wibble")
        {game, _tally} = Game.make_move(game, "w")
        assert game.game_state == :good_guess
        assert game.turns_left == 7

        {game, _tally} = Game.make_move(game, "i")
        assert game.game_state == :good_guess
        assert game.turns_left == 7
        {game, _tally} = Game.make_move(game, "b")
        assert game.game_state == :good_guess
        assert game.turns_left == 7
        {game, _tally} = Game.make_move(game, "l")
        assert game.game_state == :good_guess
        assert game.turns_left == 7
        {game, _tally} = Game.make_move(game, "e")
        assert game.game_state == :won
        assert game.turns_left == 7
    end

    test "bag guess is recognozed" do
        game = Game.init_game("wibble")
        {game, _tally} = Game.make_move(game, "x")
        assert game.game_state == :bad_guess
        assert game.turns_left == 6
    end

    test "lost game is recognozed" do
        game = Game.init_game("w")
        {game, _tally} = Game.make_move(game, "a")
        assert game.game_state == :bad_guess
        assert game.turns_left == 6

        {game, _tally} = Game.make_move(game, "b")
        assert game.game_state == :bad_guess
        assert game.turns_left == 5

        {game, _tally} = Game.make_move(game, "c")
        assert game.game_state == :bad_guess
        assert game.turns_left == 4

        {game, _tally} = Game.make_move(game, "d")
        assert game.game_state == :bad_guess
        assert game.turns_left == 3

        {game, _tally} = Game.make_move(game, "e")
        assert game.game_state == :bad_guess
        assert game.turns_left == 2

        {game, _tally} = Game.make_move(game, "f")
        assert game.game_state == :bad_guess
        assert game.turns_left == 1

    end

end