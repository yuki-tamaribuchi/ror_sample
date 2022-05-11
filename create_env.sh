#!/bin/bash
touch .env

echo USER_ID=$(id -u) > .env
echo USER_NAME=$(id -un) >> .env
echo GROUP_ID=$(id -g) >> .env
echo GROUP_NAME=$(id -gn) >> .env