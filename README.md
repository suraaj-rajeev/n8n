# n8n on Render

This repository contains a minimal setup to run [n8n](https://n8n.io/) on [Render](https://render.com/).

## Prerequisites

- Node.js `20.x` (Render uses this version automatically; see `.node-version`)
- A Render Web Service configured from this repository
- A managed PostgreSQL instance (Render, Supabase, or another provider)
- An `N8N_ENCRYPTION_KEY` secret to protect credentials stored by n8n

## Getting Started Locally

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Set up environment variables:**

   Create a `.env` file in the project root (or export them in your terminal):

   ```bash
   # Required: Encryption key (minimum 16 characters)
   export N8N_ENCRYPTION_KEY="your-encryption-key-here-min-16-characters"

   # Database Configuration (PostgreSQL/Supabase)
   export DB_TYPE=postgresdb
   export DB_POSTGRESDB_HOST=db.xxxxx.supabase.co
   export DB_POSTGRESDB_PORT=5432
   export DB_POSTGRESDB_DATABASE=postgres
   export DB_POSTGRESDB_USER=postgres.xxxxxxxxxxxxx
   export DB_POSTGRESDB_PASSWORD=your_password_here
   export DB_POSTGRESDB_SSL_ENABLED=true
   export DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false
   export DB_POSTGRESDB_CONNECTION_TIMEOUT=120000
   export DB_POSTGRESDB_IDLE_CONNECTION_TIMEOUT=30000
   export DB_POSTGRESDB_POOL_SIZE=2

   # Local Development Settings
   export N8N_HOST=localhost
   export N8N_PROTOCOL=http
   export N8N_PORT=5678
   export WEBHOOK_URL=http://localhost:5678/

   # Optional: User folder for local data persistence
   export N8N_USER_FOLDER=./.n8n

   # Optional: Disable telemetry
   export N8N_DIAGNOSTICS_ENABLED=false
   export N8N_VERSION_NOTIFICATIONS_ENABLED=false
   ```

3. **Start n8n with .env file:**
   ```bash
   npm run dev:direct
   ```

   Or if you prefer the bash script:
   ```bash
   npm run dev
   ```

4. **Access n8n:**
   Visit `http://localhost:5678/` after the server reports it is ready.

## Deploying to Render

1. **Create a Web Service** – In Render, choose “New +” → “Web Service” and point it at this repo.
2. **Confirm Settings** – Render will detect `render.yaml` and apply the same build (`npm ci`) and start (`./start.sh`) commands.
3. **Provide Secrets** – Add the required database values (`DB_POSTGRESDB_*`) and `N8N_ENCRYPTION_KEY` in the Render dashboard. These are marked with `sync: false` in `render.yaml`.
4. **Deploy** – Trigger a deploy. After the first successful deployment, webhooks will be available at `https://<your-service>.onrender.com/`.

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

