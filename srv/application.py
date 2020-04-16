#!/usr/bin/env python3
import falcon
from falcon_jinja2 import FalconTemplate
import ujson
from pony.orm import select, count
from .data_types import Repo, db
api = application = falcon.API()
falcon_template = FalconTemplate(path=".")


# Routes
class Home(object):
    @falcon_template.render("index.html")
    def on_get(self,req,resp):
        resp.status =falcon.HTTP_200


home = Home()
application.add_route("/",home)


class Github(object):
    def on_get(self, req,resp):
        import pdb;pdb.set_trace()
        doc = {"title":"Github"}
        query = select(count(r) for r in Repo)
        print(query)
        resp.body = ujson.dumps(doc,ensure_ascii=False)
        resp.status = falcon.HTTP_200


github = Github()
application.add_route("/api/github",github)
