# https://www.ansible.com/
#
# docker run --rm \
# 	-it \
# 	-v ${PWD}/hosts:/etc/ansible/hosts \
# 	-v ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
# 	-v ${HOME}/.ssh:/root/.ssh:ro \
# 	ansible all -m ping
#
FROM alpine:latest
LABEL maintainer "Coleman Word <colemanword@gmail.com>"

RUN builddeps=' \
		python-dev \
		py2-pip \
		musl-dev \
		openssl-dev \
		libffi-dev \
		gcc \
		' \
	&& apk --no-cache add \
        git \
	ca-certificates \
	python \
	py-paramiko \
	py-yaml \
	py-jinja2 \
	py-httplib2 \
	$builddeps \
	&& pip install --upgrade pip \
	&& pip install \
		ansible \
		six \
	&& apk del --purge $builddeps

RUN git clone https://github.com/Thekubebro/ansible-docker.git && cd ansible-docker

ENTRYPOINT [ "ansible-playbook" ]
