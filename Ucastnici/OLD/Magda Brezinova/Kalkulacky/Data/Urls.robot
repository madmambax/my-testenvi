*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***

${json_string_urls}=
...  {
...    "staging": {
...      "universum-car":"https://stage.universum.renomia.cz/car",
...      "universum-tools": "https://stage.universum.renomia.cz/smlouvy-a-nabidky",
...      "pfp-uni-car":"https://pfp.stage.universum.renomia.cz/car"
...    },
...    "produkce": {
...      "universum-car":"https://universum.renomia.cz/car",
...      "pfp-uni-car":"https://pfp.universum.renomia.cz/car"
...    },
...    "rev-app": {
...      "universum-car":"https://rev-pfp.car.rev.stage.universum.renomia.cz/car",
...      "pfp-uni-car":"https://rev-pfp.pfp.rev.stage.universum.renomia.cz/car"
...    },
...    "local": {
...      "universum-car":"http://localhost:3000/car ",
...      "pfp-uni-car":"http://localhost:3000/car "
...    },
...    "localhost": {
...    },
...    "_params": {
...      "universum-car": {
...        "backoffice": true,
...        "pfp-only": false,
...        "product": "car"
...      },
...      "pfp-uni-car": {
...        "backoffice": true,
...        "pfp-only": true,
...        "product": "car"
...      }
...    }
...  }