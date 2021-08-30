module StringExtensions exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, string)
import Test exposing (..)
import UiBase.StringExtensions exposing (joinGrammatically)


suite : Test
suite =
    describe "The String Extensions module"
        [ describe "String.reverse"
            -- Nest as many descriptions as you like.
            [ test "does nothing with empty list" <|
                \_ ->
                    []
                        |> joinGrammatically
                        |> Expect.equal ""
            , test
                "does nothing with one word"
              <|
                \_ ->
                    [ "hello" ]
                        |> joinGrammatically
                        |> Expect.equal "hello"
            , test
                "joins two words with and"
              <|
                \_ ->
                    [ "hello", "goodbye" ]
                        |> joinGrammatically
                        |> Expect.equal "hello and goodbye"
            , test
                "joins more words with Oxford comma"
              <|
                \_ ->
                    [ "hello", "goodbye", "something else" ]
                        |> joinGrammatically
                        |> Expect.equal "hello, goodbye, and something else"
            ]
        ]
