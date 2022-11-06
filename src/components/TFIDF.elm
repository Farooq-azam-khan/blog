module Pages.TFIDF exposing (..)

import Helper
    exposing
        ( BlogDevelopmentStep(..)
        , BlogPostMetaData
        , PulicationDate(..)
        , blog_p
        , blog_section
        , compile_latex_code
        , page_view_template
        , python_code_block
        )
import Html exposing (..)
import Html.Attributes exposing (class)
import Katex as K
    exposing
        ( Latex
        , display
        , human
        , inline
        )


passage : List Latex
passage =
    [ human "The formula for Singular Value Decomposition is"
    , display "A = USV^T"
    , human "where "
    , inline "A"
    , human ", "
    , inline "U"
    , human ", "
    , inline "S"
    , human ", "
    , inline "V"
    , human "are matricies."
    ]


type alias Model =
    { meta_data : BlogPostMetaData
    }


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )


view : Model -> Html a
view model =
    page_view_template model.meta_data <|
        div []
            [ blog_section
                [ h2 [] [ text "What is TF?" ]
                , p
                    []
                    [ text "Unlike with traditional supervised Machine Learning (ML) problems the challenge with dealing with text data is that it is hard to figure out how to deal with it."
                    , text " Computers do not know how to deal with text data. We have come up with a standard of representing numbers in the form of ASCII, Latin, or UTF-8 encodings."
                    , text " Similarily our ML models will have some sort of encodings that we need it to know about."
                    , text " Dealing with text in the ML pipeline is reffered to as the preprocessing step."
                    ]
                , p []
                    [ text "Lets say we have a list of sentences"
                    ]
                , pre []
                    [ code [ class "python" ]
                        [ text """text_data  = ['A big Whale.', 
            'The quick brown fox.',
            'The Giraffe that cried.' ]""" ]
                    ]
                ]
            , blog_p
                [ text "We can lowercase each word, remove any punctuation, and split on space."
                , text " This will allow us to tokenize each word and count up how many times it appears in each sentence."
                ]
            , python_code_block
                [ text """import pandas as pd 
def create_doc_term_df(corpus, vectorizer):
    doc_term_matrix = vectorizer.fit_transform(corpus)
    df = pd.DataFrame(doc_term_matrix.toarray(), columns=vectorizer.get_feature_names_out())
    df.index.name = 'Sentence'
    return df
"""
                ]
            , blog_p [ text "Lets run the function and get the output" ]
            , python_code_block
                [ text """from sklearn.feature_extraction.text import CountVectorizer
vectorizer = CountVectorizer()
create_doc_term_df(account_names, vecotrizer)
'''Output: 
          big  brown  cried  fox  giraffe  quick  that  the  whale
Sentence                                                          
0           1      0      0    0        0      0     0    0      1
1           0      1      0    1        0      1     0    1      0
2           0      0      1    0        1      0     1    1      0
'''"""
                ]
            , blog_p
                [ text "Higher relevance is given to words that ppear more often across many sentences. The formula below calculates this frequency."
                ]
            , compile_latex_code [ display "tf_{i,j} = \\frac{n_{i,j}}{\\sum_{k=1}^{K} n_{k,j}}" ]
            , blog_p
                [ compile_latex_code [ human "where ", inline "i", human " referes to the index of the sentence and j refers to the index of the word at the ", inline "j", human "'th position." ]
                ]
            , blog_section
                [ h2 [] [ text "IDF" ]
                , blog_p
                    [ text "Now that we have calculated the frequency of each word within a sentence, we must also calculate the amount of times each word appears across all sentences."
                    , text " We are comparing the relevance of each word against other words in the sentence across all sentences."
                    , text " The reason this is an important step in our pipeline is because it normalizes our data across all account names."
                    ]
                , blog_p
                    [ text "Think of a spam email classfier."
                    , text " The word \"urgent! click here!\" would have a high term frequency within the email; however, across all the emails you have received these words will have a low frequency."
                    , text " The purpose of inverse document frequency is to drown out the words in documents that do not appear in other documents."
                    ]
                , compile_latex_code [ human "The formula for calculating ", inline "idf", human " is,", display "idf(w) = \\log(\\frac{N}{df_t})" ]
                , compile_latex_code
                    [ human "where "
                    , inline "df_t"
                    , human " is the number of documents that contain the word "
                    , inline "w"
                    , human ". "
                    , human "E.g. "
                    , inline "df(\"big\") = 1"
                    , human ". Also, "
                    , inline "N"
                    , human " is the number of words in our list. For our toy example, "
                    , inline "N=9"
                    , human "."
                    ]
                ]
            , blog_section
                [ h2 [] [ text "Putting it all Together, TFIDF" ]
                , compile_latex_code
                    [ human "The last step is to get the "
                    , inline "tfidf"
                    , human "."
                    , human " We simply multiply the "
                    , inline "tf"
                    , human " and the "
                    , inline "idf"
                    , human "."
                    , display "tfidf_{i,j}(word) = tf_{i,j}\\cdot idf(word)"
                    ]
                ]
            , python_code_block
                [ text """from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer = TfidfVectorizer()
print(create_doc_term_df(text_data, vectorizer).to_string())
'''output
               big     brown     cried       fox   giraffe     quick      that      the     whale
Sentence                                                                                         
0         0.707107  0.000000  0.000000  0.000000  0.000000  0.000000  0.000000  0.00000  0.707107
1         0.000000  0.528635  0.000000  0.528635  0.000000  0.528635  0.000000  0.40204  0.000000
2         0.000000  0.000000  0.528635  0.000000  0.528635  0.000000  0.528635  0.40204  0.000000
'''
"""
                ]
            ]


init : ( Model, Cmd Msg )
init =
    ( { meta_data =
            { title = "Term Frequency-Inverse Document Frequency"
            , published_date = InDevelopment
            , summary = "In this tutorial we will look at what TF and IDF are and how they can be use to process text data in Machine learning."
            , post_link = "tf-idf"
            , developmentStep = Draft "1.0"
            }
      }
    , Cmd.none
    )
