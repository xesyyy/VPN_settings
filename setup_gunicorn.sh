#!/bin/bash

cat <<EOL | sudo tee /etc/systemd/system/gunicorn.service
[Unit]
Description=Gunicorn instance to serve my Flask app
After=network.target

[Service]
User=root
Group=www-data
WorkingDirectory=/root/app
ExecStart=/usr/local/bin/gunicorn --workers 3 --bind unix:/tmp/gunicorn.sock -m 007 app:app

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload

sudo systemctl start gunicorn

sudo systemctl enable gunicorn

sudo systemctl status gunicorn
