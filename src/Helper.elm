module Helper exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Katex as K
    exposing
        ( Latex
        , display
        , human
        , inline
        )


type alias BlogPostMetaData =
    { title : String
    , published_date : String
    , post_link : String
    , summary : String
    }


page_view_template : { a | published_date : String, summary : String } -> Html msg -> Html msg
page_view_template model children =
    div
        [ class "mb-40" ]
        [ p [ class "text-gray-500 text-sm" ] [ text model.published_date ]
        , p
            [ class "text-grey-600" ]
            [ span [ class "font-medium" ] [ text "Summary" ]
            , text ": "
            , text model.summary
            ]
        , children
        ]


compile_latex_code : List Latex -> Html a
compile_latex_code lst =
    lst
        |> List.map (K.generate htmlGenerator)
        |> div [ class "" ]


htmlGenerator : Maybe Bool -> String -> Html msg
htmlGenerator isDisplayMode stringLatex =
    case isDisplayMode of
        Just True ->
            div [ class "overflow-x-auto py-5" ] [ text stringLatex ]

        _ ->
            span [] [ text stringLatex ]
