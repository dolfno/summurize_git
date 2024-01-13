#!/bin/bash
past_days=$1
gitlog = $(git log --oneline --since "$past_days day ago")
curl https://api.openai.com/v1/chat/completions   -H "Content-Type: application/json"   -H "Authorization: Bearer ${OPENAI_API_KEY}"   -d '{
    "model": "gpt-3.5-turbo",
    "messages": [
      {
        "role": "user",
        "content": "${gitlog} \n Summarize the above git commits by providing the top 5 most important features. ignore the tag releases."
      }
    ]
  }'
  
