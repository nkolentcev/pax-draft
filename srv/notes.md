ms0: pre
    - git, docker ?go 
    - dokcker and docker-compose

service
    user
        /GET    - получить пользователя
        endpoint /user/{pin}
        возврат либо ошибки либо пользователя

        /POST    - создать пользователя
        /PATCH  - обновить пользователя
    
    boarding pass
        /GET    - проверить посадочный талон
        /POST    - создать посадочный талон
        /PATH   - обновить данные посадочного талона 

