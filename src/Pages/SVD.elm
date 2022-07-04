module Pages.SVD exposing (..)

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
    [ human "The formula for Singular Value Decomposition is"
    , display "A = USV^T"
    , human "where "
    , inline "A"
    , human ", "
    , inline "U"
    , human ", "
    , inline "S"
    , human ", "
    , inline "V"
    , human "are matricies."
    ]



-- if it is a draft, then show title but, link is not clickable and is greyed out


type alias Model =
    { title : String, date_added : String, is_draft : Bool }


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
    let
        htmlGenerator isDisplayMode stringLatex =
            case isDisplayMode of
                Just True ->
                    div [] [ text stringLatex ]

                _ ->
                    span [] [ text stringLatex ]
    in
    passage
        |> List.map (K.generate htmlGenerator)
        |> div []


init : ( Model, Cmd Msg )
init =
    ( { is_draft = True, title = "Singular Value Decomposition", date_added = "TBD" }, Cmd.none )
