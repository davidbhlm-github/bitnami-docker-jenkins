FROM gcr.io/stacksmith-images/minideb:jessie-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=jenkins \
    BITNAMI_IMAGE_VERSION=2.45-r0 \
    PATH=/opt/bitnami/tomcat/bin:/opt/bitnami/git/bin:/opt/bitnami/java/bin:$PATH

# Additional modules required
RUN bitnami-pkg install java-1.8.0_121-0 --checksum 2743f753fd1ea88bf90352d95694f89ab0a0fb855cf0d1c7b2a6d92835f9ad27
RUN bitnami-pkg install tomcat-9.0.0.M17-1 --checksum faf6d4bd2a9ffb3db8f27befe4902bd8baa7aa3872fb3a249d91a108dbec00e1
RUN bitnami-pkg install git-2.10.1-1 --checksum 454e9eb6fb781c8d492f9937439dcdfc1a931959d948d4c70e79716d2ea51a2b

# Install jenkins
RUN bitnami-pkg unpack jenkins-2.45-0 --checksum 106b5d181dd7c1ce797a5c2133b681dedacdc90aa10906594278aeb1e81abb56

COPY rootfs /

VOLUME ["/bitnami/jenkins"]

EXPOSE 8080 8443 50000

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["nami", "start", "--foreground", "tomcat"]
