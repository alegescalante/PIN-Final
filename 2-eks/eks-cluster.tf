module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name    = local.name
  cluster_version = "1.24"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    #instance_types = ["m5.large"]   
  }
  eks_managed_node_groups = {
    eks-cluster-wg = {
      name = "node-group"

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2


      capacity_type = "SPOT"


    }
  }
}