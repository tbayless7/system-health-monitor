
`setup-cron.md` (Linux/WSL cron steps):

```markdown
# Cron Setup (Linux/WSL)

## Install + start cron
```bash
sudo apt update
sudo apt install -y cron
sudo service cron start
sudo systemctl enable cron
