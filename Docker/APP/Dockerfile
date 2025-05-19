#Base: Liberica OpenJDK 21 
FROM bellsoft/liberica-openjdk-debian:21
#La aplicacion esta compilada con Java 21. La imagen oficial de WildFly 29.0.1
#no tiene soporte para Java 21 por lo que se utiliza la imagen de Liberica OpenJDK 21.

#Instalar utilerías y certificados
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl tar gzip ca-certificates \
 && rm -rf /var/lib/apt/lists/*
#para poder descargar el .tar de WildFly y confiar en el certificado de la web añadimos curl y los certificados ca


#WildFly 29.0.1
ARG WILDFLY_VERSION=29.0.1.Final
#añadimos la version de WildFly que queremos descargar. En este caso la 29.0.1 - la que pide la aquitectura
RUN mkdir -p /opt \
 && curl -SL https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz \
      | tar zx -C /opt \
 && mv /opt/wildfly-${WILDFLY_VERSION} /opt/wildfly \
 && rm -rf /opt/wildfly/*.tar.gz
#COmo no existe la version 29.0.1 de WildFly en el repositorio de WildFly, la descargamos directamente de su github y la colocamos en /opt
#y descomprimimos el .tar.gz en /opt/wildfly


#Define una variable de entorno llamada WILDFLY_HOME que apunta al directorio donde se instalo WildFly
ENV WILDFLY_HOME=/opt/wildfly
#Añade el subdirectorio bin de WildFly al PATH del sistema. Con esto, se puede invocar scripts como standalone.sh
ENV PATH=${PATH}:${WILDFLY_HOME}/bin

#Usuario admin
RUN ${WILDFLY_HOME}/bin/add-user.sh admin 123456 --silent

# Ajustamos metaspace
RUN sed -i '/^JAVA_OPTS=/ s|"$| -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m"|' $WILDFLY_HOME/bin/standalone.conf

#Puertos y arranque
EXPOSE 8080 9990 8009

#Configuración de WildFly
CMD ["sh","-c","${WILDFLY_HOME}/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0"]
