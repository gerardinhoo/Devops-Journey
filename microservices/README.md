# Microservices Learning Track

Two tiny apps that implement the **same Users/Orders domain** in different architectures so you can compare them side-by-side.

## What’s here

- [`monolithicProject/`](./monolithicProject): Single-process Node/Express app (one deployable)
- [`microservicesProject/`](./microservicesProject): Split into `users-svc` and `orders-svc` with Docker Compose

## How to run

See each project’s README for exact steps and curl cheatsheets:

- Monolith → [`monolithicProject/README.md`](./monolithicProject/README.md)
- Microservices → [`microservicesProject/README.md`](./microservicesProject/README.md)

## TL;DR: Monolith vs. Microservices

| Topic        | Monolith                      | Microservices                             |
| ------------ | ----------------------------- | ----------------------------------------- |
| Calls        | Function calls in one process | Network calls (HTTP) between services     |
| Deploy/Scale | One deploy; scale whole app   | Deploy/scale each service independently   |
| Faults       | One crash can drop everything | Fault isolation; degrade gracefully       |
| Ops          | Simple                        | Timeouts, retries, health checks, tracing |

## Migration path (what this track demonstrates)

1. Build the monolith and keep a clean boundary (e.g., `findUserById`).
2. Extract **users** to `users-svc`; `orders-svc` calls it over HTTP.
3. Add health checks & env config; compare behavior and ops trade-offs.

Happy hacking! 🚀
