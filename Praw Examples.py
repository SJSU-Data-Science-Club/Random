#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 14 16:00:56 2018

@author: travisbarton
"""
import  praw, prawcore
import base64, datetime




reddit = praw.Reddit(user_agent='Comment Extraction (by /u/USERNAME)',
                     client_id='SI8pN3DSbt0zor', 
                     client_secret='xaxkj7HNh8kwg8e5t4m6KvSrbTI')



##############################################################

#Comment extraction

## Getting the subreddit
awww = reddit.subreddit('aww')



## Getting the top x posts
posts = awww.hot(limit = 5)
for post in posts:
    print(post.title)






## Lets look at comments

for post in posts:
    comments = post.comments[:]
    while comments:
        comment = comments.pop(0)
        print(comment.body)
        

    
submission.comments.replace_more(limit=None)
comment_queue = submission.comments[:]  # Seed with top-level
while comment_queue:
    comment = comment_queue.pop(0)
    print(comment.body)
    comment_queue.extend(comment.replies)
