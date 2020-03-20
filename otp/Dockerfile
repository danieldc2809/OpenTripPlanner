FROM openjdk:8-jre-alpine

LABEL maintainer "daniel.josedecampos@bue.edu.ar"

ENV OTP_BASE=/var/otp
WORKDIR $OTP_BASE

COPY app/target/otp-1.5.0-SNAPSHOT-shaded.jar $OTP_BASE
