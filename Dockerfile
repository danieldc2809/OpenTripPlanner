FROM openjdk:8-jre-alpine

LABEL maintainer "daniel.josedecampos@bue.edu.ar"

ENV OTP_BASE=/var/otp
ENV OTP_GRAPHS=$OTP_BASE/graphs/buenosaires

WORKDIR $OTP_BASE

COPY otp-1.5.0-SNAPSHOT-shaded.jar $OTP_BASE
COPY buenosaires $OTP_GRAPHS