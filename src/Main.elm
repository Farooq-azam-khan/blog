port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Helper exposing (BlogPostMetaData)
import Html exposing (..)
import Html.Attributes exposing (alt, class, href, src, target)
import Pages.CosineSimilarity as CosineSimilarity
import Pages.CosineSimilarityPt2 as CosineSimilarityPt2
import Pages.SVD as SVD
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


port sendUrlChangedData : String -> Cmd msg


type alias Model =
    { page : Page, key : Nav.Key }



-- To add a new page: add a Route, Page, Page Msg, route parser,
-- blog post list, page content view, update


type Route
    = HomeR
    | SVDRoute
    | CosineSimilarityR
    | CosineSimilarityPt2R


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


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map HomeR Parser.top
        , Parser.map SVDRoute (Parser.s "svd")
        , parse_blog_page_post_link CosineSimilarityR (Tuple.first CosineSimilarity.init).meta_data
        , parse_blog_page_post_link CosineSimilarityPt2R (Tuple.first CosineSimilarityPt2.init).meta_data
        ]


blog_posts_lists : List BlogPostMetaData
blog_posts_lists =
    [ (Tuple.first CosineSimilarityPt2.init).meta_data
    , (Tuple.first CosineSimilarity.init).meta_data
    ]


page_content_view : Model -> ( String, String, Html Msg )
page_content_view model =
    case model.page of
        SVDPage svd_model ->
            ( "svd"
            , svd_model.title
            , SVD.view svd_model |> Html.map SVDMessages
            )

        CosineSimilarityPage cs_model ->
            ( "cosine-similarity"
            , cs_model.meta_data.title
            , CosineSimilarity.view cs_model |> Html.map CosineSimilarityMessages
            )

        CosineSimilarityPt2Page cspt2_model ->
            ( "cosine-similarity-pt2", cspt2_model.meta_data.title, CosineSimilarityPt2.view cspt2_model |> Html.map CosineSimilarityPt2Messages )

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


view : Model -> Browser.Document Msg
view model =
    let
        ( title, blog_header, content ) =
            page_content_view model
    in
    { title = title ++ "| Blog | Farooq A. Khan"
    , body =
        [ div
            [ class "mx-5 sm:mx-0 sm:mx-auto prose lg:prose-lg sm:max-w-xl lg:max-w-3xl mt-10 " ]
            [ div [ class "sm:flex sm:items-center space-x-3" ]
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
                    ( model, Cmd.batch [ Nav.pushUrl model.key (Url.toString url), sendUrlChangedData (Url.toString url) ] )

        SVDMessages svd_page_message ->
            case model.page of
                SVDPage svd_model ->
                    mapToPageActivity model SVDPage SVDMessages (SVD.update svd_page_message svd_model)

                _ ->
                    ( model, Cmd.none )

        CosineSimilarityMessages cs_page_messages ->
            case model.page of
                CosineSimilarityPage cs_model ->
                    mapToPageActivity model CosineSimilarityPage CosineSimilarityMessages (CosineSimilarity.update cs_page_messages cs_model)

                _ ->
                    ( model, Cmd.none )

        CosineSimilarityPt2Messages cs_page_messages ->
            case model.page of
                CosineSimilarityPt2Page cs_model ->
                    mapToPageActivity model CosineSimilarityPt2Page CosineSimilarityPt2Messages (CosineSimilarityPt2.update cs_page_messages cs_model)

                _ ->
                    ( model, Cmd.none )


updateUrl : Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse parser url of
        Just SVDRoute ->
            mapToPageActivity model SVDPage SVDMessages SVD.init

        Just HomeR ->
            ( { model | page = HomePage }, Cmd.none )

        Just CosineSimilarityR ->
            mapToPageActivity model CosineSimilarityPage CosineSimilarityMessages CosineSimilarity.init

        Just CosineSimilarityPt2R ->
            mapToPageActivity model CosineSimilarityPt2Page CosineSimilarityPt2Messages CosineSimilarityPt2.init

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


blog_list_post_component : BlogPostMetaData -> Html msg
blog_list_post_component blog_data =
    div
        [ class "hover:bg-orange-100 py-2 rounded hover:rounded-lg ease-in duration-200 border-l-4  border-white hover:border-indigo-400 px-3 flex flex-col space-y-2" ]
        [ span [ class "text-indigo-600 " ] [ text blog_data.published_date ]
        , span [ class "mt-3" ]
            [ a
                [ href blog_data.post_link ]
                [ text blog_data.title ]
            ]
        , span [ class "text-gray-700" ]
            [ text blog_data.summary
            ]
        ]


home_page_content : Html Msg
home_page_content =
    div [ class "" ]
        [ section [ class "space-y-2" ] (List.map blog_list_post_component blog_posts_lists)
        , section []
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
subscriptions _ =
    Sub.none


mapToPageActivity :
    Model
    -> (other_pg_model -> Page)
    -> (other_pg_msg -> Msg)
    -> ( other_pg_model, Cmd other_pg_msg )
    -> ( Model, Cmd Msg )
mapToPageActivity model page cmd_msg ( pg_model, pg_msg ) =
    ( { model | page = page pg_model }
    , Cmd.batch [ Cmd.map cmd_msg pg_msg, sendUrlChangedData "url_changed" ]
    )


parse_blog_page_post_link :
    Route
    -> BlogPostMetaData
    -> Parser (Route -> a) a
parse_blog_page_post_link route meta_data =
    Parser.map route
        (Parser.s
            meta_data.post_link
        )


init : flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    updateUrl url { page = NotFound, key = key }


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
