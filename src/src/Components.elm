module Components exposing (layout)

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
            , internalLink ( "a broken link", Route.NotFound )

            --    , externalButtonLink ( "tweet about it", "https://twitter.com/intent/tweet?text=elm-spa is ez pz" )
            ]
        ]

internalLink : ( String, Route ) -> Element msg
internalLink ( label, route ) =
    Element.link styles.link
        { label = text label
        , url = Route.toHref route
        }
externalLink : (String,String) -> Element msg
externalLink (label,url) =
    Element.newTabLink styles.link
        {label = text label
        , url = url}


externalButtonLink : ( String, String ) -> Element msg
externalButtonLink ( label, url ) =
    Element.newTabLink styles.button
        { label = text label
        , url = url
        }


footer : Element msg
footer =
    row [] [ text "built with elm ❤" ]



-- STYLES


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
        , Border.roundEach({topLeft=9,topRight=0,bottomLeft=0,bottomRight=0})
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
