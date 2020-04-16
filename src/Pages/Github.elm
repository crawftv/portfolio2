module Pages.Github exposing (Flags, Model, Msg, page)

import Element
import Html
import Http
import Page exposing (Document, Page)
import Json.Decode as Decode exposing (Decoder, int, string, float)
import Json.Decode.Pipeline exposing (required)


type alias Flags =
    ()


type Model
    = Loading
    | Success TestResponse
    | Failure

type alias TestResponse =
    {title: String}

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
        { url = "/api/github"
        , expect = Http.expectJson GotData testDecoder
        }
    )

testDecoder : Decoder TestResponse
testDecoder =
    Decode.succeed TestResponse
    |> required "title"  string


-- UPDATE


type Msg
    = GotData (Result Http.Error TestResponse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotData result ->
            case result of
                Ok resp ->
                    ( Success resp, Cmd.none )

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
            , body = [ Element.text data.title]
            }
