FROM python:3.7
WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/
RUN pip install -r requirements.txt
COPY . /usr/src/app

ENV PORT=

CMD streamlit run streamlit_app.py --server.port=${PORT} --browser.serverAddress="0.0.0.0"