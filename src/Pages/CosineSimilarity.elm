module Pages.CosineSimilarity exposing (..)

import Helper exposing (htmlGenerator)
import Html exposing (..)
import Html.Attributes exposing (class)
import Katex as K
    exposing
        ( Latex
        , display
        , human
        , inline
        )


view : Model -> Html a
view model =
    div [ class "mb-40" ]
        [ p [ class "text-grey-600" ]
            [ span [ class "font-medium" ] [ text "Summary" ]
            , text ": This tutorial will focus on the math behind text vector similarity using numpy, pytorch, and stentence-transformer libraries in python."
            ]
        , section []
            [ h2 [] [ text "What is Cosine Similarity?" ]
            , p [] [ text "Cosine similarity aims to measure the angle between two vecotrs. The angle is an indicator of how close the vectors are to each other. If the angle is 1, then the two vectors lie on top of each other are are exactly the same. If the angle is 0, then the vectors. This is very useful when we have a vector representaion of something and we want to compare it to another vecotr. For example, we can compoare two sentences together." ]
            , ul []
                [ li [] [ text "\"The quick brown fox jumps over the lazy dogs\"" ]
                , li [] [ text "\"The quick fox jumped over the dogs\"" ]
                ]
            , p [] [ text "We would like to have a vector representation of these two sentences such that their similarity score is close to 1 (i.e. 100%)" ]
            , p [] [ text "Other application include, impage comparison, plagarism detection, etc." ]
            , section [ class "space-y-5" ]
                [ h2 [] [ text "How do you calculate it?" ]
                , p [] [ text "Below is the formula to calculate cosine similarity" ]
                , compile_latex_code cosine_sim
                , compile_latex_code [ human "Let ", inline "x = [1,2,3]", human " and ", inline "y=[4,5,6]" ]
                , compile_latex_code [ human "The dot product is", display "[1,2,3] \\cdot [4,5,6] = 3 + 10 + 18 = 32", human "And the magnitude is", display "1^2 + 2^2 + 3^2 = 1 + 4 + 9 = 14", display "4^2 + 5^2 + 6^2 = 77" ]
                , p []
                    [ text "The similarity between the two vectors is"
                    , compile_latex_code [ display "\\frac{32}{14\\cdot 77} = 0.029" ]
                    ]
                , p [] [ text "Granted this does not show the power the cosine function has, we will look at more interesting examples below." ]
                ]
            , section [ class "space-y-2" ]
                [ h2 [] [ text "A Complex Example" ]
                , p [] [ text "We will use a deep learning model to generate vector representations of sentenes in an attempt to find similarities between sentences using the cosine similarity function" ]
                , pre []
                    [ code [ class "python" ] python_sentence_sim_code ]
                , p []
                    [ text "The above example imports the tentence transformers library ("
                    , code [] [ text "pip install sentence-transfomers" ]
                    , text "). "
                    , text "We use the 'paraphrase-Mini-L6-v2' model for calculating the encodings for each sentence. After applying the cosine similarity function we get a score of 0.875 which indicates the two sentences are very similary."
                    ]
                ]
            ]
        ]


python_sentence_sim_code =
    [ text "from sentence_transformers import SentenceTransformer\n"
    , text "# The Deep Learning model that will give us the vector representation\n"
    , text "model = SentenceTransformer('paraphrase-MiniLM-L6-v2')\n"
    , text "# The two sentences we want to compare\n"
    , text "s1 = 'The quick brown fox jumps over the lazy dogs'\n"
    , text "s2 = 'The quick fox jumped over the dogs'\n"
    , text "# Apply the model to get the number representation\n"
    , text "s1_encoding = model.encode(s1)\n"
    , text "s2_encoding = model.encode(s2)\n"
    , text "mag_s1 = np.sqrt(np.sum(np.square(s1_encoding)))\n"
    , text "mag_s2 = np.sqrt(np.sum(np.square(s2_encoding)))\n"
    , text "np.dot(s1_encoding, s2_encoding) / (mag_s1 * mag_s2)\n"
    , text "# Output: 0.8754566\n"
    ]


compile_latex_code : List Latex -> Html a
compile_latex_code lst =
    lst
        |> List.map (K.generate htmlGenerator)
        |> div [ class "py-2" ]


cosine_sim : List Latex
cosine_sim =
    [ display "cos(\\theta) = \\frac{x y}{\\Vert x \\Vert \\cdot \\Vert y \\Vert}"
    ]


type alias Model =
    { title : String }


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )


init : ( Model, Cmd Msg )
init =
    ( { title = "Comapring Vectors with Cosine Simlarity Function" }, Cmd.none )
