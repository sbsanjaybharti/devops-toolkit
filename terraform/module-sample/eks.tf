module "eks" {
  source                = "terraform-aws-modules/eks/aws"
  version               = "~> 20.0"
  cluster_name          = "${var.project_name}"
  cluster_version       = var.kubernetes_version
  cluster_endpoint_public_access  = true
  enable_irsa            = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
 
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "${var.project_name}: Allow all node-to-node traffic"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }
  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    worker_group = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      name = "${var.project_name}-wg"
      instance_types = var.instance_type

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
      # additional_security_group_ids = [
      #   aws_security_group.eks_nodes_custom.id,
      #   aws_security_group.default_worker_group_mgmt.id,
      #   aws_security_group.special_worker_group_mgmt.id
      # ]
    }
  }

  tags = {
    Environment = "development"
    Terraform   = "true"
  }
}
