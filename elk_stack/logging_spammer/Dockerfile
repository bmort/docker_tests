FROM python:3.6.2-alpine3.6
LABEL maintainer="Benjamin Mort <ben.mort@gmail.com>"
RUN pip install python-logstash
WORKDIR /app
COPY logging_spammer.py /app/logging_spammer.py
ENTRYPOINT ["python3"]
CMD ["logging_spammer.py"]