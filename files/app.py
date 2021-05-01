from flask import Flask, jsonify, request
from aadhar_verification import aadharNumVerify
import requests

app = Flask(__name__)

url = "https://nationalapi.docsumo.com/api/v1/national/extract/?side=back&save_data=false&return_redacted=false&fraud_check=true"

payload = {}
headers = {'X-API-KEY': 'zL0dtXkaOkhehgfOZAKWcGgqUhHyne1gkMYog93ZOYg1h80SfZ2KDcebTkcl',}

@app.route('/')
def index():
    return "App Works!!"

@app.route('/check/', methods=['POST'])
def transfer():
    if request.method == 'POST':

        file = request.files['image']
        file.save('aadhar.jpeg')
        files = [('files', open('aadhar.jpeg','rb'))]
        response = requests.request("POST", url, headers=headers, data = payload, files = files)
        no = str(response.json()['data']['no']['value'])

        res = str(aadharNumVerify(no))
        
        return jsonify({'status': res})

if __name__ == '__main__':
    app.run(debug=False)
