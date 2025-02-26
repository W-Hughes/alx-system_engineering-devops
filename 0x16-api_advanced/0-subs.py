#!/usr/bin/python3
"""
This is a function to query subscribers on a given Reddit subreddit.
"""
import requests


def number_of_subscribers(subreddit):
    """Returns the total number of subscribers on any given subreddit."""
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {
        "User-Agent": "Linux:0x16.api.advanced:v1.0.0 (u/Fuzzy_Taro_9722)"
    }

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        if response.status_code != 200:
            return 0
        return response.json().get("data", {}).get("subscribers", 0)
    except (requests.exceptions.RequestException, ValueError):
        return 0
