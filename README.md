# API

## Todos

- backup redis boards in Postgres database
- action history (save as 'snapshots' in database)?
- deploy frontend; whitelist IP from rate limiter and action cable

## Add Pixel

```
PATCH /api/canvas/:id

Headers: 
{
  "Content-Type": "application/json",
  "Authorization": "Bearer token"
}

Body: 
{
  x: integer,
  y: integer,
}

Response: 200
Response Body: 
{ 
  coords: [x, y],
  color:  [r, g, b, a]
}
```

## Get Canvas

TODO: caching config (don't always read from redis?)

```
GET /api/canvas/:id

Response: 200
Reponse Body: raw array
```

## Create Canvas

**NOTE: Admin only**

```
POST /api/canvas

{ 
  id: "string"
}

Headers: 
{
  "Content-Type": "application/json",
  "Authorization": "Bearer token"
}

Response: 201
```