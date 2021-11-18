![Screenshot from 2021-08-26 14-49-12](https://user-images.githubusercontent.com/81737737/131341252-68b2a394-7f6c-4ce6-82fa-298592fae126.png)

![Screenshot from 2021-08-26 14-49-29](https://user-images.githubusercontent.com/81737737/131341251-f601dba4-b495-4530-a067-737e10679281.png)

![Screenshot from 2021-08-26 14-50-04](https://user-images.githubusercontent.com/81737737/131341249-f4de317b-fc81-4f02-9d6f-574bfce118d7.png)

curl -X POST -H "Accept: Application/json" -H "Content-Type: application/json" localhost:3000/api/robot/0/orders -d '{"commands":["PLACE 0,0,NORTH", "MOVE", "REPORT"]}'
