variable "project_name" {
    type = string
    description = "The name of deployment project"
    default = "toolkit-managed"
}
variable "aws_region" {
    type = string
    description = "AWS region to deploy resources"
    default = "eu-central-1"
}
variable "kubernetes_version" {
    type = string
    description = "Kubernetes version for EKS cluster"
    default = "1.34"
}
variable "instance_type" {
    type = list(string)
    description = "EC2 instance type for EKS worker nodes"
    default = ["t3.micro"]
}
variable "desired_size" {
    type = number
    description = "Desired number of worker nodes in the EKS node group"
    default = 2
  
}
variable "max_size" {
    type = number
    description = "Maximum number of worker nodes in the EKS node group"
    default = 3
}
variable "min_size" {
    type = number
    description = "Minimum number of worker nodes in the EKS node group"
    default = 1
}
