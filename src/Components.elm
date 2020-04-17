module Components exposing (layout, vl_horizontal_statistic, vl_vertical_statistic)

import Document exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Generated.Route as Route exposing (Route)


layout : { page : Document msg } -> Document msg
layout { page } =
    { title = page.title
    , body =
        [ column [ spacing 32, padding 20, width (fill |> maximum 780), height fill, centerX ]
            [ navbar
            , column [ height fill ] page.body
            , footer
            ]
        ]
    }


navbar : Element msg
navbar =
    row [ Region.navigation, width fill ]
        [ row [ Element.alignLeft ]
            [ internalLink ( "CrawfordC.com", Route.Top )
            , externalLink ( "book", "https://book.CrawfordC.com" )
            , internalLink ( "Github", Route.Github )
            , externalLink ( "Résumé", "https://resume.creddle.io/resume/9l4nm5phwtj" )

            --    , externalButtonLink ( "tweet about it", "https://twitter.com/intent/tweet?text=elm-spa is ez pz" )
            ]
        ]


internalLink : ( String, Route ) -> Element msg
internalLink ( label, route ) =
    Element.link styles.link
        { label = text label
        , url = Route.toHref route
        }


externalLink : ( String, String ) -> Element msg
externalLink ( label, url ) =
    Element.newTabLink styles.link
        { label = text label
        , url = url
        }


externalButtonLink : ( String, String ) -> Element msg
externalButtonLink ( label, url ) =
    Element.newTabLink styles.button
        { label = text label
        , url = url
        }


footer : Element msg
footer =
    row [] [ text "built with elm ❤" ]



-- VALUE label Horizontal Statistic


vl_horizontal_statistic : ( String, String ) -> Element msg
vl_horizontal_statistic ( label, value ) =
    Element.row [ Font.family [ Font.monospace ], Element.spacing 5 ]
        [ Element.el
            [ Font.bold
            , Font.size (round (scaled 4))
            ]
            (Element.text value)
        , Element.el
            [ Font.size (round (scaled 1))
            , Element.centerY
            ]
            (Element.text label)
        ]


vl_vertical_statistic : ( String, String ) -> Element msg
vl_vertical_statistic ( label, value ) =
    Element.column [ Font.family [ Font.monospace ], Element.spacing 3 ]
        [ Element.el
            [ Font.bold
            , Font.size (round (scaled 4))
            , Element.centerX
            ]
            (Element.text value)
        , Element.el
            [ Font.size (round (scaled 1))
            , Font.medium
            ]
            (Element.text label)
        ]



-- STYLES


scaled =
    Element.modular 16 1.25


colors : { blue : Color, white : Color, red : Color }
colors =
    { white = rgb 1 1 1
    , red = rgb255 204 85 68
    , blue = rgb255 50 100 150
    }


styles :
    { link : List (Element.Attribute msg)
    , button : List (Element.Attribute msg)
    }
styles =
    { link =
        [ Font.underline
        , Font.color colors.blue
        , mouseOver [ alpha 0.6 ]
        , Border.width 1
        , Border.roundEach { topLeft = 9, topRight = 0, bottomLeft = 0, bottomRight = 0 }
        , Element.padding 5
        ]
    , button =
        [ Font.color colors.white
        , Background.color colors.red
        , Border.rounded 4
        , paddingXY 24 10
        , mouseOver [ alpha 0.6 ]
        ]
    }
