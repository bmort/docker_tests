# coding: utf-8
"""Dummy app to spam a bunch of logs"""
import time
import random
import socket
import logging


def main():
    """."""
    log = logging.getLogger(__name__)
    log.addHandler(logging.StreamHandler())
    log.setLevel(logging.DEBUG)

    host_name = socket.gethostname()
    start_time = time.time()
    try:
        while True:
            elapsed = time.time() - start_time
            log.info('hello from %s (%.1f s)', host_name, elapsed)
            log.debug('this is a debug message from %s', host_name)
            time.sleep(random.uniform(0.01, 0.5))
    except KeyboardInterrupt:
        print('Exiting...')


if __name__ == '__main__':
    main()
    