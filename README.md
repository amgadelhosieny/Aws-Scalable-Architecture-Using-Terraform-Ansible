# 🚀 AWS Infrastructure with Terraform & Ansible  

## 📌 Project Overview  
This project provisions a **highly available** AWS infrastructure using Terraform and configures it using Ansible. It deploys the following resources:  

- **Bastion Host**: Provides SSH access to private instances.  
- **Frontend Load Balancer**: Distributes traffic to Nginx instances.  
- **Backend Load Balancer**: Routes traffic to Node.js instances.  
- **Security Groups**: Restrict access as per best security practices.  
- **MongoDB Cluster**: Secure database instances.  

---

## 🏠 Architecture Overview  

![image](https://github.com/user-attachments/assets/640ae867-f0b8-4621-a5ac-8fe242f689aa)  

---

## 🌜 Infrastructure Components  

| Component             | Description                          |  
|----------------------|----------------------------------|  
| **VPC**             | Custom AWS Virtual Private Cloud |  
| **Bastion Host**    | SSH access to private instances |  
| **Nginx Load Balancers** | Handle incoming web traffic |  
| **Node.js Servers** | Hosts the backend application |  
| **MongoDB Cluster** | Database instances in private subnets |  
| **Security Groups** | Controls inbound & outbound traffic |  

---

## 🚀 Deployment Instructions  

### Prerequisites  
Ensure you have the following installed:  
- [Terraform](https://developer.hashicorp.com/terraform/downloads)  
- AWS CLI configured with proper credentials  
- Ansible  

### Steps to Deploy  

1️⃣ **Clone the Repository**  
```sh
git clone https://github.com/amgadelhosieny/Aws-Scalable-Architecture-Using-Terraform-Ansible.git
```  

2️⃣ **Initialize Terraform**  
```sh
terraform init
```  

3️⃣ **Plan the Deployment**  
```sh
terraform plan
```  

4️⃣ **Apply the Configuration**  
```sh
terraform apply -auto-approve
```  

5️⃣ **Access the Infrastructure**  
```sh
ssh -i your-key.pem ec2-user@<BASTION-HOST-IP>
```  

---

## 🛠️ Configuration Management with Ansible  

After provisioning the infrastructure using Terraform, **Ansible** automates the installation and configuration of required software on the servers.  

### 📝 Ansible Playbooks in this Project:  
- **Nginx Playbook**: Installs and configures Nginx on frontend servers.  
- **Node.js Playbook**: Sets up Node.js and deploys the backend application.  
- **MongoDB Playbook**: Configures and secures MongoDB instances.  

### ⚡ Running Ansible Playbooks  

Once Terraform completes provisioning, update the Ansible inventory with the generated EC2 instance IPs and run:  

```sh
ansible-playbook -i inventory nginx-setup.yml
ansible-playbook -i inventory nodejs-setup.yml
ansible-playbook -i inventory mongodb-setup.yml
```  

This ensures that all servers are properly configured without manual intervention. ✅  

---

## 🛠️ Best Practices Implemented  

✅ **Security Groups**: Restrict unnecessary traffic exposure.  
✅ **Bastion Host Access**: Only SSH from a trusted source.  
✅ **Private Subnets**: Secure application and database instances.  
✅ **Scalability**: Load balancers for high availability.  

---

## 📌 Future Enhancements  

- 🔹 Implement **IAM Role-based access**.  
- 🔹 Enable **Auto Scaling** for application instances.  
- 🔹 Add **Monitoring & Logging** using AWS CloudWatch.  

---

## 🎯 Author  
**Amgad Elhosieny**  

