function restic-gcs
  set -lx GOOGLE_PROJECT_ID backups-hugoreeves-com
  set -lx GOOGLE_APPLICATION_CREDENTIALS $HOME/.config/restic/envs/gcs/gcs-service-key.json
  set -lx GS_CONNECTIONS 50

  set -lx RESTIC_REPOSITORY gs:personal.backups.hugoreeves.com:/
  set -lx RESTIC_PASSWORD_COMMAND "gopass-password-only backups/restic/gcs/password"


  set -lx KEEP_LAST 3
  set -lx RETENTION_HOURS 7
  set -lx RETENTION_DAYS 7
  set -lx RETENTION_WEEKS 7
  set -lx RETENTION_MONTHS 18
  set -lx RETENTION_YEARS 20

  restic \
    --option gs.connections=$GS_CONNECTIONS \
    $argv
end
