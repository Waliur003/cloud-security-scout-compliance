## Cloud Security Engineering Project 02: Cloud Security Scout (Automated Continuous Compliance & Configuration Auditing)

### Overview

I have architected and deployed a serverless, continuous compliance auditing engine on AWS using Infrastructure as Code (IaC) primitives. This project demonstrates an automated governance framework designed to detect, catalog, and alert on real-time infrastructure misconfigurations and security baseline drift. The system leverages a zero-maintenance, decoupled architecture that inspects peripheral network access vectors and cloud storage perimeters without introducing operational disruption. By executing a programmatic audit loop on a recurring cron schedule, the engine records active infrastructure anomalies into an on-demand database registry and streams instant diagnostic alerting payloads directly to engineering teams within milliseconds of drift detection.

---

### The Problem

As cloud infrastructure grows across enterprise landscapes, tracking configuration accuracy manually becomes a mathematical impossibility. Fast-paced development loops frequently introduce subtle but high-risk configuration errors that expose corporate assets to the public web. Traditional compliance mechanisms consistently fail due to three architectural limitations:

* **The Exposure Vulnerability Window:** Standard periodic or quarterly compliance reviews create massive windows of vulnerability. If a engineer creates an unencrypted storage asset or mistakenly leaves a database port exposed, that vulnerability can remain active for weeks before being intercepted by a manual audit.

* **Lack of Historical State Tracking:** Infrastructure configurations change rapidly. Without a centralized, timestamped registry tracking configuration changes over time, incident response teams cannot establish reliable historical context to determine when a drift occurred or isolate the root cause of an architectural failure.

* **Operational Blind Spots and Silent Drift:** Peripheral security groups and block parameters frequently suffer from unauthorized mutations. Lacking an automated, decoupled notification engine to immediately flag misconfigurations, security units operate blindly, unaware of vulnerabilities until an active threat actor exploits them.

### The Solution

* **Serverless Compute Auditing:** Engineered an automated layer-7 scanner using AWS Lambda running Python and the AWS SDK (Boto3), abstracting the compute footprint entirely to minimize operating overhead while systematically parsing infrastructure state arrays.

* **On-Demand Configuration Ledger:** Deployed a highly scalable metadata catalog using Amazon DynamoDB configured for provisionless scalability, creating a permanent, timestamped system of record for all infrastructure security alerts.

* **Sub-Millisecond Alerting Fabric:** Constructed a decoupled Pub-Sub messaging topology via Amazon SNS that routes critical security group and access block mutations instantly to engineering mailboxes the moment a baseline deviation is evaluated.

* **Automated Clock-Triggered Invocations:** Integrated an Amazon EventBridge Scheduler routine executing strict cron definitions, shrinking the threat window down to less than 24 hours by evaluating the cloud ecosystem automatically during low-traffic windows.

### Tech Stack

* **Compute Engine:** AWS Lambda (Python 3.12 Serverless Native Architecture)

* **Configuration Persistence:** Amazon DynamoDB (On-Demand NoSQL Indexing Store)

* **Messaging Architecture:** Amazon SNS (Simple Notification Service / Pub-Sub Pipeline)

* **Trigger Mechanics:** Amazon EventBridge (Scheduler / Cron Execution Mechanics)

* **Identity & Privilege Control:** AWS IAM (Least-Privilege Audit Boundary Policies)

* **IaC Automation Framework:** Terraform (v1.0+ / Modularized Declarative Configuration Arrays)

### Architecture Diagram

### Project Procedure

#### 1. On-Demand Compliance Cataloging Engineering

I engineered an entry tracking repository using Amazon DynamoDB to serve as the long-term historical database layer for configuration drifts.

* **Composite Key Engineering:** Structured a unique data mapping schema utilizing FindingID as the string partition index and Timestamp as the string sort index to isolate entries precisely over execution timelines.

* **Provisionless Scalability Allocation:** Enforced the billing framework parameters to execute under ON_DEMAND constraints, guaranteeing the data layer absorbs burst-traffic scanning evaluation bursts without structural throttling or resource idling.

#### 2. Decoupled Notification Fabric Mapping

I deployed an asynchronous alerting pipeline via Amazon SNS to broadcast severe infrastructure vulnerability traces automatically to relevant nodes.

