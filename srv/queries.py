#!/usr/bin/env python3

event_by_date = """
    SELECT  *
    FROM aggregate_events
    ORDER BY  unix_time
    """
repo_count = """
    SELECT COUNT(*) as RepoCount
    FROM repos
    LIMIT 1
    """

## Create Tables
create_repos = """
     CREATE TABLE repos
     (id int PRIMARY KEY,
     node_id text,
     name text UNIQUE,
     full_name text,
     private int,
     html_url text,
     description text,
     pushed_at_unix real,
     updated_at_unix real,
     created_at_unix real
     )"""

create_events = """
     CREATE TABLE events
     (id text PRIMARY KEY,
     type text,
     repo_id int,
     created_at_unix real,
     created_at_ymd text
     )"""

create_aggregate_events ="""
     CREATE TABLE aggregate_events
     (created_at_ymd text PRIMARY KEY,
     event_count int DEFAULT 0,
     unix_time real
     )"""
