FROM python:3.6.2-alpine3.6
LABEL maintainer="Benjamin Mort <ben.mort@gmail.com>"
RUN apk --no-cache add curl
RUN pip install flask>=0.12.2
COPY app.py /app/app.py
WORKDIR /app
HEALTHCHECK --interval=5s --timeout=2s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/ || exit 1
ENTRYPOINT ["python3"]
CMD ["app.py"]