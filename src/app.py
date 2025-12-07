from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def hello():
    # This gets the container's hostname (the Pod ID)
    hostname = socket.gethostname()
    return f"<h1>Hello from Azure AKS!</h1><p>Served by Container Pod: <b>{hostname}</b></p>"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
    