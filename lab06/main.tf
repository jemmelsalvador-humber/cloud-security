resource "aws_iam_role" "iam_role" {
  name               = "role-5433"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_instance_profile" "instance_profile" {
  name = "instanceprof-5433"
  role = aws_iam_role.iam_role.name
}
resource "aws_iam_policy" "iam_policy" {
  name        = "policy-5433"
  description = "My granular policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:DescribeInstances",
          "ec2:RunInstances",
          "ec2:TerminateInstances"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "role_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}
resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "vpc-5433"
  }
}
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-5433"
  }
}
resource "aws_network_interface" "nic" {
  subnet_id   = aws_subnet.subnet.id
  private_ips = ["172.16.10.100"]
  tags = {
    Name = "nic-5433"
  }
}
resource "aws_instance" "ec2" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  network_interface {
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }
  tags = {
    Name = "ec2-5433"
  }
}
resource "aws_iam_policy_attachment" "policy_detach" {
  name = "policydetach-5433"
  roles       = []
  policy_arn = aws_iam_policy.iam_policy.arn
  depends_on = [aws_instance.ec2]
}