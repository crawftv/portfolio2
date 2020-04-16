module Pages.Github exposing (Flags, Model, Msg, page)

import Components exposing (vl_horizontal_statistic, vl_vertical_statistic)
import Element
import Html
import Http
import Json.Decode as Decode exposing (Decoder, float, int, string)
import Json.Decode.Pipeline exposing (required)
import Page exposing (Document, Page)


type alias Flags =
    ()


type Model
    = Loading
    | Success TestResponse
    | Failure


type alias TestResponse =
    { repo_count : Int
    }


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
        |> required "repo_count" int



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
            , body =
                [
                 vl_vertical_statistic ( "Repos", "90" )
                ]
            }

        Loading ->
            { title = "Github"
            , body = [ Element.text "Loading Data" ]
            }

        Success data ->
            { title = "Github"
            , body =
                [ vl_vertical_statistic ( "Number of Repos", String.fromInt data.repo_count )
                ]
            }
