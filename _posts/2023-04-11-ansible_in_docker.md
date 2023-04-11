---
title: Run ansible in docker
categories:
- docker
- ansible
tags:
- docker
- ansible
---

Need to run older versions of ansible? Build it in a docker container and run it from there, no muss, no fuss

```
# heavily poached from
# geektechstuff
# using a lot of https://hub.docker.com/r/philm/ansible_playbook/dockerfile/

# Alpine is a lightweight version of Linux.
# apline:latest could also be used
FROM alpine:3.7

RUN \
# apk add installs the following
 apk add \
   curl \
   python \
   py-pip \
   py-boto \
   py-dateutil \
   py-httplib2 \
   py-jinja2 \
   py-paramiko \
   py-setuptools \
   py-yaml \
   openssh-client \
   bash \
   tar && \
 pip install --upgrade pip

# Makes the Ansible directories
RUN mkdir /etc/ansible /ansible
RUN mkdir ~/.ssh

# Over rides SSH Hosts Checking
RUN echo "host *" >> ~/.ssh/config &&\
    echo "StrictHostKeyChecking no" >> ~/.ssh/config

# Downloads the Ansible tar (curl) and saves it (-o)
RUN \
  curl -kfsSL https://releases.ansible.com/ansible/ansible-2.4.2.0.tar.gz -o ansible.tar.gz
# Extracts Ansible from the tar file
RUN \
  tar -xzf ansible.tar.gz -C ansible --strip-components 1 && \
  rm -fr ansible.tar.gz /ansible/docs /ansible/examples /ansible/packaging

# Makes a directory for ansible playbooks
RUN mkdir -p /ansible/playbooks
# Makes the playbooks directory the working directory
WORKDIR /ansible/playbooks

# Sets environment variables
ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING False
ENV ANSIBLE_RETRY_FILES_ENABLED False
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

# Sets entry point (same as running ansible-playbook)
ENTRYPOINT ["ansible-playbook"]
# Can also use ["ansible"] if wanting it to be an ad-hoc command version
#ENTRYPOINT ["ansible"]
```

Build it.
```
docker build -t ansible:2.4.2 .
```


Run it like so;
```
# docker run -v "${PWD}"://ansible/playbooks:ro -v ~/.ssh:/root/.ssh:ro --rm ansible:2.4.2 <ARGS>
eg;
docker run -v "${PWD}"://ansible/playbooks:ro -v ~/.ssh:/root/.ssh:ro --rm ansible:2.4.2 -i ansible/inventory ansible/playbook.yml
```
