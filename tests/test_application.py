#!/usr/bin/env python3
import falcon
import pytest
from falcon import testing
from srv.application import api



@pytest.fixture
def client():
    return testing.TestClient(api)

def test_Home(client):

    response = client.simulate_get("/")

    assert response.status == falcon.HTTP_OK

def test_Github(client):
