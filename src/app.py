import time

from flask import Flask

app = Flask(__name__)

@app.route("/will")
def hello_world():
    return "Hello World"

@app.route("/ready")
def ready():
    return "It works!"


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)