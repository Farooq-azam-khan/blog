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
