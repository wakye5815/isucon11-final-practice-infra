variable "subnet_id" {
  type = string
}
variable "vpc_security_group_ids" {
  type = list(string)
}

resource "aws_key_pair" "main" {
  key_name   = "isucon11-final-practice-server-key"
  public_key = file("${path.module}/wakye5815-4isucon11-final-practice-infra.pub")
}

locals {
  instance_suffixes = toset(["first", "second", "thrid"])
}

resource "aws_instance" "main" {
  for_each      = local.instance_suffixes
  ami           = "ami-00acaccebe03b5bed" // https://github.com/matsuu/aws-isucon
  instance_type = "c5.large"
  key_name      = aws_key_pair.main.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  root_block_device {
    volume_type = "gp3"
    volume_size = "30"
  }

  tags = {
    Name = "isucon11-final-practice-${each.value}-server"
  }
}

resource "aws_eip" "main" {
  for_each = local.instance_suffixes
  domain   = "vpc"
  instance = aws_instance.main[each.key].id
}
