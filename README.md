###The directory structure is as follows:
1.  app:
	* src --code folder
		* server.py  -fastapi server
		* db_orm.py  - db connection and crud aoperation functions
		* requirements.txt  - pip installs all dependencies from this file
		* security_utils.py - sercurity related function like creating token 
		* server_data_model.py - model for server data objects
	* Dockerfile -- contains installation instruction for fastapi and starting api server

2.  db:
	* **mysql** is used  as db 
	*	mysql initialisation for tables and data  
		contains data creation script used while installation.(SMSTestProject/db/user_db_and_data_createion.sql)
	* **Tables used are as follows:**
	
            mysql> describe user_pass;
            +----------+--------------+------+-----+---------+-------+
            | Field    | Type         | Null | Key | Default | Extra |
            +----------+--------------+------+-----+---------+-------+
            | username | varchar(100) | NO   | PRI | NULL    |       |
            | password | varchar(100) | YES  |     | NULL    |       |
            +----------+--------------+------+-----+---------+-------+
            2 rows in set (0.05 sec)
               
            mysql> describe chemicals;
            +---------+--------------+------+-----+---------+-------+
            | Field   | Type         | Null | Key | Default | Extra |
            +---------+--------------+------+-----+---------+-------+
            | chem_id | int(11)      | NO   | PRI | NULL    |       |
            | name    | varchar(255) | NO   |     | NULL    |       |
            +---------+--------------+------+-----+---------+-------+
            2 rows in set (0.00 sec)
    
            mysql> describe commodities;
            +--------------+--------------+------+-----+---------+-------+
            | Field        | Type         | Null | Key | Default | Extra |
            +--------------+--------------+------+-----+---------+-------+
            | commodity_id | int(11)      | NO   | PRI | NULL    |       |
            | name         | varchar(255) | NO   |     | NULL    |       |
            | price        | float        | YES  |     | NULL    |       |
            | inventory    | float        | YES  |     | NULL    |       |
            +--------------+--------------+------+-----+---------+-------+
            4 rows in set (0.00 sec)
                    
            mysql> describe chemical_composition;
            +--------------+---------+------+-----+---------+-------+
            | Field        | Type    | Null | Key | Default | Extra |
            +--------------+---------+------+-----+---------+-------+
            | commodity_id | int(11) | NO   | PRI | NULL    |       |
            | chem_id      | int(11) | NO   | PRI | NULL    |       |
            | percentage   | float   | YES  |     | NULL    |       |
            +--------------+---------+------+-----+---------+-------+
            3 rows in set (0.00 sec)

3.  __docker-compose.yml__  : this file contains how to start both db and fastapi server

--------------------------------------------------------------------------------------------------
###My development environment:
1. I have used **ubuntu 18.04** for development and testing
    * The steps needed to run the application
	    1. install docker:
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io


		2. start docker service if not running 
			*       sudo systemctl start docker
			*       sudo systemctl enable docker
		3. **check if docker is installed** 
			*        docker --version

	    4. install docker-compose
		    *        sudo apt  install docker-compose

	    5. **(Optional)  to login to sql install mysql-client**
sudo apt install mysql-client-core-5.7

 ### **NOTE** : check if your user has privileges/ access to docker and docker compose
* if not create a group called docker and add your user to that group 
	
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
---------------------------------------------------------------------------------------

###INSTALLATION:
* now open terminal to project directory and run:     
 
        docker-compose up

* There are two services in this setup 
	1. database : mysql server
	2. fastapi server

* wait till it downloads all the required files and other requirements  

