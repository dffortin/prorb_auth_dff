# README

## Two users created

- <jblow@example.com>   Password123
- <jdoe@example.com>    Password123

## Added Post model to

1. Create posts
2. List all posts (displaying title and author - user email displayed rather than user_id)
3. Users can update their own posts (link suppressed when user_id doesn't match session[:user_id])
4. Show the details of a specific posts
5. If not logged in, user can only see posts but not edit them
# prorb_auth_dff

15-Mar-2024
Added scope post_owner and modified PostsController [edit, update and destroy] actions to use scope. Added flash message to each as well.
