# coding: utf-8
"""Dummy app to spam a bunch of logs"""
import time
import random
import socket
import sys
import logging

import logstash


def hostname_resolves(hostname):
    """."""
    try:
        socket.gethostbyname(hostname)
        return True
    except socket.error:
        return False


def main():
    """."""
    log = logging.getLogger('logging_spammer')
    log.setLevel(logging.DEBUG)

    host_name = socket.gethostname()
    address = socket.gethostbyname(host_name)
    print('hostname = {}, address = {}'.format(host_name, address))

    # For the host to be resolved the container must be in the same overlay
    # network as the logstash container.
    host = 'logstash'
    if hostname_resolves(host):
        handler = logstash.LogstashHandler(host, port=5000, version=1)
        log.addHandler(handler)
    else:
        handler = logging.StreamHandler(stream=sys.stdout)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        log.addHandler(handler)

    start_time = time.time()
    try:
        while True:
            elapsed = time.time() - start_time
            # log.info('hello from %s (%.1f s)', host_name, elapsed)
            log.info('hello ...')
            log.debug('hello again ...')
            # log.debug('this is a debug message from %s', host_name)
            time.sleep(random.uniform(0.01, 0.5))
    except KeyboardInterrupt:
        print('Exiting...')


if __name__ == '__main__':
    main()
    