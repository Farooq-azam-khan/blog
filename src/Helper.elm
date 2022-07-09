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
        |> div [ class "py-2" ]


htmlGenerator isDisplayMode stringLatex =
    case isDisplayMode of
        Just True ->
            div [] [ text stringLatex ]

        _ ->
            span [] [ text stringLatex ]
