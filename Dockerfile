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


RUN  yum install epel-release -y && yum install cobbler cobbler-web xinetd dnsmasq wget debmirror pykickstart httpd net-tools -y
RUN sed -i s/"^Listen 80"/"Listen 10.20.0.2:80"/ /etc/httpd/conf/httpd.conf ; \
sed -i s/"^Listen 443"/"Listen 10.20.0.2:443"/ /etc/httpd/conf.d/ssl.conf ; \
ln -s /etc/cobbler/cobbler_tftp.conf /etc/httpd/conf.d/cobbler_tftp.conf

RUN systemctl enable cobblerd; systemctl enable httpd; systemctl enable xinetd; systemctl enable dnsmasq

EXPOSE 67/udp
EXPOSE 69/udp
EXPOSE 8089/tcp

#RUN mkdir -p /u02/cobbler-ansible
#COPY ./cobbler-ansible /u02/cobbler-ansible
#RUN cd /u02/cobbler-ansible; ansible-playbook /u02/cobbler-ansible/deploy-it.yml

CMD ["/sbin/init"]
