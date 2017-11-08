FROM centos:7

MAINTAINER Stefan Lehmann <derstef@gmail.com>

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=151 \
    JAVA_VERSION_BUILD=12 \
    JAVA_URL_HASH=e758a0de34e24606bca991d704f6dcbf

RUN yum --enablerepo=extras install epel-release -y \
  && yum update -y \
  && yum install -y ca-certificates net-tools curl unzip lsof wget git vim which figlet \
  && wget --no-cookies --no-check-certificate \
      --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjre8-downloads-2133155.html; oraclelicense=accept-securebackup-cookie" \
      "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_URL_HASH}/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.rpm" \
  && yum localinstall -y jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.rpm \
  && rm -f jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.rpm \
  && rm -rf /var/cache/yum

# Set environment variables.
ENV HOME /root
ENV JAVA_HOME /usr/java/jdk1.8.0_${JAVA_VERSION_MINOR}

# Define working directory.
WORKDIR /root

# expose hybris ports
EXPOSE 9001
EXPOSE 9002

# expose default solr port
EXPOSE 8983

# expose the default debug port for connecting via IDE
EXPOSE 8000

# Define default command.
CMD ["bash"]
