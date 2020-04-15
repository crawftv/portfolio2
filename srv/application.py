#!/usr/bin/env python3
import falcon
from falcon_jinja2 import FalconTemplate
import json


api = application = falcon.API()
falcon_template = FalconTemplate(path=".")
class Home(object):
    @falcon_template.render("index.html")
    def on_get(self,req,resp):
        resp.status =falcon.HTTP_200


home = Home()

application.add_route("/",home)


class Github(object):
    def on_get(self, req,resp):
        doc = {"title":"Github"}
        resp.body = json.dumps(doc)
        resp.status = falcon.HTTP_200


github = Github()
application.add_route("/api/github",github)
