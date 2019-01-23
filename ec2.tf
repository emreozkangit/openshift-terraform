resource "aws_key_pair" "bastion" {
  key_name   = "${var.bastion_key_name}"
  public_key = "${file(var.bastion_key_path)}"
}
resource "aws_instance" "bastion" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type        = "t2.xlarge"
  subnet_id            = "${aws_subnet.PublicSubnetA.id}"
  security_groups = [
    "${aws_security_group.sec_bastion.id}",
  ]
  associate_public_ip_address = true
  key_name = "${aws_key_pair.bastion.id}"
  user_data = "${data.template_file.sysprep-bastion.rendered}"
  tags {
    Name = "Bastion"
  }
}

resource "aws_key_pair" "openshift" {
  key_name   = "${var.openshift_key_name}"
  public_key = "${file(var.openshift_key_path)}"
}
resource "aws_instance" "master1" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetA.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Master-1"
  }
}

resource "aws_ebs_volume" "dockervg_master1" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_master1" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_master1.id}"
  instance_id = "${aws_instance.master1.id}"
}

resource "aws_instance" "master2" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetB.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Master-2"
  }
}

resource "aws_ebs_volume" "dockervg_master2" {
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_master2" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_master2.id}"
  instance_id = "${aws_instance.master2.id}"
}

resource "aws_instance" "master3" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetC.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Master-3"
  }
}

resource "aws_ebs_volume" "dockervg_master3" {
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_master3" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_master3.id}"
  instance_id = "${aws_instance.master3.id}"
}

resource "aws_instance" "worker1" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetA.id}" 
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Worker-1"
  }
}
resource "aws_ebs_volume" "dockervg_worker1" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_worker1" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_worker1.id}"
  instance_id = "${aws_instance.worker1.id}"
}

resource "aws_ebs_volume" "glstr_worker1" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  size              = 40
  type              ="gp2"
}

resource "aws_volume_attachment" "glstr_ebs_attachment_worker1" {
  device_name = "/dev/xvdc"
  volume_id   = "${aws_ebs_volume.glstr_worker1.id}"
  instance_id = "${aws_instance.worker1.id}"
}

resource "aws_instance" "worker2" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetB.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Worker-2"
  }
}
resource "aws_ebs_volume" "dockervg_worker2" {
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_worker2" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_worker2.id}"
  instance_id = "${aws_instance.worker2.id}"
}

resource "aws_ebs_volume" "glstr_worker2" {
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  size              = 40
  type              ="gp2"
}

resource "aws_volume_attachment" "glstr_ebs_attachment_worker2" {
  device_name = "/dev/xvdc"
  volume_id   = "${aws_ebs_volume.glstr_worker2.id}"
  instance_id = "${aws_instance.worker2.id}"
}

resource "aws_instance" "worker3" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetC.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Worker-3"
  }
}
resource "aws_ebs_volume" "dockervg_worker3" {
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_worker3" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_worker3.id}"
  instance_id = "${aws_instance.worker3.id}"
}

resource "aws_ebs_volume" "glstr_worker3" {
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  size              = 40
  type              ="gp2"
}

resource "aws_volume_attachment" "glstr_ebs_attachment_worker3" {
  device_name = "/dev/xvdc"
  volume_id   = "${aws_ebs_volume.glstr_worker3.id}"
  instance_id = "${aws_instance.worker3.id}"
}

resource "aws_instance" "infra1" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetA.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Infra-1"
  }
}
resource "aws_ebs_volume" "dockervg_infra1" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_infra1" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_infra1.id}"
  instance_id = "${aws_instance.infra1.id}"
}

resource "aws_ebs_volume" "glstr_registry_block_infra1" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  size              = 40
  type              ="gp2"
}

resource "aws_volume_attachment" "glstr_registry_block_ebs_attachment_infra1" {
  device_name = "/dev/xvdc"
  volume_id   = "${aws_ebs_volume.glstr_registry_block_infra1.id}"
  instance_id = "${aws_instance.infra1.id}"
}
resource "aws_instance" "infra2" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetB.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Infra-2"
  }
}
resource "aws_ebs_volume" "dockervg_infra2" {
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_infra2" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_infra2.id}"
  instance_id = "${aws_instance.infra2.id}"
}

resource "aws_ebs_volume" "glstr_registry_block_infra2" {
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  size              = 40
  type              ="gp2"
}

resource "aws_volume_attachment" "glstr_registry_block_ebs_attachment_infra2" {
  device_name = "/dev/xvdc"
  volume_id   = "${aws_ebs_volume.glstr_registry_block_infra2.id}"
  instance_id = "${aws_instance.infra2.id}"
}

resource "aws_instance" "infra3" {
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  instance_type        = "t2.large"
  subnet_id            = "${aws_subnet.PrivateSubnetC.id}"
  security_groups = [
    "${aws_security_group.sec_openshift.id}",
  ]
  key_name = "${aws_key_pair.openshift.id}"
  user_data = "${data.template_file.sysprep-openshift.rendered}"
  tags {
    Name = "Infra-3"
  }
}
resource "aws_ebs_volume" "dockervg_infra3" {
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  size              = 20
  type              ="gp2"
}

resource "aws_volume_attachment" "dockervg_ebs_attachment_infra3" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.dockervg_infra3.id}"
  instance_id = "${aws_instance.infra3.id}"
}
resource "aws_ebs_volume" "glstr_registry_block_infra3" {
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  size              = 40
  type              ="gp2"
}

resource "aws_volume_attachment" "glstr_registry_block_ebs_attachment_infra3" {
  device_name = "/dev/xvdc"
  volume_id   = "${aws_ebs_volume.glstr_registry_block_infra3.id}"
  instance_id = "${aws_instance.infra3.id}"
}