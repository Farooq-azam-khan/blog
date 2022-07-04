port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Pages.CosineSimilarity as CosineSimilarity
import Pages.SVD as SVD
import Task
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


port sendUrlChangedData : String -> Cmd msg


type alias Model =
    { page : Page, key : Nav.Key }


type Page
    = SVDPage SVD.Model
    | CosineSimilarityPage CosineSimilarity.Model
    | HomePage
    | NotFound


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | SVDMessages SVD.Msg
    | CosineSimilarityMessages CosineSimilarity.Msg


type Route
    = HomeR
    | SVDRoute
    | CosineSimilarityR


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map HomeR Parser.top
        , Parser.map SVDRoute (Parser.s "svd")
        , Parser.map CosineSimilarityR (Parser.s "cosine-similarity")
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
                    ( model, Cmd.batch [ Nav.pushUrl model.key (Url.toString url), sendUrlChangedData "changedurl" ] )

        SVDMessages svd_page_message ->
            case model.page of
                SVDPage svd_model ->
                    toSVD model (SVD.update svd_page_message svd_model)

                _ ->
                    ( model, Cmd.none )

        CosineSimilarityMessages cs_page_messages ->
            case model.page of
                CosineSimilarityPage cs_model ->
                    toCosineSimilarity model (CosineSimilarity.update cs_page_messages cs_model)

                _ ->
                    ( model, Cmd.none )


updateUrl : Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    let
        send_data_cmd =
            sendUrlChangedData (Url.toString url)
    in
    case Parser.parse parser url of
        Just SVDRoute ->
            toSVD model SVD.init

        Just HomeR ->
            ( { model | page = HomePage }, Cmd.none )

        Just CosineSimilarityR ->
            toCosineSimilarity model CosineSimilarity.init

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


toSVD : Model -> ( SVD.Model, Cmd SVD.Msg ) -> ( Model, Cmd Msg )
toSVD model ( svd_model, svd_cmd ) =
    ( { model | page = SVDPage svd_model }
    , Cmd.batch [ sendUrlChangedData "svd", Cmd.map SVDMessages svd_cmd ]
    )


toCosineSimilarity : Model -> ( CosineSimilarity.Model, Cmd CosineSimilarity.Msg ) -> ( Model, Cmd Msg )
toCosineSimilarity model ( cs_model, cs_cmd ) =
    ( { model | page = CosineSimilarityPage cs_model }
    , Cmd.batch [ Cmd.map CosineSimilarityMessages cs_cmd, sendUrlChangedData "cosine-similarity" ]
    )


init : flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    updateUrl url { page = NotFound, key = key }


view : Model -> Browser.Document Msg
view model =
    let
        ( title, blog_header, content ) =
            case model.page of
                SVDPage svd_model ->
                    ( "svd"
                    , "Singular Value Decomposition"
                    , SVD.view svd_model |> Html.map SVDMessages
                    )

                CosineSimilarityPage cs_model ->
                    ( "cosine-similarity"
                    , cs_model.title
                    , CosineSimilarity.view cs_model |> Html.map CosineSimilarityMessages
                    )

                HomePage ->
                    ( "Home"
                    , "Welcome to My Blog"
                    , home_page_content
                    )

                NotFound ->
                    ( "Not Found"
                    , "Page Not Found"
                    , div [] [ text "url not found" ]
                    )
    in
    { title = "Farooq A. Khan | Blog | " ++ title
    , body =
        [ div
            [ class "prose lg:prose-xl sm:max-w-xl lg:max-w-2xl mt-10 mx-auto" ]
            [ h1
                []
                [ text blog_header ]
            , content
            ]
        ]
    }


home_page_content : Html Msg
home_page_content =
    div []
        [ ol []
            [ li [] [ a [ href "/svd" ] [ text "SVD" ] ]
            , li [] [ a [ href "/cosine-similarity" ] [ text "Cosine Similarity" ] ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
