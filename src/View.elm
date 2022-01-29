module View exposing (View, map, placeholder, blog_page_scaffold)

import Html exposing (..)
import Html.Attributes exposing (..)

type alias View msg =
    { title : String
    , body : List (Html msg)
    }


map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn doc =
    { title = doc.title
    , body = List.map (Html.map fn) doc.body
    }


placeholder : String -> View msg
placeholder moduleName =
    { title = "Placeholder - " ++ moduleName
    , body = [ Html.text moduleName ]
    }

blog_page_scaffold : String -> Html msg -> View msg
blog_page_scaffold moduleName  page =
    { title = moduleName
    , body = [ div [class "prose lg:prose-xl sm:max-w-xl lg:max-w-2xl mt-10 mx-auto"] [page ]]
    }
