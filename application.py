#!/usr/bin/env python3
import falcon

api = application = falcon.API()

class Home(object):
    def on_get(self,req,resp):
        doc = "Home Page"
        resp.status =falcon.HTTP_200
        resp.body=(doc)


home = Home()

application.add_route("/",home)
