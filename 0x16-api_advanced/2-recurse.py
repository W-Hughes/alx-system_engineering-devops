#!/usr/bin/python3
"""
This is a function to query Reddit API recursively
"""
import requests


def recurse(subreddit, hot_list=None, after=None):
    """Returns a list of all hot posts on any given subreddit."""
    if hot_list is None:
        hot_list = []

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {
        "User-Agent": "Linux:0x16.api.advanced:v1.0.0 (u/Fuzzy_Taro_9722)"
        }
    params = {"after": after, "limit": 100}

    try:
        response = requests.get(
            url, headers=headers, params=params, allow_redirects=False
        )
        if response.status_code != 200:
            return None

        data = response.json().get("data", {})
        after = data.get("after")

        for post in data.get("children", []):
            hot_list.append(post["data"].get("title", "Unknown Title"))

        if after is None:
            return hot_list

        return recurse(subreddit, hot_list, after)

    except (requests.exceptions.RequestException, ValueError):
        return None
