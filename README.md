# kiwi-summer-camp-cloud-task
This is a ~2-hour solution of the cloud task for Kiwi Summer Camp 2019.

It is not perfect, but I mainly aimed to not cross the 2 hour limit too much.

I have done multiple projects on AWS so this was something new for me. I mainly appreciate the possibility to control Kubernetes through Terraform, which is something I knew it existed, but never actually tried it.

## Structure

This repository consists of the sample Python app and terraform config files.

The folders are named accordingly.
```
/
└───app
└───terraform
```

## Requirements

For deploying the stack including the applicaion you will need [Terraform](https://terraform.io). (>= 0.12)

To run the application locally you will need Python3 or Docker.

## Usage

### Running the Python app

If you want to develop the application locally you can do it with the following steps

1. Clone this repository if you haven't already

```bash 
git clone https://github.com/trebidav/kiwi-summer-camp-cloud-task
```

2. In the root of the repository use this command to run the app locally:

```bash
python3 app/app.py
```

or if you just want to run it, easiest way is with docker:

```bash 
docker build -t kiwi-summer-camp-app app/
docker run -P 5000:5000 kiwi-summer-camp-app
```

3. The application is listening on port 5000:
- [http://localhost:5000](http://localhost:5000)
- [http://localhost:5000/health](http://localhost:5000/health)

4. If you modify the application code and push it to the `dev` branch - a build of the image is triggered in Docker Hub. The image is available on `davidtrebicky/kiwi-summer-camp-cloud-task`

### Deploying the application with Terraform (0.12)


1. Clone this repository if you haven't already

```bash 
git clone https://github.com/trebidav/kiwi-summer-camp-cloud-task
```

2. Navigate to the terraform subdirectory

```bash 
cd terraform/
```

3. Edit the `main.tf` file according to your GCP credentials

More information on this is in the `main.tf` file

TODO: This custom settings could be placed in a `terraform.tfvars` but I didn't do it for simplicity and time reasons

4. Generate the Terraform plan 

```bash
terraform plan --out=terraform.tfplan
``` 

5. Inspect the plan and apply it 

```bash
terraform apply "terraform.tfplan"
```

6. Use the Terraform output to navigate to the newly deployed application

```bash
Outputs:

sample-app-url = http://35.242.194.193:80
```

It may take some time before it's actually available
