# XYZ Demo App Repository

This repository contains a sample Python app using the [Flask](https://flask.palletsprojects.com/en/2.2.x/) 
library. Testing uses the [PyTest](https://docs.pytest.org/en/7.2.x/) library. 
The app binds to port `80` on all IPs.

## Local Development
1. Make sure you have `virtualenv` installed.
2. Create a new `virtualenv` environment.
3. Run `pip install -r requirements.txt`.
4. Test the app with `pytest src/`.
5. Run the application with `python ./src/app.py`.
6. To build the container locally, run `docker build -t richardboydii/xyz-demo-app:latest`.
7. To launch the container, run `docker run -p 0.0.0.0:80:80 richardboydii/xyz-demo-app:latest`.

## Deployment
The app uses [Terraform](https://www.terraform.io/) to create a Kubernetes Deployment 
on the cluster provisioned in [xyz-infrastructure](https://github.com/richardboydii/xyz-infrastructure).
GitHub Actions runs the job anytime a push or merge is made to main or staging. 
It deploys 2 replicas by default backed by a Classic Load Balancer.