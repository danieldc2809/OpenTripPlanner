
FROM tomcat:8

ENV JAVA_OPTS="-Xss4m"

RUN mkdir /app

ADD https://jdbc.postgresql.org/download/postgresql-42.2.1.jar /usr/local/tomcat/lib

COPY ./app/onebusaway-transit-data-federation-builder-2.0.0-withAllDependencies.jar /app

COPY ./app/onebusaway-transit-data-federation-webapp.war /tmp
RUN unzip \
	-q \
	/tmp/onebusaway-transit-data-federation-webapp.war \
	-d /usr/local/tomcat/webapps/onebusaway-transit-data-federation-webapp
COPY ./config/onebusaway-transit-data-federation-webapp-data-sources.xml /usr/local/tomcat/webapps/onebusaway-transit-data-federation-webapp/WEB-INF/classes/data-sources.xml


COPY ./app/onebusaway-api-webapp.war /tmp
RUN unzip \
	-q \
	/tmp/onebusaway-api-webapp.war \
	-d /usr/local/tomcat/webapps/onebusaway-api-webapp
COPY ./config/onebusaway-api-webapp-data-sources.xml /usr/local/tomcat/webapps/onebusaway-api-webapp/WEB-INF/classes/data-sources.xml

RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ./app/onebusaway-enterprise-acta-webapp.war /tmp
RUN unzip \
	-q \
	/tmp/onebusaway-enterprise-acta-webapp.war \
	-d /usr/local/tomcat/webapps/ROOT
COPY ./config/onebusaway-enterprise-acta-webapp-data-sources.xml /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/data-sources.xml
