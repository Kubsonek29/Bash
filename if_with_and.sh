#!/bin/bash
if [[ ( $1 == "admin" && $2 == "secret" ) ]]; then
echo "username : $1"
echo "password : $2"
echo "valid user and password"
elif [[ ( $1 == "" && $2 == "" ) ]]; then
echo "username : admin"
echo "password : secret"
echo "valid user and password"
else
echo "username : $1"
echo "password : $2"
echo "invalid user or password"
fi
