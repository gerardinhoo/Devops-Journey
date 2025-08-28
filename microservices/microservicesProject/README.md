# ShopLite — Microservices (users-svc + orders-svc)

Same Users/Orders domain as the monolith, split into **two services** and wired with **Docker Compose**.

users-svc (3001) orders-svc (3002)
┌──────────────────┐ ┌──────────────────┐
│ GET /healthz │ │ GET /healthz │
│ GET /users │ │ GET /orders │─┐ (enrich via HTTP)
│ GET /users/:id │◀──HTTP──▶│ GET /orders/:id │ │
└──────────────────┘ │ POST /orders │─┘
└──────────────────┘

- **Service discovery:** inside Compose, `orders` calls **`http://users:3001`** (service name `users`).
- **Resilience:** `orders` adds a small HTTP timeout + fallback when calling `users`.
- **Health checks:** `orders` waits for `users` to pass `/healthz`.

---

## Requirements

- Docker & Docker Compose (v2 preferred: `docker compose ...`)
- (Optional) curl for quick testing

---

## Run

```bash
cd microservices/microservicesProject
docker compose up --build
# (or: docker-compose up --build)
```

## Smoke tests

```bash
# users
curl http://localhost:3001/healthz
curl http://localhost:3001/users
curl http://localhost:3001/users/u1

# orders (enriched with user from users-svc)
curl http://localhost:3002/healthz
curl http://localhost:3002/orders
curl http://localhost:3002/orders/o100

# create an order
curl -X POST http://localhost:3002/orders \
  -H "Content-Type: application/json" \
  -d '{"userId":"u1","item":"Mouse","total":49}'
```

## How enrichment works

- Monolith: enrichment was a local function:
  findUserById(order.userId)

- Microservices: orders-svc performs a network call:

```bash
const r = await fetch(`${USERS_BASE_URL}/users/${o.userId}`);
const user = r.ok ? await r.json() : { fullName: "Unknown" };
return { ...o, user };
```

- USERS_BASE_URL is set in docker-compose.yml to http://users:3001

## Project Structure

microservicesProject/
├─ docker-compose.yml
├─ users-svc/
│ ├─ app.js
│ ├─ package.json
│ └─ Dockerfile
└─ orders-svc/
├─ app.js
├─ package.json
└─ Dockerfile

## Troubleshooting

- Calling localhost from a container: use the service name (http://users:3001), not http://localhost:3001.

- Ports busy: change the left side of the port mapping in docker-compose.yml, e.g. "13001:3001".

- 404 for /users/:id: Call /users/u1 (no leading colon in the URL).

- orders-svc says users-svc unavailable: ensure Compose is up and users healthcheck passes; try docker compose logs users

## Notes & conventions

- Uses Node 20 (built-in fetch).

- Each service runs as non-root user in its container.

- Minimal timeout + fallback pattern shown in orders-svc. A must for real microservices.

- Data is in-memory for clarity; in real systems, each service owns its own database.
