module Pages.SVD exposing (..)

import Helper exposing (BlogDevelopmentStep(..), BlogPostMetaData, PulicationDate(..), page_view_template)
import Html exposing (..)
import Katex as K
    exposing
        ( Latex
        , display
        , human
        , inline
        )



-- if it is a draft, then show title but, link is not clickable and is greyed out


type alias Model =
    { meta_data : BlogPostMetaData
    }


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
    page_view_template model.meta_data <|
        (passage
            |> List.map (K.generate htmlGenerator)
            |> div []
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


init : ( Model, Cmd Msg )
init =
    ( { meta_data =
            { title = "Singular Value Decomposition"
            , published_date = InDevelopment
            , summary = "TBD"
            , post_link = "svd"
            , developmentStep = Draft "1.0"
            }
      }
    , Cmd.none
    )
