*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***

${json_string_values}=
...          {
...          "requestLoggerUrls":{
...            "staging": {
...              "kalkulace":["https://stage.inovis.renomia.cz/quote/car/calculate"],
...              "přepočet":["https://stage.inovis.renomia.cz/quote/car/series/async"],
...              "sjednání":["https://stage.inovis.renomia.cz/calculator/CarSlavia/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarPillow/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarAxa/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarAllianz/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarCSOB/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarCP/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarUNIQA/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarKooperativa/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarCPP/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarDirect/contract/draft"]
...            },
...            "produkce": {
...              "kalkulace":["https://s20.suri.cz/quote/car/calculate"],
...              "přepočet":["https://s20.suri.cz/quote/car/series/async"],
...              "sjednání":["https://s20.suri.cz/calculator/CarSlavia/contract/draft",
...                          "https://s20.suri.cz/calculator/CarPillow/contract/draft",
...                          "https://s20.suri.cz/calculator/CarAxa/contract/draft",
...                          "https://s20.suri.cz/calculator/CarAllianz/contract/draft",
...                          "https://s20.suri.cz/calculator/CarCSOB/contract/draft",
...                          "https://s20.suri.cz/calculator/CarCP/contract/draft",
...                          "https://s20.suri.cz/calculator/CarUNIQA/contract/draft",
...                          "https://s20.suri.cz/calculator/CarKooperativa/contract/draft",
...                          "https://s20.suri.cz/calculator/CarCPP/contract/draft",
...                          "https://s20.suri.cz/calculator/CarDirect/contract/draft"]
...            },
...            "local": {
...              "kalkulace":["https://stage.inovis.renomia.cz/quote/car/calculate"],
...              "přepočet":["https://stage.inovis.renomia.cz/quote/car/series/async"],
...              "sjednání":["https://stage.inovis.renomia.cz/calculator/CarSlavia/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarPillow/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarAxa/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarAllianz/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarCSOB/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarCP/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarUNIQA/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarKooperativa/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarCPP/contract/draft",
...                          "https://stage.inovis.renomia.cz/calculator/CarDirect/contract/draft"
...              ]
...            }
...          },
...          "requestLoggerSteps": {
...            "kalkulace": "calculate",
...            "přepočet":"async",
...            "sjednání": "draft"
...          },
...          "sliders":{
...            "Pojištění skel": {
...              "min": 4000,
...              "max": 120000,
...              "initialOffset": 5
...            },
...            "Povinné ručení":{
...              "min": 0,
...              "max": 150,
...              "initialOffset": 0
...            }
...          },
...          "fuel": {
...            "petrol": "benzín",
...            "diesel": "nafta",
...            "electric": "elektřina"
...          },
...          "insurer":{
...            "Allianz pojišťovna a.s.":"allianz",
...            "AXA pojišťovna a.s.":"axa",
...            "Direct pojišťovna a.s.":"direct",
...            "ČSOB Pojišťovna a.s.":"csob",
...            "Česká podnikatelská pojišťovna a.s., Vienna Insurance Group":"cpp",
...            "Generali Pojišťovna a.s.":"cp",
...            "Kooperativa pojišťovna a.s., Vienna Insurance Group":"kooperativa",
...            "Slavia pojišťovna a.s.":"slavia",
...            "UNIQA pojišťovna a.s.":"uniqa",
...            "Hasičská vzájemná pojišťovna a.s.":"hvp",
...            "Pillow pojišťovna, a. s.":"pillow"
...          },
...          "usage": {
...            "private": "běžné",
...            "rental": "půjčovna",
...            "delivery": "rozvoz zboží",
...            "driving-school": "autoškola",
...            "historic": "veterán",
...            "priority": "přednost v jízdě"
...          },
...          "type": {
...            "car": "osobní",
...            "motorcycle": "motocykl",
...            "van": "užitkový",
...            "truck": "nákladní",
...            "semi-trailer": "návěs",
...            "trailer": "přívěs",
...            "tractor": "traktor",
...            "campervan": "obytný vůz",
...            "work-machine": "pracovní stroj",
...            "bus": "autobus",
...            "quadbike":"tří/čtyřkolka"
...          },
...          "policyHoldertype": {
...            "self-employed" : "podnikatel (OSVČ)",
...            "person" : "fyzická osoba",
...            "company" : "právnická os. | firma"
...          },
...          "checkBoxes":
...          {
...            "Extrabenefit Profi POV":"isExtraBenefit",
...            "ano, vozidlo parkuje v garáži":"garaged",
...            "ano, vlastník vozidla je jeho první majitel":"Checkbox-isFirstOwner",
...            "ano, vozidlo je mírně poškozeno":"isDamaged",
...            "pojistník je lékař (MuDr.)":"isDoctor",
...            "sleva za zkušenost Uniqa":"isExperience",
...            "platba prostřednictvím SIPO":"sipoPayment",
...            "Spočítat u Allinaz":"Checkbox-allianz",
...            "Spočítat u AXA":"Checkbox-axa",
...            "Spočítat u Generali":"Checkbox-cp",
...            "Spočítat u ČSOB":"Checkbox-csob",
...            "Spočítat u Direct":"Checkbox-direct",
...            "Spočítat u HVP":"Checkbox-hvp",
...            "Spočítat u Slavia":"Checkbox-slavia",
...            "Spočítat u UNIQA":"Checkbox-uniqa",
...            "vyplněný příslušný dotazník, případně specifikace parametrů pojištění":"clientParameters",
...            "pojistné smlouvy, které zákazník uzavřel v minulosti":"closedContract",
...            "kopii dokumentu, ze kterého plyne požadavek na pojištění":"copyOfDocument",
...            "fotodokumentace vozidla":"carPhotoDocument",
...            "velký technický průkaz":"technicalCard",
...            "Plátcem DPH je pojistník":"isVatPayer",
...            "zadat později":"Checkbox-later"
...          },
...          "radios":{
...            "Pojistník vozidla je fyzická osoba":"Radio-policyHolder.type.person",
...            "Pojistník vozidla je podnikatel":"Radio-policyHolder.type.self-employed",
...            "Pojistník vozidla je právnická osoba":"Radio-policyHolder.type.company",
...            "Provozovatel vozidla je fyzická osoba":"Radio-user.type.person",
...            "Provozovatel vozidla je podnikatel":"Radio-user.type.self-employed",
...            "Provozovatel vozidla je právnická osoba":"Radio-user.type.company",
...            "Spoluúčast do 5%":"Radio-products.cic.participation0.-5000",
...            "Spoluúčast 5%":"Radio-products.cic.participation0.5000",
...            "Spoluúčast 10%":"Radio-products.cic.participation0.10000",
...            "Spoluúčast nad 10%":"Radio-products.cic.participation0.10000+",
...            "Havarijní pojištění - bez HAV":"Radio-products.cic.type0.none",
...            "Havarijní pojištění - allrisk":"Radio-products.cic.type0.allRisk",
...            "Havarijní pojištění - allrisk + GAP":"Radio-products.cic.type0.allRiskGap",
...            "Havarijní pojištění - havárie":"Radio-products.cic.type0.accident",
...            "Havarijní pojištění - odcizení":"Radio-products.cic.type0.theft",
...            "Provozovatel vozidla je pojistník":"Radio-userSameAsPolicyHolder.true",
...            "Provozovatel vozidla je jiná osoba":"Radio-userSameAsPolicyHolder.false",
...            "Vlastník vozidla je pojistník":"Radio-ownerSameAsPolicyHolder.policyHolder",
...            "Vlastník vozidla je jiná osoba":"Radio-ownerSameAsPolicyHolder.person",
...            "Vlastník vozidla je provozovatel":"Radio-ownerSameAsPolicyHolder.user",
...            "Vlastník vozidla je leasing":"ownerSameAsPolicyHolder.leasing",
...            "Vlastník vozidla je jiný podnikatel":"Radio-ownerSameAsPolicyHolder.self-employed",
...            "Vlastník vozidla je jiná firma":"Radio-ownerSameAsPolicyHolder.company",
...            "Platba - roční":"Radio-paymentPeriod.annually",
...            "Platba - pololetní":"Radio-paymentPeriod.semi-annually",
...            "Platba - čtvrtletní":"Radio-paymentPeriod.quarterly",
...            "Platba - měsíční":"Radio-paymentPeriod.monthly",
...            "Platba - převodem":"Radio-paymentMethod.bank-transfer",
...            "Platba - složenkou":"Radio-paymentMethod.postal-order",
...            "Platba - SIPO":"Radio-paymentMethod.sipo",
...            "Platba - inkasem":"Radio-paymentMethod.collection",
...            "Financování - hotovost":"Radio-acquisitionType.cash",
...            "Financování - finanční leasing":"Radio-acquisitionType.leasing",
...            "Financování - operativní leasing":"Radio-acquisitionType.operating-leasing",
...            "Financování - úvěr":"Radio-acquisitionType.loan",
...            "Minulé poškození - ne" : "Radio-wasBadlyDamaged.false",
...            "Minulé poškození - ano" : "Radio-wasBadlyDamaged.true",
...            "Minulé poškození - není známo" : "Radio-wasBadlyDamaged.",
...            "Kategorie":"category",
...            "Číslo předchozí smlouvy" : "supersededContractNo",
...            "Bylo již vozidlo v minulosti vážněji poškozeno?":"damageDescriptionPast",
...            "Je vozidlo v době uzavření pojistné smlouvy mírně poškozeno?": "damageDescription",
...            "LPG + benzín":"Radio-fuel.lpg",
...            "CNG + benzín":"Radio-fuel.cng",
...            "ele. + benzín":"Radio-fuel.hybrid",
...            "Cena vozidla":"cic.carValue",
...            "Jméno":"firstName",
...            "Příjmení":"lastName"
...          },
...          "textareas":{
...            "Výčet a důvody nesrovnalostí, nebo podstatné změny":"Textarea m-2-b m-sm-4-b p-2-t"
...          },
...          "steps":{
...            "konfigurace":"",
...            "nabídky":"quote",
...            "doplňující informace":"calculator",
...            "záznam z jednání":"contract"
...          },
...          "id":{
...            "town":"react-select-10-input",
...            "manufacturer":"react-select-13-input"
...          },
...          "field":{
...          "typ bonusu": "bonusType",
...          "Váš telefon": "phoneNumber",
...          "Typ pojistníka": "policyHolder-type",
...          "Tovární značka":"manufacturer",
...          "Kategorie":"category"
...          },
...          "inputs": {
...            "typ vozidla": "Radio-type",
...            "typ vozidla další": "react-select-9-input",
...
...            "Tovární značka": "react-select-2-input",
...
...            "pojistník jméno": "policyHolder.firstName",
...            "pojistník příjmení": "policyHolder.lastName",
...            "pojistník rodné číslo": "policyHolder.birthNumber",
...
...            "způsob platby": "Radio-paymentMethod.postal-order",
...
...            "Spočítat u": {
...              "Allianz": "Checkbox-allianz",
...              "Axa": "Checkbox-axa",
...              "ČPP": "Checkbox-cpp",
...              "GČP": "Checkbox-cp",
...              "ČSOB":"Checkbox-csob",
...              "Direct": "Checkbox-direct",
...              "HVP": "Checkbox-hvp",
...              "Kooperatia": "Checkbox-kooperativa",
...              "Pillow": "Checkbox-pillow",
...              "Slavia": "Checkbox-slavia",
...              "Uniqa": "Checkbox-uniqa"
...            }
...          }
...        }
