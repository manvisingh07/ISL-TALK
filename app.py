from flask import Flask, request, jsonify
from bs4 import BeautifulSoup
import requests


app = Flask(__name__)

@app.route('/api', methods=['GET'])
def API():
   if request.method == 'GET':
       uri = 'https://indiansignlanguage.org/'
       query = str(request.args['query']) 
       if " " in query:
           query = str(query).replace(" ","-")
       else:
           pass

       ready_uri = uri + query
       content = requests.get(ready_uri).content
       soup = BeautifulSoup(content, 'html.parser')
       video_link = soup.find('iframe', {'class':'youtube-player'})
       video_url = video_link.get('src')
       d={}
       d['url'] = str(video_url)

   return jsonify(d)


if __name__ == '__main__':
    app.run()