* **Standard Topic Allocation:** Provisioned a central messaging hub named SecurityScoutAlerts to isolate security warning payloads from routine application message data.

* **Subscription Transport Binding:** Anchored an explicit communication channel mapping directly from the topic to an engineering monitoring endpoint over the email transport protocol, completing the instant dispatch path.

#### 3. Auditor Context Identity Scoping

To restrict the execution identity of the serverless scanner, I formulated a strict, read-only boundary configuration using AWS IAM.

* **Audit Domain Separation:** Authored a targeted JSON document limiting explicit actions down to global directory mapping and read queries (`s3:ListAllMyBuckets`, `s3:GetBucketPublicAccessBlock`, `ec2:DescribeSecurityGroups`).

* **State Mutation Isolation:** Appended write clearance bounds strictly to the specific resource ARNs matching the DynamoDB logging index and the central SNS notification topic, completely dropping wildcard actions or peripheral system privileges.

#### 4. Programmatic Audit Logic Formulation

I developed a decoupled python script package within an AWS Lambda layer to act as the primary configuration assessment worker.

* **Storage Perimeter Testing:** Configured logic structures to systematically extract all active S3 buckets and review their underlying public access blocks, flagging an active warning if any parameter evaluates to a non-enforced status.

* **Network Border Parsing:** Programmed automated iterations across EC2 network profiles to evaluate inbound security policies, isolating high-value management vectors (SSH Port 22 and RDP Port 3389) that are inadvertently exposed to the open world (`0.0.0.0/0`).

* **Environment Abstraction Mapping:** Extracted table definitions and notification identifiers dynamically via operating environment variables, decoupling core system logic completely from baseline infrastructure details.

#### 5. Chronological Event Trigger Automation

I finalized the continuous monitoring loop by structuring an asynchronous scheduler loop at the account perimeter.

* **Cron Expression Mapping:** Configured an Amazon EventBridge Scheduler rule utilizing recurring expressions timed strictly to launch at 2:00 AM nightly.

* **Invocation Clearance Validation:** Attached explicit cross-service Lambda invocation rules allowing the EventBridge principal to safely trigger the function executor across internal boundaries without manual system intervention.

### Infrastructure as Code (IaC) Architecture

The entire configuration monitoring platform is provisioned through declarative, modular Terraform configurations to guarantee immediate environment repeatability and baseline state compliance.

#### Directory Layout & Modular Structure

```text
cloud-security-scout-compliance/
├── provider.tf
├── variables.tf
├── dynamodb.tf
├── sns.tf
├── iam.tf
├── lambda.tf
├── eventbridge.tf
└── outputs.tf
```

#### Detailed File-by-File Technical Breakdown

##### 1. System Provider Scoping (`provider.tf`)

* **Package Enforcement:** Locks execution cycles securely against the modern AWS Provider registry (v5.0+) and requires a minimum compilation framework version of v1.0.0+.

##### 2. Variable Abstractions & Metadata Outputs (`variables.tf` & `outputs.tf`)

* **Portability Mapping:** Abstracts configuration region targets, project prefixes, and operational alerting destinations into cleanly parameterized schemas, keeping the infrastructure portable.

##### 3. Persistence Catalog Definer (`dynamodb.tf`)

* **NoSQL Allocation:** Outlines the aws_dynamodb_table container mapping structural hash keys and billing modes cleanly to manage configuration state outputs safely.

##### 4. Messaging Engine Fabric (`sns.tf`)

* **Topic Hub Provisioning:** Establishes the communication pipeline and links target destination endpoints directly to the central warning topic.

##### 5. Identity Boundary Enforcer (`iam.tf`)

* **Trust Contract Handshake:** Assigns a service trust configuration to the Lambda principal and attaches granular read-only mapping documents to seal the execution context.

##### 6. Serverless Worker Infrastructure (`lambda.tf`)

* **Runtime Deployment:** Compiles local code scripts into automated deployment archives, provisions the compute function running Python 3.12, and injects runtime context variables.

##### 7. Asynchronous Trigger Mapping (`eventbridge.tf`)

* **Cron Execution Rule:** Handles the automated cron scheduling loop and includes the mandatory aws_lambda_permission block to clear cross-service invocation blocks.

