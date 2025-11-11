# n8n on Render

This repository contains a minimal setup to run [n8n](https://n8n.io/) on [Render](https://render.com/).

## Prerequisites

- Node.js `20.x` (Render uses this version automatically; see `.node-version`)
- A Render Web Service configured from this repository
- A managed PostgreSQL instance (Render, Supabase, or another provider)
- An `N8N_ENCRYPTION_KEY` secret to protect credentials stored by n8n

## What’s Included

- `package.json` – Pins the deployment to the `n8n` npm package and exposes a single `start` script.
- `start.sh` – Ensures the n8n data directory exists with secure permissions, binds to Render’s injected `PORT`, and starts n8n.
- `render.yaml` – Declarative Render configuration for provisioning a free web service, defining environment variables, and wiring in database secrets.

## Getting Started Locally

```bash
npm install
PORT=5678 npm start
```

Visit `http://localhost:5678/` after the server reports it is ready. If you want local credentials to persist, export `N8N_USER_FOLDER` to point at a directory on your machine (e.g. `./.n8n`).

## Deploying to Render

1. **Create a Web Service** – In Render, choose “New +” → “Web Service” and point it at this repo.
2. **Confirm Settings** – Render will detect `render.yaml` and apply the same build (`npm ci`) and start (`./start.sh`) commands.
3. **Provide Secrets** – Add the required database values (`DB_POSTGRESDB_*`) and `N8N_ENCRYPTION_KEY` in the Render dashboard. These are marked with `sync: false` in `render.yaml`.
4. **Deploy** – Trigger a deploy. After the first successful deployment, webhooks will be available at `https://<your-service>.onrender.com/`.

## Environment Variables

`render.yaml` lists recommended variables. Key ones include:

- `N8N_HOST`, `N8N_PROTOCOL`, `N8N_PORT` – Configure n8n to use Render’s hostname and injected port.
- `WEBHOOK_URL` – Ensures externally accessible webhook URLs point to your Render service.
- `N8N_RUNNERS_*` – Enables the n8n Workflow Runners feature.
- `DB_POSTGRESDB_*` – Connection details for the PostgreSQL database.

Secrets marked with `sync: false` must be added through Render’s dashboard; they are intentionally omitted from version control.

## Updating n8n

Edit the version constraint in `package.json`, then run:

```bash
npm install
git commit -am "chore: bump n8n"
```

Render will pick up the change on the next deploy.

## Troubleshooting

- **Health check failures** – Confirm the service is responding at `/healthz`. n8n exposes a basic health endpoint once it finishes booting.
- **Permission errors** – `start.sh` enforces strict permissions on `/home/node/.n8n`. If you override `N8N_USER_FOLDER`, ensure the destination is writable by the service user.
- **Database connectivity** – Verify the `DB_POSTGRESDB_*` secrets and that SSL settings match your provider.

## License

This repository does not include a license file; add one if you plan to distribute changes publicly.

