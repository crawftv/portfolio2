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
