## RoR-Elevator-Service-Tech-Proposal
Using the RoR framework, provide a technical proposal for how you would approach creating an elevator service. This service should support at least the core requirements listed below and does NOT need to support any UI (api only).    
Requirements 
1. Accepts new floor pickup requests  
2. Accepts new floor drop off requests  
3. Emergency error handling  
4. Order optimization (handle incoming requests before, during and after traveling between floors and ensuring all incoming request for pick up and drop off are handled in a way so that requests do not become stale but also allowing for optimal)

## Installation
1. Clone repository
2. Make sure you have Ruby installed
3. Run `bundle install`
4. Run `rake db:setup`
5. Start the server by `rails s`

## Decription
You have only one elevator, it could pick up or dropoff you from first to the tenth floor.
The server accepts pickup and dropoff requests on `localhost:3000`.
Example:
```bash
http://localhost:3000/pickup?floor=1
http://localhost:3000/dropoff?floor=1
```
You will see an error if you try to send a floor higher than 10 or lower than 1. Also if the Elevator will break then you will see funny emergency messages.
