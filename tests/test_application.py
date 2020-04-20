#!/usr/bin/env python3
import falcon
import pytest
from falcon import testing
from srv.application import api
import srv.application
import sqlite3
import srv.queries as query
from faker import Faker

fake = Faker()
@pytest.fixture
def client():
    return testing.TestClient(api)

def make_fake_repos():
    data_generator = (
        lambda : fake.pyint(max_value=10e10),
        fake.text,
        fake.text,
        fake.text,
        fake.pybool,
        fake.text,
        fake.text,
        fake.pyfloat,
        fake.pyfloat,
        fake.pyfloat
    )
    data = []
    for _ in range(1,101):
        data.append([ii() for ii in data_generator])
    return data

def make_fake_events():
    data_generator = (
        fake.text,
        fake.text,
        fake.pyint,
        fake.pyfloat,
        fake.text
    )
    data = []
    for _ in range(1,101):
        data.append([ii() for ii in data_generator])
    return data

def aggregate_fake_events(db):
    query = db.cursor().execute("""
    SELECT created_at_ymd , COUNT(created_at_ymd), avg(created_at_unix)
    FROM events
    GROUP BY created_at_ymd
    ORDER BY avg(created_at_unix)
    """)
    rows = [ i for i in  query.fetchall()]
    return rows

def mock_db():
    try:
        import os; os.remove("test.db")
    except:
        pass
    _db = sqlite3.connect("test.db")
    _db.execute(query.create_repos)
    _db.executemany("""
        INSERT INTO repos VALUES (?,?,?,?,?,?,?,?,?,?)""",
                    make_fake_repos())
    _db.execute(query.create_events)
    _db.executemany("""
        INSERT INTO events VALUES (?,?,?,?,?)""",
                    make_fake_events())
    _db.execute(query.create_aggregate_events)
    aggregated_events = aggregate_fake_events(_db)
    _db.executemany("""INSERT INTO aggregate_events VALUES (?,?,?)""",
                    aggregated_events)
    _db.commit()
    return _db

def test_Home(client):

    response = client.simulate_get("/")

    assert response.status == falcon.HTTP_OK

def test_Github(client,monkeypatch):
    mock_db()
    monkeypatch.setattr(srv.application.github, "db", "test.db")
    response = client.simulate_get("/api/github")
#    import sys; sys.stderr.write(str(response.body))
    assert response.status == falcon.HTTP_OK
