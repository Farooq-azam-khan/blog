module Pages.PageTemplate exposing (..)

import Helper
    exposing
        ( BlogPostMetaData
        , compile_latex_code
        , page_view_template
        )
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Katex
    exposing
        ( Latex
        , display
        , human
        , inline
        )


type alias Model =
    { meta_data : BlogPostMetaData
    }


init : ( Model, Cmd Msg )
init =
    ( { meta_data =
            { title = ""
            , published_date = ""
            , summary = ""
            , post_link = ""
            }
      }
    , Cmd.none
    )


view : Model -> Html a
view model =
    page_view_template
        model.meta_data
    <|
        div []
            [ section []
                []
            ]


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
