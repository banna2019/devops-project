---
- name: Get superbackend SG ID
  ec2_group_facts:
    region: "{{ region }}"
    filters:
      vpc-id: "{{ elb_vpc_id }}"
      group-name: "{{ elb_vpc_name }}-{{ app_superbackend_group }}"
  register: sg_superback

- name: list of superbackend all the security group id.
  set_fact:
    sg_superback_id: "{{ item.group_id }}"
  with_items: "{{ sg_superback.security_groups }}"

- name: create targets
  set_fact:
    targets: "{{ targets|default([]) + [ {'Id': item, 'Port': 8992 } ] }}"
  with_items: "{{ superbackend_instance_ids }}"

- name: Create superbackend target group
  elb_target_group:
    name: "{{ elb_vpc_name }}-{{ app_elb_name }}"
    region: "{{ region }}"
    state: "{{ elb_resource_state }}"
    tags:
      env: "{{ elb_vpc_name }}-{{ app_target_name }}"
    protocol: http
    port: 80
    vpc_id: "{{ elb_vpc_id }}"
    health_check_path: /
    successful_response_codes: "200"
    target_type: instance
    targets: "{{ targets }}"
  register: superbackend_tg

- name: Create an ELB Application Load Balancer and attach superbackend listener
  elb_application_lb:
    name: "{{ elb_vpc_name }}-{{ app_elb_name }}"
    region: "{{ region }}"
    security_groups:
      - "{{ sg_superback_id }}" 
    subnets:
      - "{{ subnet_ec2_ids[0] }}" 
      - "{{ subnet_ec2_ids[1] }}" 
      - "{{ subnet_ec2_ids[2] }}" 
    idle_timeout: 600  #seconds
    tags:
      env: "{{ elb_vpc_name }}-{{ app_elb_name }}"
    deletion_protection: true
    listeners:
      - Protocol: HTTP
        Port: 80
        DefaultActions:
          - Type: forward
            TargetGroupName: "{{ superbackend_tg.target_group_name }}"
        Rules:
          - Conditions:
              - Field: path-pattern
                Values:
                  - '/'
            Priority: '1'
            Actions:
              - Type: forward
                TargetGroupName: "{{ superbackend_tg.target_group_name }}"
    state: "{{ elb_resource_state }}"
