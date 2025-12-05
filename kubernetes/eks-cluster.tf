module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"  # REQUIRED FIX

  cluster_name    = "myAppp-eks-cluster"
  cluster_version = "1.31" # use supported version if 1.33 fails

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni = { most_recent = true }
  }

  vpc_id     = module.myAppp-vpc.vpc_id
  subnet_ids = module.myAppp-vpc.private_subnets

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 6
      desired_size = 3

      instance_types = ["t2.small"]
      key_name       = "northold"
    }
  }

  tags = {
    environment = "development"
    application = "myAppp"
  }
}

