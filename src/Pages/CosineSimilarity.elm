module Pages.CosineSimilarity exposing (..)

import Helper exposing (htmlGenerator)
import Html exposing (..)
import Katex as K
    exposing
        ( Latex
        , display
        , human
        , inline
        )


passage : List Latex
passage =
    [ human "We will work with cosine similarity here."
    , display "cos(\\theta) = \\frac{x\\cdot y}{xy}"
    ]


type alias Model =
    { title : String }


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )


view : Model -> Html a
view model =
    passage
        |> List.map (K.generate htmlGenerator)
        |> div []


init : ( Model, Cmd Msg )
init =
    ( { title = "Comapring Vectors with Cosine Simlarity Function" }, Cmd.none )
