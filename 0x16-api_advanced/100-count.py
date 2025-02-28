#!/usr/bin/python3
"""Module to count keywords in Reddit hot posts."""
import re
import requests


def count_words(subreddit, word_list, instances=None, after="", count=0):
    """
    Recursively counts occurrences of keywords
    in hot post titles and prints them.

    Args:
        subreddit (str): The subreddit to query.
        word_list (list): List of keywords to count.
        instances (dict): Dictionary of word counts (default None).
        after (str): Pagination parameter (default "").
        count (int): Number of posts processed so far (default 0).
    """
    if instances is None:
        # Initialize with empty dict; duplicates handled during counting
        instances = {}

    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/bdov_)"}
    params = {"after": after, "count": count, "limit": 100}

    try:
        response = requests.get(
            url, headers=headers, params=params, allow_redirects=False
        )

        if response.status_code != 200:  # Includes 404, 403, etc.
            return
        results = response.json()
        if "data" not in results:  # Handle non-JSON or unexpected responses
            return
    except (requests.RequestException, ValueError):
        return

    data = results.get("data")
    after = data.get("after")
    count += data.get("dist", 0)
    posts = data.get("children", [])

    if not posts:
        return

    for post in posts:
        title = post["data"].get("title", "").lower()
        for word in word_list:
            # Count whole words only using regex
            times = len(
                re.findall(r'\b' + re.escape(word.lower()) + r'\b', title)
            )

            if times > 0:
                # Use original case in output, but count case-insensitively
                if word in instances:
                    instances[word] += times
                else:
                    instances[word] = times

    if after is None:
        if not instances:
            return
        # Sort by count (descending) then alphabetically
        sorted_instances = sorted(
            instances.items(), key=lambda kv: (-kv[1], kv[0])
        )

        for word, freq in sorted_instances:
            print(f"{word}: {freq}")
    else:
        count_words(subreddit, word_list, instances, after, count)
