dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["mock_subnet_1", "mock_subnet_2"]
    vpc_id         = "mock_vpc_id"
  }
}

inputs = {
  app_name         = "karaoke"
  aws_region       = "us-east-1"
  instance_keypair = "karaoke-key-pair"
  instance_type    = "t3.small"
  subnet_ids       = dependency.vpc.outputs.public_subnets
  vpc_id           = dependency.vpc.outputs.vpc_id
}