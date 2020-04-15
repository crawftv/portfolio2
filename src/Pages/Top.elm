module Pages.Top exposing (Flags, Model, Msg, page)

import Element exposing (Element, column, el, fill, maximum, padding, paragraph, px, row, spaceEvenly, spacing, text, textColumn, width)
import Html exposing (li, ul)
import Page exposing (Document, Page)


type alias Flags =
    ()


type alias Model =
    ()


type alias Msg =
    Never


page : Page Flags Model Msg
page =
    Page.static
        { view = view
        }


view : Document Msg
view =
    { title = "Home Page"
    , body =
        [ textColumn [ width (fill |> maximum 800), spacing 5 ]
            [ viewContent aboutMe, education ]
        ]
    }


aboutMe =
    { paragraphHeading = "About Me"
    , paragraphBody =
        "I am a software engineer focusing on solving problems using Python data science tools."
    }


type alias Content =
    { paragraphHeading : String
    , paragraphBody : String
    }


viewContent : Content -> Element msg
viewContent content =
    column []
        [ el [] (text content.paragraphHeading)
        , paragraph []
            [ el [] (text content.paragraphBody)
            ]
        ]


education =
    column []
        [ el [] (text "Education")
        , Element.html
            (ul []
                [ li [] [ Html.text "Lambda School" ]
                , ul []
                    [ li [] [ Html.text "Data Science Concentration" ]
                    , li [] [ Html.text "Descriptive and Predictive statistics" ]
                    , li [] [ Html.text "Machine Learning" ]
                    , li [] [ Html.text "Computer Science" ]
                    ]
                , li [] [ Html.text "The University of Alabama" ]
                , ul []
                    [ li [] [ Html.text "Bachelors Degree in Finance" ]
                    , li [] [ Html.text "Minor in Statistics" ]
                    , li [] [ Html.text "Presidential Scholar, Dean's List, Outstanding student in Finance" ]
                    ]
                ]
            )
        ]