### Verification and Results

#### Verified S3 Perimeter Drift Interception

Simulated a high-priority security policy breakdown by creating an unhardened test bucket with public access controls intentionally left disabled. Upon execution of the Cloud Security Scout scanning engine, CloudWatch telemetry confirmed that the Lambda function successfully caught the target vulnerability, stopped the event loop from dropping the error, and registered a structured alert within milliseconds.

#### Validated EC2 Network Firewall Auditing

Injected a testing security group policy containing a standard wide-open port allocation allowing open ingress traffic on SSH Port 22 from 0.0.0.0/0. The continuous compliance scanner successfully analyzed the network metadata registry, isolated the unauthorized security rule group parameter, and labeled it an active environmental risk.

#### Confirmed Database State Insertion & Alert Output Delivery

Inspected the system outputs immediately following the infrastructure injection test cycles. The Amazon DynamoDB lookup index correctly committed persistent records cataloging unique item IDs, exact timestamps, and specific target resource tags. Simultaneously, the Pub-Sub notification layer compiled a detailed diagnostic message block and successfully delivered a formatted emergency warning summary straight to the engineering monitoring inbox.

### Verification Screenshots

#### AWS Lambda Environment Architecture

* **Console View:** Screenshot of the AWS Lambda Configuration portal showing the active function environment fields mapping out target tables and notification routing values safely away from baseline code logic.
<img width="1919" height="809" alt="Screenshot 1" src="https://github.com/user-attachments/assets/df00e55b-34a5-4041-af6e-f106b317fa99" />


#### EventBridge Schedule Activation

* **Console View:** Screenshot of the Amazon EventBridge Scheduler dashboard showcasing the active, verified security-scout-nightly-trigger mapping execution cycles precisely to a nightly 2:00 AM chronological path.
<img width="1917" height="910" alt="Screenshot 2" src="https://github.com/user-attachments/assets/ca71a19c-cf18-43a3-8aa5-7693867e7038" />


#### Real-Time Security Alert & Final Notification Output

Refer to the verification image named image_finding_alert.png. This screenshot details the final verification step of the architecture: an engineering email inbox showing the successful receipt of an automated emergency notification payload generated by the compliance engine. The log outputs detail the exact timestamp, the flagged security group ID, and the violated architectural boundary, proving the asynchronous alerting path is fully operational.
<img width="1555" height="405" alt="Screenshot 3" src="https://github.com/user-attachments/assets/775c526b-4d56-4c3a-b1b1-ee21571e8085" />


#### DynamoDB Compliance Ledger State

Refer to the validation image named image_dynamodb_records.png. This screenshot captures the Amazon DynamoDB Item Explorer interface showing the updated tracking registry. It validates successful, on-demand logging of the system findings, displaying structural columns for unique UUID tokens, active statuses, and specific resource identification values.
<img width="1919" height="765" alt="Screenshot 4" src="https://github.com/user-attachments/assets/d0a50ece-e4d9-486a-a70c-5589c31daeb8" />


### Future Improvements

* **Multi-Account Organizational Crawling:** Scale the execution boundaries by integrating cross-account assume-role configurations, allowing the single scanning container to audit multi-account footprints inside AWS Organizations.

* **Automated Remediation Workflows:** Interface the output loops directly with AWS Step Functions to trigger automated healing actions, such as programmatically applying a public access block immediately upon drift discovery.

* **Centralized Security Hub Aggregation:** Modify the output logic patterns to pipe database findings straight into AWS Security Hub as custom security compliance insights, aligning the platform with global enterprise operational consoles.

### Notes

This architecture highlights specialized cloud core competencies in designing serverless compute schedulers, programmatic layer-7 system metadata extraction, zero-idle background operations, and decoupled notification management infrastructures built completely via reproducible automation models.

**Bottom Line:** The Cloud Security Scout transforms chaotic infrastructure monitoring into a precise, automated continuous compliance framework. By crawling environment state vectors on a serverless, zero-idle footprint, tracking drift indices within a NoSQL persistence ledger, and instantly delivering diagnostic traces during security baseline breaks, the system guarantees comprehensive environmental guardrails with absolute operational agility.
