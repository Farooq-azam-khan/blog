module Helper exposing (..)

import Html exposing (..)


htmlGenerator isDisplayMode stringLatex =
    case isDisplayMode of
        Just True ->
            div [] [ text stringLatex ]

        _ ->
            span [] [ text stringLatex ]
