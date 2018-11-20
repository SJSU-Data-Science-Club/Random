#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 14 16:00:56 2018

@author: travisbarton
"""
import  praw, prawcore
import base64, datetime




reddit = praw.Reddit(user_agent='Comment Extraction (by /u/USERNAME)',
                     client_id='b8unlbKK1rWOow', 
                     client_secret='FuFwla268qevA5Ju1MgRPs2Sihg')



##############################################################

#Comment extraction

## Getting the subreddit
awww = reddit.subreddit('aww')



## Getting the top x posts
posts = awww.top('day',limit = 5)
for post in posts:
    print(post.id)






## Lets look at comments

for post in posts:
    comments = post.comments[:]
    while comments:
        comment = comments.pop(0)
        print(comment.body)
        

def comment_extractor(submission):
    goalie = []    
    submission.comments.replace_more(limit=None)
    comment_queue = submission.comments[:]  # Seed with top-level
    while comment_queue:
        comment = comment_queue.pop(0)
        goalie.append(comment.body)
        comment_queue.extend(comment.replies)



comment_extractor()