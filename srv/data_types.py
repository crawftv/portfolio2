#!/usr/bin/env python3
import typing

from dataclasses import dataclass
from typing import Dict, Any
import dateutil.parser


def ISO_to_unix(string: str) -> float:
    t = dateutil.parser.parse(string).timestamp()
    return t


def ymd_date_string(string: str) -> str:
    dd = dateutil.parser.parse(string)
    f = f"{dd.year}-{dd.month:02d}-{dd.day:02d}"
    return f


# Github API Response types
@dataclass(frozen=True)
class EventResponse:
    """Data class for handling a Github api response"""
    id: str
    type: str
    actor: Dict
    repo: Dict
    payload: Dict
    public: bool
    created_at: str

    @property
    def created_at_unix(self):
        return ISO_to_unix(self.created_at)

    @property
    def repo_id(self):
        return self.repo["id"]

    @property
    def created_at_ymd(self):
        return ymd_date_string(self.created_at)


@dataclass(frozen=True)
class RepoResponse:
    """Data class for handling a Github api response"""
    id: int
    node_id: str
    name: str
    full_name: str
    private: bool
    owner: Dict
    html_url: str
    description: str
    fork: bool
    url: str
    forks_url: str
    keys_url: str
    collaborators_url: str
    teams_url: str
    hooks_url: str
    issue_events_url: str
    events_url: str
    assignees_url: str
    branches_url: str
    tags_url: str
    blobs_url: str
    git_tags_url: str
    git_refs_url: str
    trees_url: str
    statuses_url: str
    languages_url: str
    stargazers_url: str
    contributors_url: str
    subscribers_url: str
    subscription_url: str
    commits_url: str
    git_commits_url: str
    comments_url: str
    issue_comment_url: str
    contents_url: str
    compare_url: str
    merges_url: str
    archive_url: str
    downloads_url: str
    issues_url: str
    pulls_url: str
    milestones_url: str
    notifications_url: str
    labels_url: str
    releases_url: str
    deployments_url: str
    created_at: str
    updated_at: str
    pushed_at: str
    git_url: str
    ssh_url: str
    clone_url: str
    svn_url: str
    homepage: str
    size: int
    stargazers_count: int
    watchers_count: int
    language: str
    has_issues: bool
    has_projects: bool
    has_downloads: bool
    has_wiki: bool
    has_pages: bool
    forks_count: int
    mirror_url: Any
    archived: bool
    disabled: bool
    open_issues_count: int
    license: Dict
    forks: int
    open_issues: int
    watchers: int
    default_branch: str

    @property
    def pushed_at_unix(self):
        return ISO_to_unix(self.pushed_at)

    @property
    def created_at_unix(self):
        return ISO_to_unix(self.created_at)

    @property
    def updated_at_unix(self):
        return ISO_to_unix(self.updated_at)
