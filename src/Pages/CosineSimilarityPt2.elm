module Pages.CosineSimilarityPt2 exposing (..)

import Helper exposing (htmlGenerator)
import Html exposing (..)
import Html.Attributes exposing (class, href, target)
import Katex as K
    exposing
        ( Latex
        , display
        , human
        , inline
        )


view : Model -> Html a
view model =
    div
        [ class "mb-40" ]
        [ section []
            [ h2 [] [ text "The Dataset" ]
            , p []
                [ text "We will use quora's qna dataset for list of question pairs."
                , text "The dataset can be found "
                , a [ target "blank", href "https://www.kaggle.com/competitions/quora-question-pairs/data" ]
                    [ text "here"
                    ]
                , text ". "
                , text "Unzip the train file, load the dataset with "
                , code [] [ text "pandas" ]
                , text ". We will look mostly at the "
                , code [] [ text "question1" ]
                , text " column."
                ]
            ]
        , section
            []
            [ h2 [] [ text "Review of Previous Blog" ]
            , p []
                [ text "We implemented three different ways of comparing vectors. Code is listed below." ]
            , pre []
                [ code []
                    [ text """import numpy as np 
from typing import List 

def get_cosine_similarity(arr1, arr2):
\tnumerator = np.dot(arr1, arr2)
\tmag1 = np.sqrt(np.sum(np.square(arr1)))
\tmag2 = np.sqrt(np.sum(np.square(arr2)))
\treturn numerator / (mag1*mag2)
 
def get_document_similarities(model, documents: List[str]):
\tsimilarities = [[0 for _ in range(len(documents))] 
\t\t\t\t\tfor _ in range((len(documents)))]
\tfor i, doc1 in enumerate(documents):
\t\tdoc1_enc = model.encode(doc1)
\t\tfor j, doc2 in enumerate(documents):
\t\t\tdoc2_enc = model.encode(doc2)
\t\t\tsim = get_cosine_similarity(doc1_enc, doc2_enc)
\t\t\tsimilarities[i][j] = sim
\treturn similarities

def get_document_similarities_faster(model, documents: List[str]):
\tsimilarities = [[0 for _ in range(len(documents))] 
\t\t\t\t\tfor _ in range((len(documents)))]
\tfor i, doc1 in enumerate(documents):
\t\tdoc1_enc = model.encode(doc1)
\t\tfor j, doc2 in enumerate(documents):
\t\t\tif i == j:
\t\t\t\tsimilarities[i][j] = 1
\t\t\telif i>j:
\t\t\t\tdoc2_enc = model.encode(doc2)
\t\t\t\tsim = get_cosine_similarity(doc1_enc, doc2_enc)
\t\t\t\tsimilarities[i][j] = sim
\t\t\t\tsimilarities[j][i] = sim
\t\t\telif i<j:
\t\t\t\tcontinue
\treturn similarities

def cosine_similarity_matrix(model, documents: List[str]):
\tdocument_encodings = model.encode(documents)
\tnumerator = np.matmul(document_encodings, document_encodings.T)
\trow_sum = np.sqrt(np.sum(np.square(document_encodings), axis=1, keepdims=True))
\tdenominator = np.matmul(row_sum, row_sum.T)
\treturn numerator / denominator # will be done elementwise 
                """
                    ]
                ]
            , p [] [ text "We will use the quora dataset to compare the timings to solidify the theory behind our understanding of the time complexities of each algorithm." ]
            ]
        , section
            []
            [ h2 []
                [ text "Experiments" ]
            , h3
                []
                [ text "Experiment #1" ]
            , p [] [ text "Below are the times of each algorithm with only 10 questions." ]
            , pre []
                [ code [ class "python" ]
                    [ text """# 888ms 
_ = get_document_similarities(model, traindf['question1'][:10].tolist())
# 414 ms
_ = get_document_similarities_faster(model, traindf['question1'][:10].tolist())
# 16.3 ms 
_ = cosine_similarity_matrix(model, traindf['question1'][:10].tolist())
"""
                    ]
                ]
            , p [] [ text "As you can see, the matrix algorithm is the fastest with 16.3 ms with 10 examples." ]
            , p []
                [ text "The question1 column has 404,290 rows of data to compare. It would take "
                , code [] [ text "((404_290 / 10) * 16.3) / 1000  / 60 = 10 mins" ]
                , text " to compare the entire dataset."
                ]
            , p []
                [ text "Does this text scales?" ]
            , section
                []
                [ h3 [] [ text "Experiment #2" ]
                , pre []
                    [ code [ class "python" ]
                        [ text """# prob. in the tens of hours
 _ = get_document_similarities(model, traindf['question1'][:500].tolist())
 # prob. in the hours
 _ = get_document_similarities(model, traindf['question1'][:500].tolist())
 # 337 ms
 _ = cosine_similarity_matrix(model, traindf['question1'][:500].tolist())
                  """
                        ]
                    ]
                , p [] [ text "It would take 4.5 mins for the matrix implementation to finish." ]
                ]
            ]
        , section []
            [ h2 [] [ text "Pytorch Matrix Multiplication" ]
            , pre []
                [ code [ class "python" ]
                    [ text """# replace np with torch 
def cosine_similarity_matrix_with_torch_cuda(model, documents: List[str]):
  document_encodings = model.encode(documents)
  document_encodings = torch.tensor(document_encodings).to(device)
  numerator = torch.matmul(document_encodings, document_encodings.T)
  row_sum = torch.sqrt(torch.sum(torch.square(document_encodings), axis=1, keepdims=True))
  denominator = torch.matmul(row_sum, row_sum.T)
  return numerator / denominator # will be done elementwise """
                    ]
                ]
            , p [] [ text "You can use the cuda option of pytorch for the matrix multiplication with google colab." ]
            , p [] [ text "Note, ", code [] [ text "device" ], text " is defined below." ]
            , pre [] [ code [ class "python" ] [ text """import torch 
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu') 
print(device) #cuda""" ] ]
            , section []
                [ h3 [] [ text "Experiment #3" ]
                , pre []
                    [ code [ class "python" ]
                        [ text """# 298 ms 
_ = cosine_similarity_matrix_with_torch_cuda(model, traindf['question1'].tolist()[:500])"""
                        ]
                    ]
                ]
            , p [] [ text "The matrix implementation does not scale." ]
            , pre []
                [ code [ class "python" ]
                    [ text "_ = cosine_similarity_matrix_with_torch_cuda(model, traindf['question1'].tolist()[:50_000])"
                    , text """
#RuntimeError: CUDA out of memory. Tried to allocate 9.31 GiB (GPU 0; 14.76 GiB total capacity; 12.90 GiB already allocated; 385.75 MiB free; 13.15 GiB reserved in total by PyTorch) 
#If reserved memory is >> allocated memory try setting max_split_size_mb to avoid fragmentation.  
#See documentation for Memory Management and PYTORCH_CUDA_ALLOC_CONF"""
                    ]
                ]
            , p [] [ text "You get a run time error with 50k rows of data." ]
            ]
        ]


type alias Model =
    { title : String }


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( { title = "Large Scale Vector Comparison"
      }
    , Cmd.none
    )
