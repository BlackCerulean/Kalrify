import base64
import ctypes
import inspect
import io
import os
import sys


import requests


#   This is the code to run Post request...
def post(text):
    # b64file = open(filename, 'rb').read()
    # imgData = base64.b64encode(b64file)
    # imgFile = open('food-ex.txt', 'wb')
    # imgFile.write(imgData)
    # imgFile.flush()
    # imgFile.close()

    url = "https://api.aiforthai.in.th/thaifood"
 
    data = {
        'file': text
    }
    headers = {
            'Content-Type': 'application/json',
            'Apikey': "zKeCFpHoMX02P8HyaTjbXxsM61TS4woM",
        }
    
    response = requests.post(url, headers=headers, json=data)
    return response
