#!/usr/bin/env python3

import pytest
from hypothesis.strategies import datetimes
import datetime
from dateutil.relativedelta import relativedelta
from hypothesis import given, assume

from srv.data_types import ISO_to_unix, ymd_date_string, EventResponse, RepoResponse
import requests
import re


def test_RepoResponse():
    """
    1. test the RepoResponse class handles the Repo response and creates a data structure
    """
    base_url = "https://api.github.com"
    user = "crawftv"
    r = requests.get(f"{base_url}/users/{user}/repos?sort=pushed")
    repo = RepoResponse(*list(r.json()[0].values()))
    assert repo
    assert repo.created_at_unix
    assert repo.pushed_at_unix
    assert repo.updated_at_unix


def test_EventResponse():
    """
    1. test that this class handles the Event repsponse and creates a data structure
    """
    base_url = "https://api.github.com"
    user = "crawftv"
    r = requests.get(f"{base_url}/users/{user}/events?")
    event = EventResponse(*r.json()[0].values())
    assert event
    assert event.created_at_unix
    assert event.repo_id
    assert event.created_at_ymd


@given(
    datetimes(
        min_value=datetime.datetime(2019, 12, 31),
        max_value=datetime.datetime.now() + relativedelta(years=5),
    )
)
def test_ISO_to_unix(dd):
    t = dd.isoformat()
    u = ISO_to_unix(t)
    assert type(u) is float


@given(
    datetimes(
        min_value=datetime.datetime(2019, 12, 31),
        max_value=datetime.datetime.now() + relativedelta(years=5),
    )
)
def test_ymd_date_string(dd):
    yy = ymd_date_string(dd.isoformat())
    assert re.match(r"20[0-3][0-9]-[0-1][0-9]-[0-3][0-9]", yy)
