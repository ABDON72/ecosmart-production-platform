# EcoSmart Foundation — Enterprise AWS CI/CD & Observability Platform 

A production-grade cloud platform designed and implemented for the EcoSmart Foundation website using AWS, Terraform, Jenkins, Docker, ECS Fargate, Prometheus, and Grafana.

This platform automates the complete application lifecycle from source code commit through container build, image management, deployment, monitoring, and operational troubleshooting while following modern DevOps and cloud engineering practices.

---

## Live Resources

* **Website (ALB):** http://ecosmart-production-alb-1101996261.us-east-1.elb.amazonaws.com

> AWS resources are provisioned and decommissioned between sessions to manage cloud costs. If the application is unavailable, the complete infrastructure can be recreated through Terraform and redeployed automatically through Jenkins.

---

## Project Overview

Designed and implemented a production-grade AWS deployment platform for the EcoSmart Foundation website using Infrastructure as Code, CI/CD automation, containerization, and observability tooling.

The platform automates the entire software delivery lifecycle:

```text
Code Commit → GitHub → Jenkins CI/CD → Docker Build → Amazon ECR → ECS Fargate → Application Load Balancer → Users
```

The project was built to simulate how modern engineering teams deploy, secure, monitor, and operate production workloads in AWS.

---

## Key Achievements

* Designed and deployed a complete AWS application platform using Terraform-managed infrastructure.
* Automated container build and deployment workflows using Jenkins and GitHub webhooks.
* Implemented container image lifecycle management with Amazon ECR.
* Deployed workloads to Amazon ECS Fargate using rolling update deployments.
* Built centralized observability pipelines using CloudWatch, Prometheus, and Grafana.
* Implemented network isolation through custom VPC design, security groups, and Application Load Balancer integration.
* Diagnosed and resolved infrastructure issues related to memory exhaustion, disk utilization, Terraform state management, and monitoring pipelines.
* Reduced deployment effort from manual releases to a fully automated CI/CD workflow.

---

## Architecture

```text
                 GitHub Repository
                        |
                        v
                 Jenkins (EC2)
                        |
              -------------------------
              |                       |
        Docker Build              AWS CLI
              |                       |
              v                       v
            Amazon ECR ------> ECS Fargate Service
                                       |
                                       v
                          Application Load Balancer
                                       |
                                       v
                              EcoSmart Website


        ECS Container Insights ---> CloudWatch
                                       |
                                       v
                          CloudWatch Exporter (EC2)
                                       |
                                       v
                                  Prometheus
                                       |
                                       v
                                   Grafana
                              (Live Dashboards)
```

### Networking

* Custom VPC architecture
* Two public subnets across separate Availability Zones
* Internet Gateway and route tables
* Application Load Balancer for traffic distribution

### Security

* Security-group based traffic isolation
* ECS services protected from direct internet access
* ALB acts as the public entry point
* IAM roles used for ECS task execution and AWS service integration

---

## Technology Stack

| Category                   | Technologies                                         |
| -------------------------- | ---------------------------------------------------- |
| Cloud Platform             | AWS EC2, ECS Fargate, ECR, ALB, VPC, IAM, CloudWatch |
| Infrastructure as Code     | Terraform                                            |
| CI/CD                      | Jenkins                                              |
| Containerization           | Docker                                               |
| Monitoring & Observability | Prometheus, Grafana, CloudWatch Exporter             |
| Source Control             | GitHub                                               |
| Operating System           | Linux                                                |
| Automation                 | GitHub Webhooks, AWS CLI                             |

---

## Skills Demonstrated

* AWS Cloud Architecture
* Infrastructure as Code (Terraform)
* Continuous Integration / Continuous Deployment (CI/CD)
* Docker Containerization
* Amazon ECS Fargate
* Amazon ECR
* Application Load Balancers
* Linux Administration
* Git & GitHub Workflows
* Monitoring & Observability
* Prometheus
* Grafana
* CloudWatch Metrics & Logs
* Infrastructure Troubleshooting
* Security Group Design
* IAM Role Configuration

---

## Screenshots

### Infrastructure provisioned via Terraform

![Terraform apply complete](screenshots/01-terraform-apply-complete.png)

### EcoSmart website deployed on ECS Fargate behind ALB

![Website live on ECS](screenshots/02-website-live-on-ecs-alb.png)

### Jenkins CI/CD pipeline configuration

![Jenkins pipeline configuration](screenshots/04-jenkins-pipeline-configuration.png)

### Successful deployment pipeline executions

![Jenkins pipeline build history](screenshots/05-jenkins-pipeline-build-history.png)

### GitHub webhook integration

![GitHub webhook configuration](screenshots/07-github-webhook-configuration.png)

### Prometheus monitoring targets

![Prometheus targets up](screenshots/10-prometheus-targets-up.png)

### Grafana dashboards displaying ECS metrics

![Grafana CPU and memory dashboard](screenshots/14-grafana-dashboard-cpu-zoomed.png)

---

## Infrastructure as Code

All infrastructure is managed through Terraform.

### Terraform Components

