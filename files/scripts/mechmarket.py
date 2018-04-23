#!/usr/bin/python

import requests
import requests.auth
import json
import subprocess
import sys

if len(sys.argv) < 2:
    print('[ERROR] Please provide a search query')
    sys.exit(-1)

query = sys.argv[1]

client_auth = requests.auth.HTTPBasicAuth('ZV1OxRMaUgWIZQ', 'WbwaHSILMbzgI_0BntEdumjjVpo')
post_data = { 'grant_type': 'password', 'username': 'ThreeFx', 'password': 'FnOA4aFSSaa9HYfzZW4RaInGDTI6qznI'}
headers = {'User-Agent': 'Mozilla/2.0 (compatible; MSIE 3.02; Windows 3.1)'}

auth_response = requests.post("https://www.reddit.com/api/v1/access_token", auth=client_auth, data=post_data, headers=headers).json()

headers = {'Authorization': 'bearer ' + auth_response['access_token'], 'User-Agent': 'Mozilla/2.0 (compatible; MSIE 3.02; Windows 3.1)', 'Accept': 'Content-Type: application/json'}

response = requests.get('https://oauth.reddit.com/r/mechmarket/search?q=' + query + '&restrict_sr=on&include_over_18=on&sort=new&t=week', headers=headers)

listings = json.loads(response.text)['data']['children']

seen = []
subprocess.call(['touch', '/home/bfiedler/.mechmarket/' + query])
with open('/home/bfiedler/.mechmarket/' + query, 'r') as seen_file:
    for line in seen_file:
        seen += [line.rstrip()]
seen = set(seen)

with open('/home/bfiedler/.mechmarket/' + query, 'a+') as append_file:
    for listing in listings:
        if not (listing['data']['id'] in seen):
            subprocess.call(['/home/bfiedler/.mechmarket/notify.sh', listing['data']['id'], listing['data']['title']])
            append_file.write(listing['data']['id'] + '\n')
