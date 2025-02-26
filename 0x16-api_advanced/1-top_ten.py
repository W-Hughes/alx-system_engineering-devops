#!/usr/bin/python3
"""
This is a module to print the titles of the
first 10 hot posts for any given subreddit.
"""
import requests


def top_ten(subreddit):
    """Prints the titles of the first 10 hottest posts on a given subreddit."""
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
        "User-Agent": "Linux:0x16.api.advanced:v1.0.0 (u/Fuzzy_Taro_9722)"
    }
    params = {"limit": 10}

    try:
        response = requests.get(
            url, headers=headers, params=params, allow_redirects=False
        )
        if response.status_code != 200:
            print("None")
            return

        posts = response.json().get("data", {}).get("children", [])
        if not posts:
            print("None")
            return

        for post in posts:
            print(post.get("data", {}).get("title"))

    except (requests.exceptions.RequestException, ValueError):
        print("None")