| File        | Purpose                                |
| ----------- | -------------------------------------- |
| main.tf     | VPC, networking, subnets, routing      |
| security.tf | Security groups and traffic control    |
| iam.tf      | IAM roles and permissions              |
| ecr.tf      | ECR repository configuration           |
| ecs.tf      | ECS cluster, service, task definitions |
| alb.tf      | Load balancer, listener, target groups |
| outputs.tf  | Infrastructure outputs                 |

### Provisioned Resources

* Custom VPC
* Public Subnets (2 Availability Zones)
* Internet Gateway
* Route Tables
* ECS Cluster
* ECS Service
* ECS Task Definition
* Amazon ECR Repository
* Application Load Balancer
* Security Groups
* IAM Roles
* CloudWatch Log Groups

Infrastructure deployment is performed using:

```bash
terraform init
terraform plan
terraform apply
```

---

## CI/CD Pipeline

The deployment workflow is fully automated through Jenkins.

### Pipeline Stages

1. Checkout Source Code
2. Authenticate with Amazon ECR
3. Build Docker Image
4. Push Image to ECR
5. Deploy Updated Image to ECS
6. Perform Rolling Update Deployment

Deployment process:

```text
Git Push
    |
    v
GitHub Webhook
    |
    v
Jenkins Pipeline
    |
    v
Docker Build
    |
    v
Amazon ECR
    |
    v
Amazon ECS Fargate
    |
    v
Production Environment
```

No manual deployment actions are required after pushing code to GitHub.

---

## Monitoring & Observability

Production metrics flow through the following monitoring pipeline:

```text
ECS Fargate
      |
      v
CloudWatch Container Insights
      |
      v
CloudWatch Exporter
      |
      v
Prometheus
      |
      v
Grafana
```

### Metrics Monitored

* ECS CPU Utilization
* ECS Memory Utilization
* Service Health Status
* Prometheus Target Availability
* CloudWatch Exporter Health

This monitoring stack provides visibility into application health and infrastructure performance in real time.

---

## Engineering Decisions

### Why ECS Fargate?

ECS Fargate eliminates server management while providing full control over container deployment, networking, scaling, and service configuration.

### Why Terraform?

Terraform enables repeatable infrastructure deployments and version-controlled cloud resources.

### Why Jenkins?

Jenkins provides flexible CI/CD automation and integrates directly with GitHub, Docker, AWS CLI, and ECR.

### Why Prometheus and Grafana?

Prometheus and Grafana provide full observability and visibility into infrastructure and application performance using open-source tooling widely adopted across the industry.

### Why a Custom VPC?

Building a dedicated VPC demonstrates practical cloud networking knowledge beyond default AWS configurations.

---

## Troubleshooting & Operational Challenges

The project intentionally documents real engineering issues encountered and resolved during implementation.

### Jenkins Service Instability

**Issue:** Jenkins repeatedly crashed without obvious error messages.

**Root Cause:** EC2 instance memory exhaustion caused the Linux OOM Killer to terminate Jenkins.

**Resolution:** Upgraded the instance from `t3.micro` to `t3.medium`.

---

### Jenkins Disk Space Issues

**Issue:** Jenkins reported low disk space warnings despite cleanup attempts.

**Root Cause:** Temporary directories were mounted on a small `tmpfs` filesystem.

**Resolution:** Relocated Jenkins data and JVM temporary directories to larger storage volumes.

---

### GitHub Push Failures

**Issue:** Terraform provider binaries exceeded GitHub file size limitations.

**Root Cause:** Large provider files were accidentally committed.

**Resolution:** Implemented proper `.gitignore` configuration and removed files from Git history.

---

### Prometheus Metrics Not Displaying

**Issue:** Grafana dashboards displayed "No Data".

**Root Cause:** Query timing and dashboard time-window configuration.

**Resolution:** Verified metrics through Prometheus APIs and adjusted dashboard query ranges.

---

### CloudWatch Exporter Label Conflicts

**Issue:** Unexpected metric label behavior in Prometheus.

**Root Cause:** Label collisions between exporter metadata and Prometheus-generated labels.

**Resolution:** Investigated metric series through Prometheus APIs and updated query logic accordingly.

---

## Project Structure

```text
ecosmart-production-platform/
├── app/
│   └── index.html
├── terraform/
│   ├── main.tf
│   ├── security.tf
│   ├── iam.tf
│   ├── ecr.tf
│   ├── ecs.tf
│   ├── alb.tf
│   └── outputs.tf
├── Dockerfile
├── Jenkinsfile
├── screenshots/
└── README.md
```

---

## Future Enhancements

* Architecture diagram visualization
* HTTPS support using AWS Certificate Manager (ACM)
* Blue/Green deployment strategy
* Automated smoke testing
* Grafana alerting and notifications
* Terraform remote state backend
* Multi-environment deployments (Dev, Staging, Production)
* AWS WAF integration
* Canary deployment strategy

---

## Related Projects

* aws-ecs-fargate-production-platform — ECS Fargate platform with auto-scaling and load testing
* jenkins-eks-kubernetes-pipeline — Jenkins, Docker, and Kubernetes deployment pipeline on Amazon EKS

---

## Author

**Abdon Njunwa**

AWS Certified Solutions Architect
Cloud & DevOps Engineer

