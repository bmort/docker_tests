# coding: utf-8
"""Python script to start a file_writer service"""
import os
import docker

def main():
    """Starts the service using the python API."""
    client = docker.from_env()
    service = client.services.create(
        image="bmort/file_writer:latest",
        name="test_file_writer",
        mounts=['{}:/app:rw'.format(os.getcwd())],
        restart_policy=docker.types.RestartPolicy(condition='none'),
        mode=docker.types.ServiceMode(mode='replicated', replicas=2)
    )
    print('Serivce ID: {}'.format(service.id))

if __name__ == '__main__':
    main()
