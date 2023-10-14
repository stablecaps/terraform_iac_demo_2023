from flask import Flask, request
from waitress import serve

import os
import re

app = Flask(__name__)

app_version = "2.0.0"


@app.after_request
def add_hostname_header(response):
    env_host = str(os.environ.get("HOSTNAME"))
    hostname = re.findall("[a-z]{3}-\d$", env_host)
    if hostname:
        response.headers["SP-LOCATION"] = hostname
    return response


@app.route("/", methods=["POST", "GET"])
def get_app_version():
    # print("Running Request now")
    port = "unknown"
    if request.method == "GET":
        port = request.environ.get("REMOTE_PORT")

    vers_str = f"Running app version <{app_version}> on random port <{port}>"
    return vers_str


# os.environ


if __name__ == "__main__":
    serve(app, listen="*:80 *:8080 *:8000")


# https://support.stackpath.com/hc/en-us/articles/360022987711-Edge-Computing-Building-a-Containerized-Python-Web-App-Using-Flask
