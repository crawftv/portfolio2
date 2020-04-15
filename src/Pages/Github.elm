module Pages.Github exposing (Flags, Model, Msg, page)

import Element
import Html
import Http
import Page exposing (Document, Page)


type alias Flags =
    ()


type Model
    = Loading
    | Success String
    | Failure


page : Page Flags Model Msg
page =
    Page.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectJson GotData
        }
    )



-- UPDATE


type Msg
    = GotData (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotData result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


-- SUBSCRIPTION
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
-- VIEW


view : Model -> Document Msg
view model =
    case model of
        Failure ->
            { title = "Failure"
            , body = [ Element.text "Failed to load data" ]
            }

        Loading ->
            { title = "Github"
            , body = [ Element.text "Loading Data" ]
            }

        Success data ->
            { title = "Github"
            , body = [ Element.text "" ]
            }
