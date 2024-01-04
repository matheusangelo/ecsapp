from flask import Flask

app = Flask(__name__)


@app.route('/health')
def health():
    return {
        "message": "ok",
        "status": 200
    }


@app.route('/')
def init():
    return {
        "message": "ok",
        "status": 200
    }


app.run()