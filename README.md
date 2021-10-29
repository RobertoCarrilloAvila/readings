# Readings

## Description
Small API to create, find, or count readings without use a csv file as a database

## Installation
Requirements:
  * ruby 2.7.2
  * bundler gem
  * rails ~> 6.1

```
$ bundle install
$ rails server
```
# Routes

```
        Prefix Verb   URI Pattern                       Controller#Action
 count_reading GET    /readings/:id/count(.:format)     readings#count
      readings POST   /readings(.:format)               readings#create
       reading GET    /readings/:id(.:format)           readings#show

```
### Postman Collection

```json
  {
    "info": {
      "_postman_id": "509072b0-e653-4708-a0c9-2536aa9872c9",
      "name": "readings",
      "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
    },
    "item": [
      {
        "name": "create",
        "request": {
          "method": "POST",
          "header": [],
          "body": {
            "mode": "raw",
            "raw": "{\n  \"id\": \"36d5658a-6908-479e-887e-a949ec199272\",\n  \"readings\": [\n    {\n      \"timestamp\": \"2021-09-29T16:08:15+01:00\",\n      \"count\": 2\n    },\n    {\n      \"timestamp\": \"2021-09-29T16:09:15+01:00\",\n      \"count\": 15\n    }\n  ]\n}",
            "options": {
              "raw": {
                "language": "json"
              }
            }
          },
          "url": {
            "raw": "localhost:3000/readings",
            "host": [
              "localhost"
            ],
            "port": "3000",
            "path": [
              "readings"
            ]
          }
        },
        "response": []
      },
      {
        "name": "show",
        "request": {
          "method": "GET",
          "header": [],
          "url": {
            "raw": "localhost:3000/readings/:id",
            "host": [
              "localhost"
            ],
            "port": "3000",
            "path": [
              "readings",
              ":id"
            ],
            "variable": [
              {
                "key": "id",
                "value": "36d5658a-6908-479e-887e-a949ec199272"
              }
            ]
          }
        },
        "response": []
      },
      {
        "name": "count",
        "request": {
          "method": "GET",
          "header": [],
          "url": {
            "raw": "localhost:3000/readings/:id/count",
            "host": [
              "localhost"
            ],
            "port": "3000",
            "path": [
              "readings",
              ":id",
              "count"
            ],
            "variable": [
              {
                "key": "id",
                "value": "36d5658a-6908-479e-887e-a949ec199272"
              }
            ]
          }
        },
        "response": []
      }
    ]
  }
```