* once it is done open the url :

   * (http://127.0.0.1:8001/docs)

-----------------------------------------------------------------------------------------------

### ***NOTE*** :
* if there is nothing displayed on screen, it means ui library to show docs is not getting downloaded
* Please install and use following command to test the apis

        sudo apt install curl

-----------------------------------------------------------------------------------------------
### APIS

1. get token for user authorisation:

        COMMAND:
        curl -X POST "http://127.0.0.1:8001/token" -H  "accept: application/json" -H  "Content-Type: application/x-www-form-urlencoded" -d "grant_type=&username=ketul&password=ketul&scope=&client_id=&client_secret="
        
        RESPONSE:
        {
          "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs",
          "token_type": "bearer"
        }

2. get chemical ids

    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to
    *  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"

            COMMAND:
            curl -X GET "http://127.0.0.1:8001/listChemicals" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0"
            
            RESPONSE:
            [
              {
                "chem_id": 0,
                "name": "Chem No0"
              },
              {
                "chem_id": 1,
                "name": "Chem No1"
              },
              {
                "chem_id": 2,
                "name": "Chem No2"
              },
              {
                "chem_id": 3,
                "name": "Chem No3"
              },
              {
                "chem_id": 4,
                "name": "Chem No4"
              },
              {
                "chem_id": 5,
                "name": "Chem No5"
              },
              {
                "chem_id": 6,
                "name": "Chem No6"
              },
              {
                "chem_id": 7,
                "name": "Chem No7"
              },
              {
                "chem_id": 8,
                "name": "Chem No8"
              },
              {
                "chem_id": 9,
                "name": "Chem No9"
              },
              {
                "chem_id": 10,
                "name": "Chem No10"
              },
              {
                "chem_id": 11,
                "name": "Chem No11"
              },
              {
                "chem_id": 12,
                "name": "Chem No12"
              },
              {
                "chem_id": 13,
                "name": "Chem No13"
              },
              {
                "chem_id": 14,
                "name": "Chem No14"
              },
              {
                "chem_id": 15,
                "name": "Chem No15"
              },
              {
                "chem_id": 16,
                "name": "Chem No16"
              },
              {
                "chem_id": 17,
                "name": "Chem No17"
              },
              {
                "chem_id": 18,
                "name": "Chem No18"
              },
              {
                "chem_id": 19,
                "name": "Chem No19"
              },
              {
                "chem_id": 20,
                "name": "Chem No20"
              },
              {
                "chem_id": 21,
                "name": "Chem No21"
              },
              {
                "chem_id": 22,
                "name": "Chem No22"
              },
              {
                "chem_id": 23,
                "name": "Chem No23"
              },
              {
                "chem_id": 24,
                "name": "Chem No24"
              },
              {
                "chem_id": 25,
                "name": "Chem No25"
              },
              {
                "chem_id": 26,
                "name": "Chem No26"
              },
              {
                "chem_id": 27,
                "name": "Chem No27"
              },
              {
                "chem_id": 28,
                "name": "Chem No28"
              },
              {
                "chem_id": 29,
                "name": "Chem No29"
              },
              {
                "chem_id": 30,
                "name": "Chem No30"
              },
              {
                "chem_id": 31,
                "name": "Chem No31"
              },
              {
                "chem_id": 32,
                "name": "Chem No32"
              },
              {
                "chem_id": 33,
                "name": "Chem No33"
              },
              {
                "chem_id": 34,
                "name": "Chem No34"
              },
              {
                "chem_id": 35,
                "name": "Chem No35"
              },
              {
                "chem_id": 36,
                "name": "Chem No36"
              },
              {
                "chem_id": 37,
                "name": "Chem No37"
              },
              {
                "chem_id": 38,
                "name": "Chem No38"
              },
              {
                "chem_id": 39,
                "name": "Chem No39"
              },
              {
                "chem_id": 40,
                "name": "Chem No40"
              },
              {
                "chem_id": 41,
                "name": "Chem No41"
              },
              {
                "chem_id": 42,
                "name": "Chem No42"
              },
              {
                "chem_id": 43,
                "name": "Chem No43"
              },
              {
                "chem_id": 44,
                "name": "Chem No44"
              },
              {
                "chem_id": 45,
                "name": "Chem No45"
              },
              {
                "chem_id": 46,
                "name": "Chem No46"
              },
              {
                "chem_id": 47,
                "name": "Chem No47"
              },
              {
                "chem_id": 48,
                "name": "Chem No48"
              },
              {
                "chem_id": 49,
                "name": "Chem No49"
              },
              {
                "chem_id": 999,
                "name": "Unknown Chemical"
              }
            ]

3. Get Commodity Info :

    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to:
    *  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs

            COMMAND:
            curl -X GET "http://127.0.0.1:8001/commodity/5" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0"
            
            RESPONSE:
            {
              "commodity_id": 5,
              "name": "hello2",
              "price": 5.2,
              "inventory": 54,
              "chemical_composition": [
                {
                  "chemical_details": {
                    "chem_id": 2,
                    "name": "Chem No2"
                  },
                  "percentage": 1.5
                },
                {
                  "chemical_details": {
                    "chem_id": 18,
                    "name": "Chem No18"
                  },
                  "percentage": 10
                },
                {
                  "chemical_details": {
                    "chem_id": 31,
                    "name": "Chem No31"
                  },
                  "percentage": 9.5
                },
                {
                  "chemical_details": {
                    "chem_id": 999,
                    "name": "Unknown Chemical"
                  },
                  "percentage": 79
                }
              ]
            }

4. Update Commodity:
    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to
    *  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"

            COMMAND:
            curl -X POST "http://127.0.0.1:8001/updateCommodity" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0" -H  "Content-Type: application/json" -d "{\"commodity_id\":5,\"inventory\":54}"
            
            RESPONE:
            "success"
            
5. Add Chemical to a commodity chemical composition:
    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to
    *  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"

            COMMAND:
            curl -X POST "http://127.0.0.1:8001/addChemicalToCommodity" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0" -H  "Content-Type: application/json" -d "{\"chem_id\":18,\"commodity_id\":5,\"percentage\":10}"
            
            RESPONSE:
            "success"
        
6. Remove chemical from Chemical Composition:

    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to
    *  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"

            COMMAND:
            curl -X POST "http://127.0.0.1:8001/removeChemicalFromCommodity" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0" -H  "Content-Type: application/json" -d "{\"chem_id\":18,\"commodity_id\":5}"
            
            
            RESPONSE:
            true
-----------------------------------------------------------------------------------------------------------------------------
