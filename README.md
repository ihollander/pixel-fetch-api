# API Info

## Add Pixel

Place a pixel on the canvas, using x-y coordinates and a color.

### Endpoint

```
PATCH http://pixel-fetch-api.herokuapp.com/api/canvas/:id
```

### Headers

```
{
  "Content-Type": "application/json"
}
```

### Rate Limit

Requests to this endpoint are rate limited to 10 requests per minute. You can view your remaining limit in the `X-Ratelimit-Remaining` header. A `429` status code will be returned if the rate limit is exceeded.

### Params

| key   | type    | required? | description | 
|-------|---------|-----------|-------------|
| **x**     | integer | yes       | The **x** coordinate of the pixel |
| **y**     | integer | yes       | The **y** coordinate of the pixel |
| **color** | string  | optional  | Must provide either **color** or **r**, **b**, **g**, **a** values. Can be a hex string (`#ff0000`) or css color (`red`). | 
| **r**     | integer | optional  | If **color** is not provided, must provide **r**, **b**, **g**, **a** values between 0-255 |
| **g**     | integer | optional  | If **color** is not provided, must provide **r**, **b**, **g**, **a** values between 0-255 |
| **b**     | integer | optional  | If **color** is not provided, must provide **r**, **b**, **g**, **a** values between 0-255 |
| **a**     | integer | optional  | If **color** is not provided, must provide **r**, **b**, **g**, **a** values between 0-255 |


### Example Response
```
Response Status: 200
Response Body: 
{ 
  coords: [x, y],
  color:  [r, g, b, a]
}
Response Headers:
{
  X-Ratelimit-Limit: integer,
  X-Ratelimit-Remaining: integer
}
```

## Get Canvas

Read the current canvas as a raw array of pixel data: `[r,b,g,a,r,g,b,a....]`

Use this endpoint if you'd like to display a snapshot of the current canvas.

### Endpoint

```
GET http://pixel-fetch-api.herokuapp.com/api/canvas/:id
```

### Rate Limit

Requests to this endpoint are rate limited to 10 requests per minute. You can view your remaining limit in the `X-Ratelimit-Remaining` header. A `429` status code will be returned if the rate limit is exceeded.

### Example Response

```
Response: 200
Reponse Body: raw array
```
