FROM python:3.7 AS builder

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y libjudy-dev python3-dev python3-cffi python3-wheel python3-nose && apt-get clean

WORKDIR /code
COPY MANIFEST.in README.md LICENSE setup.py ./
COPY judyz_cffi judyz_cffi/
COPY tests tests/

RUN python setup.py bdist_wheel

RUN pip install dist/judyz_cffi-0.9.0-py3-none-any.whl && nosetests3 tests/


FROM ubuntu:18.04

WORKDIR /dist

COPY --from=builder /code/dist ./
