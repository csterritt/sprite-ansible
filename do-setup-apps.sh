#!/bin/bash
set -euo pipefail
ansible-playbook --ask-become-pass -i hosts -v remote-apps-setup.yaml
