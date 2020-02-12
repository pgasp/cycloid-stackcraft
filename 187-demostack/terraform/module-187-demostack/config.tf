"locals" = {
  "tags_cycloid" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }

  "tags_stack" = {}
}

"provider" "aws" {
  "region" = "eu-west-3"
}

"resource" "aws_db_instance" "mydatabase" {
  "instance_class" = "mydatabase"

  "tags" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }

  "vpc_security_group_ids" = ["${aws_security_group.generated_sg_aws_db_instance_mydatabase.id}"]
}

"resource" "aws_instance" "serveur" {
  "ami" = "ami-007fae589fdf6e955"

  "instance_type" = "t2.micro"

  "tags" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }

  "vpc_security_group_ids" = ["${aws_security_group.generated_sg_aws_instance_serveur.id}"]
}

"resource" "aws_security_group" "generated_sg_aws_db_instance_mydatabase" {
  "name_prefix" = "generated_sg_aws_db_instance_mydatabase"

  "tags" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }
}

"resource" "aws_security_group" "generated_sg_aws_instance_serveur" {
  "name_prefix" = "generated_sg_aws_instance_serveur"

  "tags" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }
}

"resource" "aws_security_group_rule" "rule_egress_generated_sg_aws_instance_serveur_to_generated_sg_aws_db_instance_mydatabase_3306_3306" {
  "description" = "sql"

  "from_port" = "3306"

  "protocol" = "TCP"

  "security_group_id" = "${aws_security_group.generated_sg_aws_instance_serveur.id}"

  "source_security_group_id" = "${aws_security_group.generated_sg_aws_db_instance_mydatabase.id}"

  "to_port" = "3306"

  "type" = "egress"
}

"resource" "aws_security_group_rule" "rule_ingress_generated_sg_aws_instance_serveur_to_generated_sg_aws_db_instance_mydatabase_3306_3306" {
  "description" = "sql"

  "from_port" = "3306"

  "protocol" = "TCP"

  "security_group_id" = "${aws_security_group.generated_sg_aws_db_instance_mydatabase.id}"

  "source_security_group_id" = "${aws_security_group.generated_sg_aws_instance_serveur.id}"

  "to_port" = "3306"

  "type" = "ingress"
}

"variable" "env" {
  "default" = "[PLACEHOLDER]"

  "type" = "string"
}

"variable" "project" {
  "default" = "[PLACEHOLDER]"

  "type" = "string"
}
