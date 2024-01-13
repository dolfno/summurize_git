# Set the past_days variable
past_days=${1:-7}
gitlog=$(git log --oneline --since "$past_days day ago" --encoding=UTF-8-MAC)
content=$(echo -e "${gitlog} \nSummarize the above git commits by providing the top 5 most important features. Ignore the 'Merge branch main' commits and the 'Released version v." | jq -Rs .)

# Now you can use the content variable
response=$(curl -s https://api.openai.com/v1/chat/completions   -H "Content-Type: application/json"   -H "Authorization: Bearer ${OPENAI_API_KEY}"   -d "{
    \"model\": \"gpt-3.5-turbo\",
    \"messages\": [
      {
        \"role\": \"user\",
        \"content\": ${content}
      }
    ]
  }" | jq -r '.choices[0].message.content')

echo $response
# Pretty print the first item from 'choices' list and take the 'content' from there
echo "$response" > mytestfile.json
