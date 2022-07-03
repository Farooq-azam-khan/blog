module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class)
import Pages.SVD as SVD
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type alias Model =
    { page : Page, key : Nav.Key }


type Page
    = SVDPage SVD.Model
    | HomePage
    | NotFound


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | SVDMessages SVD.Msg


type Route
    = HomeR
    | SVDRoute


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map HomeR Parser.top
        , Parser.map SVDRoute (Parser.s "svd")
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangedUrl url ->
            updateUrl url model

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

        SVDMessages svd_page_message ->
            case model.page of
                SVDPage svd_model ->
                    toSVD model (SVD.update svd_page_message svd_model)

                _ ->
                    ( model, Cmd.none )


updateUrl : Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse parser url of
        Just SVDRoute ->
            toSVD model SVD.init

        Just HomeR ->
            ( { model | page = HomePage }, Cmd.none )

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


toSVD : Model -> ( SVD.Model, Cmd SVD.Msg ) -> ( Model, Cmd Msg )
toSVD model ( svd_model, svd_cmd ) =
    ( { model | page = SVDPage svd_model }, Cmd.map SVDMessages svd_cmd )


init : flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    updateUrl url { page = NotFound, key = key }


view : Model -> Browser.Document Msg
view model =
    let
        content =
            case model.page of
                SVDPage svd_model ->
                    SVD.view svd_model |> Html.map SVDMessages

                HomePage ->
                    div [] [ text "Home Page" ]

                NotFound ->
                    div [] [ text "url not found" ]
    in
    { title = "Welcome to My Blog"
    , body = [ div [ class "prose lg:prose-xl sm:max-w-xl lg:max-w-2xl mt-10 mx-auto" ] [ h1 [] [ text "Welcome to My Blog" ], content ] ]
    }


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
