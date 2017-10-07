# coding: utf-8
"""."""
import time
import socket
from flask import Flask


APP = Flask(__name__)
START_TIME = time.time()


@APP.route('/')
def hello_world():
    """."""
    elapsed = time.time() - START_TIME
    return ('Hello from {}. Running for {:.1f} s\n'
            .format(socket.gethostname(), elapsed))


if __name__ == '__main__':
    APP.run(host='0.0.0.0')
