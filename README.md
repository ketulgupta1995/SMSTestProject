### The directory structure is as follows:
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
	* user- root  password- root
	* command to connect to db after running the appliucation
		* ``` mysql --host=127.0.0.1 --port=32000 -uroot -p```
		
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
4. __install_docker_mysql.sh__  : installs all  the prerequisite for running the application like docker and docker compose and mysql client
5. __execution_screenshots__  : These are some screenshots of the project taken while testing to show how it works.
--------------------------------------------------------------------------------------------------
### My development environment:
1. I have used **ubuntu 18.04** for development and testing
    * Following are prerequisites needed to run the application.
    * All these steps all captured in **install_docker_mysql.sh** 
    * Run the file install_docker_mysql.sh to get them installed.
    	* Go to project folder and run ```./install_docker_mysql.sh```
    	* It does following things:

		```
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
		docker --version
		sudo apt  install docker-compose
		sudo apt install mysql-client-core-5.7 ```

---------------------------------------------------------------------------------------

### INSTALLATION:

 ### **NOTE** : check if your user has privileges/ access to docker and docker compose
* if not add your user to docker group 
	
        sudo usermod -aG docker $USER
        newgrp docker

* **In terminal go to project directory** and run:     

        newgrp docker 
        docker-compose up

* There are two services in this setup 
	1. database : mysql server
	2. fastapi server : Application server

* Wait till it downloads all the required files and other requirements.

* Once it is done open the url :

   *  To test if application started successfully go to (http://127.0.0.1:8001/) 
   *  You should see {hello:'greetings'}

-----------------------------------------------------------------------------------------------

### ***NOTE*** :
* Go to (http://127.0.0.1:8001/docs), click on **LOCK** symbol and use username: ketul and password: ketul, Authorise it
* All apis have been documented there.
* **if there is nothing displayed on browser window , it means UI library(swagger-ui) is not getting downloaded**
* **Please install and use following command to test the apis:**

        sudo apt install curl

-----------------------------------------------------------------------------------------------
### APIS

1. Get token for user authorisation:
	* user : ketul 
	* password : ketul
	
	
	| Input Required in body | 
	| ------------- |
	| username,password  | 
	
```
        COMMAND:
        curl -X POST "http://127.0.0.1:8001/token" -H  "accept: application/json" -H  "Content-Type: application/x-www-form-urlencoded" -d "grant_type=&username=ketul&password=ketul&scope=&client_id=&client_secret="
        
        RESPONSE:
        {
          "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs",
          "token_type": "bearer"
        }
```
2. Get All Chemicals 

    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to
    *  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * No input Required data in request url http://127.0.0.1:8001/listChemicals.
    	
	
	| Input Required in url/body | 
	| ------------- |
	| None | 
	

    
    
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
             .........
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
    * Required data in request is commodity id in url http://127.0.0.1:8001/commodity/{numeric_id}.  **id should be between 1 and 49**
	
	
	| Input Required in url | 
	| ------------- |
	| commodity_id (value between 1 to 40)  | 
	
    
    
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
    * Required data in body :
	
	| Input Required in body | 
	| ------------- |
	|  {"commodity_id":5,"price":18,"inventory":5,"name":"commodity name"} | 
	|  only **commodity_id** is compulsory |
	
    ```
            COMMAND:
            curl -X POST "http://127.0.0.1:8001/updateCommodity" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0" -H  "Content-Type: application/json" -d "{\"commodity_id\":5,\"inventory\":54}"
            
            RESPONE:
            "success"```
            
5. Add Chemical to a commodity chemical composition:
    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to
    *  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * Required data in body
    
	| Input Required in body | 
	| ------------- |
	|  {"commodity_id":5,"chem_id":18, "percentage": 51} | 
	|  all are compulsory |
	
	
    ``` COMMAND:
            curl -X POST "http://127.0.0.1:8001/addChemicalToCommodity" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0" -H  "Content-Type: application/json" -d "{\"chem_id\":18,\"commodity_id\":5,\"percentage\":10}"
            
            RESPONSE:
            "success" ```
        
6. Remove chemical from Chemical Composition:

    * **use the access_token value in previous token response to auhtorise user else NOT_AUTHORISED error response will be given.**
    * eg if acces_token contains  :
    
            "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * replace gibberish text after **"Authorization: Bearer "**  in **COMMAND** to
    *  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzNzg1Mn0.aQLwUH316HrvMsz1AKbY1UBWyVXOpm8Jmj9i1L_8fZs"
    * Required data in body
        
	| Input Required in body | 
	| ------------- |
	|  {"commodity_id":5,"chem_id":18} | 
	|  all are compulsory |
           
	   ```  COMMAND:
            curl -X POST "http://127.0.0.1:8001/removeChemicalFromCommodity" -H  "accept: application/json" -H  "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJrZXR1bCIsImV4cCI6MTYwMzUzODE0Mn0.WUeBsQ7d4OZfTggL9Qb7DZhL--wbxm1ZJkpWn8MZvR0" -H  "Content-Type: application/json" -d "{\"chem_id\":18,\"commodity_id\":5}"
            
            RESPONSE:
            true  ```
-----------------------------------------------------------------------------------------------------------------------------
