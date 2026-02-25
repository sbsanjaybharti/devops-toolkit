resource "aws_ecr_repository" "main" {
  name = "${var.project_name}-repository"

  tags = {
    Name = "${var.project_name}-repository"
  }
}
# resource "aws_security_group" "default_worker_group_mgmt" {
#   name_prefix = "${var.project_name}-default_worker_group_mgmt"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = [
#       "10.0.0.0/8",
#     ]
#   }
# }
# resource "aws_security_group" "special_worker_group_mgmt" {
#   name_prefix = "${var.project_name}-special_worker_group_mgmt"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"

#     cidr_blocks = [
#       "10.0.0.0/8",
#       "172.16.0.0/12",
#       "192.168.0.0/16",
#     ]
#   }
# }

# resource "aws_security_group" "eks_nodes_custom" {
#   name_prefix = "${var.project_name}-eks-nodes"
#   vpc_id      = module.vpc.vpc_id
#   description = "EKS worker nodes SG"

#   # 🔑 REQUIRED: node-to-node traffic
#   ingress {
#     description = "Node to node all traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     self        = true
#   }

#   # Allow cluster DNS, kubelet, CNI, etc.
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.project_name}-eks-nodes"
#   }
# }


# # IAM Role for EKS Cluster
# resource "aws_iam_role" "eks_cluster_role" {
#     name = "${var.project_name}-cluster-role"

#     assume_role_policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [{
#             Action = "sts:AssumeRole"
#             Effect = "Allow"
#             Principal = {
#                 Service = "eks.amazonaws.com"
#             }
#         }]
#     })
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#     role       = aws_iam_role.eks_cluster_role.name
# }

# # IAM Role for EKS Nodes
# resource "aws_iam_role" "eks_node_role" {
#     name = "${var.project_name}-node-role"

#     assume_role_policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [{
#             Action = "sts:AssumeRole"
#             Effect = "Allow"
#             Principal = {
#                 Service = "ec2.amazonaws.com"
#             }
#         }]
#     })
# }

# resource "aws_iam_role_policy_attachment" "eks_node_policy" {
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#     role       = aws_iam_role.eks_node_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#     role       = aws_iam_role.eks_node_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_ecr_readonly" {
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#     role       = aws_iam_role.eks_node_role.name
# }