# Projet Terraform - Déploiement d'une infrastructure AWS

Ce projet utilise **Terraform** pour déployer une infrastructure cloud sur AWS, comprenant un réseau VPC, un sous-réseau (subnet), et une instance EC2 exécutant une machine virtuelle Ubuntu avec **Nginx** pré-installé. Le déploiement est automatisé via un pipeline CI/CD utilisant **GitHub Actions**.

## Structure du projet

. ├── main.tf ├── variables.tf ├── outputs.tf ├── terraform.tfvars ├── .github/ │ └── workflows/ │ └── terraform.yml └── README.md

## Prérequis

**AWS Account** : Vous devez avoir un compte AWS avec les autorisations nécessaires pour créer des ressources comme VPC, EC2, etc.
Terraform : Installez Terraform sur votre machine locale pour tester en local avant de pousser sur GitHub.
**GitHub Account** : Vous devez avoir un compte GitHub pour configurer et utiliser GitHub Actions.

## Installation de Terraform
Téléchargez et installez Terraform depuis terraform.io/downloads.
Vérifiez l'installation avec la commande :
```sh
   terraform version
```

## Fichiers du projet

### 1. `main.tf`

Ce fichier contient la configuration principale de l'infrastructure. Il définit les ressources suivantes :

- **VPC** : Un réseau privé virtuel (VPC) dans AWS avec un bloc CIDR défini.
- **Subnet** : Un sous-réseau (subnet) à l'intérieur du VPC.
- **EC2 Instance** : Une instance EC2 Ubuntu avec Nginx pré-installé, lancée dans le subnet créé précédemment.

### 2. `variables.tf`

Ce fichier définit les variables nécessaires à la configuration de l'infrastructure. Vous devrez renseigner des valeurs par défaut ou des valeurs dans un fichier `terraform.tfvars` (voir ci-dessous).

Exemple de variables :
- `vpc_cidr` : Plage CIDR du VPC (par exemple, `10.0.0.0/16`).
- `subnet_cidr` : Plage CIDR du subnet (par exemple, `10.0.1.0/24`).
- `ami_id` : ID de l'AMI Ubuntu à utiliser pour l'instance EC2.
- `instance_type` : Type de l'instance EC2 (par exemple, `t2.micro`).

### 3. `outputs.tf`

Ce fichier contient les sorties de l'infrastructure déployée. Par exemple, l'adresse IP publique de l'instance EC2, l'ID du VPC et l'ID du subnet, qui peuvent être utilisés après le déploiement pour accéder aux ressources.

## Pipeline CI/CD avec GitHub Actions

Le pipeline CI/CD est configuré dans `.github/workflows/terraform.yml` pour automatiser le déploiement de l'infrastructure chaque fois qu'un commit est poussé vers la branche main.

## Exécution

Clonez ce repository sur votre machine locale ou dans votre propre repository GitHub.
Modifier le fichier variables.tf pour définir les variables nécessaires (par exemple vpc_cidr, subnet_cidr, ami_id, instance_type).
Poussez vos modifications sur GitHub et le pipeline GitHub Actions s'exécutera automatiquement pour créer votre infrastructure.
Une fois l'infrastructure déployée, vous pouvez accéder à votre instance EC2 via son IP public

## Secrets GitHub

Pour que GitHub Actions puisse interagir avec AWS, vous devez ajouter vos identifiants AWS dans les secrets GitHub :

Allez dans les paramètres de votre repository GitHub.
Sous "Secrets", ajoutez les variables suivantes :
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
Ces secrets seront utilisés dans le workflow pour configurer les credentials AWS.

