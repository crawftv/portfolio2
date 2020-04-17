module Pages.Github exposing (Flags, Model, Msg, page)

import Components exposing (vl_horizontal_statistic, vl_vertical_statistic)
import Debug
import Element
import Html
import Http
import Json.Decode as Decode exposing (Decoder, dict, float, int, list, string)
import Json.Decode.Pipeline exposing (required)
import LineChart
import Page exposing (Document, Page)


type alias Flags =
    ()


type Model
    = Loading
    | Success APIResponse
    | Failure


type alias APIResponse =
    { repo_count : Int
    , event_list : List Event
    }


type alias Event =
    { created_at : String
    , event_count : Float
    , unix_time : Float
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
        , expect = Http.expectJson GotData responseDecoder
        }
    )


responseDecoder : Decoder APIResponse
responseDecoder =
    Decode.succeed APIResponse
        |> required "repo_count" int
        |> required "event_by_date" (list eventDecoder)


eventDecoder : Decoder Event
eventDecoder =
    Decode.succeed Event
        |> required "created_at_ymd" string
        |> required "event_count" float
        |> required "unix_time" float



-- UPDATE


type Msg
    = GotData (Result Http.Error APIResponse)


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
                [ vl_vertical_statistic ( "Repos", "90" )
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
                , Element.html
                    (LineChart.view1 .unix_time .event_count data.event_list)
                ]
            }
