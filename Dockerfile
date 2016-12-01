FROM centos:7.2.1511

MAINTAINER on.iylin@gmail.com

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]


RUN export http_proxy=http://192.168.200.4:8080; export https_proxy=$http_proxy

RUN export http_proxy=http://192.168.200.4:8080; export https_proxy=$http_proxy; yum install epel-release -y
RUN export http_proxy=http://192.168.200.4:8080; export https_proxy=$http_proxy; yum install ansible -y

RUN export http_proxy=http://192.168.200.4:8080; export https_proxy=$http_proxy; yum install cobbler cobbler-web -y
RUN export http_proxy=http://192.168.200.4:8080; export https_proxy=$http_proxy; yum install xinetd -y

RUN systemctl enable cobblerd 
RUN systemctl enable httpd
RUN systemctl enable xinetd


RUN mkdir -p /u02/cobbler-ansible
COPY ./cobbler-ansible /u02/cobbler-ansible
RUN cd /u02/cobbler-ansible; ansible-playbook /u02/cobbler-ansible/deploy-it.yml

CMD ["/sbin/init"]
