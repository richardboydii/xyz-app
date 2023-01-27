# XYZ Demo App Repository

This repository contains a sample Python app using the [Flask](https://flask.palletsprojects.com/en/2.2.x/) 
library. Testing uses the [PyTest](https://docs.pytest.org/en/7.2.x/) library. 
The app binds to port `5000` on all IPs.


## Local Development
1. Make sure you have `virtualenv` installed.
2. Create a new `virtualenv` environment.
3. Run `pip install -r requirements.txt`.
4. Test the app with `pytest src/`.
5. Run the application with `python ./src/app.py`.

## Deployment
The app uses [Terraform](https://www.terraform.io/) to create a Kubernetes Deployment 
on the cluster provisioned in [xyz-infrastructure](https://github.com/richardboydii/xyz-infrastructure)