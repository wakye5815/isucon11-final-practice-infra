variable "vpc_id" {
  type = string
}

resource "aws_security_group" "allow_all_http_inbound_sg" {
  name   = "allow-all-http-inbound-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_all_http_inbound_sg_rule" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.allow_all_http_inbound_sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_all_https_inbound_sg" {
  name   = "allow-all-https-inbound-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_all_https_inbound_sg_rule" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.allow_all_https_inbound_sg.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_all_outbound_sg" {
  name   = "allow-all-outbound-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_all_outbound_sg.id
}

resource "aws_security_group" "access_ssh_for_developer_sg" {
  name   = "access-ssh-for-developer-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = [] // ブランクだとエラーになる
  security_group_id = aws_security_group.access_ssh_for_developer_sg.id

  lifecycle {
    ignore_changes = [cidr_blocks]
  }
}

output "security_group_ids" {
  value = [
    aws_security_group.allow_all_http_inbound_sg.id,
    aws_security_group.allow_all_https_inbound_sg.id,
    aws_security_group.allow_all_outbound_sg.id,
    aws_security_group.access_ssh_for_developer_sg.id
  ]
}
