#!/usr/bin/env python3
import falcon
from falcon_jinja2 import FalconTemplate
import ujson
import sqlite3


api = application = falcon.API()
falcon_template = FalconTemplate(path=".")
db = "file:srv/portfolio.db?mode=ro"

# Routes
class Home(object):
    @falcon_template.render("index.html")
    def on_get(self,req,resp):
        resp.status =falcon.HTTP_200


home = Home()
application.add_route("/",home)


class Github(object):
    def on_get(self, req,resp):
        doc = {}
        with sqlite3.connect(db, uri=True)as c:
            query = c.cursor().execute("SELECT COUNT(*) from repos").fetchone()[0]
            doc["repo_count"] = query
        resp.body = ujson.dumps(doc,ensure_ascii=False)
        resp.status = falcon.HTTP_200


github = Github()
application.add_route("/api/github",github)
