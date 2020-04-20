#!/usr/bin/env python3
import falcon
from falcon_jinja2 import FalconTemplate
import ujson
import sqlite3
import srv.queries as query

api = application = falcon.API()
falcon_template = FalconTemplate(path=".")


# Routes
class Home(object):
    @falcon_template.render("index.html")
    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200


home = Home()
application.add_route("/", home)


class Github(object):
    def __init__(self):
        self.db = "file:srv/portfolio.db?mode=ro"
    def on_get(self, req, resp):
        doc = {}
        with sqlite3.connect(self.db, uri=True) as conn:
            conn.row_factory = lambda c, r: dict(zip([col[0] for col in c.description], r))
            query_repo_count = conn.cursor().execute(query.repo_count).fetchone()
            doc["repo_count"] = query_repo_count["RepoCount"]
            query_event_by_date = conn.cursor().execute(query.event_by_date).fetchall()
            doc["event_by_date"] = query_event_by_date
        resp.body = ujson.dumps(doc, ensure_ascii=False)
        resp.status = falcon.HTTP_200


github = Github()
application.add_route("/api/github", github)
