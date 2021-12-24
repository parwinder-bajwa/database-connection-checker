# Database Connection Checker (DCC)

This application is intended to check connection to a database and it was written in Python language and HTTP. 


## Setup

Kindly ensure that you have Python3, and pip3 installed properly 

This project requires additional Python modules as per below.

a) flask module 
```bash
pip3 install flask
```


b) mysql-connector module
```bash
pip3 install mysql-connector-python-rf
```
### To run the application

Go to application folder and execute below command. 

```bash
python3 app.py
```
It will listen on 5000 as default.

Open your browser and visit `localhost:5000` or `127.0.0.1:5000`.

Lastly, enter the required information and submit it. 

## Dockerize 

I have added Dockerfile, to create docker image for this application.

I am using image `python:3.6.15-slim` as the base image.

It simply because this image is official Python image that generally only installs the minimal packages needed to run our application.

## Provisioning 

There are 3 clusters (development / staging / production) and those clusters was created via Terraform

All of the clusters were provisioned using re-usable module.

The module is official and can be found on below link 

[GKE module](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine)

Assume, in GCP environment vpc prod and non-prod already created successfully. 

Development and Staging cluster will be provisioned under non-prod vpc.

Production cluster will be provisioned under prod vpc.

In order for terraform can authenticate to Google cloud, please export your GCP credentials (JSON) as environment variable. Example as per below. 

``` 
#assume your credentials file located on /opt/dcc-key.json
export GOOGLE_APPLICATION_CREDENTIALS=/opt/dcc-key.json
```

## Continuous Integration and Continuous Delivery (CI/CD)

This project is using Jenkins as the tool for supporting the CI/CD processes. 

The repository is connect to Jenkins using webhook.

It will trigger the pipeline when there is pull-request approved. 

The pipeline flow can be seen on a file called `Jenkinsfile` under this repo.

## Monitoring 

This project is using 3 elements of monitoring. 

#### 1. Node Exporter 
Exporter can fetch statistics from an application in the format used by that system (i.e. XML), convert those statistics into metrics that Prometheus can utilize, and then expose them on a Prometheus-friendly URL.

#### 2. Prometheus
Prometheus will collect the metrics by scraping node exporter endpoint. 

Prometheus can also visualize the collected metrics, but in our case it will just behave as the Data Source for Grafana.

#### 3. Grafana
Grafana will be visualizing the metrics to proper dashboard. 

Promotheus is the data source for Grafana. 

```
for all monitoring elements will be created and managed by the Jenkins CI/CD pipeline
```

## Conclusion

There's a lot of room for improvement.