FROM centos:6
MAINTAINER alberto.garcial@hotmail.com
RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y http://pkgs.repoforge.org/x11vnc/x11vnc-0.9.13-1.el6.rf.x86_64.rpm
RUN yum install -y puppet-3.4.3
RUN yum install -y tar
RUN yum install -y bzip2
ADD /puppet-modules /etc/puppet/modules
ADD /puppet-apply.sh /etc/puppet/puppet-apply.sh
ADD /selenium-bootstrap.sh /selenium-bootstrap.sh
ENV SELENIUM_PORT 4444
RUN sh /etc/puppet/puppet-apply.sh
CMD sh selenium-bootstrap.sh
