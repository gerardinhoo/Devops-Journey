# ShopLite — Monolith (Node/Express)

A tiny single-process app that manages **Users** and **Orders** together.  
Orders are enriched with user info via a **local function call** (no network).  
This serves as the baseline you’ll later compare to the microservices split.

/api
├─ /users (GET all)
├─ /users/:id (GET one)
├─ /orders (GET list, enriched with user)
├─ /orders/:id (GET one)
└─ /orders (POST create)

## Requirements

- Node 18+ (Node 20 recommended)
- (Optional) Docker & Docker Compose

## Run (local)

```bash
npm install
npm run dev
# or: PORT=3000 NODE_ENV=development npm run dev
```

## Smoke tests

```bash
# health
curl http://localhost:3000/healthz

# users
curl http://localhost:3000/api/users
curl http://localhost:3000/api/users/u1

# orders (enriched with user.fullName)
curl http://localhost:3000/api/orders
curl http://localhost:3000/api/orders/o100

# create an order
curl -X POST http://localhost:3000/api/orders \
  -H "Content-Type: application/json" \
  -d '{"userId":"u1","item":"Mouse","total":49}'
```

## Docker

.dockerignore filters out dev artifacts (node_modules, .env, etc.).
Dockerfile uses node:20-alpine, non-root user, npm ci --omit=dev.

```bash
docker build -t shoplite-monolith:dev .
docker run --rm -p 3000:3000 shoplite-monolith:dev
```

## Design Notes

- Single deployable: Users + Orders in one process/codebase.

- Boundary kept clean: findUserById() used by Orders; later we’ll replace this with an HTTP call in microservices.

- Status codes: 200 on success, 201 on create, 404 when not found.

- Graceful shutdown: handles SIGINT/SIGTERM so containers stop cleanly.

## Env Vars (optional)

If using a local .env, load it with dotenv or set vars in your shell:

- PORT (default 3000)

- NODE_ENV (development locally, production in Docker)

## Next Steps

Move to microservicesProject/ to split into:

- users-svc (exposes /users/:id)

-orders-svc (enriches orders by calling users-svc over HTTP via Docker Compose)
