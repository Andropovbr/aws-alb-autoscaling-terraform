# Projeto: Infraestrutura com Load Balancer e Auto Scaling (AWS + Terraform)

Este projeto provisiona uma infraestrutura escalável e altamente disponível na AWS utilizando **Terraform**. A arquitetura inclui um **Application Load Balancer (ALB)**, **Auto Scaling Group (ASG)**, **EC2 instances** com **NGINX**, e rede configurada com sub-redes públicas e privadas em múltiplas zonas de disponibilidade.

---

## 🔧 Recursos Criados

- **VPC personalizada** com sub-redes públicas e privadas
- **Internet Gateway** e **NAT Gateway**
- **Route Tables** e associações para sub-redes públicas e privadas
- **Security Groups** para o Load Balancer e para as instâncias EC2
- **Application Load Balancer (ALB)** com listener na porta 80
- **Launch Template** e **Auto Scaling Group** com EC2 Linux
- **Script de inicialização (`user_data`)** que instala e configura o NGINX automaticamente
- **Acesso via AWS Systems Manager (SSM)** às instâncias EC2

---

## 🌐 Acesso

- Acesse o site através do **DNS público do Load Balancer**, exportado via `output` do Terraform:

```
terraform output alb_dns_name
```

---

## 📁 Estrutura do Projeto

```
aws-alb-autoscaling-terraform/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── modules/
    ├── network/
    ├── compute/
    ├── alb/
    └── security/
```

---

## ⚙️ Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/aws-alb-autoscaling-terraform.git
cd aws-alb-autoscaling-terraform
```

### 2. Configure suas variáveis em `terraform.tfvars`

Exemplo:

```hcl
vpc_cidr = "10.0.0.0/16"

public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
azs = ["us-east-1a", "us-east-1b"]

ami_id = "ami-0c101f26f147fa7fd" # Amazon Linux 2
instance_type = "t2.micro"
key_name = "andre-key"
```

> ⚠️ Certifique-se de que sua chave SSH esteja criada no EC2 (`~/.ssh/andre-key.pem`) e registrada no painel da AWS.

### 3. Inicialize o Terraform

```bash
terraform init
```

### 4. Visualize o plano de execução

```bash
terraform plan
```

### 5. Aplique a infraestrutura

```bash
terraform apply
```

---

## 🛠 Como acessar as instâncias EC2 via SSM

Este projeto configura as instâncias com permissão para serem acessadas via **AWS Systems Manager (Session Manager)**:

1. Vá até o Console da AWS → Systems Manager → Session Manager.
2. Inicie uma nova sessão.
3. Escolha a instância desejada.

> ✅ Não é necessário IP público nem abrir portas SSH.

---

## 📦 Tags Utilizadas

Todos os recursos são identificados com as seguintes tags:

```hcl
Project = "aws-alb-autoscaling-terraform"
Owner   = "André Santos"
```

---

## 🧹 Destruir a Infraestrutura

```bash
terraform destroy
```

---

## ✍️ Autor

**André Santos**

---

## 📘 Aprendizados

- Uso de módulos para organização e reuso de código
- Prática com recursos VPC, subnets, NAT Gateway, Security Groups
- Configuração de balanceamento de carga com ALB
- Auto Scaling com EC2 e Launch Template
- Acesso via Systems Manager sem necessidade de IP público

---

## 📸 Demonstração

_Aqui você pode adicionar prints do diagrama ou do site em funcionamento acessado pelo ALB._

---