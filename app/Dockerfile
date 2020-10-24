FROM python:3.7
EXPOSE 8000
# install dependencies
COPY ./src/requirements.txt /app/src/requirements.txt
RUN pip install -r /app/src/requirements.txt
WORKDIR /app

COPY . /app
# command to run on container start
CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8000"]