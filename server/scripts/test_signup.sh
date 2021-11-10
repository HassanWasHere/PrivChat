#!/bin/bash
curl --header "Content-Type: application/json" --request POST --data '{"username":"HELLOWORLD","password":"xyz", "pubkey": "test"}' http://localhost:8080/signup
