#!/usr/bin/env python3
import falcon
from falcon_jinja2 import FalconTemplate

api = application = falcon.API()
falcon_template = FalconTemplate(path=".")
class Home(object):
    @falcon_template.render("index.html")
    def on_get(self,req,resp):
        resp.status =falcon.HTTP_200


home = Home()

application.add_route("/",home)
