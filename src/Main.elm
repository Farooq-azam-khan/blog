port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (alt, class, href, src, target)
import Pages.CosineSimilarity as CosineSimilarity
import Pages.CosineSimilarityPt2 as CosineSimilarityPt2
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
    | CosineSimilarityPt2Page CosineSimilarityPt2.Model
    | HomePage
    | NotFound


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | SVDMessages SVD.Msg
    | CosineSimilarityMessages CosineSimilarity.Msg
    | CosineSimilarityPt2Messages CosineSimilarityPt2.Msg


type Route
    = HomeR
    | SVDRoute
    | CosineSimilarityR
    | CosineSimilarityPt2R


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map HomeR Parser.top
        , Parser.map SVDRoute (Parser.s "svd")
        , Parser.map CosineSimilarityR (Parser.s "cosine-similarity")
        , Parser.map CosineSimilarityPt2R (Parser.s "cosine-similarity-pt2")
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

        CosineSimilarityPt2Messages cs_page_messages ->
            case model.page of
                CosineSimilarityPt2Page cs_model ->
                    toCosineSimilarityPt2 model (CosineSimilarityPt2.update cs_page_messages cs_model)

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

        Just CosineSimilarityPt2R ->
            toCosineSimilarityPt2 model CosineSimilarityPt2.init

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


toCosineSimilarityPt2 : Model -> ( CosineSimilarityPt2.Model, Cmd CosineSimilarityPt2.Msg ) -> ( Model, Cmd Msg )
toCosineSimilarityPt2 model ( cs_model, cs_cmd ) =
    ( { model
        | page = CosineSimilarityPt2Page cs_model
      }
    , Cmd.batch [ Cmd.map CosineSimilarityPt2Messages cs_cmd, sendUrlChangedData "cosine-similarity-pt2" ]
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
                    , svd_model.title
                    , SVD.view svd_model |> Html.map SVDMessages
                    )

                CosineSimilarityPage cs_model ->
                    ( "cosine-similarity"
                    , cs_model.title
                    , CosineSimilarity.view cs_model |> Html.map CosineSimilarityMessages
                    )

                CosineSimilarityPt2Page cspt2_model ->
                    ( "cosine-similarity-pt2", cspt2_model.title, CosineSimilarityPt2.view cspt2_model |> Html.map CosineSimilarityPt2Messages )

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
            [ class "prose lg:prose-lg sm:max-w-xl lg:max-w-3xl mt-10 mx-auto" ]
            [ div [ class "flex items-center space-x-3" ]
                [ a [ target "blank", class "flex-shrink-0", href "http://www.github.com/farooq-azam-khan" ]
                    [ img [ alt "image of Farooq Azam Khan", class "rounded-full w-32 h-32", src "https://avatars.githubusercontent.com/u/33574913?v=4" ]
                        []
                    ]
                , h1
                    [ class "hover:underline tracking-wide" ]
                    [ text blog_header ]
                ]
            , content
            ]
        ]
    }


blog_list_post_component : { published_date : String, post_title : String, post_link : String, post_summary : String } -> Html Msg
blog_list_post_component blog_data =
    div
        [ class "hover:bg-orange-100 py-2 rounded hover:rounded-lg ease-in duration-200 border-l-4  border-white hover:border-indigo-400 px-3 flex flex-col space-y-2" ]
        [ span [ class "text-indigo-600 " ] [ text blog_data.published_date ]
        , span [ class "mt-3" ]
            [ a
                [ href blog_data.post_link ]
                [ text blog_data.post_title ]
            ]
        , span [ class "text-gray-700" ]
            [ text blog_data.post_summary
            ]
        ]


home_page_content : Html Msg
home_page_content =
    div [ class "" ]
        [ -- li [] [ a [ href "/svd" ] [ text "SVD" ] ]
          -- ,
          div [ class "space-y-2" ]
            [ blog_list_post_component
                { post_title = "Large Scale Sentence Comparison"
                , published_date = "July 9th, 2022"
                , post_link = "/cosine-similarity-pt2"
                , post_summary = ""
                }
            , blog_list_post_component
                { post_title = "Comapring Vectors with Cosine Simlarity Function"
                , published_date = "July 4th, 2022"
                , post_link = "/cosine-similarity"
                , post_summary = "In this blog, we will aim to understand the cosine function and its applications. Specifically we will look at comparing two strings and their similarity score."
                }
            ]
        , div []
            [ h2 [ class "text-gray-700" ] [ text "Drafts" ]
            , ul [ class "list-disc" ]
                [ li [] [ text "Singular Value Decomposition and Recommendation Engines" ]
                , li [] [ text "What Principal Component Analysis teaches us about Dimensionality reduction" ]
                , li [] [ text "The Deep Learning Model Development Architecture" ]
                , li [] [ text "Linear Regression: The Basis for all Modern Deep Learning Algorithms" ]
                , li [] [ text "What RNNs are and why they are Turing Complete!" ]
                ]
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
