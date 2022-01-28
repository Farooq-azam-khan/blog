module Page.SVD exposing (Model, Msg, Data, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)
import Html exposing (..)
import Html.Attributes exposing (..)

type alias Model =
    ()


type alias Msg =
    Never

type alias RouteParams =
    {}

page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


type alias Data =
    ()


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    View.blog_page_scaffold 
        "SVD" 
        (div 
            [ 
            ] 
            [ h1 [] [text "Singular Value Decomposition (SVD)"]
            , p [] [text "What is it? SVD is a very versatile tool in linear algebra. In Machine Learning it is used as a dimentionality reduction technique."]
            , p [] [text "SVD is reduces an N dimentional matrix down to K dimensions where K < N."]
            , p [] [text "$$A = USV^T$$"]
            , p [] [text "where A is an m x n matrix, U is an m x r orthogonal left sigular matrix, S is an r by r diagonal matrix, and V is an r by n diagonal right singualr matrix."]
            , p [] [text "SVD is used in recommendation engines. Also used to calculate the fast fourier transforms, linear regression, etc. Understanding this topic will greatly set you in the path of understanding and using linear algebra effectively."]
            
            ]
        )
