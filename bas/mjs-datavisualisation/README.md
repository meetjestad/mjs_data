# About
This repository contains code for a data visualisation dashboard for data of the IoT sensors of the Meet je Stad project. More info about the project on https://meetjestad.net.

This data visualisation application is written in Python based around the tool Streamlit. Its interactive UI components allow the users to play with the data retrieved from the Meet je Stad API.

The live application is running on https://meetjestad.databash.nl.

# Running the application locally
The application can be run locally by first building the Docker image and then running the Docker image:
```
docker build -t mjs-streamlit .
docker run --rm -p 9090:9090 -e PORT=9090 --name mjs-dashboard mjs-streamlit:latest
```

The application can then be accessed in the browser on address `localhost:9090`.

# Developing
New changes in the code don't automatically come through in the application, you should first stop the running Docker container with `docker kill mjs-dashboard`, then build the Docker image again and run it with the commands listed in the section above.
When adding features, please commit them in a separate branch and merge them with the main branch again when you are finished.

For more Streamlit input components, check out https://docs.streamlit.io/library/api-reference/widgets.

Some extra functionality was added to be able to 'save' the parameters you used to create a certain visualisation, i.e. when you select some fields in the application to create your visualisation the URL in the browser changes. This URL can be shared with others such that the fields in the application are automatically filled and the same visualisation is shown.
When adding new input components to the application, make sure to follow the same format as the existing inputs (register parametes and adding the right arguments for the input).

# Commands executed for GCP Cloud Run deployment:
The application is live, it is hosted on Google Cloud with the use of Cloud Run, this service makes it easy to deploy Docker containers. The Docker container only spins up when there is traffic, so the costs are low.
In order to host it there I used the following commands:

```
gcloud auth login
gcloud init
gcloud config set compute/region europe-west4
gcloud config set compute/zone europe-west4
gcloud services enable run.googleapis.com containerregistry.googleapis.com
gcloud auth configure-docker
docker build -t mjs-streamlit .
docker tag mjs-streamlit:latest gcr.io/mjs-datavisualisation/mjs-streamlit:latest
docker push gcr.io/mjs-datavisualisation/mjs-streamlit:latest
gcloud run deploy mjs-datavisualisation  \
--image gcr.io/mjs-datavisualisation/mjs-streamlit:latest \
--platform managed  \
--allow-unauthenticated \ 
--region europe-west4 \
--memory 2Gi --timeout=900
```

# Commands for image update
The following commands can be run in order to update the Docker image of the application on Cloud Run if the Cloud Run service is already running with this Docker image.

```
gcloud auth login
gcloud config set project mjs-datavisualisation
docker build -t mjs-streamlit .
docker tag mjs-streamlit:latest gcr.io/mjs-datavisualisation/mjs-streamlit:latest
docker push gcr.io/mjs-datavisualisation/mjs-streamlit:latest
gcloud run deploy mjs-datavisualisation  \
--image gcr.io/mjs-datavisualisation/mjs-streamlit:latest \
--platform managed  \
--region europe-west4 \
--memory 2Gi \
--timeout=900
```