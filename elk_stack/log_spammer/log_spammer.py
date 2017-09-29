# coding: utf-8
"""Dummy app to spam a bunch of logs"""
import time
import random
import socket


def main():
    """."""
    host_name = socket.gethostname()
    start_time = time.time()
    try:
        while True:
            elapsed = time.time() - start_time
            print('hello from %s (%.1f s)' % (host_name, elapsed), flush=True)
            time.sleep(random.uniform(0.01, 0.5))
    except KeyboardInterrupt:
        print('Exiting...')


if __name__ == '__main__':
    main()