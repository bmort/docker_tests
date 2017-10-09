# coding: utf-8
""" Simple UDP socket server.
"""
import socket
import sys

HOST = ''
PORT = 8888


def main():
    """."""
    try:
        socket_ = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        print('* Socket created.')
    except OSError as error:
        print('* Failed to create socket. Erorr code: {}, Message: {}'.
              format(error.errno, error.strerror))
        sys.exit()

    try:
        socket_.bind((HOST, PORT))
    except OSError:
        print('Bind failed')
        sys.exit()

    print('Socket bind complete.')

    while True:
        payload = socket_.recvfrom(1024)
        data = payload[0]
        addr = payload[1]

        if not data:
            break

        socket_.sendto(data, addr)
        print('Message[{}:{}] - {}'.
              format(addr[0], addr[1], data.strip()))

    socket_.close()


if __name__ == '__main__':
    main()
