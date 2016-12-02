1. build container
2. run ansible playbook
3. Run it like

docker run -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v /etc/cobbler:/etc/cobbler \
-v /var/lib/tftpboot:/var/lib/tftpboot \
-v /etc/xinetd.d:/etc/xinetd.d \
-v /var/lib/cobbler:/var/lib/cobbler \
-p 67:67/udp \
 --net host \
0cb24ed7d7f0

4. ..

5. Have fun
