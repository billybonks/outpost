# Outpost

Outpost runs persistent Firecracker VMs on a remote Linux server.

## Requirements

- An x86-64 Arch, Ubuntu, or Debian server with KVM, TUN/TAP, cgroup v2, and `/dev/userfaultfd`
- API connectivity via Tailscale, Cloudflare Tunnel, or localhost (see below)
- SSH and interactive sudo access to the server

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/nishantdania/outpost/refs/heads/main/install.sh | bash
```

The installer asks for `user@server` to install both the client and remote server, `local` to install a server on this machine, or nothing for the client only. It installs `outpost` in `~/.local/bin`; after a remote install, `outpost list` works immediately. On Arch, required packages must already be installed; Outpost never upgrades the system. Re-run the installer before using `outpost uninstall`; it confirms `uninstall` (or accepts `--yes`) and removes the configured server and local Outpost files. If the server no longer exists or cannot be reached, `outpost uninstall --client-only` removes only the local client files.

### Choose connectivity

When installing a server, the installer asks whether to use **Tailscale**. If you decline, it offers **Cloudflare Tunnel**; declining both installs a **local-only** server.

| Mode | API listener | Remote access |
| --- | --- | --- |
| Tailscale | Server's Tailscale IPv4 address, port 17890 | Private API connectivity; SSH via the host requires SSH access and network permissions |
| Cloudflare Tunnel | `127.0.0.1:17890` | HTTPS API through a Cloudflare hostname; SSH is not exposed by the tunnel |
| Local-only | `127.0.0.1:17890` | Host only |

For Tailscale, install it and sign in on the server first. For Cloudflare, install `cloudflared` first and have your domain managed by Cloudflare. The installer never installs either networking tool or upgrades Arch packages automatically.

#### Cloudflare Tunnel

1. In Cloudflare's dashboard, create a remotely managed Cloudflare Tunnel.
2. Configure a published application route for your hostname (for example, `outpost.example.com`) with **HTTP** origin **`127.0.0.1:17890`**.
3. Run the Outpost installer, decline Tailscale, and choose Cloudflare. Enter the hostname and paste **only the tunnel token** from the dashboard's connector command when prompted. Token input is hidden.

The installer creates a dedicated `outpost-cloudflared.service`; it does not replace an existing `cloudflared.service`. The tunnel token is stored root-only in `/etc/outpost-cloudflared/cloudflared.env`, not in command arguments or the client configuration. The Outpost API bearer token remains required and gives administrative control over VMs and images: keep it secret. Cloudflare Access can add another layer of protection, but is not configured by this installer; machine clients would need to supply Access service-token headers.

The host's CLI keeps using localhost. For a remote installation (`user@server`), the local client uses the HTTPS hostname. SSH, exec, copy, and sync still require a separate SSH route to the host/VMs; an API tunnel alone does not provide these operations. Large image uploads or long-running image builds are also subject to Cloudflare's request-size and timeout limits.

`outpost uninstall` removes the dedicated tunnel service and its local credentials along with the server. Delete the Cloudflare dashboard tunnel and DNS route separately. To switch an existing Cloudflare installation to another mode without deleting VMs, first disable/remove its dedicated service and credentials:

```bash
sudo systemctl disable --now outpost-cloudflared.service
sudo rm /etc/systemd/system/outpost-cloudflared.service /etc/outpost-cloudflared/cloudflared.env
sudo rmdir /etc/outpost-cloudflared
sudo systemctl daemon-reload
```

Then rerun the installer with the new mode. Remove the dashboard route if it is no longer needed.

#### Noninteractive installs

Set `OUTPOST_INSTALL_NETWORK` to `tailscale`, `cloudflare`, or `local` to skip the connectivity prompts. Server automation must select a mode explicitly. Client-only installs do not require a networking choice.

```bash
# Local-only host
OUTPOST_INSTALL_TARGET=local OUTPOST_INSTALL_NETWORK=local bash install.sh

# Tailscale host (already signed in)
OUTPOST_INSTALL_TARGET=local OUTPOST_INSTALL_NETWORK=tailscale bash install.sh

# Cloudflare host: token file must be owned by you, private (e.g. chmod 600),
# and contain just the dashboard tunnel token.
OUTPOST_INSTALL_TARGET=local \
  OUTPOST_INSTALL_NETWORK=cloudflare \
  OUTPOST_INSTALL_CLOUDFLARE_HOSTNAME=outpost.example.com \
  OUTPOST_INSTALL_CLOUDFLARE_TOKEN_FILE=/secure/path/tunnel-token \
  bash install.sh
```

For remote installation, use `OUTPOST_INSTALL_TARGET=user@server`; the Cloudflare token-file path must exist **on that server**. Without a token file, the remote terminal prompts for the token. Local-only mode must be installed directly on the server (`local` or `OUTPOST_INSTALL_MODE=server`).

## Usage

```bash
outpost create dev
outpost list
outpost ssh dev
outpost exec dev -- uname -a
outpost copy ./file dev:/root/file
outpost sync ./project/ dev:/root/project/
outpost stop dev
outpost start dev
outpost delete dev
outpost image list
outpost image build -t coding:latest ./images/coding
outpost create coding --image coding:latest --cpus 4 --memory 8G --disk 32G
outpost uninstall
```

## Agent skill

A skill for agents to use Outpost with tmux is available at [outpost-work](https://github.com/nishantdania/dotfiles/tree/fc641d49c64a38de0fdddc76ba24d86262693875/.pi/skills/outpost-work).
